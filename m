Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbTEOUKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbTEOUKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:10:08 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:26267 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264212AbTEOUJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:09:20 -0400
Message-Id: <200305152020.h4FKKfGi014696@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
In-reply-to: Your message of "Thu, 15 May 2003 13:10:21 PDT."
             <20030515.131021.104054490.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 15 May 2003 16:20:41 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I mean, this is the most fundamental part of how the networking
>locks configuration changes, I'm actually baffled that ATM
>doesn't make use of it :-(

i dont know either.  this will take a bit of looking around so
i will probably hold this off till a later patch.   i suspect atm
doesnt use rtnl because its register/unregister function dont
use the underlying netdevice layer (when perhaps it should).
thanks for the pointer.

here is the the atm_dev locking patch with the __module_get change:


--- linux-2.5.68/include/linux/atmdev.h.004	Fri May  9 08:30:20 2003
+++ linux-2.5.68/include/linux/atmdev.h	Wed May 14 12:40:39 2003
@@ -331,6 +331,8 @@
 	struct k_atm_dev_stats stats;	/* statistics */
 	char		signal;		/* signal status (ATM_PHY_SIG_*) */
 	int		link_rate;	/* link rate (default: OC3) */
+	atomic_t	refcnt;		/* reference count */
+	spinlock_t	lock;		/* protect internal members */
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *proc_entry; /* proc entry */
 	char *proc_name;		/* proc entry name */
@@ -392,7 +394,7 @@
 
 struct atm_dev *atm_dev_register(const char *type,const struct atmdev_ops *ops,
     int number,unsigned long *flags); /* number == -1: pick first available */
-struct atm_dev *atm_find_dev(int number);
+struct atm_dev *atm_dev_lookup(int number);
 void atm_dev_deregister(struct atm_dev *dev);
 void shutdown_atm_dev(struct atm_dev *dev);
 void bind_vcc(struct atm_vcc *vcc,struct atm_dev *dev);
@@ -403,30 +405,46 @@
  *
  */
 
-static __inline__ int atm_guess_pdu2truesize(int pdu_size)
+static inline int atm_guess_pdu2truesize(int pdu_size)
 {
 	return ((pdu_size+15) & ~15) + sizeof(struct sk_buff);
 }
 
 
-static __inline__ void atm_force_charge(struct atm_vcc *vcc,int truesize)
+static inline void atm_force_charge(struct atm_vcc *vcc,int truesize)
 {
 	atomic_add(truesize, &vcc->sk->rmem_alloc);
 }
 
 
-static __inline__ void atm_return(struct atm_vcc *vcc,int truesize)
+static inline void atm_return(struct atm_vcc *vcc,int truesize)
 {
 	atomic_sub(truesize, &vcc->sk->rmem_alloc);
 }
 
 
-static __inline__ int atm_may_send(struct atm_vcc *vcc,unsigned int size)
+static inline int atm_may_send(struct atm_vcc *vcc,unsigned int size)
 {
 	return (size + atomic_read(&vcc->sk->wmem_alloc)) < vcc->sk->sndbuf;
 }
 
 
+static inline void atm_dev_hold(struct atm_dev *dev)
+{
+	atomic_inc(&dev->refcnt);
+}
+
+
+static inline void atm_dev_release(struct atm_dev *dev)
+{
+	atomic_dec(&dev->refcnt);
+
+	if ((atomic_read(&dev->refcnt) == 1) &&
+	    test_bit(ATM_DF_CLOSE,&dev->flags))
+		shutdown_atm_dev(dev);
+}
+
+
 int atm_charge(struct atm_vcc *vcc,int truesize);
 struct sk_buff *atm_alloc_charge(struct atm_vcc *vcc,int pdu_size,
     int gfp_flags);
--- linux-2.5.68/net/atm/resources.c.000	Fri May  9 08:29:01 2003
+++ linux-2.5.68/net/atm/resources.c	Wed May 14 15:33:16 2003
@@ -27,10 +27,8 @@
 
 
 LIST_HEAD(atm_devs);
-struct atm_vcc *nodev_vccs = NULL;
-extern spinlock_t atm_dev_lock;
+spinlock_t atm_dev_lock = SPIN_LOCK_UNLOCKED;
 
-/* Caller must hold atm_dev_lock. */
 static struct atm_dev *__alloc_atm_dev(const char *type)
 {
 	struct atm_dev *dev;
@@ -42,67 +40,78 @@
 	dev->type = type;
 	dev->signal = ATM_PHY_SIG_UNKNOWN;
 	dev->link_rate = ATM_OC3_PCR;
-	list_add_tail(&dev->dev_list, &atm_devs);
+	spin_lock_init(&dev->lock);
 
 	return dev;
 }
 
-/* Caller must hold atm_dev_lock. */
 static void __free_atm_dev(struct atm_dev *dev)
 {
-	list_del(&dev->dev_list);
 	kfree(dev);
 }
 
-/* Caller must hold atm_dev_lock. */
-struct atm_dev *atm_find_dev(int number)
+static struct atm_dev *__atm_dev_lookup(int number)
 {
 	struct atm_dev *dev;
 	struct list_head *p;
 
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
-		if (dev->ops && dev->number == number)
+		if ((dev->ops) && (dev->number == number)) {
+			atm_dev_hold(dev);
 			return dev;
+		}
 	}
 	return NULL;
 }
 
