Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314228AbSESHHs>; Sun, 19 May 2002 03:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314239AbSESHHn>; Sun, 19 May 2002 03:07:43 -0400
Received: from panda.sul.com.br ([200.219.150.4]:43024 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S314228AbSESHHg>;
	Sun, 19 May 2002 03:07:36 -0400
Date: Sat, 18 May 2002 22:07:12 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [BKPATCH] ISDN: Re: AUDIT of 2.5.15 copy_to/from_user
Message-ID: <20020519010712.GC4279@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Rusty Russell <rusty@rustcorp.com.au>,
	<linux-kernel@vger.kernel.org>,
	<kernel-janitor-discuss@lists.sourceforge.net>
In-Reply-To: <20020519001915.GA4279@conectiva.com.br> <Pine.LNX.4.44.0205190128060.11522-100000@chaos.physics.uiowa.edu> <20020519004558.GB4279@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 18, 2002 at 09:45:58PM -0300, Arnaldo C. Melo escreveu:
> Em Sun, May 19, 2002 at 01:30:34AM -0500, Kai Germaschewski escreveu:
> > On Sat, 18 May 2002, Arnaldo Carvalho de Melo wrote:
> > 
> > > ISDN will be on its way to Linus in some minutes...
> > 
> > I surely remember fixing that some months back already. Apparently I lost 
> > the patch somewhere on the way ;( 
> > 
> > Anyway, I'll be happy to do this for ISDN, but if you have it already
> > done, go ahead (and CC me when you submit it, please).
> 
> Of course, I'm finishing it in some minutes.

Here it is,

	Linus/Kai, please consider pulling it from:

http://kernel-acme.bkbits.net:8080/isdn-copy_tofrom_user-2.5

- Arnaldo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.544   -> 1.545  
#	drivers/isdn/isdnloop/isdnloop.c	1.8     -> 1.9    
#	drivers/isdn/hardware/avm/c4.c	1.25    -> 1.26   
#	drivers/isdn/eicon/eicon_mod.c	1.7     -> 1.8    
#	drivers/isdn/tpam/tpam_commands.c	1.3     -> 1.4    
#	drivers/isdn/i4l/isdn_tty.c	1.11    -> 1.12   
#	drivers/isdn/act2000/module.c	1.4     -> 1.5    
#	drivers/isdn/sc/command.c	1.3     -> 1.4    
#	drivers/isdn/hardware/avm/b1.c	1.16    -> 1.17   
#	drivers/isdn/hisax/isar.c	1.8     -> 1.9    
#	drivers/isdn/icn/icn.c	1.8     -> 1.9    
#	drivers/isdn/sc/ioctl.c	1.2     -> 1.3    
#	drivers/isdn/i4l/isdn_ppp.c	1.16    -> 1.17   
#	drivers/isdn/capi/kcapi.c	1.30    -> 1.31   
#	drivers/isdn/hisax/config.c	1.16    -> 1.17   
#	drivers/isdn/divert/divert_procfs.c	1.8     -> 1.9    
#	drivers/isdn/capi/capi.c	1.29    -> 1.30   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/19	acme@conectiva.com.br	1.545
# drivers/isdn/*.c
# 
# 	- fix copy_{to,from}_user error handling (thanks to Rusty for pointing this out)
# --------------------------------------------
#
diff -Nru a/drivers/isdn/act2000/module.c b/drivers/isdn/act2000/module.c
--- a/drivers/isdn/act2000/module.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/act2000/module.c	Sun May 19 03:59:20 2002
@@ -283,16 +283,18 @@
 					actcapi_manufacturer_req_net(card);
 					return 0;
 				case ACT2000_IOCTL_SETMSN:
-					if ((ret = copy_from_user(tmp, (char *)a, sizeof(tmp))))
-						return ret;
+					if (copy_from_user(tmp, (char *)a,
+							   sizeof(tmp)))
+						return -EFAULT;
 					if ((ret = act2000_set_msn(card, tmp)))
 						return ret;
 					if (card->flags & ACT2000_FLAGS_RUNNING)
 						return(actcapi_manufacturer_req_msn(card));
 					return 0;
 				case ACT2000_IOCTL_ADDCARD:
-					if ((ret = copy_from_user(&cdef, (char *)a, sizeof(cdef))))
-						return ret;
+					if (copy_from_user(&cdef, (char *)a,
+							   sizeof(cdef)))
+						return -EFAULT;
 					if (act2000_addcard(cdef.bus, cdef.port, cdef.irq, cdef.id))
 						return -EIO;
 					return 0;
diff -Nru a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/capi/capi.c	Sun May 19 03:59:20 2002
@@ -673,10 +673,9 @@
 		skb_queue_head(&cdev->recvqueue, skb);
 		return -EMSGSIZE;
 	}
-	retval = copy_to_user(buf, skb->data, skb->len);
-	if (retval) {
+	if (copy_to_user(buf, skb->data, skb->len)) {
 		skb_queue_head(&cdev->recvqueue, skb);
-		return retval;
+		return -EFAULT;
 	}
 	copied = skb->len;
 
@@ -703,7 +702,7 @@
 	if (!skb)
 		return -ENOMEM;
 
-	if ((retval = copy_from_user(skb_put(skb, count), buf, count))) {
+	if (copy_from_user(skb_put(skb, count), buf, count)) {
 		kfree_skb(skb);
 		return -EFAULT;
 	}
@@ -782,45 +781,36 @@
 
 	case CAPI_GET_VERSION:
 		{
-			retval = copy_from_user((void *) &data.contr,
+			if (copy_from_user((void *) &data.contr,
 						(void *) arg,
-						sizeof(data.contr));
-			if (retval)
+						sizeof(data.contr)))
 				return -EFAULT;
 		        cdev->errcode = capi20_get_version(data.contr, &data.version);
 			if (cdev->errcode)
 				return -EIO;
-			retval = copy_to_user((void *) arg,
-					      (void *) &data.version,
-					      sizeof(data.version));
-			if (retval)
+			if (copy_to_user((void *)arg, (void *)&data.version,
+					 sizeof(data.version)))
 				return -EFAULT;
 		}
 		return 0;
 
 	case CAPI_GET_SERIAL:
 		{
-			retval = copy_from_user((void *) &data.contr,
-						(void *) arg,
-						sizeof(data.contr));
-			if (retval)
+			if (copy_from_user((void *)&data.contr, (void *)arg,
+					   sizeof(data.contr)))
 				return -EFAULT;
 			cdev->errcode = capi20_get_serial (data.contr, data.serial);
 			if (cdev->errcode)
 				return -EIO;
-			retval = copy_to_user((void *) arg,
-					      (void *) data.serial,
-					      sizeof(data.serial));
-			if (retval)
+			if (copy_to_user((void *)arg, (void *)data.serial,
+					 sizeof(data.serial)))
 				return -EFAULT;
 		}
 		return 0;
 	case CAPI_GET_PROFILE:
 		{
-			retval = copy_from_user((void *) &data.contr,
-						(void *) arg,
-						sizeof(data.contr));
-			if (retval)
+			if (copy_from_user((void *)&data.contr, (void *)arg,
+					   sizeof(data.contr)))
 				return -EFAULT;
 
 			if (data.contr == 0) {
@@ -848,18 +838,15 @@
 
 	case CAPI_GET_MANUFACTURER:
 		{
-			retval = copy_from_user((void *) &data.contr,
-						(void *) arg,
-						sizeof(data.contr));
-			if (retval)
+			if (copy_from_user((void *)&data.contr, (void *)arg,
+					   sizeof(data.contr)))
 				return -EFAULT;
 			cdev->errcode = capi20_get_manufacturer(data.contr, data.manufacturer);
 			if (cdev->errcode)
 				return -EIO;
 
-			retval = copy_to_user((void *) arg, (void *) data.manufacturer,
-					      sizeof(data.manufacturer));
-			if (retval)
+			if (copy_to_user((void *)arg, (void *)data.manufacturer,
+					 sizeof(data.manufacturer)))
 				return -EFAULT;
 
 		}
@@ -868,10 +855,8 @@
 		data.errcode = cdev->errcode;
 		cdev->errcode = CAPI_NOERROR;
 		if (arg) {
-			retval = copy_to_user((void *) arg,
-					      (void *) &data.errcode,
-					      sizeof(data.errcode));
-			if (retval)
+			if (copy_to_user((void *)arg, (void *)&data.errcode,
+					 sizeof(data.errcode)))
 				return -EFAULT;
 		}
 		return data.errcode;
@@ -886,9 +871,8 @@
 			struct capi_manufacturer_cmd mcmd;
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
-			retval = copy_from_user((void *) &mcmd, (void *) arg,
-						sizeof(mcmd));
-			if (retval)
+			if (copy_from_user((void *)&mcmd, (void *)arg,
+					   sizeof(mcmd)))
 				return -EFAULT;
 			return capi20_manufacturer(mcmd.cmd, mcmd.data);
 		}
@@ -898,10 +882,8 @@
 	case CAPI_CLR_FLAGS:
 		{
 			unsigned userflags;
-			retval = copy_from_user((void *) &userflags,
-						(void *) arg,
-						sizeof(userflags));
-			if (retval)
+			if (copy_from_user((void *)&userflags, (void *)arg,
+					   sizeof(userflags)))
 				return -EFAULT;
 			if (cmd == CAPI_SET_FLAGS)
 				cdev->userflags |= userflags;
@@ -911,13 +893,9 @@
 		return 0;
 
 	case CAPI_GET_FLAGS:
-		{
-			retval = copy_to_user((void *) arg,
-					      (void *) &cdev->userflags,
-					      sizeof(cdev->userflags));
-			if (retval)
-				return -EFAULT;
-		}
+		if (copy_to_user((void *)arg, (void *)&cdev->userflags,
+				 sizeof(cdev->userflags)))
+			return -EFAULT;
 		return 0;
 
 	case CAPI_NCCI_OPENCOUNT:
@@ -928,10 +906,8 @@
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
 			unsigned ncci;
 			int count = 0;
-			retval = copy_from_user((void *) &ncci,
-						(void *) arg,
-						sizeof(ncci));
-			if (retval)
+			if (copy_from_user((void *)&ncci, (void *)arg,
+					   sizeof(ncci)))
 				return -EFAULT;
 			nccip = capincci_find(cdev, (u32) ncci);
 			if (!nccip)
@@ -951,10 +927,8 @@
 			struct capincci *nccip;
 			struct capiminor *mp;
 			unsigned ncci;
-			retval = copy_from_user((void *) &ncci,
-						(void *) arg,
-						sizeof(ncci));
-			if (retval)
+			if (copy_from_user((void *)&ncci, (void *)arg,
+					   sizeof(ncci)))
 				return -EFAULT;
 			nccip = capincci_find(cdev, (u32) ncci);
 			if (!nccip || (mp = nccip->minorp) == 0)
diff -Nru a/drivers/isdn/capi/kcapi.c b/drivers/isdn/capi/kcapi.c
--- a/drivers/isdn/capi/kcapi.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/capi/kcapi.c	Sun May 19 03:59:20 2002
@@ -1060,15 +1060,15 @@
 	case AVMB1_LOAD_AND_CONFIG:
 
 		if (cmd == AVMB1_LOAD) {
-			if ((retval = copy_from_user((void *) &ldef, data,
-						sizeof(avmb1_loaddef))))
-				return retval;
+			if (copy_from_user((void *)&ldef, data,
+					   sizeof(avmb1_loaddef)))
+				return -EFAULT;
 			ldef.t4config.len = 0;
 			ldef.t4config.data = 0;
 		} else {
-			if ((retval = copy_from_user((void *) &ldef, data,
-					    	sizeof(avmb1_loadandconfigdef))))
-				return retval;
+			if (copy_from_user((void *)&ldef, data,
+					   sizeof(avmb1_loadandconfigdef)))
+				return -EFAULT;
 		}
 		card = get_capi_ctr_by_nr(ldef.contr);
 		card = capi_ctr_get(card);
@@ -1123,9 +1123,8 @@
 		return 0;
 
 	case AVMB1_RESETCARD:
-		if ((retval = copy_from_user((void *) &rdef, data,
-					 sizeof(avmb1_resetdef))))
-			return retval;
+		if (copy_from_user((void *)&rdef, data, sizeof(avmb1_resetdef)))
+			return -EFAULT;
 		card = get_capi_ctr_by_nr(rdef.contr);
 		if (!card)
 			return -ESRCH;
@@ -1146,9 +1145,8 @@
 		return 0;
 
 	case AVMB1_GET_CARDINFO:
-		if ((retval = copy_from_user((void *) &gdef, data,
-					 sizeof(avmb1_getdef))))
-			return retval;
+		if (copy_from_user((void *)&gdef, data, sizeof(avmb1_getdef)))
+			return -EFAULT;
 
 		card = get_capi_ctr_by_nr(gdef.contr);
 		if (!card)
@@ -1159,9 +1157,8 @@
 			gdef.cardtype = AVM_CARDTYPE_T1;
 		else gdef.cardtype = AVM_CARDTYPE_B1;
 
-		if ((retval = copy_to_user(data, (void *) &gdef,
-					 sizeof(avmb1_getdef))))
-			return retval;
+		if (copy_to_user(data, (void *)&gdef, sizeof(avmb1_getdef)))
+			return -EFAULT;
 
 		return 0;
 	}
@@ -1187,9 +1184,8 @@
 	{
 		kcapi_flagdef fdef;
 
-		if ((retval = copy_from_user((void *) &fdef, data,
-					 sizeof(kcapi_flagdef))))
-			return retval;
+		if (copy_from_user((void *)&fdef, data, sizeof(kcapi_flagdef)))
+			return -EFAULT;
 
 		card = get_capi_ctr_by_nr(fdef.contr);
 		if (!card)
diff -Nru a/drivers/isdn/divert/divert_procfs.c b/drivers/isdn/divert/divert_procfs.c
--- a/drivers/isdn/divert/divert_procfs.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/divert/divert_procfs.c	Sun May 19 03:59:20 2002
@@ -185,8 +185,8 @@
 	divert_rule *rulep;
 	char *cp;
 
-	if ((i = copy_from_user(&dioctl, (char *) arg, sizeof(dioctl))))
-		return (i);
+	if (copy_from_user(&dioctl, (char *) arg, sizeof(dioctl)))
+		return -EFAULT;
 
 	switch (cmd) {
 		case IIOCGETVER:
@@ -254,7 +254,7 @@
 		default:
 			return (-EINVAL);
 	}			/* switch cmd */
-	return (copy_to_user((char *) arg, &dioctl, sizeof(dioctl)));	/* success */
+	return copy_to_user((char *)arg, &dioctl, sizeof(dioctl)) ? -EFAULT : 0;
 }				/* isdn_divert_ioctl */
 
 
diff -Nru a/drivers/isdn/eicon/eicon_mod.c b/drivers/isdn/eicon/eicon_mod.c
--- a/drivers/isdn/eicon/eicon_mod.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/eicon/eicon_mod.c	Sun May 19 03:59:20 2002
@@ -213,7 +213,10 @@
 					return(EICON_CTRL_VERSION);
 				case EICON_IOCTL_GETTYPE:
 					if (card->bus == EICON_BUS_PCI) {
-						copy_to_user((char *)a, &card->hwif.pci.master, sizeof(int));
+						if (copy_to_user((char *)a,
+							&card->hwif.pci.master,
+								 sizeof(int)))
+							return -EFAULT;
 					}
 					return(card->type);
 				case EICON_IOCTL_GETMMIO:
@@ -351,7 +354,8 @@
 					return -ENODEV;
 
 				case EICON_IOCTL_ADDCARD:
-					if ((ret = copy_from_user(&cdef, (char *)a, sizeof(cdef))))
+					if (copy_from_user(&cdef, (char *)a,
+							   sizeof(cdef)))
 						return -EFAULT;
 					if (!(eicon_addcard(0, cdef.membase, cdef.irq, cdef.id, 0)))
 						return -EIO;
@@ -376,8 +380,9 @@
 #ifdef CONFIG_ISDN_DRV_EICON_PCI
 					if (c->arg < EICON_IOCTL_DIA_OFFSET)
 						return -EINVAL;
-					if (copy_from_user(&dstart, (char *)a, sizeof(dstart)))
-						return -1;
+					if (copy_from_user(&dstart, (char *)a,
+							   sizeof(dstart)))
+						return -EFAULT;
 					if (!(card = eicon_findnpcicard(dstart.card_id)))
 						return -EINVAL;
 					ret = do_ioctl(NULL, NULL,
@@ -667,7 +672,8 @@
 
 			if (user) {
 				spin_unlock_irqrestore(&eicon_lock, flags);
-				copy_to_user(p, skb->data, cnt);
+				if (copy_to_user(p, skb->data, cnt))
+					return -EFAULT;
 				spin_lock_irqsave(&eicon_lock, flags);
 			}
 			else
diff -Nru a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
--- a/drivers/isdn/hardware/avm/b1.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/hardware/avm/b1.c	Sun May 19 03:59:20 2002
@@ -166,15 +166,14 @@
 {
 	unsigned char buf[256];
 	unsigned char *dp;
-	int i, left, retval;
+	int i, left;
 	unsigned int base = card->port;
 
 	dp = t4file->data;
 	left = t4file->len;
 	while (left > sizeof(buf)) {
 		if (t4file->user) {
-			retval = copy_from_user(buf, dp, sizeof(buf));
-			if (retval)
+			if (copy_from_user(buf, dp, sizeof(buf)))
 				return -EFAULT;
 		} else {
 			memcpy(buf, dp, sizeof(buf));
@@ -190,8 +189,7 @@
 	}
 	if (left) {
 		if (t4file->user) {
-			retval = copy_from_user(buf, dp, left);
-			if (retval)
+			if (copy_from_user(buf, dp, left))
 				return -EFAULT;
 		} else {
 			memcpy(buf, dp, left);
@@ -211,7 +209,7 @@
 	unsigned char buf[256];
 	unsigned char *dp;
 	unsigned int base = card->port;
-	int i, j, left, retval;
+	int i, j, left;
 
 	dp = config->data;
 	left = config->len;
@@ -223,8 +221,7 @@
 	}
 	while (left > sizeof(buf)) {
 		if (config->user) {
-			retval = copy_from_user(buf, dp, sizeof(buf));
-			if (retval)
+			if (copy_from_user(buf, dp, sizeof(buf)))
 				return -EFAULT;
 		} else {
 			memcpy(buf, dp, sizeof(buf));
@@ -240,8 +237,7 @@
 	}
 	if (left) {
 		if (config->user) {
-			retval = copy_from_user(buf, dp, left);
-			if (retval)
+			if (copy_from_user(buf, dp, left))
 				return -EFAULT;
 		} else {
 			memcpy(buf, dp, left);
diff -Nru a/drivers/isdn/hardware/avm/c4.c b/drivers/isdn/hardware/avm/c4.c
--- a/drivers/isdn/hardware/avm/c4.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/hardware/avm/c4.c	Sun May 19 03:59:20 2002
@@ -191,15 +191,14 @@
 {
 	u32 val;
 	unsigned char *dp;
-	int left, retval;
+	int left;
 	u32 loadoff = 0;
 
 	dp = t4file->data;
 	left = t4file->len;
 	while (left >= sizeof(u32)) {
 	        if (t4file->user) {
-			retval = copy_from_user(&val, dp, sizeof(val));
-			if (retval)
+			if (copy_from_user(&val, dp, sizeof(val)))
 				return -EFAULT;
 		} else {
 			memcpy(&val, dp, sizeof(val));
@@ -216,8 +215,7 @@
 	if (left) {
 		val = 0;
 		if (t4file->user) {
-			retval = copy_from_user(&val, dp, left);
-			if (retval)
+			if (copy_from_user(&val, dp, left))
 				return -EFAULT;
 		} else {
 			memcpy(&val, dp, left);
@@ -808,8 +806,7 @@
 	left = config->len;
 	while (left >= sizeof(u32)) {
 	        if (config->user) {
-			retval = copy_from_user(val, dp, sizeof(val));
-			if (retval)
+			if (copy_from_user(val, dp, sizeof(val)))
 				return -EFAULT;
 		} else {
 			memcpy(val, dp, sizeof(val));
@@ -822,8 +819,7 @@
 	if (left) {
 		memset(val, 0, sizeof(val));
 		if (config->user) {
-			retval = copy_from_user(&val, dp, left);
-			if (retval)
+			if (copy_from_user(&val, dp, left))
 				return -EFAULT;
 		} else {
 			memcpy(&val, dp, left);
diff -Nru a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
--- a/drivers/isdn/hisax/config.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/hisax/config.c	Sun May 19 03:59:20 2002
@@ -641,9 +641,10 @@
 		count = cs->status_end - cs->status_read + 1;
 		if (count >= len)
 			count = len;
-		if (user)
-			copy_to_user(p, cs->status_read, count);
-		else
+		if (user) {
+			if (copy_to_user(p, cs->status_read, count))
+				return -EFAULT;
+		} else
 			memcpy(p, cs->status_read, count);
 		cs->status_read += count;
 		if (cs->status_read > cs->status_end)
@@ -655,9 +656,10 @@
 				cnt = HISAX_STATUS_BUFSIZE;
 			else
 				cnt = count;
-			if (user)
-				copy_to_user(p, cs->status_read, cnt);
-			else
+			if (user) {
+				if (copy_to_user(p, cs->status_read, cnt))
+					return -EFAULT;
+			} else
 				memcpy(p, cs->status_read, cnt);
 			p += cnt;
 			cs->status_read += cnt % HISAX_STATUS_BUFSIZE;
diff -Nru a/drivers/isdn/hisax/isar.c b/drivers/isdn/hisax/isar.c
--- a/drivers/isdn/hisax/isar.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/hisax/isar.c	Sun May 19 03:59:20 2002
@@ -217,7 +217,7 @@
 	}
 	if ((ret = copy_from_user(&size, p, sizeof(int)))) {
 		printk(KERN_ERR"isar_load_firmware copy_from_user ret %d\n", ret);
-		return ret;
+		return -EFAULT;
 	}
 	p += sizeof(int);
 	printk(KERN_DEBUG"isar_load_firmware size: %d\n", size);
@@ -240,6 +240,7 @@
 	while (cnt < size) {
 		if ((ret = copy_from_user(&blk_head, p, BLK_HEAD_SIZE))) {
 			printk(KERN_ERR"isar_load_firmware copy_from_user ret %d\n", ret);
+			ret = -EFAULT;
 			goto reterror;
 		}
 #ifdef __BIG_ENDIAN
@@ -282,6 +283,7 @@
 			*mp++ = noc;
 			if ((ret = copy_from_user(tmpmsg, p, nom))) {
 				printk(KERN_ERR"isar_load_firmware copy_from_user ret %d\n", ret);
+				ret = -EFAULT;
 				goto reterror;
 			}
 			p += nom;
diff -Nru a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
--- a/drivers/isdn/i4l/isdn_ppp.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/i4l/isdn_ppp.c	Sun May 19 03:59:20 2002
@@ -731,7 +731,11 @@
 
 	restore_flags(flags);
 
-	copy_to_user(buf, save_buf, count);
+	if (copy_to_user(buf, save_buf, count)) {
+		kfree(save_buf);
+		retval = -EFAULT;
+		goto out;
+	}
 	kfree(save_buf);
 
 	retval = count;
diff -Nru a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
--- a/drivers/isdn/i4l/isdn_tty.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/i4l/isdn_tty.c	Sun May 19 03:59:20 2002
@@ -1202,9 +1202,12 @@
 						   &(m->pluscount),
 						   &(m->lastplus),
 						   from_user);
-			if (from_user)
-				copy_from_user(&(info->xmit_buf[info->xmit_count]), buf, c);
-			else
+			if (from_user) {
+				if (copy_from_user(&(info->xmit_buf[info->xmit_count]), buf, c)) {
+					total = -EFAULT;
+					goto out;
+				}
+			} else
 				memcpy(&(info->xmit_buf[info->xmit_count]), buf, c);
 #ifdef CONFIG_ISDN_AUDIO
 			if (info->vonline) {
@@ -1284,6 +1287,7 @@
 		}
 		isdn_timer_ctrl(ISDN_TIMER_MODEMXMIT, 1);
 	}
+out:
 	if (from_user)
 		up(&info->write_sem);
 	return total;
@@ -2589,7 +2593,8 @@
 		*pluscount = 0;
 	}
 	if (from_user) {
-		copy_from_user(cbuf, p, count);
+		if (copy_from_user(cbuf, p, count))
+			return;
 		p = cbuf;
 	}
 	while (count > 0) {
diff -Nru a/drivers/isdn/icn/icn.c b/drivers/isdn/icn/icn.c
--- a/drivers/isdn/icn/icn.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/icn/icn.c	Sun May 19 03:59:20 2002
@@ -821,9 +821,9 @@
 		printk(KERN_WARNING "icn: Could not allocate code buffer\n");
 		return -ENOMEM;
 	}
-	if ((ret = copy_from_user(codebuf, buffer, ICN_CODE_STAGE1))) {
+	if (copy_from_user(codebuf, buffer, ICN_CODE_STAGE1)) {
 		kfree(codebuf);
-		return ret;
+		return -EFAULT;
 	}
 	if (!card->rvalid) {
 		if (check_region(card->port, ICN_PORTLEN)) {
@@ -1057,9 +1057,10 @@
 		count = cmd_free;
 		if (count > len)
 			count = len;
-		if (user)
-			copy_from_user(msg, buf, count);
-		else
+		if (user) {
+			if (copy_from_user(msg, buf, count))
+				return -EFAULT;
+		} else
 			memcpy(msg, buf, count);
 
 		save_flags(flags);
@@ -1237,15 +1238,17 @@
 				case ICN_IOCTL_GETDOUBLE:
 					return (int) card->doubleS0;
 				case ICN_IOCTL_DEBUGVAR:
-					if ((i = copy_to_user((char *) a,
-					  (char *) &card, sizeof(ulong))))
-						return i;
+					if (copy_to_user((char *)a,
+							 (char *)&card,
+							 sizeof(ulong)))
+						return -EFAULT;
 					a += sizeof(ulong);
 					{
 						ulong l = (ulong) & dev;
-						if ((i = copy_to_user((char *) a,
-							     (char *) &l, sizeof(ulong))))
-							return i;
+						if (copy_to_user((char *)a,
+								 (char *)&l,
+								 sizeof(ulong)))
+							return -EFAULT;
 					}
 					return 0;
 				case ICN_IOCTL_LOADBOOT:
@@ -1266,8 +1269,10 @@
 				case ICN_IOCTL_ADDCARD:
 					if (!dev.firstload)
 						return -EBUSY;
-					if ((i = copy_from_user((char *) &cdef, (char *) a, sizeof(cdef))))
-						return i;
+					if (copy_from_user((char *)&cdef,
+							   (char *)a,
+							   sizeof(cdef)))
+						return -EFAULT;
 					return (icn_addcard(cdef.port, cdef.id1, cdef.id2));
 					break;
 				case ICN_IOCTL_LEASEDCFG:
diff -Nru a/drivers/isdn/isdnloop/isdnloop.c b/drivers/isdn/isdnloop/isdnloop.c
--- a/drivers/isdn/isdnloop/isdnloop.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/isdnloop/isdnloop.c	Sun May 19 03:59:20 2002
@@ -986,9 +986,10 @@
 
 		if (count > 255)
 			count = 255;
-		if (user)
-			copy_from_user(msg, buf, count);
-		else
+		if (user) {
+			if (copy_from_user(msg, buf, count))
+				return -EFAULT;
+		} else
 			memcpy(msg, buf, count);
 		isdnloop_putmsg(card, '>');
 		for (p = msg; count > 0; count--, p++) {
@@ -1076,7 +1077,8 @@
 
 	if (card->flags & ISDNLOOP_FLAGS_RUNNING)
 		return -EBUSY;
-	copy_from_user((char *) &sdef, (char *) sdefp, sizeof(sdef));
+	if (copy_from_user((char *) &sdef, (char *) sdefp, sizeof(sdef)))
+		return -EFAULT;
 	save_flags(flags);
 	cli();
 	switch (sdef.ptype) {
@@ -1149,9 +1151,10 @@
 					return (isdnloop_start(card, (isdnloop_sdef *) a));
 					break;
 				case ISDNLOOP_IOCTL_ADDCARD:
-					if ((i = verify_area(VERIFY_READ, (void *) a, sizeof(isdnloop_cdef))))
-						return i;
-					copy_from_user((char *) &cdef, (char *) a, sizeof(cdef));
+					if (copy_from_user((char *)&cdef,
+							   (char *)a,
+							   sizeof(cdef)))
+						return -EFAULT;
 					return (isdnloop_addcard(cdef.id1));
 					break;
 				case ISDNLOOP_IOCTL_LEASEDCFG:
diff -Nru a/drivers/isdn/sc/command.c b/drivers/isdn/sc/command.c
--- a/drivers/isdn/sc/command.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/sc/command.c	Sun May 19 03:59:20 2002
@@ -126,11 +126,11 @@
 		int		err;
 
 		memcpy(&cmdptr, cmd->parm.num, sizeof(unsigned long));
-		if((err = copy_from_user(&ioc, (scs_ioctl *) cmdptr, 
-			sizeof(scs_ioctl)))) {
+		if (copy_from_user(&ioc, (scs_ioctl *)cmdptr,
+				   sizeof(scs_ioctl))) {
 			pr_debug("%s: Failed to verify user space 0x%x\n",
 				adapter[card]->devicename, cmdptr);
-			return err;
+			return -EFAULT;
 		}
 		return sc_ioctl(card, &ioc);
 	}
diff -Nru a/drivers/isdn/sc/ioctl.c b/drivers/isdn/sc/ioctl.c
--- a/drivers/isdn/sc/ioctl.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/sc/ioctl.c	Sun May 19 03:59:20 2002
@@ -55,8 +55,8 @@
 		/*
 		 * Get the SRec from user space
 		 */
-		if ((err = copy_from_user(srec, (char *) data->dataptr, sizeof(srec))))
-			return err;
+		if (copy_from_user(srec, (char *) data->dataptr, sizeof(srec)))
+			return -EFAULT;
 
 		status = send_and_receive(card, CMPID, cmReqType2, cmReqClass0, cmReqLoadProc,
 				0, sizeof(srec), srec, &rcvmsg, SAR_TIMEOUT);
@@ -96,8 +96,9 @@
 		/*
 		 * Get the switch type from user space
 		 */
-		if ((err = copy_from_user(&switchtype, (char *) data->dataptr, sizeof(char))))
-			return err;
+		if (copy_from_user(&switchtype, (char *)data->dataptr,
+				   sizeof(char)))
+			return -EFAULT;
 
 		pr_debug("%s: SCIOCSETSWITCH: setting switch type to %d\n", adapter[card]->devicename,
 			switchtype);
@@ -141,8 +142,9 @@
 		/*
 		 * Package the switch type and send to user space
 		 */
-		if ((err = copy_to_user((char *) data->dataptr, &switchtype, sizeof(char))))
-			return err;
+		if (copy_to_user((char *)data->dataptr, &switchtype,
+				 sizeof(char)))
+			return -EFAULT;
 
 		return 0;
 	}
@@ -173,8 +175,8 @@
 		/*
 		 * Package the switch type and send to user space
 		 */
-		if ((err = copy_to_user((char *) data->dataptr, spid, sizeof(spid))))
-			return err;
+		if (copy_to_user((char *)data->dataptr, spid, sizeof(spid)))
+			return -EFAULT;
 
 		return 0;
 	}	
@@ -190,8 +192,8 @@
 		/*
 		 * Get the spid from user space
 		 */
-		if ((err = copy_from_user(spid, (char *) data->dataptr, sizeof(spid))))
-			return err;
+		if (copy_from_user(spid, (char *) data->dataptr, sizeof(spid)))
+			return -EFAULT;
 
 		pr_debug("%s: SCIOCSETSPID: setting channel %d spid to %s\n", 
 			adapter[card]->devicename, data->channel, spid);
@@ -237,8 +239,8 @@
 		/*
 		 * Package the dn and send to user space
 		 */
-		if ((err = copy_to_user((char *) data->dataptr, dn, sizeof(dn))))
-			return err;
+		if (copy_to_user((char *)data->dataptr, dn, sizeof(dn)))
+			return -EFAULT;
 
 		return 0;
 	}	
@@ -254,8 +256,8 @@
 		/*
 		 * Get the spid from user space
 		 */
-		if ((err = copy_from_user(dn, (char *) data->dataptr, sizeof(dn))))
-			return err;
+		if (copy_from_user(dn, (char *)data->dataptr, sizeof(dn)))
+			return -EFAULT;
 
 		pr_debug("%s: SCIOCSETDN: setting channel %d dn to %s\n", 
 			adapter[card]->devicename, data->channel, dn);
@@ -290,8 +292,9 @@
 		pr_debug("%s: SCIOSTAT: ioctl received\n", adapter[card]->devicename);
 		GetStatus(card, &bi);
 		
-		if ((err = copy_to_user((boardInfo *) data->dataptr, &bi, sizeof(boardInfo))))
-			return err;
+		if (copy_to_user((boardInfo *)data->dataptr, &bi,
+				 sizeof(boardInfo)))
+			return -EFAULT;
 
 		return 0;
 	}
@@ -324,8 +327,8 @@
 		/*
 		 * Package the switch type and send to user space
 		 */
-		if ((err = copy_to_user((char *) data->dataptr, &speed, sizeof(char))))
-			return err;
+		if (copy_to_user((char *) data->dataptr, &speed, sizeof(char)))
+			return -EFAULT;
 
 		return 0;
 	}
diff -Nru a/drivers/isdn/tpam/tpam_commands.c b/drivers/isdn/tpam/tpam_commands.c
--- a/drivers/isdn/tpam/tpam_commands.c	Sun May 19 03:59:20 2002
+++ b/drivers/isdn/tpam/tpam_commands.c	Sun May 19 03:59:20 2002
@@ -126,7 +126,6 @@
  */
 static int tpam_command_ioctl_dspload(tpam_card *card, u32 arg) {
 	tpam_dsp_ioctl tdl;
-	int ret;
 
 	dprintk("TurboPAM(tpam_command_ioctl_dspload): card=%d\n", card->id);
 
@@ -141,10 +140,9 @@
 		return -EPERM;
 
 	/* write the data in the board's memory */
-	ret = copy_from_user_to_pam(card, (void *)tdl.address, 
-				    (void *)arg + sizeof(tpam_dsp_ioctl), 
-				    tdl.data_len);
-	return 0;
+	return copy_from_user_to_pam(card, (void *)tdl.address, 
+				     (void *)arg + sizeof(tpam_dsp_ioctl), 
+				     tdl.data_len);
 }
 
 /*
@@ -158,7 +156,6 @@
  */
 static int tpam_command_ioctl_dspsave(tpam_card *card, u32 arg) {
 	tpam_dsp_ioctl tdl;
-	int ret;
 
 	dprintk("TurboPAM(tpam_command_ioctl_dspsave): card=%d\n", card->id);
 
@@ -171,9 +168,8 @@
 		return -EPERM;
 
 	/* read the data from the board's memory */
-	ret = copy_from_pam_to_user(card, (void *)arg + sizeof(tpam_dsp_ioctl),
-				    (void *)tdl.address, tdl.data_len);
-	return ret;
+	return copy_from_pam_to_user(card, (void *)arg + sizeof(tpam_dsp_ioctl),
+				     (void *)tdl.address, tdl.data_len);
 }
 
 /*
