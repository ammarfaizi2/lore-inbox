Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289647AbSBGQh0>; Thu, 7 Feb 2002 11:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289631AbSBGQhL>; Thu, 7 Feb 2002 11:37:11 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23716 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289347AbSBGQgp>;
	Thu, 7 Feb 2002 11:36:45 -0500
Date: Thu, 7 Feb 2002 08:36:36 -0800
From: Dave Hansen <haveblue@us.ibm.com>
Message-Id: <200202071636.g17GaaS02460@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Removal of big kernel lock from isdn drivers [1/3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 of 3

isdn.bkl-remove.isdn_dev_rwsem.patch:
* changes name of "dev" to "isdn_dev"
      - If there are going to be global variables,
        they can at least not have exceedingly generic
        names like "dev"!
* adds global isdn_dev_rwsem
      - isdn_dev_rwsem must be held when manipulating "isdn_dev"

This could probably be 2 different patches, but I don't imagine that
the name change will be very controvertial.    

I've been examining the continuing additions of the big kernel lock 
(BKL) to the 2.5 tree.  I noticed that in 2.5.3, the ISDN subsystem 
added the BKL to several places.  In response to this, I have written 
several patches to attempt removal of the BKL from the ISDN subsystem. 
I have little knowledge of the drivers themselves, so I would like some 
assistance from those of you who understand them better.  I probably 
have an over-simplified view of the code, so my patches may be too 
simplistic. 


-- 
Dave Hansen
haveblue@us.ibm.com
diff -ur -X exclude linux-2.5.3-clean/drivers/isdn/isdn_audio.c linux/drivers/isdn/isdn_audio.c
--- linux-2.5.3-clean/drivers/isdn/isdn_audio.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/isdn_audio.c	Mon Feb  4 11:35:49 2002
@@ -564,13 +564,13 @@
 			cli();
 			di = info->isdn_driver;
 			ch = info->isdn_channel;
-			__skb_queue_tail(&dev->drv[di]->rpqueue[ch], skb);
-			dev->drv[di]->rcvcount[ch] += 2;
+			__skb_queue_tail(&isdn_dev->drv[di]->rpqueue[ch], skb);
+			isdn_dev->drv[di]->rcvcount[ch] += 2;
 			restore_flags(flags);
 			/* Schedule dequeuing */
-			if ((dev->modempoll) && (info->rcvsched))
+			if ((isdn_dev->modempoll) && (info->rcvsched))
 				isdn_timer_ctrl(ISDN_TIMER_MODEMREAD, 1);
-			wake_up_interruptible(&dev->drv[di]->rcv_waitq[ch]);
+			wake_up_interruptible(&isdn_dev->drv[di]->rcv_waitq[ch]);
 		} else
 			kfree_skb(skb);
 		s->last = what;
@@ -685,13 +685,13 @@
 	cli();
 	di = info->isdn_driver;
 	ch = info->isdn_channel;
-	__skb_queue_tail(&dev->drv[di]->rpqueue[ch], skb);
-	dev->drv[di]->rcvcount[ch] += 2;
+	__skb_queue_tail(&isdn_dev->drv[di]->rpqueue[ch], skb);
+	isdn_dev->drv[di]->rcvcount[ch] += 2;
 	restore_flags(flags);
 	/* Schedule dequeuing */
-	if ((dev->modempoll) && (info->rcvsched))
+	if ((isdn_dev->modempoll) && (info->rcvsched))
 		isdn_timer_ctrl(ISDN_TIMER_MODEMREAD, 1);
-	wake_up_interruptible(&dev->drv[di]->rcv_waitq[ch]);
+	wake_up_interruptible(&isdn_dev->drv[di]->rcv_waitq[ch]);
 }
 
 void
diff -ur -X exclude linux-2.5.3-clean/drivers/isdn/isdn_common.c linux/drivers/isdn/isdn_common.c
--- linux-2.5.3-clean/drivers/isdn/isdn_common.c	Sun Jan 27 11:33:38 2002
+++ linux/drivers/isdn/isdn_common.c	Mon Feb  4 11:40:24 2002
@@ -42,7 +42,8 @@
 MODULE_AUTHOR("Fritz Elfert");
 MODULE_LICENSE("GPL");
 
-isdn_dev *dev;
+isdn_dev_t *isdn_dev;
+DECLARE_RWSEM(isdn_dev_rwsem);
 
 static char *isdn_revision = "$Revision: 1.114.6.16 $";
 
@@ -75,14 +76,14 @@
 {
 	int i;
 
-	for (i = 0; i < dev->drivers; i++) {
+	for (i = 0; i < isdn_dev->drivers; i++) {
 		isdn_ctrl cmd;
 
 		cmd.driver = i;
 		cmd.arg = 0;
 		cmd.command = ISDN_CMD_LOCK;
 		isdn_command(&cmd);
-		dev->drv[i]->locks++;
+		isdn_dev->drv[i]->locks++;
 	}
 }
 
@@ -98,16 +99,18 @@
 {
 	int i;
 
-	for (i = 0; i < dev->drivers; i++)
-		if (dev->drv[i]->locks > 0) {
+	down_read(&isdn_dev_rwsem);
+	for (i = 0; i < isdn_dev->drivers; i++)
+		if (isdn_dev->drv[i]->locks > 0) {
 			isdn_ctrl cmd;
 
 			cmd.driver = i;
 			cmd.arg = 0;
 			cmd.command = ISDN_CMD_UNLOCK;
 			isdn_command(&cmd);
-			dev->drv[i]->locks--;
+			isdn_dev->drv[i]->locks--;
 		}
+        up_read(&isdn_dev_rwsem);
 }
 
 void
@@ -230,7 +233,7 @@
 {
 	int i;
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-		if (dev->chanmap[i] == ch && dev->drvmap[i] == di)
+		if (isdn_dev->chanmap[i] == ch && isdn_dev->drvmap[i] == di)
 			return i;
 	return -1;
 }
@@ -242,7 +245,7 @@
 static void
 isdn_timer_funct(ulong dummy)
 {
-	int tf = dev->tflags;
+	int tf = isdn_dev->tflags;
 	if (tf & ISDN_TIMER_FAST) {
 		if (tf & ISDN_TIMER_MODEMREAD)
 			isdn_tty_readmodem();
@@ -276,7 +279,7 @@
 
 		save_flags(flags);
 		cli();
-		mod_timer(&dev->timer, jiffies+ISDN_TIMER_RES);
+		mod_timer(&isdn_dev->timer, jiffies+ISDN_TIMER_RES);
 		restore_flags(flags);
 	}
 }
@@ -289,18 +292,18 @@
 
 	save_flags(flags);
 	cli();
-	if ((tf & ISDN_TIMER_SLOW) && (!(dev->tflags & ISDN_TIMER_SLOW))) {
+	if ((tf & ISDN_TIMER_SLOW) && (!(isdn_dev->tflags & ISDN_TIMER_SLOW))) {
 		/* If the slow-timer wasn't activated until now */
 		isdn_timer_cnt1 = 0;
 		isdn_timer_cnt2 = 0;
 	}
-	old_tflags = dev->tflags;
+	old_tflags = isdn_dev->tflags;
 	if (onoff)
-		dev->tflags |= tf;
+		isdn_dev->tflags |= tf;
 	else
-		dev->tflags &= ~tf;
-	if (dev->tflags && !old_tflags)
-		mod_timer(&dev->timer, jiffies+ISDN_TIMER_RES);
+		isdn_dev->tflags &= ~tf;
+	if (isdn_dev->tflags && !old_tflags)
+		mod_timer(&isdn_dev->timer, jiffies+ISDN_TIMER_RES);
 	restore_flags(flags);
 }
 
@@ -317,7 +320,7 @@
 		return;
 	}
 	/* Update statistics */
-	dev->ibytes[i] += skb->len;
+	isdn_dev->ibytes[i] += skb->len;
 	
 	/* First, try to deliver data to network-device */
 	if (isdn_net_rcv_skb(i, skb))
@@ -327,10 +330,10 @@
 	 * makes sense for async streams only, so it is
 	 * called after possible net-device delivery.
 	 */
-	if (dev->v110[i]) {
-		atomic_inc(&dev->v110use[i]);
-		skb = isdn_v110_decode(dev->v110[i], skb);
-		atomic_dec(&dev->v110use[i]);
+	if (isdn_dev->v110[i]) {
+		atomic_inc(&isdn_dev->v110use[i]);
+		skb = isdn_v110_decode(isdn_dev->v110[i], skb);
+		atomic_dec(&isdn_dev->v110use[i]);
 		if (!skb)
 			return;
 	}
@@ -339,7 +342,7 @@
 	if (skb->len) {
 		if (isdn_tty_rcv_skb(i, di, channel, skb))
 			return;
-		wake_up_interruptible(&dev->drv[di]->rcv_waitq[channel]);
+		wake_up_interruptible(&isdn_dev->drv[di]->rcv_waitq[channel]);
 	} else
 		dev_kfree_skb(skb);
 }
@@ -360,7 +363,7 @@
 	if (cmd->command == ISDN_CMD_SETL2) {
 		int idx = isdn_dc2minor(cmd->driver, cmd->arg & 255);
 		unsigned long l2prot = (cmd->arg >> 8) & 255;
-		unsigned long features = (dev->drv[cmd->driver]->interface->features
+		unsigned long features = (isdn_dev->drv[cmd->driver]->interface->features
 						>> ISDN_FEATURE_L2_SHIFT) &
 						ISDN_FEATURE_L2_MASK;
 		unsigned long l2_feature = (1 << l2prot);
@@ -374,14 +377,14 @@
 			 * Layer-2 to transparent
 			 */
 				if (!(features & l2_feature)) {
-					dev->v110emu[idx] = l2prot;
+					isdn_dev->v110emu[idx] = l2prot;
 					cmd->arg = (cmd->arg & 255) |
 						(ISDN_PROTO_L2_TRANS << 8);
 				} else
-					dev->v110emu[idx] = 0;
+					isdn_dev->v110emu[idx] = 0;
 		}
 	}
-	return dev->drv[cmd->driver]->interface->command(cmd);
+	return isdn_dev->drv[cmd->driver]->interface->command(cmd);
 }
 
 void
@@ -438,7 +441,7 @@
 		case ISDN_STAT_BSENT:
 			if (i < 0)
 				return -1;
-			if (dev->global_flags & ISDN_GLOBAL_STOPPED)
+			if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED)
 				return 0;
 			if (isdn_net_stat_callback(i, c))
 				return 0;
@@ -446,24 +449,24 @@
 				return 0;
 			if (isdn_tty_stat_callback(i, c))
 				return 0;
-			wake_up_interruptible(&dev->drv[di]->snd_waitq[c->arg]);
+			wake_up_interruptible(&isdn_dev->drv[di]->snd_waitq[c->arg]);
 			break;
 		case ISDN_STAT_STAVAIL:
 			save_flags(flags);
 			cli();
-			dev->drv[di]->stavail += c->arg;
+			isdn_dev->drv[di]->stavail += c->arg;
 			restore_flags(flags);
-			wake_up_interruptible(&dev->drv[di]->st_waitq);
+			wake_up_interruptible(&isdn_dev->drv[di]->st_waitq);
 			break;
 		case ISDN_STAT_RUN:
-			dev->drv[di]->flags |= DRV_FLAG_RUNNING;
+			isdn_dev->drv[di]->flags |= DRV_FLAG_RUNNING;
 			for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-				if (dev->drvmap[i] == di)
-					isdn_all_eaz(di, dev->chanmap[i]);
+				if (isdn_dev->drvmap[i] == di)
+					isdn_all_eaz(di, isdn_dev->chanmap[i]);
 			set_global_features();
 			break;
 		case ISDN_STAT_STOP:
-			dev->drv[di]->flags &= ~DRV_FLAG_RUNNING;
+			isdn_dev->drv[di]->flags &= ~DRV_FLAG_RUNNING;
 			break;
 		case ISDN_STAT_ICALL:
 			if (i < 0)
@@ -471,7 +474,7 @@
 #ifdef ISDN_DEBUG_STATCALLB
 			printk(KERN_DEBUG "ICALL (net): %d %ld %s\n", di, c->arg, c->parm.num);
 #endif
-			if (dev->global_flags & ISDN_GLOBAL_STOPPED) {
+			if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED) {
 				cmd.driver = di;
 				cmd.arg = c->arg;
 				cmd.command = ISDN_CMD_HANGUP;
@@ -494,7 +497,7 @@
                  	                  if ((retval = divert_if->stat_callback(c))) 
 					    return(retval); /* processed */
 #endif /* CONFIG_ISDN_DIVERSION */                       
-					if ((!retval) && (dev->drv[di]->flags & DRV_FLAG_REJBUS)) {
+					if ((!retval) && (isdn_dev->drv[di]->flags & DRV_FLAG_REJBUS)) {
 						/* No tty responding */
 						cmd.driver = di;
 						cmd.arg = c->arg;
@@ -509,7 +512,7 @@
 					cmd.driver = di;
 					cmd.arg = c->arg;
 					cmd.command = ISDN_CMD_ACCEPTD;
-					for ( p = dev->netdev; p; p = p->next )
+					for ( p = isdn_dev->netdev; p; p = p->next )
 						if ( p->local->isdn_channel == cmd.arg )
 						{
 							strcpy( cmd.parm.setup.eazmsn, p->local->msn );
@@ -550,7 +553,7 @@
 #ifdef ISDN_DEBUG_STATCALLB
 			printk(KERN_DEBUG "CINF: %ld %s\n", c->arg, c->parm.num);
 #endif
-			if (dev->global_flags & ISDN_GLOBAL_STOPPED)
+			if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED)
 				return 0;
 			if (strcmp(c->parm.num, "0"))
 				isdn_net_stat_callback(i, c);
@@ -561,7 +564,7 @@
 			printk(KERN_DEBUG "CAUSE: %ld %s\n", c->arg, c->parm.num);
 #endif
 			printk(KERN_INFO "isdn: %s,ch%ld cause: %s\n",
-			       dev->drvid[di], c->arg, c->parm.num);
+			       isdn_dev->drvid[di], c->arg, c->parm.num);
 			isdn_tty_stat_callback(i, c);
 #ifdef CONFIG_ISDN_DIVERSION
                         if (divert_if)
@@ -584,7 +587,7 @@
 #ifdef ISDN_DEBUG_STATCALLB
 			printk(KERN_DEBUG "DCONN: %ld\n", c->arg);
 #endif
-			if (dev->global_flags & ISDN_GLOBAL_STOPPED)
+			if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED)
 				return 0;
 			/* Find any net-device, waiting for D-channel setup */
 			if (isdn_net_stat_callback(i, c))
@@ -605,9 +608,9 @@
 #ifdef ISDN_DEBUG_STATCALLB
 			printk(KERN_DEBUG "DHUP: %ld\n", c->arg);
 #endif
-			if (dev->global_flags & ISDN_GLOBAL_STOPPED)
+			if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED)
 				return 0;