-
-struct atm_dev *atm_dev_register(const char *type, const struct atmdev_ops *ops,
-				 int number, unsigned long *flags)
+struct atm_dev *atm_dev_lookup(int number)
 {
 	struct atm_dev *dev;
 
 	spin_lock(&atm_dev_lock);
+	dev = __atm_dev_lookup(number);
+	spin_unlock(&atm_dev_lock);
+	return dev;
+}
+
+struct atm_dev *atm_dev_register(const char *type, const struct atmdev_ops *ops,
+				 int number, unsigned long *flags)
+{
+	struct atm_dev *dev, *inuse;
 
 	dev = __alloc_atm_dev(type);
 	if (!dev) {
 		printk(KERN_ERR "atm_dev_register: no space for dev %s\n",
 		    type);
-		goto done;
+		return NULL;
 	}
+	spin_lock(&atm_dev_lock);
 	if (number != -1) {
-		if (atm_find_dev(number)) {
+		if ((inuse = __atm_dev_lookup(number))) {
+			atm_dev_release(inuse);
+			spin_unlock(&atm_dev_lock);
 			__free_atm_dev(dev);
-			dev = NULL;
-			goto done;
+			return NULL;
 		}
 		dev->number = number;
 	} else {
 		dev->number = 0;
-		while (atm_find_dev(dev->number))
+		while ((inuse = __atm_dev_lookup(dev->number))) {
+			atm_dev_release(inuse);
 			dev->number++;
+		}
 	}
-	dev->vccs = dev->last = NULL;
-	dev->dev_data = NULL;
-	barrier();
+
 	dev->ops = ops;
 	if (flags)
 		dev->flags = *flags;
 	else
 		memset(&dev->flags, 0, sizeof(dev->flags));
 	memset(&dev->stats, 0, sizeof(dev->stats));
+	atomic_set(&dev->refcnt, 1);
+	list_add_tail(&dev->dev_list, &atm_devs);
+	spin_unlock(&atm_dev_lock);
 
 #ifdef CONFIG_PROC_FS
 	if (ops->proc_read) {
@@ -110,33 +119,50 @@
 			printk(KERN_ERR "atm_dev_register: "
 			       "atm_proc_dev_register failed for dev %s\n",
 			       type);
+			spin_lock(&atm_dev_lock);
+			list_del(&dev->dev_list);
+			spin_unlock(&atm_dev_lock);
 			__free_atm_dev(dev);
-			dev = NULL;
-			goto done;
+			return NULL;
 		}
 	}
 #endif
 
-done:
-	spin_unlock(&atm_dev_lock);
 	return dev;
 }
 
 
 void atm_dev_deregister(struct atm_dev *dev)
 {
+	unsigned long warning_time;
+
 #ifdef CONFIG_PROC_FS
 	if (dev->ops->proc_read)
 		atm_proc_dev_deregister(dev);
 #endif
 	spin_lock(&atm_dev_lock);
-	__free_atm_dev(dev);
+	list_del(&dev->dev_list);
 	spin_unlock(&atm_dev_lock);
+
+        warning_time = jiffies;
+        while (atomic_read(&dev->refcnt) != 1) {
+                current->state = TASK_INTERRUPTIBLE;
+                schedule_timeout(HZ / 4);
+                current->state = TASK_RUNNING;
+                if ((jiffies - warning_time) > 10 * HZ) {
+                        printk(KERN_EMERG "atm_dev_deregister: waiting for "
+                               "dev %d to become free. Usage count = %d\n",
+                               dev->number, atomic_read(&dev->refcnt));
+                        warning_time = jiffies;
+                }
+        }
+
+	__free_atm_dev(dev);
 }
 
 void shutdown_atm_dev(struct atm_dev *dev)
 {
-	if (dev->vccs) {
+	if (atomic_read(&dev->refcnt) > 1) {
 		set_bit(ATM_DF_CLOSE, &dev->flags);
 		return;
 	}
@@ -161,44 +187,44 @@
 	sock_init_data(NULL, sk);
 	memset(vcc, 0, sizeof(*vcc));
 	vcc->sk = sk;
-	if (nodev_vccs)
-		nodev_vccs->prev = vcc;
-	vcc->prev = NULL;
-	vcc->next = nodev_vccs;
-	nodev_vccs = vcc;
+
 	return sk;
 }
 
 
-static void unlink_vcc(struct atm_vcc *vcc,struct atm_dev *hold_dev)
+static void unlink_vcc(struct atm_vcc *vcc)
 {
-	if (vcc->prev)
-		vcc->prev->next = vcc->next;
-	else if (vcc->dev)
-		vcc->dev->vccs = vcc->next;
-	else
-		nodev_vccs = vcc->next;
-	if (vcc->next)
-		vcc->next->prev = vcc->prev;
-	else if (vcc->dev)
-		vcc->dev->last = vcc->prev;
-	if (vcc->dev && vcc->dev != hold_dev && !vcc->dev->vccs &&
-	    test_bit(ATM_DF_CLOSE,&vcc->dev->flags))
-		shutdown_atm_dev(vcc->dev);
+	unsigned long flags;
+	if (vcc->dev) {
+		spin_lock_irqsave(&vcc->dev->lock, flags);
+		if (vcc->prev)
+			vcc->prev->next = vcc->next;
+		else
+			vcc->dev->vccs = vcc->next;
+
+		if (vcc->next)
+			vcc->next->prev = vcc->prev;
+		else
+			vcc->dev->last = vcc->prev;
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+	}
 }
 
 
 void free_atm_vcc_sk(struct sock *sk)
 {
-	unlink_vcc(atm_sk(sk), NULL);
+	unlink_vcc(atm_sk(sk));
 	sk_free(sk);
 }
 
 void bind_vcc(struct atm_vcc *vcc,struct atm_dev *dev)
 {
-	unlink_vcc(vcc,dev);
+	unsigned long flags;
+
+	unlink_vcc(vcc);
 	vcc->dev = dev;
 	if (dev) {
+		spin_lock_irqsave(&dev->lock, flags);
 		vcc->next = NULL;
 		vcc->prev = dev->last;
 		if (dev->vccs)
@@ -206,17 +232,12 @@
 		else
 			dev->vccs = vcc;
 		dev->last = vcc;
-	} else {
-		if (nodev_vccs)
-			nodev_vccs->prev = vcc;
-		vcc->next = nodev_vccs;
-		vcc->prev = NULL;
-		nodev_vccs = vcc;
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 }
 
 EXPORT_SYMBOL(atm_dev_register);
 EXPORT_SYMBOL(atm_dev_deregister);
-EXPORT_SYMBOL(atm_find_dev);
+EXPORT_SYMBOL(atm_dev_lookup);
 EXPORT_SYMBOL(shutdown_atm_dev);
 EXPORT_SYMBOL(bind_vcc);
--- linux-2.5.68/net/atm/resources.h.000	Fri May  9 09:09:51 2003
+++ linux-2.5.68/net/atm/resources.h	Fri May  9 09:10:29 2003
@@ -11,7 +11,7 @@
 
 
 extern struct list_head atm_devs;
-extern struct atm_vcc *nodev_vccs; /* VCCs not linked to any device */
+extern spinlock_t atm_dev_lock;
 
 
 struct sock *alloc_atm_vcc_sk(int family);
--- linux-2.5.68/net/atm/common.c.005	Wed May 14 16:12:29 2003
+++ linux-2.5.68/net/atm/common.c	Wed May 14 13:04:14 2003
@@ -115,7 +115,6 @@
 #define DPRINTK(format,args...)
 #endif
 
-spinlock_t atm_dev_lock = SPIN_LOCK_UNLOCKED;
 
 static struct sk_buff *alloc_tx(struct atm_vcc *vcc,unsigned int size)
 {
@@ -175,19 +174,17 @@
 			atm_return(vcc,skb->truesize);
 			kfree_skb(skb);
 		}
-		spin_lock (&atm_dev_lock);	
-		fops_put (vcc->dev->ops);
+
+		module_put(vcc->dev->ops->owner);
+		atm_dev_release(vcc->dev);
 		if (atomic_read(&vcc->sk->rmem_alloc))
 			printk(KERN_WARNING "atm_release_vcc: strange ... "
 			    "rmem_alloc == %d after closing\n",
 			    atomic_read(&vcc->sk->rmem_alloc));
 		bind_vcc(vcc,NULL);
-	} else
-		spin_lock (&atm_dev_lock);	
+	}
 
 	if (free_sk) free_atm_vcc_sk(sk);