-			dev->drv[di]->online &= ~(1 << (c->arg));
+			isdn_dev->drv[di]->online &= ~(1 << (c->arg));
 			isdn_info_update();
 			/* Signal hangup to network-devices */
 			if (isdn_net_stat_callback(i, c))
@@ -628,9 +631,9 @@
 			printk(KERN_DEBUG "BCONN: %ld\n", c->arg);
 #endif
 			/* Signal B-channel-connect to network-devices */
-			if (dev->global_flags & ISDN_GLOBAL_STOPPED)
+			if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED)
 				return 0;
-			dev->drv[di]->online |= (1 << (c->arg));
+			isdn_dev->drv[di]->online |= (1 << (c->arg));
 			isdn_info_update();
 			if (isdn_net_stat_callback(i, c))
 				break;
@@ -644,9 +647,9 @@
 #ifdef ISDN_DEBUG_STATCALLB
 			printk(KERN_DEBUG "BHUP: %ld\n", c->arg);
 #endif
-			if (dev->global_flags & ISDN_GLOBAL_STOPPED)
+			if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED)
 				return 0;
-			dev->drv[di]->online &= ~(1 << (c->arg));
+			isdn_dev->drv[di]->online &= ~(1 << (c->arg));
 			isdn_info_update();
 #ifdef CONFIG_ISDN_X25
 			/* Signal hangup to network-devices */
@@ -663,7 +666,7 @@
 #ifdef ISDN_DEBUG_STATCALLB
 			printk(KERN_DEBUG "NODCH: %ld\n", c->arg);
 #endif
-			if (dev->global_flags & ISDN_GLOBAL_STOPPED)
+			if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED)
 				return 0;
 			if (isdn_net_stat_callback(i, c))
 				break;
@@ -671,7 +674,7 @@
 				break;
 			break;
 		case ISDN_STAT_ADDCH:
-			if (isdn_add_channels(dev->drv[di], di, c->arg, 1))
+			if (isdn_add_channels(isdn_dev->drv[di], di, c->arg, 1))
 				return -1;
 			isdn_info_update();
 			break;