-
-	spin_unlock (&atm_dev_lock);
 }
 
 
@@ -280,11 +277,11 @@
 	    vcc->qos.txtp.min_pcr,vcc->qos.txtp.max_pcr,vcc->qos.txtp.max_sdu);
 	DPRINTK("  RX: %d, PCR %d..%d, SDU %d\n",vcc->qos.rxtp.traffic_class,
 	    vcc->qos.rxtp.min_pcr,vcc->qos.rxtp.max_pcr,vcc->qos.rxtp.max_sdu);
-	fops_get (dev->ops);
+	__module_get(dev->ops->owner);
 	if (dev->ops->open) {
 		error = dev->ops->open(vcc,vpi,vci);
 		if (error) {
-			fops_put (dev->ops);
+			module_put(dev->ops->owner);
 			bind_vcc(vcc,NULL);
 			return error;
 		}
@@ -298,14 +295,13 @@
 	struct atm_dev *dev;
 	int return_val;
 
-	spin_lock (&atm_dev_lock);
-	dev = atm_find_dev(itf);
+	dev = atm_dev_lookup(itf);
 	if (!dev)
 		return_val =  -ENODEV;
-	else
+	else {
 		return_val = atm_do_connect_dev(vcc,dev,vpi,vci);
-
-	spin_unlock (&atm_dev_lock);
+		if (return_val) atm_dev_release(dev);
+	}
 
 	return return_val;
 }
@@ -336,15 +332,20 @@
 	}
 	else {
 		struct atm_dev *dev = NULL;
-		struct list_head *p;
+		struct list_head *p, *next;
 
-		spin_lock (&atm_dev_lock);
-		list_for_each(p, &atm_devs) {
+		spin_lock(&atm_dev_lock);
+		list_for_each_safe(p, next, &atm_devs) {
 			dev = list_entry(p, struct atm_dev, dev_list);
-			if (!atm_do_connect_dev(vcc,dev,vpi,vci)) break;
+			atm_dev_hold(dev);
+			spin_unlock(&atm_dev_lock);
+			if (!atm_do_connect_dev(vcc,dev,vpi,vci))
+				break;
+			atm_dev_release(dev);
 			dev = NULL;
+			spin_lock(&atm_dev_lock);
 		}
-		spin_unlock (&atm_dev_lock);
+		spin_unlock(&atm_dev_lock);
 		if (!dev) return -ENODEV;
 	}
 	if (vpi == ATM_VPI_UNSPEC || vci == ATM_VCI_UNSPEC)
@@ -562,7 +563,6 @@
 	int error,len,size,number, ret_val;
 
 	ret_val = 0;
-	spin_lock (&atm_dev_lock);
 	vcc = ATM_SD(sock);
 	switch (cmd) {
 		case SIOCOUTQ:
@@ -600,14 +600,17 @@
 				goto done;
 			}
 			size = 0;
+			spin_lock(&atm_dev_lock);
 			list_for_each(p, &atm_devs)
 				size += sizeof(int);
 			if (size > len) {
+				spin_unlock(&atm_dev_lock);
 				ret_val = -E2BIG;
 				goto done;
 			}
-			tmp_buf = kmalloc(size,GFP_KERNEL);
+			tmp_buf = kmalloc(size, GFP_ATOMIC);
 			if (!tmp_buf) {
+				spin_unlock(&atm_dev_lock);
 				ret_val = -ENOMEM;
 				goto done;
 			}
@@ -616,6 +619,7 @@
 				dev = list_entry(p, struct atm_dev, dev_list);
 				*tmp_p++ = dev->number;
 			}
+			spin_unlock(&atm_dev_lock);
 		        ret_val = ((copy_to_user(buf, tmp_buf, size)) ||
 			    put_user(size, &((struct atm_iobuf *) arg)->length)
 			    ) ? -EFAULT : 0;
@@ -840,7 +844,7 @@
 		ret_val = -EFAULT;
 		goto done;
 	}
-	if (!(dev = atm_find_dev(number))) {
+	if (!(dev = atm_dev_lookup(number))) {
 		ret_val = -ENODEV;
 		goto done;
 	}
@@ -851,14 +855,14 @@
 			size = strlen(dev->type)+1;
 			if (copy_to_user(buf,dev->type,size)) {
 				ret_val = -EFAULT;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_GETESI:
 			size = ESI_LEN;
 			if (copy_to_user(buf,dev->esi,size)) {
 				ret_val = -EFAULT;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_SETESI:
@@ -868,7 +872,7 @@
 				for (i = 0; i < ESI_LEN; i++)
 					if (dev->esi[i]) {
 						ret_val = -EEXIST;
-						goto done;
+						goto done_release;
 					}
 			}
 			/* fall through */
@@ -878,20 +882,20 @@
 
 				if (!capable(CAP_NET_ADMIN)) {
 					ret_val = -EPERM;
-					goto done;
+					goto done_release;
 				}
 				if (copy_from_user(esi,buf,ESI_LEN)) {
 					ret_val = -EFAULT;
-					goto done;
+					goto done_release;
 				}
 				memcpy(dev->esi,esi,ESI_LEN);
 				ret_val =  ESI_LEN;
-				goto done;
+				goto done_release;
 			}
 		case ATM_GETSTATZ:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-				goto done;
+				goto done_release;
 			}
 			/* fall through */
 		case ATM_GETSTAT:
@@ -899,27 +903,27 @@
 			error = fetch_stats(dev,buf,cmd == ATM_GETSTATZ);
 			if (error) {
 				ret_val = error;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_GETCIRANGE:
 			size = sizeof(struct atm_cirange);
 			if (copy_to_user(buf,&dev->ci_range,size)) {
 				ret_val = -EFAULT;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_GETLINKRATE:
 			size = sizeof(int);
 			if (copy_to_user(buf,&dev->link_rate,size)) {
 				ret_val = -EFAULT;
-				goto done;
+				goto done_release;
 			}
 			break;
 		case ATM_RSTADDR:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-				goto done;
+				goto done_release;
 			}
 			atm_reset_addr(dev);
 			break;
@@ -927,20 +931,20 @@
 		case ATM_DELADDR:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-				goto done;
+				goto done_release;
 			}
 			{
 				struct sockaddr_atmsvc addr;
 
 				if (copy_from_user(&addr,buf,sizeof(addr))) {
 					ret_val = -EFAULT;
-					goto done;
+					goto done_release;
 				}
 				if (cmd == ATM_ADDADDR)
 					ret_val = atm_add_addr(dev,&addr);
 				else
 					ret_val = atm_del_addr(dev,&addr);
-				goto done;
+				goto done_release;
 			}
 		case ATM_GETADDR:
 			size = atm_get_addr(dev,buf,len);
@@ -951,13 +955,13 @@
 			   write the length" */
 				ret_val = put_user(size,
 						   &((struct atmif_sioc *) arg)->length) ? -EFAULT : 0;
-			goto done;
+			goto done_release;
 		case ATM_SETLOOP:
 			if (__ATM_LM_XTRMT((int) (long) buf) &&
 			    __ATM_LM_XTLOC((int) (long) buf) >
 			    __ATM_LM_XTRMT((int) (long) buf)) {
 				ret_val = -EINVAL;
-				goto done;
+				goto done_release;
 			}
 			/* fall through */
 		case ATM_SETCIRANGE:
@@ -967,18 +971,18 @@
 		case SONET_SETFRAMING:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-				goto done;
+				goto done_release;
 			}
 			/* fall through */
 		default:
 			if (!dev->ops->ioctl) {
 				ret_val = -EINVAL;
-				goto done;
+				goto done_release;
 			}
 			size = dev->ops->ioctl(dev,cmd,buf);
 			if (size < 0) {
 				ret_val = (size == -ENOIOCTLCMD ? -EINVAL : size);
-				goto done;
+				goto done_release;
 			}
 	}
 	
@@ -987,9 +991,10 @@
 			-EFAULT : 0;
 	else
 		ret_val = 0;
+done_release:
+	atm_dev_release(dev);
 
- done:
-	spin_unlock (&atm_dev_lock); 
+done:
 	return ret_val;
 }
 
--- linux-2.5.68/net/atm/proc.c.001	Tue May 13 17:27:02 2003
+++ linux-2.5.68/net/atm/proc.c	Wed May 14 15:44:21 2003
@@ -84,6 +84,7 @@
 	add_stats(buf,"0",&dev->stats.aal0);
 	strcat(buf,"  ");
 	add_stats(buf,"5",&dev->stats.aal5);
+	sprintf(strchr(buf,0), "\t[%d]", atomic_read(&dev->refcnt));
 	strcat(buf,"\n");
 }
 
@@ -161,7 +162,7 @@
 #endif
 
 
-static void pvc_info(struct atm_vcc *vcc,char *buf)
+static void pvc_info(struct atm_vcc *vcc, char *buf, int clip_info)
 {
 	static const char *class_name[] = { "off","UBR","CBR","VBR","ABR" };
 	static const char *aal_name[] = {
@@ -178,20 +179,17 @@
 	    class_name[vcc->qos.rxtp.traffic_class],vcc->qos.txtp.min_pcr,
 	    class_name[vcc->qos.txtp.traffic_class]);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-	if (try_atm_clip_ops()) {
-		if (vcc->push == atm_clip_ops->clip_push) {
-			struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
-			struct net_device *dev;
-
-			dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
-			off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
-			    dev ? dev->name : "none?");
-			if (clip_vcc->encap)
-				off += sprintf(buf+off,"LLC/SNAP");
-			else
-				off += sprintf(buf+off,"None");
-		}
-		module_put(atm_clip_ops->owner);
+	if (clip_info && (vcc->push == atm_clip_ops->clip_push)) {
+		struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
+		struct net_device *dev;
+
+		dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
+		off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
+		    dev ? dev->name : "none?");
+		if (clip_vcc->encap)
+			off += sprintf(buf+off,"LLC/SNAP");
+		else
+			off += sprintf(buf+off,"None");
 	}
 #endif
 	strcpy(buf+off,"\n");
@@ -312,16 +310,19 @@
 
 	if (!pos) {
 		return sprintf(buf,"Itf Type    ESI/\"MAC\"addr "
-		    "AAL(TX,err,RX,err,drop) ...\n");
+		    "AAL(TX,err,RX,err,drop) ...               [refcnt]\n");
 	}
 	left = pos-1;
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
 		if (left-- == 0) {
 			dev_info(dev,buf);
+			spin_unlock(&atm_dev_lock);
 			return strlen(buf);
 		}
 	}
+	spin_unlock(&atm_dev_lock);
 	return 0;
 }
 
@@ -332,31 +333,50 @@
 
 static int atm_pvc_info(loff_t pos,char *buf)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct list_head *p;
 	struct atm_vcc *vcc;
-	int left;
+	int left, clip_info = 0;
 
 	if (!pos) {
 		return sprintf(buf,"Itf VPI VCI   AAL RX(PCR,Class) "
 		    "TX(PCR,Class)\n");
 	}
 	left = pos-1;
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+	if (try_atm_clip_ops())
+		clip_info = 1;
+#endif
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
+		spin_lock_irqsave(&dev->lock, flags);
 		for (vcc = dev->vccs; vcc; vcc = vcc->next)