@@ -679,13 +682,13 @@
 			save_flags(flags);
 			cli();
 			for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-				if ((dev->drvmap[i] == di) &&
-				    (dev->chanmap[i] == c->arg)) {
+				if ((isdn_dev->drvmap[i] == di) &&
+				    (isdn_dev->chanmap[i] == c->arg)) {
 				    if (c->parm.num[0])
-				      dev->usage[i] &= ~ISDN_USAGE_DISABLED;
+				      isdn_dev->usage[i] &= ~ISDN_USAGE_DISABLED;
 				    else
-				      if (USG_NONE(dev->usage[i])) {
-					dev->usage[i] |= ISDN_USAGE_DISABLED;
+				      if (USG_NONE(isdn_dev->usage[i])) {
+					isdn_dev->usage[i] |= ISDN_USAGE_DISABLED;
 				      }
 				      else 
 					retval = -1;
@@ -695,35 +698,35 @@
 			isdn_info_update();
 			break;
 		case ISDN_STAT_UNLOAD:
-			while (dev->drv[di]->locks > 0) {
+			while (isdn_dev->drv[di]->locks > 0) {
 				isdn_ctrl cmd;
 				cmd.driver = di;
 				cmd.arg = 0;
 				cmd.command = ISDN_CMD_UNLOCK;
 				isdn_command(&cmd);
-				dev->drv[di]->locks--;
+				isdn_dev->drv[di]->locks--;
 			}
 			save_flags(flags);
 			cli();
 			isdn_tty_stat_callback(i, c);
 			for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-				if (dev->drvmap[i] == di) {
-					dev->drvmap[i] = -1;
-					dev->chanmap[i] = -1;
-					dev->usage[i] &= ~ISDN_USAGE_DISABLED;
+				if (isdn_dev->drvmap[i] == di) {
+					isdn_dev->drvmap[i] = -1;
+					isdn_dev->chanmap[i] = -1;
+					isdn_dev->usage[i] &= ~ISDN_USAGE_DISABLED;
 					isdn_unregister_devfs(i);
 				}
-			dev->drivers--;
-			dev->channels -= dev->drv[di]->channels;
-			kfree(dev->drv[di]->rcverr);
-			kfree(dev->drv[di]->rcvcount);
-			for (i = 0; i < dev->drv[di]->channels; i++)
-				skb_queue_purge(&dev->drv[di]->rpqueue[i]);
-			kfree(dev->drv[di]->rpqueue);
-			kfree(dev->drv[di]->rcv_waitq);
-			kfree(dev->drv[di]);
-			dev->drv[di] = NULL;
-			dev->drvid[di][0] = '\0';
+			isdn_dev->drivers--;
+			isdn_dev->channels -= isdn_dev->drv[di]->channels;
+			kfree(isdn_dev->drv[di]->rcverr);
+			kfree(isdn_dev->drv[di]->rcvcount);
+			for (i = 0; i < isdn_dev->drv[di]->channels; i++)
+				skb_queue_purge(&isdn_dev->drv[di]->rpqueue[i]);
+			kfree(isdn_dev->drv[di]->rpqueue);
+			kfree(isdn_dev->drv[di]->rcv_waitq);
+			kfree(isdn_dev->drv[di]);
+			isdn_dev->drv[di] = NULL;
+			isdn_dev->drvid[di][0] = '\0';
 			isdn_info_update();
 			set_global_features();
 			restore_flags(flags);
@@ -792,26 +795,26 @@
 	struct sk_buff *skb;
 	u_char *cp;
 
-	if (!dev->drv[di])
+	if (!isdn_dev->drv[di])
 		return 0;
-	if (skb_queue_empty(&dev->drv[di]->rpqueue[channel])) {
+	if (skb_queue_empty(&isdn_dev->drv[di]->rpqueue[channel])) {
 		if (sleep)
 			interruptible_sleep_on(sleep);
 		else
 			return 0;
 	}
-	if (len > dev->drv[di]->rcvcount[channel])
-		len = dev->drv[di]->rcvcount[channel];
+	if (len > isdn_dev->drv[di]->rcvcount[channel])
+		len = isdn_dev->drv[di]->rcvcount[channel];
 	cp = buf;
 	count = 0;
 	while (len) {
-		if (!(skb = skb_peek(&dev->drv[di]->rpqueue[channel])))
+		if (!(skb = skb_peek(&isdn_dev->drv[di]->rpqueue[channel])))
 			break;
 #ifdef CONFIG_ISDN_AUDIO
 		if (ISDN_AUDIO_SKB_LOCK(skb))
 			break;
 		ISDN_AUDIO_SKB_LOCK(skb) = 1;
-		if ((ISDN_AUDIO_SKB_DLECOUNT(skb)) || (dev->drv[di]->DLEflag & (1 << channel))) {
+		if ((ISDN_AUDIO_SKB_DLECOUNT(skb)) || (isdn_dev->drv[di]->DLEflag & (1 << channel))) {
 			char *p = skb->data;
 			unsigned long DLEmask = (1 << channel);
 
@@ -819,13 +822,13 @@
 			count_pull = count_put = 0;
 			while ((count_pull < skb->len) && (len > 0)) {
 				len--;
-				if (dev->drv[di]->DLEflag & DLEmask) {
+				if (isdn_dev->drv[di]->DLEflag & DLEmask) {
 					*cp++ = DLE;
-					dev->drv[di]->DLEflag &= ~DLEmask;
+					isdn_dev->drv[di]->DLEflag &= ~DLEmask;
 				} else {
 					*cp++ = *p;
 					if (*p == DLE) {
-						dev->drv[di]->DLEflag |= DLEmask;
+						isdn_dev->drv[di]->DLEflag |= DLEmask;
 						(ISDN_AUDIO_SKB_DLECOUNT(skb))--;
 					}
 					p++;
@@ -864,7 +867,7 @@
 #ifdef CONFIG_ISDN_AUDIO
 			ISDN_AUDIO_SKB_LOCK(skb) = 0;
 #endif
-			skb = skb_dequeue(&dev->drv[di]->rpqueue[channel]);
+			skb = skb_dequeue(&isdn_dev->drv[di]->rpqueue[channel]);
 			dev_kfree_skb(skb);
 		} else {
 			/* Not yet emptied this buff, so it
@@ -876,7 +879,7 @@
 			ISDN_AUDIO_SKB_LOCK(skb) = 0;
 #endif
 		}
-		dev->drv[di]->rcvcount[channel] -= count_put;
+		isdn_dev->drv[di]->rcvcount[channel] -= count_put;
 	}
 	return count;
 }
@@ -884,13 +887,13 @@
 static __inline int
 isdn_minor2drv(int minor)
 {
-	return (dev->drvmap[minor]);
+	return (isdn_dev->drvmap[minor]);
 }
 
 static __inline int
 isdn_minor2chan(int minor)
 {
-	return (dev->chanmap[minor]);
+	return (isdn_dev->chanmap[minor]);
 }
 
 static char *
@@ -903,32 +906,32 @@
 	sprintf(istatbuf, "idmap:\t");
 	p = istatbuf + strlen(istatbuf);
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		sprintf(p, "%s ", (dev->drvmap[i] < 0) ? "-" : dev->drvid[dev->drvmap[i]]);
+		sprintf(p, "%s ", (isdn_dev->drvmap[i] < 0) ? "-" : isdn_dev->drvid[isdn_dev->drvmap[i]]);
 		p = istatbuf + strlen(istatbuf);
 	}
 	sprintf(p, "\nchmap:\t");
 	p = istatbuf + strlen(istatbuf);
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		sprintf(p, "%d ", dev->chanmap[i]);
+		sprintf(p, "%d ", isdn_dev->chanmap[i]);
 		p = istatbuf + strlen(istatbuf);
 	}
 	sprintf(p, "\ndrmap:\t");
 	p = istatbuf + strlen(istatbuf);
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		sprintf(p, "%d ", dev->drvmap[i]);
+		sprintf(p, "%d ", isdn_dev->drvmap[i]);
 		p = istatbuf + strlen(istatbuf);
 	}
 	sprintf(p, "\nusage:\t");
 	p = istatbuf + strlen(istatbuf);
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		sprintf(p, "%d ", dev->usage[i]);
+		sprintf(p, "%d ", isdn_dev->usage[i]);
 		p = istatbuf + strlen(istatbuf);
 	}
 	sprintf(p, "\nflags:\t");
 	p = istatbuf + strlen(istatbuf);
 	for (i = 0; i < ISDN_MAX_DRIVERS; i++) {
-		if (dev->drv[i]) {
-			sprintf(p, "%ld ", dev->drv[i]->online);
+		if (isdn_dev->drv[i]) {
+			sprintf(p, "%ld ", isdn_dev->drv[i]->online);
 			p = istatbuf + strlen(istatbuf);
 		} else {
 			sprintf(p, "? ");
@@ -938,7 +941,7 @@
 	sprintf(p, "\nphone:\t");
 	p = istatbuf + strlen(istatbuf);
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		sprintf(p, "%s ", dev->num[i]);
+		sprintf(p, "%s ", isdn_dev->num[i]);
 		p = istatbuf + strlen(istatbuf);
 	}
 	sprintf(p, "\n");
@@ -952,13 +955,13 @@
 void
 isdn_info_update(void)
 {
-	infostruct *p = dev->infochain;
+	infostruct *p = isdn_dev->infochain;
 
 	while (p) {
 		*(p->private) = 1;
 		p = (infostruct *) p->next;
 	}
-	wake_up_interruptible(&(dev->info_waitq));
+	wake_up_interruptible(&(isdn_dev->info_waitq));
 }
 
 static int
@@ -970,9 +973,9 @@
 	if (!p)
 		return -ENOMEM;
 
-	p->next = (char *) dev->infochain;
+	p->next = (char *) isdn_dev->infochain;
 	p->private = (char *) &(filep->private_data);
-	dev->infochain = p;
+	isdn_dev->infochain = p;
 	/* At opening we allow a single update */
 	filep->private_data = (char *) 1;
 
@@ -982,17 +985,16 @@
 static int
 isdn_status_release(struct inode *ino, struct file *filep)
 {
-	infostruct *p = dev->infochain;
+	infostruct *p = isdn_dev->infochain;
 	infostruct *q = NULL;
 	
-	lock_kernel();
-
+	down_write(&isdn_dev_rwsem);
 	while (p) {
 		if (p->private == (char *) &(filep->private_data)) {
 			if (q)
 				q->next = p->next;
 			else
-				dev->infochain = (infostruct *) (p->next);
+				isdn_dev->infochain = (infostruct *) (p->next);
 			kfree(p);
 			goto out;
 		}
@@ -1002,7 +1004,7 @@
 	printk(KERN_WARNING "isdn: No private data while closing isdnctrl\n");
 
  out:
-	unlock_kernel();
+	up_write(&isdn_dev_rwsem);
 	return 0;
 }
 
@@ -1016,13 +1018,13 @@
 	if (off != &file->f_pos)
 		return -ESPIPE;
 
-	lock_kernel();
+	down_write(&isdn_dev_rwsem);
 	if (!file->private_data) {
 		if (file->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto out;
 		}
-		interruptible_sleep_on(&(dev->info_waitq));
+		interruptible_sleep_on(&(isdn_dev->info_waitq));
 	}
 	p = isdn_statstr();
 	file->private_data = 0;
@@ -1039,7 +1041,7 @@
 	goto out;
 
  out:
-	unlock_kernel();
+	up_write(&isdn_dev_rwsem);
 	return retval;
 }
 
@@ -1054,13 +1056,13 @@
 {
 	unsigned int mask = 0;
 
-	lock_kernel();
+	down_read(&isdn_dev_rwsem);
 
-	poll_wait(file, &(dev->info_waitq), wait);
+	poll_wait(file, &(isdn_dev->info_waitq), wait);
 	if (file->private_data)
 		mask |= POLLIN | POLLRDNORM;
 
-	unlock_kernel();
+	up_read(&isdn_dev_rwsem);
 	return mask;
 }
 
@@ -1095,8 +1097,8 @@
 					       sizeof(ulong) * ISDN_MAX_CHANNELS * 2)))
 				return ret;
 			for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-				put_user(dev->ibytes[i], p++);
-				put_user(dev->obytes[i], p++);
+				put_user(isdn_dev->ibytes[i], p++);
+				put_user(isdn_dev->obytes[i], p++);
 			}
 			return 0;
 		} else
@@ -1146,9 +1148,11 @@
 	uint minor = minor(ino->i_rdev);
 	int drvidx;
 
+	down_read(&isdn_dev_rwsem);
 	drvidx = isdn_minor2drv(minor - ISDN_MINOR_CTRL);
 	if (drvidx < 0)
 		return -ENODEV;
+	up_read(&isdn_dev_rwsem);
 
 	isdn_lock_drivers();
 	return 0;
@@ -1157,14 +1161,15 @@
 static int
 isdn_ctrl_release(struct inode *ino, struct file *filep)
 {
-	lock_kernel();
-
-	if (dev->profd == current)
-		dev->profd = NULL;
+        down_read(&isdn_dev_rwsem);
+	
+	if (isdn_dev->profd == current)
+		isdn_dev->profd = NULL;
 
 	isdn_unlock_drivers();
 
-	unlock_kernel();
+	up_read(&isdn_dev_rwsem);
+
 	return 0;
 }
 
@@ -1180,24 +1185,24 @@
 	if (off != &file->f_pos)
 		return -ESPIPE;
 
-	lock_kernel();
+	down_read(&isdn_dev_rwsem);
 
 	drvidx = isdn_minor2drv(minor - ISDN_MINOR_CTRL);
 	if (drvidx < 0) {
 		retval = -ENODEV;
 		goto out;
 	}
-	if (!dev->drv[drvidx]->stavail) {
+	if (!isdn_dev->drv[drvidx]->stavail) {
 		if (file->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto out;
 		}
-		interruptible_sleep_on(&(dev->drv[drvidx]->st_waitq));
+		interruptible_sleep_on(&(isdn_dev->drv[drvidx]->st_waitq));
 	}
-	if (dev->drv[drvidx]->interface->readstat) {
-		if (count > dev->drv[drvidx]->stavail)
-			count = dev->drv[drvidx]->stavail;
-		len = dev->drv[drvidx]->interface->
+	if (isdn_dev->drv[drvidx]->interface->readstat) {
+		if (count > isdn_dev->drv[drvidx]->stavail)
+			count = isdn_dev->drv[drvidx]->stavail;
+		len = isdn_dev->drv[drvidx]->interface->
 			readstat(buf, count, 1, drvidx,
 				 isdn_minor2chan(minor));
 	} else {
@@ -1206,15 +1211,15 @@
 	save_flags(flags);
 	cli();
 	if (len)
-		dev->drv[drvidx]->stavail -= len;
+		isdn_dev->drv[drvidx]->stavail -= len;
 	else
-		dev->drv[drvidx]->stavail = 0;
+		isdn_dev->drv[drvidx]->stavail = 0;
 	restore_flags(flags);
 	*off += len;
 	retval = len;
 	
  out:
-	unlock_kernel();
+	up_read(&isdn_dev_rwsem);
 	return retval;
 }
 
@@ -1228,22 +1233,22 @@
 	if (off != &file->f_pos)
 		return -ESPIPE;
 
-	lock_kernel();
+	down_read(&isdn_dev_rwsem);
 
 	drvidx = isdn_minor2drv(minor - ISDN_MINOR_CTRL);
 	if (drvidx < 0) {
 		retval = -ENODEV;
 		goto out;
 	}
-	if (!dev->drv[drvidx]->interface->writecmd) {
+	if (!isdn_dev->drv[drvidx]->interface->writecmd) {
 		retval = -EINVAL;
 		goto out;
 	}
-	retval = dev->drv[drvidx]->interface->
+	retval = isdn_dev->drv[drvidx]->interface->
 		writecmd(buf, count, 1, drvidx, isdn_minor2chan(minor - ISDN_MINOR_CTRL));
 
  out:
-	unlock_kernel();
+	up_read(&isdn_dev_rwsem);
 	return retval;
 }
 
@@ -1259,14 +1264,14 @@
 		/* driver deregistered while file open */
 		return POLLHUP;
 
-	lock_kernel();
+	down_read(&isdn_dev_rwsem);
 
-	poll_wait(file, &(dev->drv[drvidx]->st_waitq), wait);
+	poll_wait(file, &(isdn_dev->drv[drvidx]->st_waitq), wait);
 	mask = POLLOUT | POLLWRNORM;
-	if (dev->drv[drvidx]->stavail)
+	if (isdn_dev->drv[drvidx]->stavail)
 		mask |= POLLIN | POLLRDNORM;
 
-	unlock_kernel();
+	up_read(&isdn_dev_rwsem);
 	return mask;
 }
 
@@ -1317,7 +1322,7 @@
 		} else {
 			s = NULL;
 		}
-		ret = down_interruptible(&dev->sem);
+		ret = down_interruptible(&isdn_dev->sem);
 		if( ret ) return ret;
 		if ((s = isdn_net_new(s, NULL))) {
 			if (copy_to_user((char *) arg, s, strlen(s) + 1)){
@@ -1327,7 +1332,7 @@
 			}
 		} else
 			ret = -ENODEV;
-		up(&dev->sem);
+		up(&isdn_dev->sem);
 		return ret;
 	case IIOCNETASL:
 		/* Add a slave to a network-interface */
@@ -1336,7 +1341,7 @@
 				return -EFAULT;
 		} else
 			return -EINVAL;
-		ret = down_interruptible(&dev->sem);
+		ret = down_interruptible(&isdn_dev->sem);
 		if( ret ) return ret;
 		if ((s = isdn_net_newslave(bname))) {
 			if (copy_to_user((char *) arg, s, strlen(s) + 1)){
@@ -1346,17 +1351,17 @@
 			}
 		} else
 			ret = -ENODEV;
-		up(&dev->sem);
+		up(&isdn_dev->sem);
 		return ret;
 	case IIOCNETDIF:
 		/* Delete a network-interface */
 		if (arg) {
 			if (copy_from_user(name, (char *) arg, sizeof(name)))
 				return -EFAULT;
-			ret = down_interruptible(&dev->sem);
+			ret = down_interruptible(&isdn_dev->sem);
 			if( ret ) return ret;
 			ret = isdn_net_rm(name);
-			up(&dev->sem);
+			up(&isdn_dev->sem);
 			return ret;
 		} else
 			return -EINVAL;
@@ -1385,10 +1390,10 @@
 		if (arg) {
 			if (copy_from_user((char *) &phone, (char *) arg, sizeof(phone)))
 				return -EFAULT;
-			ret = down_interruptible(&dev->sem);
+			ret = down_interruptible(&isdn_dev->sem);
 			if( ret ) return ret;
 			ret = isdn_net_addphone(&phone);
-			up(&dev->sem);
+			up(&isdn_dev->sem);
 			return ret;
 		} else
 			return -EINVAL;
@@ -1397,10 +1402,10 @@
 		if (arg) {
 			if (copy_from_user((char *) &phone, (char *) arg, sizeof(phone)))
 				return -EFAULT;
-			ret = down_interruptible(&dev->sem);
+			ret = down_interruptible(&isdn_dev->sem);
 			if( ret ) return ret;
 			ret = isdn_net_getphones(&phone, (char *) arg);
-			up(&dev->sem);
+			up(&isdn_dev->sem);
 			return ret;
 		} else
 			return -EINVAL;
@@ -1409,10 +1414,10 @@
 		if (arg) {
 			if (copy_from_user((char *) &phone, (char *) arg, sizeof(phone)))
 				return -EFAULT;
-			ret = down_interruptible(&dev->sem);
+			ret = down_interruptible(&isdn_dev->sem);
 			if( ret ) return ret;
 			ret = isdn_net_delphone(&phone);
-			up(&dev->sem);
+			up(&isdn_dev->sem);
 			return ret;
 		} else
 			return -EINVAL;
@@ -1448,16 +1453,16 @@
 		break;
 #endif                          /* CONFIG_NETDEVICES */
 	case IIOCSETVER:
-		dev->net_verbose = arg;
-		printk(KERN_INFO "isdn: Verbose-Level is %d\n", dev->net_verbose);
+		isdn_dev->net_verbose = arg;
+		printk(KERN_INFO "isdn: Verbose-Level is %d\n", isdn_dev->net_verbose);
 		return 0;
 	case IIOCSETGST:
 		if (arg)
-			dev->global_flags |= ISDN_GLOBAL_STOPPED;
+			isdn_dev->global_flags |= ISDN_GLOBAL_STOPPED;
 		else
-			dev->global_flags &= ~ISDN_GLOBAL_STOPPED;
+			isdn_dev->global_flags &= ~ISDN_GLOBAL_STOPPED;
 		printk(KERN_INFO "isdn: Global Mode %s\n",
-		       (dev->global_flags & ISDN_GLOBAL_STOPPED) ? "stopped" : "running");
+		       (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED) ? "stopped" : "running");
 		return 0;
 	case IIOCSETBRJ:
 		drvidx = -1;
@@ -1472,7 +1477,7 @@
 					*p = 0;
 				drvidx = -1;
 				for (i = 0; i < ISDN_MAX_DRIVERS; i++)
-					if (!(strcmp(dev->drvid[i], iocts.drvid))) {
+					if (!(strcmp(isdn_dev->drvid[i], iocts.drvid))) {
 						drvidx = i;
 						break;
 					}
@@ -1481,12 +1486,12 @@
 		if (drvidx == -1)
 			return -ENODEV;
 		if (iocts.arg)
-			dev->drv[drvidx]->flags |= DRV_FLAG_REJBUS;
+			isdn_dev->drv[drvidx]->flags |= DRV_FLAG_REJBUS;
 		else
-			dev->drv[drvidx]->flags &= ~DRV_FLAG_REJBUS;
+			isdn_dev->drv[drvidx]->flags &= ~DRV_FLAG_REJBUS;
 		return 0;
 	case IIOCSIGPRF:
-		dev->profd = current;
+		isdn_dev->profd = current;
 		return 0;
 		break;
 	case IIOCGETPRF:
@@ -1501,14 +1506,14 @@
 				return ret;
 
 			for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-				if (copy_to_user(p, dev->mdm.info[i].emu.profile,
+				if (copy_to_user(p, isdn_dev->mdm.info[i].emu.profile,
 						 ISDN_MODEM_NUMREG))
 					return -EFAULT;
 				p += ISDN_MODEM_NUMREG;
-				if (copy_to_user(p, dev->mdm.info[i].emu.pmsn, ISDN_MSNLEN))
+				if (copy_to_user(p, isdn_dev->mdm.info[i].emu.pmsn, ISDN_MSNLEN))
 					return -EFAULT;
 				p += ISDN_MSNLEN;
-				if (copy_to_user(p, dev->mdm.info[i].emu.plmsn, ISDN_LMSNLEN))
+				if (copy_to_user(p, isdn_dev->mdm.info[i].emu.plmsn, ISDN_LMSNLEN))
 					return -EFAULT;
 				p += ISDN_LMSNLEN;
 			}
@@ -1528,14 +1533,14 @@
 				return ret;
 
 			for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-				if (copy_from_user(dev->mdm.info[i].emu.profile, p,
+				if (copy_from_user(isdn_dev->mdm.info[i].emu.profile, p,
 						   ISDN_MODEM_NUMREG))
 					return -EFAULT;
 				p += ISDN_MODEM_NUMREG;
-				if (copy_from_user(dev->mdm.info[i].emu.plmsn, p, ISDN_LMSNLEN))
+				if (copy_from_user(isdn_dev->mdm.info[i].emu.plmsn, p, ISDN_LMSNLEN))
 					return -EFAULT;
 				p += ISDN_LMSNLEN;
-				if (copy_from_user(dev->mdm.info[i].emu.pmsn, p, ISDN_MSNLEN))
+				if (copy_from_user(isdn_dev->mdm.info[i].emu.pmsn, p, ISDN_MSNLEN))
 					return -EFAULT;
 				p += ISDN_MSNLEN;
 			}
@@ -1555,7 +1560,7 @@
 			if (strlen(iocts.drvid)) {
 				drvidx = -1;
 				for (i = 0; i < ISDN_MAX_DRIVERS; i++)
-					if (!(strcmp(dev->drvid[i], iocts.drvid))) {
+					if (!(strcmp(isdn_dev->drvid[i], iocts.drvid))) {
 						drvidx = i;
 						break;
 					}
@@ -1581,7 +1586,7 @@
 							/* Fall through */
 						case ',':
 							bname[j] = '\0';
-							strcpy(dev->drv[drvidx]->msn2eaz[i], bname);
+							strcpy(isdn_dev->drv[drvidx]->msn2eaz[i], bname);
 							j = ISDN_MSNLEN;
 							break;
 						default:
@@ -1597,8 +1602,8 @@
 				p = (char *) iocts.arg;
 				for (i = 0; i < 10; i++) {
 					sprintf(bname, "%s%s",
-						strlen(dev->drv[drvidx]->msn2eaz[i]) ?
-						dev->drv[drvidx]->msn2eaz[i] : "_",
+						strlen(isdn_dev->drv[drvidx]->msn2eaz[i]) ?
+						isdn_dev->drv[drvidx]->msn2eaz[i] : "_",
 						(i < 9) ? "," : "\0");
 					if (copy_to_user(p, bname, strlen(bname) + 1))
 						return -EFAULT;
@@ -1610,7 +1615,7 @@
 			return -EINVAL;
 	case IIOCDBGVAR:
 		if (arg) {
-			if (copy_to_user((char *) arg, (char *) &dev, sizeof(ulong)))
+			if (copy_to_user((char *) arg, (char *) &isdn_dev, sizeof(ulong)))
 				return -EFAULT;
 			return 0;
 		} else
@@ -1631,7 +1636,7 @@
 					*p = 0;
 				drvidx = -1;
 				for (i = 0; i < ISDN_MAX_DRIVERS; i++)
-					if (!(strcmp(dev->drvid[i], iocts.drvid))) {
+					if (!(strcmp(isdn_dev->drvid[i], iocts.drvid))) {
 						drvidx = i;
 						break;
 					}
@@ -1723,7 +1728,7 @@
 char *
 isdn_map_eaz2msn(char *msn, int di)
 {
-	driver *this = dev->drv[di];
+	driver *this = isdn_dev->drv[di];
 	int i;
 
 	if (strlen(msn) == 1) {
@@ -1760,30 +1765,30 @@
 	 * because we can emulate this in linklevel.
 	 */
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-		if (USG_NONE(dev->usage[i]) &&
-		    (dev->drvmap[i] != -1)) {
-			int d = dev->drvmap[i];
-			if ((dev->usage[i] & ISDN_USAGE_EXCLUSIVE) &&
-			((pre_dev != d) || (pre_chan != dev->chanmap[i])))
+		if (USG_NONE(isdn_dev->usage[i]) &&
+		    (isdn_dev->drvmap[i] != -1)) {
+			int d = isdn_dev->drvmap[i];
+			if ((isdn_dev->usage[i] & ISDN_USAGE_EXCLUSIVE) &&
+			((pre_dev != d) || (pre_chan != isdn_dev->chanmap[i])))
 				continue;
 			if (!strcmp(isdn_map_eaz2msn(msn, d), "-"))
 				continue;
-			if (dev->usage[i] & ISDN_USAGE_DISABLED)
+			if (isdn_dev->usage[i] & ISDN_USAGE_DISABLED)
 			        continue; /* usage not allowed */
-			if (dev->drv[d]->flags & DRV_FLAG_RUNNING) {
-				if (((dev->drv[d]->interface->features & features) == features) ||
-				    (((dev->drv[d]->interface->features & vfeatures) == vfeatures) &&
-				     (dev->drv[d]->interface->features & ISDN_FEATURE_L2_TRANS))) {
+			if (isdn_dev->drv[d]->flags & DRV_FLAG_RUNNING) {
+				if (((isdn_dev->drv[d]->interface->features & features) == features) ||
+				    (((isdn_dev->drv[d]->interface->features & vfeatures) == vfeatures) &&
+				     (isdn_dev->drv[d]->interface->features & ISDN_FEATURE_L2_TRANS))) {
 					if ((pre_dev < 0) || (pre_chan < 0)) {
-						dev->usage[i] &= ISDN_USAGE_EXCLUSIVE;
-						dev->usage[i] |= usage;
+						isdn_dev->usage[i] &= ISDN_USAGE_EXCLUSIVE;
+						isdn_dev->usage[i] |= usage;
 						isdn_info_update();
 						restore_flags(flags);
 						return i;
 					} else {
-						if ((pre_dev == d) && (pre_chan == dev->chanmap[i])) {
-							dev->usage[i] &= ISDN_USAGE_EXCLUSIVE;
-							dev->usage[i] |= usage;
+						if ((pre_dev == d) && (pre_chan == isdn_dev->chanmap[i])) {
+							isdn_dev->usage[i] &= ISDN_USAGE_EXCLUSIVE;
+							isdn_dev->usage[i] |= usage;
 							isdn_info_update();
 							restore_flags(flags);
 							return i;
@@ -1808,21 +1813,21 @@
 	save_flags(flags);
 	cli();
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-		if (((!usage) || ((dev->usage[i] & ISDN_USAGE_MASK) == usage)) &&
-		    (dev->drvmap[i] == di) &&
-		    (dev->chanmap[i] == ch)) {
-			dev->usage[i] &= (ISDN_USAGE_NONE | ISDN_USAGE_EXCLUSIVE);
-			strcpy(dev->num[i], "???");
-			dev->ibytes[i] = 0;
-			dev->obytes[i] = 0;
+		if (((!usage) || ((isdn_dev->usage[i] & ISDN_USAGE_MASK) == usage)) &&
+		    (isdn_dev->drvmap[i] == di) &&
+		    (isdn_dev->chanmap[i] == ch)) {
+			isdn_dev->usage[i] &= (ISDN_USAGE_NONE | ISDN_USAGE_EXCLUSIVE);
+			strcpy(isdn_dev->num[i], "???");
+			isdn_dev->ibytes[i] = 0;
+			isdn_dev->obytes[i] = 0;
 // 20.10.99 JIM, try to reinitialize v110 !
-			dev->v110emu[i] = 0;
-			atomic_set(&(dev->v110use[i]), 0);
-			isdn_v110_close(dev->v110[i]);
-			dev->v110[i] = NULL;
+			isdn_dev->v110emu[i] = 0;
+			atomic_set(&(isdn_dev->v110use[i]), 0);
+			isdn_v110_close(isdn_dev->v110[i]);
+			isdn_dev->v110[i] = NULL;
 // 20.10.99 JIM, try to reinitialize v110 !
 			isdn_info_update();
-			skb_queue_purge(&dev->drv[di]->rpqueue[ch]);
+			skb_queue_purge(&isdn_dev->drv[di]->rpqueue[ch]);
 		}
 	restore_flags(flags);
 }
@@ -1839,9 +1844,9 @@
 	save_flags(flags);
 	cli();
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-		if ((dev->drvmap[i] == di) &&
-		    (dev->chanmap[i] == ch)) {
-			dev->usage[i] &= ~ISDN_USAGE_EXCLUSIVE;
+		if ((isdn_dev->drvmap[i] == di) &&
+		    (isdn_dev->chanmap[i] == ch)) {
+			isdn_dev->usage[i] &= ~ISDN_USAGE_EXCLUSIVE;
 			isdn_info_update();
 			restore_flags(flags);
 			return;
@@ -1860,10 +1865,10 @@
 	int v110_ret = skb->len;
 	int idx = isdn_dc2minor(drvidx, chan);
 
-	if (dev->v110[idx]) {
-		atomic_inc(&dev->v110use[idx]);
-		nskb = isdn_v110_encode(dev->v110[idx], skb);
-		atomic_dec(&dev->v110use[idx]);
+	if (isdn_dev->v110[idx]) {
+		atomic_inc(&isdn_dev->v110use[idx]);
+		nskb = isdn_v110_encode(isdn_dev->v110[idx], skb);
+		atomic_dec(&isdn_dev->v110use[idx]);
 		if (!nskb)
 			return 0;
 		v110_ret = *((int *)nskb->data);
@@ -1874,9 +1879,9 @@
 		}
 		/* V.110 must always be acknowledged */
 		ack = 1;
-		ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, ack, nskb);
+		ret = isdn_dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, ack, nskb);
 	} else {
-		int hl = dev->drv[drvidx]->interface->hl_hdrlen;
+		int hl = isdn_dev->drv[drvidx]->interface->hl_hdrlen;
 
 		if( skb_headroom(skb) < hl ){
 			/* 
@@ -1892,22 +1897,22 @@
 			skb_tmp = skb_realloc_headroom(skb, hl);
 			printk(KERN_DEBUG "isdn_writebuf_skb_stub: reallocating headroom%s\n", skb_tmp ? "" : " failed");
 			if (!skb_tmp) return -ENOMEM; /* 0 better? */
-			ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, ack, skb_tmp);
+			ret = isdn_dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, ack, skb_tmp);
 			if( ret > 0 ){
 				dev_kfree_skb(skb);
 			} else {
 				dev_kfree_skb(skb_tmp);
 			}
 		} else {
-			ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, ack, skb);
+			ret = isdn_dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, ack, skb);
 		}
 	}
 	if (ret > 0) {
-		dev->obytes[idx] += ret;
-		if (dev->v110[idx]) {
-			atomic_inc(&dev->v110use[idx]);
-			dev->v110[idx]->skbuser++;
-			atomic_dec(&dev->v110use[idx]);
+		isdn_dev->obytes[idx] += ret;
+		if (isdn_dev->v110[idx]) {
+			atomic_inc(&isdn_dev->v110use[idx]);
+			isdn_dev->v110[idx]->skbuser++;
+			atomic_dec(&isdn_dev->v110use[idx]);
 			/* For V.110 return unencoded data length */
 			ret = v110_ret;
 			/* if the complete frame was send we free the skb;
@@ -1916,7 +1921,7 @@
 				dev_kfree_skb(skb);
 		}
 	} else
-		if (dev->v110[idx])
+		if (isdn_dev->v110[idx])
 			dev_kfree_skb(nskb);
 	return ret;
 }
@@ -1934,7 +1939,7 @@
 
 	m = (adding) ? d->channels + n : n;
 
-	if (dev->channels + n > ISDN_MAX_CHANNELS) {
+	if (isdn_dev->channels + n > ISDN_MAX_CHANNELS) {
 		printk(KERN_WARNING "register_isdn: Max. %d channels supported\n",
 		       ISDN_MAX_CHANNELS);
 		return -1;
@@ -1992,14 +1997,14 @@
 		init_waitqueue_head(&d->snd_waitq[j]);
 	}
 
-	dev->channels += n;
+	isdn_dev->channels += n;
 	save_flags(flags);
 	cli();
 	for (j = d->channels; j < m; j++)
 		for (k = 0; k < ISDN_MAX_CHANNELS; k++)
-			if (dev->chanmap[k] < 0) {
-				dev->chanmap[k] = j;
-				dev->drvmap[k] = drvidx;
+			if (isdn_dev->chanmap[k] < 0) {
+				isdn_dev->chanmap[k] = j;
+				isdn_dev->drvmap[k] = drvidx;
 				isdn_register_devfs(k);
 				break;
 			}
@@ -2017,12 +2022,12 @@
 {
 	int drvidx;
 
-	dev->global_features = 0;
+	isdn_dev->global_features = 0;
 	for (drvidx = 0; drvidx < ISDN_MAX_DRIVERS; drvidx++) {
-		if (!dev->drv[drvidx])
+		if (!isdn_dev->drv[drvidx])
 			continue;
-		if (dev->drv[drvidx]->interface)
-			dev->global_features |= dev->drv[drvidx]->interface->features;
+		if (isdn_dev->drv[drvidx]->interface)
+			isdn_dev->global_features |= isdn_dev->drv[drvidx]->interface->features;
 	}
 }
 
@@ -2032,14 +2037,14 @@
 {
   if ((di < 0) || (di >= ISDN_MAX_DRIVERS)) 
     return(NULL);
-  return(dev->drvid[di]); /* driver name */
+  return(isdn_dev->drvid[di]); /* driver name */
 } /* map_drvname */
 
 static int map_namedrv(char *id)
 {  int i;
 
    for (i = 0; i < ISDN_MAX_DRIVERS; i++)
-    { if (!strcmp(dev->drvid[i],id)) 
+    { if (!strcmp(isdn_dev->drvid[i],id)) 
         return(i);
     }
    return(-1);
@@ -2092,7 +2097,7 @@
 	ulong flags;
 	int drvidx;
 
-	if (dev->drivers >= ISDN_MAX_DRIVERS) {
+	if (isdn_dev->drivers >= ISDN_MAX_DRIVERS) {
 		printk(KERN_WARNING "register_isdn: Max. %d drivers supported\n",
 		       ISDN_MAX_DRIVERS);
 		return 0;
@@ -2115,7 +2120,7 @@
 	d->interface = i;
 	d->channels = 0;
 	for (drvidx = 0; drvidx < ISDN_MAX_DRIVERS; drvidx++)
-		if (!dev->drv[drvidx])
+		if (!isdn_dev->drv[drvidx])
 			break;
 	if (isdn_add_channels(d, drvidx, i->channels, 0)) {
 		kfree(d);
@@ -2129,12 +2134,12 @@
 	save_flags(flags);
 	cli();
 	for (j = 0; j < drvidx; j++)
-		if (!strcmp(i->id, dev->drvid[j]))
+		if (!strcmp(i->id, isdn_dev->drvid[j]))
 			sprintf(i->id, "line%d", drvidx);
-	dev->drv[drvidx] = d;
-	strcpy(dev->drvid[drvidx], i->id);
+	isdn_dev->drv[drvidx] = d;
+	strcpy(isdn_dev->drvid[drvidx], i->id);
 	isdn_info_update();
-	dev->drivers++;
+	isdn_dev->drivers++;
 	set_global_features();
 	restore_flags(flags);
 	return 1;
@@ -2170,7 +2175,7 @@
 	char buf[11];
 
 	sprintf (buf, "isdnctrl%d", k);
-	dev->devfs_handle_isdnctrlX[k] =
+	isdn_dev->devfs_handle_isdnctrlX[k] =
 	    devfs_register (devfs_handle, buf, DEVFS_FL_DEFAULT,
 			    ISDN_MAJOR, ISDN_MINOR_CTRL + k, 0600 | S_IFCHR,
 			    &isdn_fops, NULL);
@@ -2178,8 +2183,8 @@
 
 static void isdn_unregister_devfs(int k)
 {
-	devfs_unregister (dev->devfs_handle_isdnX[k]);
-	devfs_unregister (dev->devfs_handle_isdnctrlX[k]);
+	devfs_unregister (isdn_dev->devfs_handle_isdnX[k]);
+	devfs_unregister (isdn_dev->devfs_handle_isdnctrlX[k]);
 }
 
 static void isdn_init_devfs(void)
@@ -2194,18 +2199,18 @@
 		char buf[8];
 
 		sprintf (buf, "ippp%d", i);
-		dev->devfs_handle_ipppX[i] =
+		isdn_dev->devfs_handle_ipppX[i] =
 		    devfs_register (devfs_handle, buf, DEVFS_FL_DEFAULT,
 				    ISDN_MAJOR, ISDN_MINOR_PPP + i,
 				    0600 | S_IFCHR, &isdn_fops, NULL);
 	}
 #  endif
 
-	dev->devfs_handle_isdninfo =
+	isdn_dev->devfs_handle_isdninfo =
 	    devfs_register (devfs_handle, "isdninfo", DEVFS_FL_DEFAULT,
 			    ISDN_MAJOR, ISDN_MINOR_STATUS, 0600 | S_IFCHR,
 			    &isdn_fops, NULL);
-	dev->devfs_handle_isdnctrl =
+	isdn_dev->devfs_handle_isdnctrl =
 	    devfs_register (devfs_handle, "isdnctrl", DEVFS_FL_DEFAULT,
 			    ISDN_MAJOR, ISDN_MINOR_CTRL, 0600 | S_IFCHR, 
 			    &isdn_fops, NULL);
@@ -2216,10 +2221,10 @@
 #  ifdef CONFIG_ISDN_PPP
 	int i;
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) 
-		devfs_unregister (dev->devfs_handle_ipppX[i]);
+		devfs_unregister (isdn_dev->devfs_handle_ipppX[i]);
 #  endif
-	devfs_unregister (dev->devfs_handle_isdninfo);
-	devfs_unregister (dev->devfs_handle_isdnctrl);
+	devfs_unregister (isdn_dev->devfs_handle_isdninfo);
+	devfs_unregister (isdn_dev->devfs_handle_isdnctrl);
 	devfs_unregister (devfs_handle);
 }
 
@@ -2254,36 +2259,40 @@
 	int i;
 	char tmprev[50];
 
-	if (!(dev = (isdn_dev *) vmalloc(sizeof(isdn_dev)))) {
+	down_write(&isdn_dev_rwsem); /* yeah, yeah, yeah, I took the easy
+ 					way out and just locked it for the
+ 					whole function */
+  	
+	if (!(isdn_dev = (isdn_dev_t *) vmalloc(sizeof(isdn_dev_t)))) {
 		printk(KERN_WARNING "isdn: Could not allocate device-struct.\n");
 		return -EIO;
 	}
-	memset((char *) dev, 0, sizeof(isdn_dev));
-	init_timer(&dev->timer);
-	dev->timer.function = isdn_timer_funct;
-	init_MUTEX(&dev->sem);
-	init_waitqueue_head(&dev->info_waitq);
+	memset((char *) isdn_dev, 0, sizeof(isdn_dev_t));
+	init_timer(&isdn_dev->timer);
+	isdn_dev->timer.function = isdn_timer_funct;
+	init_MUTEX(&isdn_dev->sem);
+	init_waitqueue_head(&isdn_dev->info_waitq);
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		dev->drvmap[i] = -1;
-		dev->chanmap[i] = -1;
-		dev->m_idx[i] = -1;
-		strcpy(dev->num[i], "???");
-		init_waitqueue_head(&dev->mdm.info[i].open_wait);
-		init_waitqueue_head(&dev->mdm.info[i].close_wait);
+		isdn_dev->drvmap[i] = -1;
+		isdn_dev->chanmap[i] = -1;
+		isdn_dev->m_idx[i] = -1;
+		strcpy(isdn_dev->num[i], "???");
+		init_waitqueue_head(&isdn_dev->mdm.info[i].open_wait);
+		init_waitqueue_head(&isdn_dev->mdm.info[i].close_wait);
 	}
 	if (devfs_register_chrdev(ISDN_MAJOR, "isdn", &isdn_fops)) {
 		printk(KERN_WARNING "isdn: Could not register control devices\n");
-		vfree(dev);
+		vfree(isdn_dev);
 		return -EIO;
 	}
 	isdn_init_devfs();
 	if ((i = isdn_tty_modem_init()) < 0) {
 		printk(KERN_WARNING "isdn: Could not register tty devices\n");
 		if (i == -3)
-			tty_unregister_driver(&dev->mdm.cua_modem);
+			tty_unregister_driver(&isdn_dev->mdm.cua_modem);
 		if (i <= -2)
-			tty_unregister_driver(&dev->mdm.tty_modem);
-		vfree(dev);
+			tty_unregister_driver(&isdn_dev->mdm.tty_modem);
+		vfree(isdn_dev);
 		isdn_cleanup_devfs();
 		devfs_unregister_chrdev(ISDN_MAJOR, "isdn");
 		return -EIO;
@@ -2291,13 +2300,13 @@
 #ifdef CONFIG_ISDN_PPP
 	if (isdn_ppp_init() < 0) {
 		printk(KERN_WARNING "isdn: Could not create PPP-device-structs\n");
-		tty_unregister_driver(&dev->mdm.tty_modem);
-		tty_unregister_driver(&dev->mdm.cua_modem);
+		tty_unregister_driver(&isdn_dev->mdm.tty_modem);
+		tty_unregister_driver(&isdn_dev->mdm.cua_modem);
 		for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-			kfree(dev->mdm.info[i].xmit_buf - 4);
+			kfree(isdn_dev->mdm.info[i].xmit_buf - 4);
 		isdn_cleanup_devfs();
 		devfs_unregister_chrdev(ISDN_MAJOR, "isdn");
-		vfree(dev);
+		vfree(isdn_dev);
 		return -EIO;
 	}
 #endif                          /* CONFIG_ISDN_PPP */
@@ -2321,6 +2330,7 @@
 	printk("\n");
 #endif
 	isdn_info_update();
+	up_write(&isdn_dev_rwsem);
 	return 0;
 }
 
@@ -2342,21 +2352,21 @@
 		restore_flags(flags);
 		return;
 	}
-	if (tty_unregister_driver(&dev->mdm.tty_modem)) {
+	if (tty_unregister_driver(&isdn_dev->mdm.tty_modem)) {
 		printk(KERN_WARNING "isdn: ttyI-device busy, remove cancelled\n");
 		restore_flags(flags);
 		return;
 	}
-	if (tty_unregister_driver(&dev->mdm.cua_modem)) {
+	if (tty_unregister_driver(&isdn_dev->mdm.cua_modem)) {
 		printk(KERN_WARNING "isdn: cui-device busy, remove cancelled\n");
 		restore_flags(flags);
 		return;
 	}
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		isdn_tty_cleanup_xmit(&dev->mdm.info[i]);
-		kfree(dev->mdm.info[i].xmit_buf - 4);
+		isdn_tty_cleanup_xmit(&isdn_dev->mdm.info[i]);
+		kfree(isdn_dev->mdm.info[i].xmit_buf - 4);
 #ifdef CONFIG_ISDN_TTY_FAX
-		kfree(dev->mdm.info[i].fax);
+		kfree(isdn_dev->mdm.info[i].fax);
 #endif
 	}
 	if (devfs_unregister_chrdev(ISDN_MAJOR, "isdn") != 0) {
@@ -2364,10 +2374,10 @@
 		restore_flags(flags);
 	} else {
 		isdn_cleanup_devfs();
-		del_timer(&dev->timer);
+		del_timer(&isdn_dev->timer);
 		restore_flags(flags);
 		/* call vfree with interrupts enabled, else it will hang */
-		vfree(dev);
+		vfree(isdn_dev);
 		printk(KERN_NOTICE "ISDN-subsystem unloaded\n");
 	}
 }
Only in linux/drivers/isdn/: isdn_common.c.orig
Only in linux/drivers/isdn/: isdn_common.c.rej
diff -ur -X exclude linux-2.5.3-clean/drivers/isdn/isdn_net.c linux/drivers/isdn/isdn_net.c
--- linux-2.5.3-clean/drivers/isdn/isdn_net.c	Fri Nov  9 13:41:41 2001
+++ linux/drivers/isdn/isdn_net.c	Mon Feb  4 11:35:49 2002
@@ -272,10 +272,10 @@
 	save_flags(flags);
 	cli();
 	lp->flags |= ISDN_NET_CONNECTED;
-	lp->isdn_device = dev->drvmap[idx];
-	lp->isdn_channel = dev->chanmap[idx];
-	dev->rx_netdev[idx] = lp->netdev;
-	dev->st_netdev[idx] = lp->netdev;
+	lp->isdn_device = isdn_dev->drvmap[idx];
+	lp->isdn_channel = isdn_dev->chanmap[idx];
+	isdn_dev->rx_netdev[idx] = lp->netdev;
+	isdn_dev->st_netdev[idx] = lp->netdev;
 	restore_flags(flags);
 }
 
@@ -299,8 +299,8 @@
 		qdisc_reset(lp->netdev->dev.qdisc);
 	}
 	lp->dialstate = 0;
-	dev->rx_netdev[isdn_dc2minor(lp->isdn_device, lp->isdn_channel)] = NULL;
-	dev->st_netdev[isdn_dc2minor(lp->isdn_device, lp->isdn_channel)] = NULL;
+	isdn_dev->rx_netdev[isdn_dc2minor(lp->isdn_device, lp->isdn_channel)] = NULL;
+	isdn_dev->st_netdev[isdn_dc2minor(lp->isdn_device, lp->isdn_channel)] = NULL;
 	isdn_free_channel(lp->isdn_device, lp->isdn_channel, ISDN_USAGE_NET);
 	lp->flags &= ~ISDN_NET_CONNECTED;
 	lp->isdn_device = -1;
@@ -327,7 +327,7 @@
 void
 isdn_net_autohup()
 {
-	isdn_net_dev *p = dev->netdev;
+	isdn_net_dev *p = isdn_dev->netdev;
 	int anymore;
 
 	anymore = 0;
@@ -338,7 +338,7 @@
 		else
 			l->cps = (l->transcount * HZ) / (jiffies - last_jiffies);
 		l->transcount = 0;
-		if (dev->net_verbose > 3)
+		if (isdn_dev->net_verbose > 3)
 			printk(KERN_DEBUG "%s: %d bogocps\n", l->name, l->cps);
 		if ((l->flags & ISDN_NET_CONNECTED) && (!l->dialstate)) {
 			anymore = 1;
@@ -375,7 +375,7 @@
 					isdn_net_hangup(&p->dev);
 			}
 
-			if(dev->global_flags & ISDN_GLOBAL_STOPPED || (ISDN_NET_DIALMODE(*l) == ISDN_NET_DM_OFF)) {
+			if(isdn_dev->global_flags & ISDN_GLOBAL_STOPPED || (ISDN_NET_DIALMODE(*l) == ISDN_NET_DM_OFF)) {
 				isdn_net_hangup(&p->dev);
 				break;
 			}
@@ -400,7 +400,7 @@
 int
 isdn_net_stat_callback(int idx, isdn_ctrl *c)
 {
-	isdn_net_dev *p = dev->st_netdev[idx];
+	isdn_net_dev *p = isdn_dev->st_netdev[idx];
 	int cmd = c->command;
 
 	if (p) {
@@ -484,10 +484,10 @@
 					case 10:
 					case 12:
 						if (lp->dialstate <= 6) {
-							dev->usage[idx] |= ISDN_USAGE_OUTGOING;
+						        isdn_dev->usage[idx] |= ISDN_USAGE_OUTGOING;
 							isdn_info_update();
 						} else
-							dev->rx_netdev[idx] = p;
+						        isdn_dev->rx_netdev[idx] = p;
 						lp->dialstate = 0;
 						isdn_timer_ctrl(ISDN_TIMER_NETHANGUP, 1);
 						if (lp->p_encap == ISDN_NET_ENCAP_CISCOHDLCK)
@@ -565,7 +565,7 @@
 void
 isdn_net_dial(void)
 {
-	isdn_net_dev *p = dev->netdev;
+	isdn_net_dev *p = isdn_dev->netdev;
 	int anymore = 0;
 	int i;
 	unsigned long flags;
@@ -624,9 +624,9 @@
 				 * If list of phone-numbers is exhausted, increment
 				 * retry-counter.
 				 */
-				if(dev->global_flags & ISDN_GLOBAL_STOPPED || (ISDN_NET_DIALMODE(*lp) == ISDN_NET_DM_OFF)) {
+				if(isdn_dev->global_flags & ISDN_GLOBAL_STOPPED || (ISDN_NET_DIALMODE(*lp) == ISDN_NET_DM_OFF)) {
 					char *s;
-					if (dev->global_flags & ISDN_GLOBAL_STOPPED)
+					if (isdn_dev->global_flags & ISDN_GLOBAL_STOPPED)
 						s = "dial suppressed: isdn system stopped";
 					else
 						s = "dial suppressed: dialmode `off'";
@@ -696,8 +696,8 @@
 						isdn_map_eaz2msn(lp->msn, cmd.driver));
 					i = isdn_dc2minor(lp->isdn_device, lp->isdn_channel);
 					if (i >= 0) {
-						strcpy(dev->num[i], cmd.parm.setup.phone);
-						dev->usage[i] |= ISDN_USAGE_OUTGOING;
+						strcpy(isdn_dev->num[i], cmd.parm.setup.phone);
+						isdn_dev->usage[i] |= ISDN_USAGE_OUTGOING;
 						isdn_info_update();
 					}
 					printk(KERN_INFO "%s: dialing %d %s...\n", lp->name,
@@ -1263,7 +1263,7 @@
 					return 0;
 				}
 				/* Log packet, which triggered dialing */
-				if (dev->net_verbose)
+				if (isdn_dev->net_verbose)
 					isdn_net_log_skb(skb, lp);
 				lp->dialstate = 1;
 				/* Connect interface with channel */
@@ -1415,7 +1415,7 @@
 static struct sk_buff*
 isdn_net_ciscohdlck_alloc_skb(isdn_net_local *lp, int len)
 {
-	unsigned short hl = dev->drv[lp->isdn_device]->interface->hl_hdrlen;
+	unsigned short hl = isdn_dev->drv[lp->isdn_device]->interface->hl_hdrlen;
 	struct sk_buff *skb;
 
 	skb = alloc_skb(hl + len, GFP_ATOMIC);
@@ -1879,7 +1879,7 @@
 int
 isdn_net_rcv_skb(int idx, struct sk_buff *skb)
 {
-	isdn_net_dev *p = dev->rx_netdev[idx];
+	isdn_net_dev *p = isdn_dev->rx_netdev[idx];
 
 	if (p) {
 		isdn_net_local *lp = p->local;
@@ -2064,9 +2064,9 @@
 	 */
 
 	for (drvidx = 0; drvidx < ISDN_MAX_DRIVERS; drvidx++)
-		if (dev->drv[drvidx])
-			if (max_hlhdr_len < dev->drv[drvidx]->interface->hl_hdrlen)
-				max_hlhdr_len = dev->drv[drvidx]->interface->hl_hdrlen;
+		if (isdn_dev->drv[drvidx])
+			if (max_hlhdr_len < isdn_dev->drv[drvidx]->interface->hl_hdrlen)
+				max_hlhdr_len = isdn_dev->drv[drvidx]->interface->hl_hdrlen;
 
 	ndev->hard_header_len = ETH_HLEN + max_hlhdr_len;
 	ndev->stop = &isdn_net_close;
@@ -2084,7 +2084,7 @@
 #ifdef ISDN_DEBUG_NET_ICALL
 	printk(KERN_DEBUG "n_fi: swapping ch of %d\n", drvidx);
 #endif
-	p = dev->netdev;
+	p = isdn_dev->netdev;
 	while (p) {
 		if (p->local->pre_device == drvidx)
 			switch (p->local->pre_channel) {
@@ -2102,16 +2102,16 @@
 static void
 isdn_net_swap_usage(int i1, int i2)
 {
-	int u1 = dev->usage[i1] & ISDN_USAGE_EXCLUSIVE;
-	int u2 = dev->usage[i2] & ISDN_USAGE_EXCLUSIVE;
+	int u1 = isdn_dev->usage[i1] & ISDN_USAGE_EXCLUSIVE;
+	int u2 = isdn_dev->usage[i2] & ISDN_USAGE_EXCLUSIVE;
 
 #ifdef ISDN_DEBUG_NET_ICALL
 	printk(KERN_DEBUG "n_fi: usage of %d and %d\n", i1, i2);
 #endif
-	dev->usage[i1] &= ~ISDN_USAGE_EXCLUSIVE;
-	dev->usage[i1] |= u2;
-	dev->usage[i2] &= ~ISDN_USAGE_EXCLUSIVE;
-	dev->usage[i2] |= u1;
+	isdn_dev->usage[i1] &= ~ISDN_USAGE_EXCLUSIVE;
+	isdn_dev->usage[i1] |= u2;
+	isdn_dev->usage[i2] &= ~ISDN_USAGE_EXCLUSIVE;
+	isdn_dev->usage[i2] |= u1;
 	isdn_info_update();
 }
 
@@ -2161,21 +2161,21 @@
 		eaz = "0";
 	} else
 		eaz = setup->eazmsn;
-	if (dev->net_verbose > 1)
+	if (isdn_dev->net_verbose > 1)
 		printk(KERN_INFO "isdn_net: call from %s,%d,%d -> %s\n", nr, si1, si2, eaz);
 	/* Accept only calls with Si1 = 7 (Data-Transmission) */
 	if (si1 != 7) {
 		restore_flags(flags);
-		if (dev->net_verbose > 1)
+		if (isdn_dev->net_verbose > 1)
 			printk(KERN_INFO "isdn_net: Service-Indicator not 7, ignored\n");
 		return 0;
 	}
 	n = (isdn_net_phone *) 0;
-	p = dev->netdev;
+	p = isdn_dev->netdev;
 	ematch = wret = swapped = 0;
 #ifdef ISDN_DEBUG_NET_ICALL
 	printk(KERN_DEBUG "n_fi: di=%d ch=%d idx=%d usg=%d\n", di, ch, idx,
-	       dev->usage[idx]);
+	       isdn_dev->usage[idx]);
 #endif
 	while (p) {
 		int matchret;
@@ -2202,7 +2202,7 @@
 #endif
 		if ((!matchret) &&                                        /* EAZ is matching   */
 		    (((!(lp->flags & ISDN_NET_CONNECTED)) &&              /* but not connected */
-		      (USG_NONE(dev->usage[idx]))) ||                     /* and ch. unused or */
+		      (USG_NONE(isdn_dev->usage[idx]))) ||                     /* and ch. unused or */
 		     ((((lp->dialstate == 4) || (lp->dialstate == 12)) && /* if dialing        */
 		       (!(lp->flags & ISDN_NET_CALLBACK)))                /* but no callback   */
 		     )))
@@ -2211,7 +2211,7 @@
 			printk(KERN_DEBUG "n_fi: match1, pdev=%d pch=%d\n",
 			       lp->pre_device, lp->pre_channel);
 #endif
-			if (dev->usage[idx] & ISDN_USAGE_EXCLUSIVE) {
+			if (isdn_dev->usage[idx] & ISDN_USAGE_EXCLUSIVE) {
 				if ((lp->pre_channel != ch) ||
 				    (lp->pre_device != di)) {
 					/* Here we got a problem:
@@ -2228,10 +2228,10 @@
 #ifdef ISDN_DEBUG_NET_ICALL
 						printk(KERN_DEBUG "n_fi: ch is 0\n");
 #endif
-						if (USG_NONE(dev->usage[sidx])) {
+						if (USG_NONE(isdn_dev->usage[sidx])) {
 							/* Second Channel is free, now see if it is bound
 							 * exclusive too. */
-							if (dev->usage[sidx] & ISDN_USAGE_EXCLUSIVE) {
+							if (isdn_dev->usage[sidx] & ISDN_USAGE_EXCLUSIVE) {
 #ifdef ISDN_DEBUG_NET_ICALL
 								printk(KERN_DEBUG "n_fi: 2nd channel is down and bound\n");
 #endif
@@ -2259,7 +2259,7 @@
 #ifdef ISDN_DEBUG_NET_ICALL
 							printk(KERN_DEBUG "n_fi: final check\n");
 #endif
-							if ((dev->usage[idx] & ISDN_USAGE_EXCLUSIVE) &&
+							if ((isdn_dev->usage[idx] & ISDN_USAGE_EXCLUSIVE) &&
 							    ((lp->pre_channel != ch) ||
 							     (lp->pre_device != di))) {
 #ifdef ISDN_DEBUG_NET_ICALL
@@ -2404,11 +2404,11 @@
 						isdn_free_channel(lp->isdn_device, lp->isdn_channel,
 							 ISDN_USAGE_NET);
 					}
-					dev->usage[idx] &= ISDN_USAGE_EXCLUSIVE;
-					dev->usage[idx] |= ISDN_USAGE_NET;
-					strcpy(dev->num[idx], nr);
+					isdn_dev->usage[idx] &= ISDN_USAGE_EXCLUSIVE;
+					isdn_dev->usage[idx] |= ISDN_USAGE_NET;
+					strcpy(isdn_dev->num[idx], nr);
 					isdn_info_update();
-					dev->st_netdev[idx] = lp->netdev;
+					isdn_dev->st_netdev[idx] = lp->netdev;
 					lp->isdn_device = di;
 					lp->isdn_channel = ch;
 					lp->ppp_slot = -1;
@@ -2435,7 +2435,7 @@
 		p = (isdn_net_dev *) p->next;
 	}
 	/* If none of configured EAZ/MSN matched and not verbose, be silent */
-	if (!ematch || dev->net_verbose)
+	if (!ematch || isdn_dev->net_verbose)
 		printk(KERN_INFO "isdn_net: call from %s -> %d %s ignored\n", nr, di, eaz);
 	restore_flags(flags);
 	return (wret == 2)?5:0;
@@ -2447,7 +2447,7 @@
 isdn_net_dev *
 isdn_net_findif(char *name)
 {
-	isdn_net_dev *p = dev->netdev;
+	isdn_net_dev *p = isdn_dev->netdev;
 
 	while (p) {
 		if (!strcmp(p->local->name, name))
@@ -2631,8 +2631,8 @@
 	netdev->local->dialwait_timer = 0;  /* Jiffies of earliest next dial-start */
 
 	/* Put into to netdev-chain */
-	netdev->next = (void *) dev->netdev;
-	dev->netdev = netdev;
+	netdev->next = (void *) isdn_dev->netdev;
+	isdn_dev->netdev = netdev;
 	return netdev->dev.name;
 }
 
@@ -2688,8 +2688,8 @@
 		features = ((1 << cfg->l2_proto) << ISDN_FEATURE_L2_SHIFT) |
 			((1 << cfg->l3_proto) << ISDN_FEATURE_L3_SHIFT);
 		for (i = 0; i < ISDN_MAX_DRIVERS; i++)
-			if (dev->drv[i])
-				if ((dev->drv[i]->interface->features & features) == features)
+			if (isdn_dev->drv[i])
+				if ((isdn_dev->drv[i]->interface->features & features) == features)
 					break;
 		if (i == ISDN_MAX_DRIVERS) {
 			printk(KERN_WARNING "isdn_net: No driver with selected features\n");
@@ -2778,7 +2778,7 @@
 			}
 			for (i = 0; i < ISDN_MAX_DRIVERS; i++)
 				/* Lookup driver-Id in array */
-				if (!(strcmp(dev->drvid[i], drvid))) {
+				if (!(strcmp(isdn_dev->drvid[i], drvid))) {
 					drvidx = i;
 					break;
 				}
@@ -2804,7 +2804,7 @@
 				return -EBUSY;
 			}
 			/* All went ok, so update isdninfo */
-			dev->usage[i] = ISDN_USAGE_EXCLUSIVE;
+			isdn_dev->usage[i] = ISDN_USAGE_EXCLUSIVE;
 			isdn_info_update();
 			restore_flags(flags);
 			lp->exclusive = i;
@@ -2914,7 +2914,7 @@
 		strcpy(cfg->eaz, lp->msn);
 		cfg->exclusive = lp->exclusive;
 		if (lp->pre_device >= 0) {
-			sprintf(cfg->drvid, "%s,%d", dev->drvid[lp->pre_device],
+			sprintf(cfg->drvid, "%s,%d", isdn_dev->drvid[lp->pre_device],
 				lp->pre_channel);
 		} else
 			cfg->drvid[0] = '\0';
@@ -3031,9 +3031,9 @@
 	idx = isdn_dc2minor(dv, ch);
 	if (idx<0) return -ENODEV;
 	/* for pre-bound channels, we need this extra check */
-	if ( strncmp(dev->num[idx],"???",3) == 0 ) return -ENOTCONN;
-	strncpy(phone->phone,dev->num[idx],ISDN_MSNLEN);
-	phone->outgoing=USG_OUTGOING(dev->usage[idx]);
+	if ( strncmp(isdn_dev->num[idx],"???",3) == 0 ) return -ENOTCONN;
+	strncpy(phone->phone,isdn_dev->num[idx],ISDN_MSNLEN);
+	phone->outgoing=USG_OUTGOING(isdn_dev->usage[idx]);
 	if ( copy_to_user(peer,phone,sizeof(*peer)) ) return -EFAULT;
 	return 0;
 }
@@ -3163,11 +3163,11 @@
 	if (q)
 		q->next = p->next;
 	else
-		dev->netdev = p->next;
+		isdn_dev->netdev = p->next;
 	if (p->local->slave) {
 		/* If this interface has a slave, remove it also */
 		char *slavename = ((isdn_net_local *) (p->local->slave->priv))->name;
-		isdn_net_dev *n = dev->netdev;
+		isdn_net_dev *n = isdn_dev->netdev;
 		q = NULL;
 		while (n) {
 			if (!strcmp(n->local->name, slavename)) {
@@ -3179,7 +3179,7 @@
 		}
 	}
 	/* If no more net-devices remain, disable auto-hangup timer */
-	if (dev->netdev == NULL)
+	if (isdn_dev->netdev == NULL)
 		isdn_timer_ctrl(ISDN_TIMER_NETHANGUP, 0);
 	restore_flags(flags);
 	kfree(p->local);
@@ -3198,7 +3198,7 @@
 	isdn_net_dev *q;
 
 	/* Search name in netdev-chain */
-	p = dev->netdev;
+	p = isdn_dev->netdev;
 	q = NULL;
 	while (p) {
 		if (!strcmp(p->local->name, name))
@@ -3207,7 +3207,7 @@
 		p = (isdn_net_dev *) p->next;
 	}
 	/* If no more net-devices remain, disable auto-hangup timer */
-	if (dev->netdev == NULL)
+	if (isdn_dev->netdev == NULL)
 		isdn_timer_ctrl(ISDN_TIMER_NETHANGUP, 0);
 	return -ENODEV;
 }
@@ -3224,16 +3224,16 @@
 	/* Walk through netdev-chain */
 	save_flags(flags);
 	cli();
-	while (dev->netdev) {
-		if (!dev->netdev->local->master) {
+	while (isdn_dev->netdev) {
+		if (!isdn_dev->netdev->local->master) {
 			/* Remove master-devices only, slaves get removed with their master */
-			if ((ret = isdn_net_realrm(dev->netdev, NULL))) {
+			if ((ret = isdn_net_realrm(isdn_dev->netdev, NULL))) {
 				restore_flags(flags);
 				return ret;
 			}
 		}
 	}
-	dev->netdev = NULL;
+	isdn_dev->netdev = NULL;
 	restore_flags(flags);
 	return 0;
 }
diff -ur -X exclude linux-2.5.3-clean/drivers/isdn/isdn_tty.c linux/drivers/isdn/isdn_tty.c
--- linux-2.5.3-clean/drivers/isdn/isdn_tty.c	Thu Jan  3 12:20:10 2002
+++ linux/drivers/isdn/isdn_tty.c	Mon Feb  4 11:35:49 2002
@@ -128,8 +128,8 @@
 	modem_info *info;
 
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		if ((midx = dev->m_idx[i]) >= 0) {
-			info = &dev->mdm.info[midx];
+		if ((midx = isdn_dev->m_idx[i]) >= 0) {
+			info = &isdn_dev->mdm.info[midx];
 			if (info->online) {
 				r = 0;
 #ifdef CONFIG_ISDN_AUDIO
@@ -182,11 +182,11 @@
 #endif
 	modem_info *info;
 
-	if ((midx = dev->m_idx[i]) < 0) {
+	if ((midx = isdn_dev->m_idx[i]) < 0) {
 		/* if midx is invalid, packet is not for tty */
 		return 0;
 	}
-	info = &dev->mdm.info[midx];
+	info = &isdn_dev->mdm.info[midx];
 #ifdef CONFIG_ISDN_AUDIO
 	ifmt = 1;
 	
@@ -269,7 +269,7 @@
 	/* Try to deliver directly via tty-flip-buf if queue is empty */
 	save_flags(flags);
 	cli();
-	if (skb_queue_empty(&dev->drv[di]->rpqueue[channel]))
+	if (skb_queue_empty(&isdn_dev->drv[di]->rpqueue[channel]))
 		if (isdn_tty_try_read(info, skb)) {
 			restore_flags(flags);
 			return 1;
@@ -277,8 +277,8 @@
 	/* Direct deliver failed or queue wasn't empty.
 	 * Queue up for later dequeueing via timer-irq.
 	 */
-	__skb_queue_tail(&dev->drv[di]->rpqueue[channel], skb);
-	dev->drv[di]->rcvcount[channel] +=
+	__skb_queue_tail(&isdn_dev->drv[di]->rpqueue[channel], skb);
+	isdn_dev->drv[di]->rcvcount[channel] +=
 		(skb->len
 #ifdef CONFIG_ISDN_AUDIO
 		 + ISDN_AUDIO_SKB_DLECOUNT(skb)
@@ -286,7 +286,7 @@
 			);
 	restore_flags(flags);
 	/* Schedule dequeuing */
-	if ((dev->modempoll) && (info->rcvsched))
+	if ((isdn_dev->modempoll) && (info->rcvsched))
 		isdn_timer_ctrl(ISDN_TIMER_MODEMREAD, 1);
 	return 1;
 }
@@ -483,7 +483,7 @@
 		info->xmit_count = 0;
 		return;
 	}
-	skb_res = dev->drv[info->isdn_driver]->interface->hl_hdrlen + 4;
+	skb_res = isdn_dev->drv[info->isdn_driver]->interface->hl_hdrlen + 4;
 #ifdef CONFIG_ISDN_AUDIO
 	if (info->vonline & 2)
 		audio_len = buflen * voice_cf[info->emu.vpar[3]];
@@ -657,11 +657,11 @@
 		restore_flags(flags);
 		isdn_tty_modem_result(RESULT_NO_DIALTONE, info);
 	} else {
-		info->isdn_driver = dev->drvmap[i];
-		info->isdn_channel = dev->chanmap[i];
+		info->isdn_driver = isdn_dev->drvmap[i];
+		info->isdn_channel = isdn_dev->chanmap[i];
 		info->drv_index = i;
-		dev->m_idx[i] = info->line;
-		dev->usage[i] |= ISDN_USAGE_OUTGOING;
+		isdn_dev->m_idx[i] = info->line;
+		isdn_dev->usage[i] |= ISDN_USAGE_OUTGOING;
 		info->last_dir = 1;
 		strcpy(info->last_num, n);
 		isdn_info_update();
@@ -699,7 +699,7 @@
 		cmd.command = ISDN_CMD_DIAL;
 		info->dialing = 1;
 		info->emu.carrierwait = 0;
-		strcpy(dev->num[i], n);
+		strcpy(isdn_dev->num[i], n);
 		isdn_info_update();
 		isdn_command(&cmd);
 		isdn_timer_ctrl(ISDN_TIMER_CARRIER, 1);
@@ -780,7 +780,7 @@
 	isdn_free_channel(di, ch, 0);
 
 	if (info->drv_index >= 0) {
-		dev->m_idx[info->drv_index] = -1;
+		isdn_dev->m_idx[info->drv_index] = -1;
 		info->drv_index = -1;
 	}
 }
@@ -876,11 +876,11 @@
 		restore_flags(flags);
 		isdn_tty_modem_result(RESULT_NO_DIALTONE, info);
 	} else {
-		info->isdn_driver = dev->drvmap[i];
-		info->isdn_channel = dev->chanmap[i];
+		info->isdn_driver = isdn_dev->drvmap[i];
+		info->isdn_channel = isdn_dev->chanmap[i];
 		info->drv_index = i;
-		dev->m_idx[i] = info->line;
-		dev->usage[i] |= ISDN_USAGE_OUTGOING;
+		isdn_dev->m_idx[i] = info->line;
+		isdn_dev->usage[i] |= ISDN_USAGE_OUTGOING;
 		info->last_dir = 1;
 //		strcpy(info->last_num, n);
 		isdn_info_update();
@@ -917,7 +917,7 @@
 		strncpy(&cmd.parm.cmsg.para[6], id, l);
 		cmd.command =CAPI_PUT_MESSAGE;
 		info->dialing = 1;
-//		strcpy(dev->num[i], n);
+//		strcpy(isdn_dev->num[i], n);
 		isdn_info_update();
 		isdn_command(&cmd);
 		isdn_timer_ctrl(ISDN_TIMER_CARRIER, 1);
@@ -970,11 +970,11 @@
 		restore_flags(flags);
 		isdn_tty_modem_result(RESULT_NO_DIALTONE, info);
 	} else {
-		info->isdn_driver = dev->drvmap[i];
-		info->isdn_channel = dev->chanmap[i];
+		info->isdn_driver = isdn_dev->drvmap[i];
+		info->isdn_channel = isdn_dev->chanmap[i];
 		info->drv_index = i;
-		dev->m_idx[i] = info->line;
-		dev->usage[i] |= ISDN_USAGE_OUTGOING;
+		isdn_dev->m_idx[i] = info->line;
+		isdn_dev->usage[i] |= ISDN_USAGE_OUTGOING;
 		info->last_dir = 1;
 		isdn_info_update();
 		restore_flags(flags);
@@ -1006,7 +1006,7 @@
 		cmd.parm.cmsg.para[l+1] = 0xd;
 		cmd.command =CAPI_PUT_MESSAGE;
 /*		info->dialing = 1;
-		strcpy(dev->num[i], n);
+		strcpy(isdn_dev->num[i], n);
 		isdn_info_update();
 */
 		isdn_command(&cmd);
@@ -1186,8 +1186,8 @@
 		c = count;
 		if (c > info->xmit_size - info->xmit_count)
 			c = info->xmit_size - info->xmit_count;
-		if (info->isdn_driver >= 0 && c > dev->drv[info->isdn_driver]->maxbufsize)
-			c = dev->drv[info->isdn_driver]->maxbufsize;
+		if (info->isdn_driver >= 0 && c > isdn_dev->drv[info->isdn_driver]->maxbufsize)
+			c = isdn_dev->drv[info->isdn_driver]->maxbufsize;
 		if (c <= 0)
 			break;
 		if ((info->online > 1)
@@ -1743,7 +1743,7 @@
 	line = minor(tty->device) - tty->driver.minor_start;
 	if (line < 0 || line > ISDN_MAX_CHANNELS)
 		return -ENODEV;
-	info = &dev->mdm.info[line];
+	info = &isdn_dev->mdm.info[line];
 	if (isdn_tty_paranoia_check(info, tty->device, "isdn_tty_open"))
 		return -ENODEV;
 #ifdef ISDN_DEBUG_MODEM_OPEN
@@ -1782,7 +1782,7 @@
 #ifdef ISDN_DEBUG_MODEM_OPEN
 	printk(KERN_DEBUG "isdn_tty_open ttyi%d successful...\n", info->line);
 #endif
-	dev->modempoll++;
+	isdn_dev->modempoll++;
 #ifdef ISDN_DEBUG_MODEM_OPEN
 	printk(KERN_DEBUG "isdn_tty_open normal exit\n");
 #endif
@@ -1863,7 +1863,7 @@
 				break;
 		}
 	}
-	dev->modempoll--;
+	isdn_dev->modempoll--;
 	isdn_tty_shutdown(info);
 	if (tty->driver.flush_buffer)
 		tty->driver.flush_buffer(tty);
@@ -2006,8 +2006,8 @@
 	memcpy(m->profile, m->mdmreg, ISDN_MODEM_NUMREG);
 	memcpy(m->pmsn, m->msn, ISDN_MSNLEN);
 	memcpy(m->plmsn, m->lmsn, ISDN_LMSNLEN);
-	if (dev->profd)
-		send_sig(SIGIO, dev->profd, 1);
+	if (isdn_dev->profd)
+		send_sig(SIGIO, isdn_dev->profd, 1);
 }
 
 int
@@ -2017,7 +2017,7 @@
 	int i;
 	modem_info *info;
 
-	m = &dev->mdm;
+	m = &isdn_dev->mdm;
 	memset(&m->tty_modem, 0, sizeof(struct tty_driver));
 	m->tty_modem.magic = TTY_DRIVER_MAGIC;
 	m->tty_modem.name = isdn_ttyname_ttyI;
@@ -2206,7 +2206,7 @@
 	save_flags(flags);
 	cli();
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		modem_info *info = &dev->mdm.info[i];
+		modem_info *info = &isdn_dev->mdm.info[i];
 
                 if (info->count == 0)
                     continue;
@@ -2217,7 +2217,7 @@
 			printk(KERN_DEBUG "m_fi: match1 wret=%d\n", wret);
 			printk(KERN_DEBUG "m_fi: idx=%d flags=%08lx drv=%d ch=%d usg=%d\n", idx,
 			       info->flags, info->isdn_driver, info->isdn_channel,
-			       dev->usage[idx]);
+			       isdn_dev->usage[idx]);
 #endif
 			if (
 #ifndef FIX_FILE_TRANSFER
@@ -2225,7 +2225,7 @@
 #endif
 				(info->isdn_driver == -1) &&
 				(info->isdn_channel == -1) &&
-				(USG_NONE(dev->usage[idx]))) {
+				(USG_NONE(isdn_dev->usage[idx]))) {
 				int matchret;
 
 				if ((matchret = isdn_tty_match_icall(eaz, &info->emu, di)) > wret)
@@ -2234,10 +2234,10 @@
 					info->isdn_driver = di;
 					info->isdn_channel = ch;
 					info->drv_index = idx;
-					dev->m_idx[idx] = info->line;
-					dev->usage[idx] &= ISDN_USAGE_EXCLUSIVE;
-					dev->usage[idx] |= isdn_calc_usage(si1, info->emu.mdmreg[REG_L2PROT]); 
-					strcpy(dev->num[idx], nr);
+					isdn_dev->m_idx[idx] = info->line;
+					isdn_dev->usage[idx] &= ISDN_USAGE_EXCLUSIVE;
+					isdn_dev->usage[idx] |= isdn_calc_usage(si1, info->emu.mdmreg[REG_L2PROT]); 
+					strcpy(isdn_dev->num[idx], nr);
 					strcpy(info->emu.cpn, eaz);
 					info->emu.mdmreg[REG_SI1I] = si2bit[si1];
 					info->emu.mdmreg[REG_PLAN] = setup->plan;
@@ -2256,7 +2256,7 @@
 	}
 	restore_flags(flags);
 	printk(KERN_INFO "isdn_tty: call from %s -> %s %s\n", nr, eaz,
-	       ((dev->drv[di]->flags & DRV_FLAG_REJBUS) && (wret != 2))? "rejected" : "ignored");
+	       ((isdn_dev->drv[di]->flags & DRV_FLAG_REJBUS) && (wret != 2))? "rejected" : "ignored");
 	return (wret == 2)?3:0;
 }
 
@@ -2272,8 +2272,8 @@
 
 	if (i < 0)
 		return 0;
-	if ((mi = dev->m_idx[i]) >= 0) {
-		info = &dev->mdm.info[mi];
+	if ((mi = isdn_dev->m_idx[i]) >= 0) {
+		info = &isdn_dev->mdm.info[mi];
 		switch (c->command) {
                         case ISDN_STAT_CINF:
                                 printk(KERN_DEBUG "CHARGEINFO on ttyI%d: %ld %s\n", info->line, c->arg, c->parm.num);
@@ -2371,14 +2371,14 @@
 						info->last_dir = 0;
 					info->dialing = 0;
 					info->rcvsched = 1;
-					if (USG_MODEM(dev->usage[i])) {
+					if (USG_MODEM(isdn_dev->usage[i])) {
 						if (info->emu.mdmreg[REG_L2PROT] == ISDN_PROTO_L2_MODEM) {
 							strcpy(info->emu.connmsg, c->parm.num);
 							isdn_tty_modem_result(RESULT_CONNECT, info);
 						} else
 							isdn_tty_modem_result(RESULT_CONNECT64000, info);
 					}
-					if (USG_VOICE(dev->usage[i]))
+					if (USG_VOICE(isdn_dev->usage[i]))
 						isdn_tty_modem_result(RESULT_VCON, info);
 					return 1;
 				}
@@ -2416,7 +2416,7 @@
 				printk(KERN_DEBUG "tty_STAT_UNLOAD ttyI%d\n", info->line);
 #endif
 				for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-					info = &dev->mdm.info[i];
+					info = &isdn_dev->mdm.info[i];
 					if (info->isdn_driver == c->driver) {
 						if (info->online)
 							isdn_tty_modem_hup(info, 1);
@@ -2485,7 +2485,7 @@
 	/* use queue instead of direct flip, if online and */
 	/* data is in queue or flip buffer is full */
 	if ((info->online) && (((tty->flip.count + strlen(msg)) >= TTY_FLIPBUF_SIZE) ||
-	    (!skb_queue_empty(&dev->drv[info->isdn_driver]->rpqueue[info->isdn_channel])))) {
+	    (!skb_queue_empty(&isdn_dev->drv[info->isdn_driver]->rpqueue[info->isdn_channel])))) {
 		skb = alloc_skb(strlen(msg)
 #ifdef CONFIG_ISDN_AUDIO
 			+ sizeof(isdn_audio_skb)
@@ -2528,11 +2528,11 @@
 		}
 	}
 	if (skb) {
-		__skb_queue_tail(&dev->drv[info->isdn_driver]->rpqueue[info->isdn_channel], skb);
-		dev->drv[info->isdn_driver]->rcvcount[info->isdn_channel] += skb->len;
+		__skb_queue_tail(&isdn_dev->drv[info->isdn_driver]->rpqueue[info->isdn_channel], skb);
+		isdn_dev->drv[info->isdn_driver]->rcvcount[info->isdn_channel] += skb->len;
 		restore_flags(flags);
 		/* Schedule dequeuing */
-		if ((dev->modempoll) && (info->rcvsched))
+		if ((isdn_dev->modempoll) && (info->rcvsched))
 			isdn_timer_ctrl(ISDN_TIMER_MODEMREAD, 1);
 
 	} else {
@@ -2706,7 +2706,7 @@
 			    /* print CID, _before_ _every_ ring */
 			    if (!(m->mdmreg[REG_CIDONCE] & BIT_CIDONCE)) {
 				    isdn_tty_at_cout("\r\nCALLER NUMBER: ", info);
-				    isdn_tty_at_cout(dev->num[info->drv_index], info);
+				    isdn_tty_at_cout(isdn_dev->num[info->drv_index], info);
 				    if (m->mdmreg[REG_CDN] & BIT_CDN) {
 					    isdn_tty_at_cout("\r\nCALLED NUMBER: ", info);
 					    isdn_tty_at_cout(info->emu.cpn, info);
@@ -2735,7 +2735,7 @@
 					    (m->mdmreg[REG_RINGCNT] == 1)) {
 						isdn_tty_at_cout("\r\n", info);
 						isdn_tty_at_cout("CALLER NUMBER: ", info);
-						isdn_tty_at_cout(dev->num[info->drv_index], info);
+						isdn_tty_at_cout(isdn_dev->num[info->drv_index], info);
 						if (m->mdmreg[REG_CDN] & BIT_CDN) {
 							isdn_tty_at_cout("\r\nCALLED NUMBER: ", info);
 							isdn_tty_at_cout(info->emu.cpn, info);
@@ -3247,7 +3247,7 @@
 	if (info->msr & UART_MSR_RI) {
 		/* Accept incoming call */
 		info->last_dir = 0;
-		strcpy(info->last_num, dev->num[info->drv_index]);
+		strcpy(info->last_num, isdn_dev->num[info->drv_index]);
 		m->mdmreg[REG_RINGCNT] = 0;
 		info->msr &= ~UART_MSR_RI;
 		l2 = m->mdmreg[REG_L2PROT];
@@ -3326,7 +3326,7 @@
 #ifdef CONFIG_ISDN_TTY_FAX
 					case '1':
 						p[0]++;
-						if (!(dev->global_features &
+						if (!(isdn_dev->global_features &
 							ISDN_FEATURE_L3_FCLASS1))
 							PARSE_ERROR1;
 						m->mdmreg[REG_SI1] = 1;
@@ -3337,7 +3337,7 @@
 						break;
 					case '2':
 						p[0]++;
-						if (!(dev->global_features &
+						if (!(isdn_dev->global_features &
 							ISDN_FEATURE_L3_FCLASS2))
 							PARSE_ERROR1;
 						m->mdmreg[REG_SI1] = 1;
@@ -3359,10 +3359,10 @@
 						p[0]++;
 						strcpy(rs, "\r\n0,");
 #ifdef CONFIG_ISDN_TTY_FAX
-						if (dev->global_features &
+						if (isdn_dev->global_features &
 							ISDN_FEATURE_L3_FCLASS1)
 							strcat(rs, "1,");
-						if (dev->global_features &
+						if (isdn_dev->global_features &
 							ISDN_FEATURE_L3_FCLASS2)
 							strcat(rs, "2,");
 #endif
@@ -3968,9 +3968,9 @@
 	int midx;
 
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++)
-		if (USG_MODEM(dev->usage[i]))
-			if ((midx = dev->m_idx[i]) >= 0) {
-				modem_info *info = &dev->mdm.info[midx];
+		if (USG_MODEM(isdn_dev->usage[i]))
+			if ((midx = isdn_dev->m_idx[i]) >= 0) {
+				modem_info *info = &isdn_dev->mdm.info[midx];
 				if (info->online) {
 					ton = 1;
 					if ((info->emu.pluscount == 3) &&
@@ -3996,7 +3996,7 @@
 	int i;
 
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		modem_info *info = &dev->mdm.info[i];
+		modem_info *info = &isdn_dev->mdm.info[i];
 		if (info->msr & UART_MSR_RI) {
 			ton = 1;
 			isdn_tty_modem_result(RESULT_RING, info);
@@ -4016,7 +4016,7 @@
 	int i;
 
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		modem_info *info = &dev->mdm.info[i];
+		modem_info *info = &isdn_dev->mdm.info[i];
 		if (info->online) {
 			ton = 1;
 			isdn_tty_senddown(info);
@@ -4037,7 +4037,7 @@
 	int i;
 
 	for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
-		modem_info *info = &dev->mdm.info[i];
+		modem_info *info = &isdn_dev->mdm.info[i];
 		if (info->dialing) {
 			if (info->emu.carrierwait++ > info->emu.mdmreg[REG_WAITC]) {
 				info->dialing = 0;
diff -ur -X exclude linux-2.5.3-clean/drivers/isdn/isdn_ttyfax.c linux/drivers/isdn/isdn_ttyfax.c
--- linux-2.5.3-clean/drivers/isdn/isdn_ttyfax.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/isdn_ttyfax.c	Mon Feb  4 11:35:49 2002
@@ -74,7 +74,7 @@
 		case 2:	/* +FCON */
 			/* Append CPN, if enabled */
 			if ((m->mdmreg[REG_CPNFCON] & BIT_CPNFCON) &&
-				(!(dev->usage[info->isdn_channel] & ISDN_USAGE_OUTGOING))) {
+				(!(isdn_dev->usage[info->isdn_channel] & ISDN_USAGE_OUTGOING))) {
 				sprintf(rs, "/%s", m->cpn);
 				isdn_tty_at_cout(rs, info);
 			}
@@ -380,10 +380,10 @@
 			restore_flags(flags);
 			PARSE_ERROR1;
 		}
-		info->isdn_driver = dev->drvmap[i];
-		info->isdn_channel = dev->chanmap[i];
+		info->isdn_driver = isdn_dev->drvmap[i];
+		info->isdn_channel = isdn_dev->chanmap[i];
 		info->drv_index = i;
-		dev->m_idx[i] = info->line;
+		isdn_dev->m_idx[i] = info->line;
 		c.driver = info->isdn_driver;
 		c.arg = info->isdn_channel;
 		isdn_command(&c);
@@ -392,7 +392,7 @@
 		info->isdn_driver = -1;
 		info->isdn_channel = -1;
 		if (info->drv_index >= 0) {
-			dev->m_idx[info->drv_index] = -1;
+			isdn_dev->m_idx[info->drv_index] = -1;
 			info->drv_index = -1;
 		}
 		restore_flags(flags);
diff -ur -X exclude linux-2.5.3-clean/drivers/isdn/isdn_v110.c linux/drivers/isdn/isdn_v110.c
--- linux-2.5.3-clean/drivers/isdn/isdn_v110.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/isdn_v110.c	Mon Feb  4 11:35:49 2002
@@ -531,9 +531,9 @@
 			 * send down an Idle-Frame (or an Sync-Frame, if
 			 * v->SyncInit != 0). 
 			 */
-			if (!(v = dev->v110[idx]))
+			if (!(v = isdn_dev->v110[idx]))
 				return 0;
-			atomic_inc(&dev->v110use[idx]);
+			atomic_inc(&isdn_dev->v110use[idx]);
 			if (v->skbidle > 0) {
 				v->skbidle--;
 				ret = 1;
@@ -549,7 +549,7 @@
 				else
 					skb = isdn_v110_idle(v);
 				if (skb) {
-					if (dev->drv[c->driver]->interface->writebuf_skb(c->driver, c->arg, 1, skb) <= 0) {
+					if (isdn_dev->drv[c->driver]->interface->writebuf_skb(c->driver, c->arg, 1, skb) <= 0) {
 						dev_kfree_skb(skb);
 						break;
 					} else {
@@ -560,41 +560,41 @@
 				} else
 					break;
 			}
-			atomic_dec(&dev->v110use[idx]);
+			atomic_dec(&isdn_dev->v110use[idx]);
 			return ret;
 		case ISDN_STAT_DHUP:
 		case ISDN_STAT_BHUP:
 			while (1) {
-				atomic_inc(&dev->v110use[idx]);
-				if (atomic_dec_and_test(&dev->v110use[idx])) {
-					isdn_v110_close(dev->v110[idx]);
-					dev->v110[idx] = NULL;
+				atomic_inc(&isdn_dev->v110use[idx]);
+				if (atomic_dec_and_test(&isdn_dev->v110use[idx])) {
+					isdn_v110_close(isdn_dev->v110[idx]);
+					isdn_dev->v110[idx] = NULL;
 					break;
 				}
 				sti();
 			}
 			break;
 		case ISDN_STAT_BCONN:
-			if (dev->v110emu[idx] && (dev->v110[idx] == NULL)) {
-				int hdrlen = dev->drv[c->driver]->interface->hl_hdrlen;
-				int maxsize = dev->drv[c->driver]->interface->maxbufsize;
-				atomic_inc(&dev->v110use[idx]);
-				switch (dev->v110emu[idx]) {
+			if (isdn_dev->v110emu[idx] && (isdn_dev->v110[idx] == NULL)) {
+				int hdrlen = isdn_dev->drv[c->driver]->interface->hl_hdrlen;
+				int maxsize = isdn_dev->drv[c->driver]->interface->maxbufsize;
+				atomic_inc(&isdn_dev->v110use[idx]);
+				switch (isdn_dev->v110emu[idx]) {
 					case ISDN_PROTO_L2_V11096:
-						dev->v110[idx] = isdn_v110_open(V110_9600, hdrlen, maxsize);
+						isdn_dev->v110[idx] = isdn_v110_open(V110_9600, hdrlen, maxsize);
 						break;
 					case ISDN_PROTO_L2_V11019:
-						dev->v110[idx] = isdn_v110_open(V110_19200, hdrlen, maxsize);
+						isdn_dev->v110[idx] = isdn_v110_open(V110_19200, hdrlen, maxsize);
 						break;
 					case ISDN_PROTO_L2_V11038:
-						dev->v110[idx] = isdn_v110_open(V110_38400, hdrlen, maxsize);
+						isdn_dev->v110[idx] = isdn_v110_open(V110_38400, hdrlen, maxsize);
 						break;
 					default:;
 				}
-				if ((v = dev->v110[idx])) {
+				if ((v = isdn_dev->v110[idx])) {
 					while (v->SyncInit) {
 						struct sk_buff *skb = isdn_v110_sync(v);
-						if (dev->drv[c->driver]->interface->writebuf_skb(c->driver, c->arg, 1, skb) <= 0) {
+						if (isdn_dev->drv[c->driver]->interface->writebuf_skb(c->driver, c->arg, 1, skb) <= 0) {
 							dev_kfree_skb(skb);
 							/* Unable to send, try later */
 							break;
@@ -604,7 +604,7 @@
 					}
 				} else
 					printk(KERN_WARNING "isdn_v110: Couldn't open stream for chan %d\n", idx);
-				atomic_dec(&dev->v110use[idx]);
+				atomic_dec(&isdn_dev->v110use[idx]);
 			}
 			break;
 		default:
--- linux-2.5.3-clean/include/linux/isdn.h	Sun Jan 27 11:33:38 2002
+++ linux/include/linux/isdn.h	Mon Feb  4 12:30:23 2002
@@ -636,9 +636,9 @@
 	devfs_handle_t devfs_handle_ipppX[ISDN_MAX_CHANNELS];
 #endif
 #endif /* CONFIG_DEVFS_FS */
-} isdn_dev;
+} isdn_dev_t;
 
-extern isdn_dev *dev;
+extern isdn_dev_t *isdn_dev;
 
 
 #endif /* __KERNEL__ */