-			if (vcc->sk->family == PF_ATMPVC &&
-			    vcc->dev && !left--) {
-				pvc_info(vcc,buf);
+			if (vcc->sk->family == PF_ATMPVC && vcc->dev && !left--) {
+				pvc_info(vcc,buf,clip_info);
+				spin_unlock_irqrestore(&dev->lock, flags);
+				spin_unlock(&atm_dev_lock);
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+				if (clip_info)
+					module_put(atm_clip_ops->owner);
+#endif
 				return strlen(buf);
 			}
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
+	spin_unlock(&atm_dev_lock);
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+	if (clip_info)
+		module_put(atm_clip_ops->owner);
+#endif
 	return 0;
 }
 
 
 static int atm_vc_info(loff_t pos,char *buf)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct list_head *p;
 	struct atm_vcc *vcc;
@@ -367,19 +387,20 @@
 		    "Address"," Itf VPI VCI   Fam Flags Reply Send buffer"
 		    "     Recv buffer\n");
 	left = pos-1;
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
+		spin_lock_irqsave(&dev->lock, flags);
 		for (vcc = dev->vccs; vcc; vcc = vcc->next)
 			if (!left--) {
 				vc_info(vcc,buf);
+				spin_unlock_irqrestore(&dev->lock, flags);
+				spin_unlock(&atm_dev_lock);
 				return strlen(buf);
 			}
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	for (vcc = nodev_vccs; vcc; vcc = vcc->next)
-		if (!left--) {
-			vc_info(vcc,buf);
-			return strlen(buf);
-		}
+	spin_unlock(&atm_dev_lock);
 
 	return 0;
 }
@@ -387,6 +408,7 @@
 
 static int atm_svc_info(loff_t pos,char *buf)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct list_head *p;
 	struct atm_vcc *vcc;
@@ -395,19 +417,21 @@
 	if (!pos)
 		return sprintf(buf,"Itf VPI VCI           State      Remote\n");
 	left = pos-1;
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
+		spin_lock_irqsave(&dev->lock, flags);
 		for (vcc = dev->vccs; vcc; vcc = vcc->next)
 			if (vcc->sk->family == PF_ATMSVC && !left--) {
 				svc_info(vcc,buf);
+				spin_unlock_irqrestore(&dev->lock, flags);
+				spin_unlock(&atm_dev_lock);
 				return strlen(buf);
 			}
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	for (vcc = nodev_vccs; vcc; vcc = vcc->next)
-		if (vcc->sk->family == PF_ATMSVC && !left--) {
-			svc_info(vcc,buf);
-			return strlen(buf);
-		}
+	spin_unlock(&atm_dev_lock);
+
 	return 0;
 }
 
--- linux-2.5.68/net/atm/signaling.c.002	Fri May  9 15:49:42 2003
+++ linux-2.5.68/net/atm/signaling.c	Wed May 14 13:10:19 2003
@@ -33,7 +33,6 @@
 struct atm_vcc *sigd = NULL;
 static DECLARE_WAIT_QUEUE_HEAD(sigd_sleep);
 
-extern spinlock_t atm_dev_lock;
 
 static void sigd_put_skb(struct sk_buff *skb)
 {
@@ -211,6 +210,7 @@
 
 static void sigd_close(struct atm_vcc *vcc)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct list_head *p;
 
@@ -219,33 +219,29 @@
 	if (skb_peek(&vcc->sk->receive_queue))
 		printk(KERN_ERR "sigd_close: closing with requests pending\n");
 	skb_queue_purge(&vcc->sk->receive_queue);
-	purge_vccs(nodev_vccs);
 
-	spin_lock (&atm_dev_lock);
+	spin_lock(&atm_dev_lock);
 	list_for_each(p, &atm_devs) {
 		dev = list_entry(p, struct atm_dev, dev_list);
+		spin_lock_irqsave(&dev->lock, flags);
 		purge_vccs(dev->vccs);
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
-	spin_unlock (&atm_dev_lock);
+	spin_unlock(&atm_dev_lock);
 }
 
 
 static struct atmdev_ops sigd_dev_ops = {
-	.close =sigd_close,
+	.close = sigd_close,
 	.send =	sigd_send
 };
 
 
 static struct atm_dev sigd_dev = {
-	&sigd_dev_ops,
-	NULL,		/* no PHY */
-    	"sig",		/* type */
-	999,		/* dummy device number */
-	NULL,NULL,	/* pretend not to have any VCCs */
-	NULL,NULL,	/* no data */
-	0,		/* no flags */
-	NULL,		/* no local address */
-	{ 0 }		/* no ESI, no statistics */
+	.ops =		&sigd_dev_ops,
+	.type =		"sig",
+	.number =	999,
+	.lock =		SPIN_LOCK_UNLOCKED
 };
 
 
--- linux-2.5.68/net/atm/lec.c.005	Fri May  9 16:02:07 2003
+++ linux-2.5.68/net/atm/lec.c	Fri May  9 16:03:33 2003
@@ -551,15 +551,10 @@
 };
 
 static struct atm_dev lecatm_dev = {
-        &lecdev_ops,
-        NULL,	    /*PHY*/
-        "lec",	    /*type*/
-        999,	    /*dummy device number*/
-        NULL,NULL,  /*no VCCs*/
-        NULL,NULL,  /*no data*/
-        0,	    /*no flags*/
-        NULL,	    /* no local address*/
-        { 0 }	    /*no ESI or rest of the atm_dev struct things*/
+	.ops	= &lecdev_ops,
+	.type	= "lec",
+	.number	= 999,
+	.lock	= SPIN_LOCK_UNLOCKED
 };
 
 /*
--- linux-2.5.68/net/atm/clip.c.005	Mon May 12 20:33:31 2003
+++ linux-2.5.68/net/atm/clip.c	Mon May 12 20:33:15 2003
@@ -717,6 +717,7 @@
 	.ops =			&atmarpd_dev_ops,
 	.type =			"arpd",
 	.number = 		999,
+	.lock =			SPIN_LOCK_UNLOCKED
 };
 
 
--- linux-2.5.68/net/atm/mpc.c.004	Mon May 12 11:39:31 2003
+++ linux-2.5.68/net/atm/mpc.c	Fri May  9 16:05:44 2003
@@ -744,6 +744,7 @@
 	.ops	= &mpc_ops,
 	.type	= "mpc",
 	.number	= 42,
+	.lock	= SPIN_LOCK_UNLOCKED
 	/* members not explicitely initialised will be 0 */
 };
 
--- linux-2.5.68/net/atm/addr.c.000	Tue May 13 23:32:07 2003
+++ linux-2.5.68/net/atm/addr.c	Wed May 14 13:12:27 2003
@@ -36,14 +36,6 @@
 }
 
 
-/*
- * Avoid modification of any list of local interfaces while reading it
- * (which may involve page faults and therefore rescheduling)
- */
-
-static DECLARE_MUTEX(local_lock);
-extern  spinlock_t atm_dev_lock;
-
 static void notify_sigd(struct atm_dev *dev)
 {
 	struct sockaddr_atmpvc pvc;
@@ -52,46 +44,46 @@
 	sigd_enq(NULL,as_itf_notify,NULL,&pvc,NULL);
 }
 
-/*
- *	This is called from atm_ioctl only. You must hold the lock as a caller
- */
 
 void atm_reset_addr(struct atm_dev *dev)
 {
+	unsigned long flags;
 	struct atm_dev_addr *this;
 
-	down(&local_lock);
+	spin_lock_irqsave(&dev->lock, flags);
 	while (dev->local) {
 		this = dev->local;
 		dev->local = this->next;
 		kfree(this);
 	}
-	up(&local_lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
 	notify_sigd(dev);
 }
 
 
 int atm_add_addr(struct atm_dev *dev,struct sockaddr_atmsvc *addr)
 {
+	unsigned long flags;
 	struct atm_dev_addr **walk;
 	int error;
 
 	error = check_addr(addr);
-	if (error) return error;
-	down(&local_lock);
+	if (error)
+		return error;
+	spin_lock_irqsave(&dev->lock, flags);
 	for (walk = &dev->local; *walk; walk = &(*walk)->next)
 		if (identical(&(*walk)->addr,addr)) {
-			up(&local_lock);
+			spin_unlock_irqrestore(&dev->lock, flags);
 			return -EEXIST;
 		}
-	*walk = kmalloc(sizeof(struct atm_dev_addr),GFP_KERNEL);
+	*walk = kmalloc(sizeof(struct atm_dev_addr), GFP_ATOMIC);
 	if (!*walk) {
-		up(&local_lock);
+		spin_unlock_irqrestore(&dev->lock, flags);
 		return -ENOMEM;
 	}
 	(*walk)->addr = *addr;
 	(*walk)->next = NULL;
-	up(&local_lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
 	notify_sigd(dev);
 	return 0;
 }
@@ -99,22 +91,24 @@
 
 int atm_del_addr(struct atm_dev *dev,struct sockaddr_atmsvc *addr)
 {
+	unsigned long flags;
 	struct atm_dev_addr **walk,*this;
 	int error;
 
 	error = check_addr(addr);
-	if (error) return error;
-	down(&local_lock);
+	if (error)
+		return error;
+	spin_lock_irqsave(&dev->lock, flags);
 	for (walk = &dev->local; *walk; walk = &(*walk)->next)
 		if (identical(&(*walk)->addr,addr)) break;
 	if (!*walk) {
-		up(&local_lock);
+		spin_unlock_irqrestore(&dev->lock, flags);
 		return -ENOENT;
 	}
 	this = *walk;
 	*walk = this->next;
 	kfree(this);
-	up(&local_lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
 	notify_sigd(dev);
 	return 0;
 }
@@ -122,24 +116,25 @@
 
 int atm_get_addr(struct atm_dev *dev,struct sockaddr_atmsvc *u_buf,int size)
 {
+	unsigned long flags;
 	struct atm_dev_addr *walk;
 	int total;
 
-	down(&local_lock);
+	spin_lock_irqsave(&dev->lock, flags);
 	total = 0;
 	for (walk = dev->local; walk; walk = walk->next) {
 		total += sizeof(struct sockaddr_atmsvc);
 		if (total > size) {
-			up(&local_lock);
+			spin_unlock_irqrestore(&dev->lock, flags);
 			return -E2BIG;
 		}
 		if (copy_to_user(u_buf,&walk->addr,
 		    sizeof(struct sockaddr_atmsvc))) {
-			up(&local_lock);
+			spin_unlock_irqrestore(&dev->lock, flags);
 			return -EFAULT;
 		}
 		u_buf++;
 	}
-	up(&local_lock);
+	spin_unlock_irqrestore(&dev->lock, flags);
 	return total;
 }
--- linux-2.5.68/net/atm/atm_misc.c.000	Wed May 14 10:28:07 2003
+++ linux-2.5.68/net/atm/atm_misc.c	Wed May 14 11:01:54 2003
@@ -63,13 +63,19 @@
 
 int atm_find_ci(struct atm_vcc *vcc,short *vpi,int *vci)
 {
+	unsigned long flags;
 	static short p = 0; /* poor man's per-device cache */
 	static int c = 0;
 	short old_p;
 	int old_c;
+	int err;
 
-	if (*vpi != ATM_VPI_ANY && *vci != ATM_VCI_ANY)
-		return check_ci(vcc,*vpi,*vci);
+	spin_lock_irqsave(&vcc->dev->lock, flags);
+	if (*vpi != ATM_VPI_ANY && *vci != ATM_VCI_ANY) {
+		err = check_ci(vcc,*vpi,*vci);
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		return err;
+	}
 	/* last scan may have left values out of bounds for current device */
 	if (*vpi != ATM_VPI_ANY) p = *vpi;
 	else if (p >= 1 << vcc->dev->ci_range.vpi_bits) p = 0;
@@ -82,6 +88,7 @@
 		if (!check_ci(vcc,p,c)) {
 			*vpi = p;
 			*vci = c;
+			spin_unlock_irqrestore(&vcc->dev->lock, flags);
 			return 0;
 		}
 		if (*vci == ATM_VCI_ANY) {
@@ -96,6 +103,7 @@
 		}
 	}
 	while (old_p != p || old_c != c);
+	spin_unlock_irqrestore(&vcc->dev->lock, flags);
 	return -EADDRINUSE;
 }
 
--- linux-2.5.68/drivers/atm/atmtcp.c.000	Fri May  9 16:47:25 2003
+++ linux-2.5.68/drivers/atm/atmtcp.c	Wed May 14 11:53:58 2003
@@ -153,6 +153,7 @@
 
 static int atmtcp_v_ioctl(struct atm_dev *dev,unsigned int cmd,void *arg)
 {
+	unsigned long flags;
 	struct atm_cirange ci;
 	struct atm_vcc *vcc;
 
@@ -162,9 +163,14 @@
 	if (ci.vci_bits == ATM_CI_MAX) ci.vci_bits = MAX_VCI_BITS;
 	if (ci.vpi_bits > MAX_VPI_BITS || ci.vpi_bits < 0 ||
 	    ci.vci_bits > MAX_VCI_BITS || ci.vci_bits < 0) return -EINVAL;
+	spin_lock_irqsave(&dev->lock, flags);
 	for (vcc = dev->vccs; vcc; vcc = vcc->next)
 		if ((vcc->vpi >> ci.vpi_bits) ||
-		    (vcc->vci >> ci.vci_bits)) return -EBUSY;
+		    (vcc->vci >> ci.vci_bits)) {
+			spin_unlock_irqrestore(&dev->lock, flags);
+			return -EBUSY;
+		}
+	spin_unlock_irqrestore(&dev->lock, flags);
 	dev->ci_range = ci;
 	return 0;
 }
@@ -227,6 +233,7 @@
 
 static void atmtcp_c_close(struct atm_vcc *vcc)
 {
+	unsigned long flags;
 	struct atm_dev *atmtcp_dev;
 	struct atmtcp_dev_data *dev_data;
 	struct atm_vcc *walk;
@@ -239,13 +246,16 @@
 	kfree(dev_data);
 	shutdown_atm_dev(atmtcp_dev);
 	vcc->dev_data = NULL;
+	spin_lock_irqsave(&atmtcp_dev->lock, flags);
 	for (walk = atmtcp_dev->vccs; walk; walk = walk->next)
 		wake_up(&walk->sleep);
+	spin_unlock_irqrestore(&atmtcp_dev->lock, flags);
 }
 
 
 static int atmtcp_c_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
+	unsigned long flags;
 	struct atm_dev *dev;
 	struct atmtcp_hdr *hdr;
 	struct atm_vcc *out_vcc;
@@ -260,11 +270,13 @@
 		    (struct atmtcp_control *) skb->data);
 		goto done;
 	}
+	spin_lock_irqsave(&dev->lock, flags);
 	for (out_vcc = dev->vccs; out_vcc; out_vcc = out_vcc->next)
 		if (out_vcc->vpi == ntohs(hdr->vpi) &&
 		    out_vcc->vci == ntohs(hdr->vci) &&
 		    out_vcc->qos.rxtp.traffic_class != ATM_NONE)
 			break;
+	spin_unlock_irqrestore(&dev->lock, flags);
 	if (!out_vcc) {
 		atomic_inc(&vcc->stats->tx_err);
 		goto done;
@@ -318,6 +330,7 @@
 	.ops		= &atmtcp_c_dev_ops,
 	.type		= "atmtcp",
 	.number		= 999,
+	.lock		= SPIN_LOCK_UNLOCKED
 };
 
 
@@ -350,9 +363,12 @@
 	struct atm_dev *dev;
 
 	dev = NULL;
-	if (itf != -1) dev = atm_find_dev(itf);
+	if (itf != -1) dev = atm_dev_lookup(itf);
 	if (dev) {
-		if (dev->ops != &atmtcp_v_dev_ops) return -EMEDIUMTYPE;
+		if (dev->ops != &atmtcp_v_dev_ops) {
+			atm_dev_release(dev);
+			return -EMEDIUMTYPE;
+		}
 		if (PRIV(dev)->vcc) return -EBUSY;
 	}
 	else {
@@ -383,14 +399,18 @@
 	struct atm_dev *dev;
 	struct atmtcp_dev_data *dev_data;
 
-	dev = atm_find_dev(itf);
+	dev = atm_dev_lookup(itf);
 	if (!dev) return -ENODEV;
-	if (dev->ops != &atmtcp_v_dev_ops) return -EMEDIUMTYPE;
+	if (dev->ops != &atmtcp_v_dev_ops) {
+		atm_dev_release(dev);
+		return -EMEDIUMTYPE;
+	}
 	dev_data = PRIV(dev);
 	if (!dev_data->persist) return 0;
 	dev_data->persist = 0;
 	if (PRIV(dev)->vcc) return 0;
 	kfree(dev_data);
+	atm_dev_release(dev);
 	shutdown_atm_dev(dev);
 	return 0;
 }
--- linux-2.5.68/drivers/atm/he.c.003	Wed May 14 10:25:02 2003
+++ linux-2.5.68/drivers/atm/he.c	Wed May 14 10:26:45 2003
@@ -345,6 +345,7 @@
 static __inline__ struct atm_vcc*
 he_find_vcc(struct he_dev *he_dev, unsigned cid)
 {
+	unsigned long flags;
 	struct atm_vcc *vcc;
 	short vpi;
 	int vci;
@@ -352,10 +353,15 @@
 	vpi = cid >> he_dev->vcibits;
 	vci = cid & ((1<<he_dev->vcibits)-1);
 
+	spin_lock_irqsave(&he_dev->atm_dev->lock, flags);
 	for (vcc = he_dev->atm_dev->vccs; vcc; vcc = vcc->next)
 		if (vcc->vci == vci && vcc->vpi == vpi
-			&& vcc->qos.rxtp.traffic_class != ATM_NONE) return vcc;
+			&& vcc->qos.rxtp.traffic_class != ATM_NONE) {
+				spin_unlock_irqrestore(&he_dev->atm_dev->lock, flags);
+				return vcc;
+			}
 
+	spin_unlock_irqrestore(&he_dev->atm_dev->lock, flags);
 	return NULL;
 }
 
--- linux-2.5.68/drivers/atm/eni.c.001	Wed May 14 11:54:50 2003
+++ linux-2.5.68/drivers/atm/eni.c	Wed May 14 12:20:46 2003
@@ -1886,8 +1886,10 @@
 
 static int get_ci(struct atm_vcc *vcc,short *vpi,int *vci)
 {
+	unsigned long flags;
 	struct atm_vcc *walk;
 
+	spin_lock_irqsave(&vcc->dev->lock, flags);
 	if (*vpi == ATM_VPI_ANY) *vpi = 0;
 	if (*vci == ATM_VCI_ANY) {
 		for (*vci = ATM_NOT_RSV_VCI; *vci < NR_VCI; (*vci)++) {
@@ -1906,17 +1908,29 @@
 			}
 			break;
 		}
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
 		return *vci == NR_VCI ? -EADDRINUSE : 0;
 	}
-	if (*vci == ATM_VCI_UNSPEC) return 0;
+	if (*vci == ATM_VCI_UNSPEC) {
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		return 0;
+	}
 	if (vcc->qos.rxtp.traffic_class != ATM_NONE &&
-	    ENI_DEV(vcc->dev)->rx_map[*vci])
+	    ENI_DEV(vcc->dev)->rx_map[*vci]) {
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
 		return -EADDRINUSE;
-	if (vcc->qos.txtp.traffic_class == ATM_NONE) return 0;
+	}
+	if (vcc->qos.txtp.traffic_class == ATM_NONE) {
+		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		return 0;
+	}
 	for (walk = vcc->dev->vccs; walk; walk = walk->next)
 		if (test_bit(ATM_VF_ADDR,&walk->flags) && walk->vci == *vci &&
-		    walk->qos.txtp.traffic_class != ATM_NONE)
+		    walk->qos.txtp.traffic_class != ATM_NONE) {
+			spin_unlock_irqrestore(&vcc->dev->lock, flags);
 			return -EADDRINUSE;
+		}
+	spin_unlock_irqrestore(&vcc->dev->lock, flags);
 	return 0;
 }
 
@@ -2124,6 +2138,7 @@
 
 static int eni_proc_read(struct atm_dev *dev,loff_t *pos,char *page)
 {
+	unsigned long flags;
 	static const char *signal[] = { "LOST","unknown","okay" };
 	struct eni_dev *eni_dev = ENI_DEV(dev);
 	struct atm_vcc *vcc;
@@ -2196,6 +2211,7 @@
 		return sprintf(page,"%10sbacklog %u packets\n","",
 		    skb_queue_len(&tx->backlog));
 	}
+	spin_lock_irqsave(&dev->lock, flags);
 	for (vcc = dev->vccs; vcc; vcc = vcc->next) {
 		struct eni_vcc *eni_vcc = ENI_VCC(vcc);
 		int length;
@@ -2214,8 +2230,10 @@
 			length += sprintf(page+length,"tx[%d], txing %d bytes",
 			    eni_vcc->tx->index,eni_vcc->txing);
 		page[length] = '\n';
+		spin_unlock_irqrestore(&dev->lock, flags);
 		return length+1;
 	}
+	spin_unlock_irqrestore(&dev->lock, flags);
 	for (i = 0; i < eni_dev->free_len; i++) {
 		struct eni_free *fe = eni_dev->free_list+i;
 		unsigned long offset;
--- linux-2.5.68/drivers/atm/fore200e.c.000	Wed May 14 11:56:59 2003
+++ linux-2.5.68/drivers/atm/fore200e.c	Wed May 14 12:01:20 2003
@@ -1074,13 +1074,16 @@
 static struct atm_vcc* 
 fore200e_find_vcc(struct fore200e* fore200e, struct rpd* rpd)
 {
+    unsigned long flags;
     struct atm_vcc* vcc;
 
+    spin_lock_irqsave(&fore200e->atm_dev->lock, flags);
     for (vcc = fore200e->atm_dev->vccs; vcc; vcc = vcc->next) {
 
 	if (vcc->vpi == rpd->atm_header.vpi && vcc->vci == rpd->atm_header.vci)
 	    break;
     }
+    spin_unlock_irqrestore(&fore200e->atm_dev->lock, flags);
     
     return vcc;
 }
@@ -1351,9 +1354,13 @@
 static int
 fore200e_walk_vccs(struct atm_vcc *vcc, short *vpi, int *vci)
 {
+    unsigned long flags;
     struct atm_vcc* walk;
 
     /* find a free VPI */
+
+    spin_lock_irqsave(&vcc->dev->lock, flags);
+
     if (*vpi == ATM_VPI_ANY) {
 
 	for (*vpi = 0, walk = vcc->dev->vccs; walk; walk = walk->next) {
@@ -1377,6 +1384,8 @@
 	}
     }
 
+    spin_unlock_irqrestore(&vcc->dev->lock, flags);
+
     return 0;
 }
 
@@ -2637,6 +2646,7 @@
 static int
 fore200e_proc_read(struct atm_dev *dev,loff_t* pos,char* page)
 {
+    unsigned long flags;
     struct fore200e* fore200e  = FORE200E_DEV(dev);
     int              len, left = *pos;
 
@@ -2883,6 +2893,7 @@
 	len = sprintf(page,"\n"    
 		      " VCCs:\n  address\tVPI.VCI:AAL\t(min/max tx PDU size) (min/max rx PDU size)\n");
 	
+	spin_lock_irqsave(&fore200e->atm_dev->lock, flags);
 	for (vcc = fore200e->atm_dev->vccs; vcc; vcc = vcc->next) {
 
 	    fore200e_vcc = FORE200E_VCC(vcc);
@@ -2897,6 +2908,7 @@
 			   fore200e_vcc->rx_max_pdu
 		);
 	}
+	spin_unlock_irqrestore(&fore200e->atm_dev->lock, flags);
 
 	return len;
     }
--- linux-2.5.68/drivers/atm/idt77252.c.002	Wed May 14 12:15:47 2003
+++ linux-2.5.68/drivers/atm/idt77252.c	Wed May 14 12:17:03 2003
@@ -2404,8 +2404,10 @@
 static int
 idt77252_find_vcc(struct atm_vcc *vcc, short *vpi, int *vci)
 {
+	unsigned long flags;
 	struct atm_vcc *walk;
 
+	spin_lock_irqsave(&vcc->dev->lock, flags);
 	if (*vpi == ATM_VPI_ANY) {
 		*vpi = 0;
 		walk = vcc->dev->vccs;
@@ -2432,6 +2434,7 @@
 		}
 	}
 
+	spin_unlock_irqrestore(&vcc->dev->lock, flags);
 	return 0;
 }
 

