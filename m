Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbQLFJRL>; Wed, 6 Dec 2000 04:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131040AbQLFJRB>; Wed, 6 Dec 2000 04:17:01 -0500
Received: from 13dyn108.delft.casema.net ([212.64.76.108]:60938 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130454AbQLFJQq>; Wed, 6 Dec 2000 04:16:46 -0500
Date: Wed, 6 Dec 2000 09:45:13 +0100 (CET)
From: Patrick van de Lageweg <patrick@bitwizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Rogier Wolff <wolff@bitwizard.nl>
Subject: [PATCH] atmrefcoun
Message-ID: <Pine.LNX.4.21.0012060945000.25551-100000@panoramix.bitwizard.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This patch contains the fix for the atmrefcount problem (noted as a
critical problem in Ted's todo list).

	Patrick

diff -u -r linux-2.4.0-test11.clean/drivers/atm/ambassador.c linux-2.4.0-test11.atmrefcount/drivers/atm/ambassador.c
--- linux-2.4.0-test11.clean/drivers/atm/ambassador.c	Fri Jul  7 06:37:24 2000
+++ linux-2.4.0-test11.atmrefcount/drivers/atm/ambassador.c	Wed Nov 29 08:41:21 2000
@@ -1251,15 +1251,10 @@
     }
   }
   
-  // prevent module unload while sleeping (kmalloc/down)
-  // doing this any earlier would complicate more error return paths
-  MOD_INC_USE_COUNT;
-  
   // get space for our vcc stuff
   vcc = kmalloc (sizeof(amb_vcc), GFP_KERNEL);
   if (!vcc) {
     PRINTK (KERN_ERR, "out of memory!");
-    MOD_DEC_USE_COUNT;
     return -ENOMEM;
   }
   atm_vcc->dev_data = (void *) vcc;
@@ -1425,7 +1420,6 @@
   // say the VPI/VCI is free again
   clear_bit(ATM_VF_ADDR,&atm_vcc->flags);
 
-  MOD_DEC_USE_COUNT;
   return;
 }
 
@@ -1703,7 +1697,8 @@
   close:	amb_close,
   send:		amb_send,
   sg_send:	amb_sg_send,
-  proc_read:	amb_proc_read
+  proc_read:	amb_proc_read,
+  owner:	THIS_MODULE,
 };
 
 /********** housekeeping **********/
diff -u -r linux-2.4.0-test11.clean/drivers/atm/atmdev_init.c linux-2.4.0-test11.atmrefcount/drivers/atm/atmdev_init.c
--- linux-2.4.0-test11.clean/drivers/atm/atmdev_init.c	Fri Apr 14 18:37:10 2000
+++ linux-2.4.0-test11.atmrefcount/drivers/atm/atmdev_init.c	Wed Nov 29 08:41:21 2000
@@ -54,7 +54,7 @@
 	devs += ia_detect();
 #endif
 #ifdef CONFIG_ATM_FORE200E
-        devs += fore200e_detect();
+	devs += fore200e_detect();
 #endif
 	return devs;
 }
diff -u -r linux-2.4.0-test11.clean/drivers/atm/atmtcp.c linux-2.4.0-test11.atmrefcount/drivers/atm/atmtcp.c
--- linux-2.4.0-test11.clean/drivers/atm/atmtcp.c	Wed Nov 15 08:36:01 2000
+++ linux-2.4.0-test11.atmrefcount/drivers/atm/atmtcp.c	Wed Nov 29 08:41:21 2000
@@ -110,7 +110,7 @@
 
 static void atmtcp_v_dev_close(struct atm_dev *dev)
 {
-	MOD_DEC_USE_COUNT;
+	/* Nothing.... Isn't this simple :-)  -- REW */
 }
 
 
@@ -298,7 +298,8 @@
 	close:		atmtcp_v_close,
 	ioctl:		atmtcp_v_ioctl,
 	send:		atmtcp_v_send,
-	proc_read:	atmtcp_v_proc
+	proc_read:	atmtcp_v_proc,
+	owner:		THIS_MODULE
 };
 
 
@@ -331,18 +332,13 @@
 	struct atmtcp_dev_data *dev_data;
 	struct atm_dev *dev;
 
-	MOD_INC_USE_COUNT;
-
 	dev_data = kmalloc(sizeof(*dev_data),GFP_KERNEL);
-	if (!dev_data) {
-		MOD_DEC_USE_COUNT;
+	if (!dev_data)
 		return -ENOMEM;
-	}
 
 	dev = atm_dev_register(DEV_LABEL,&atmtcp_v_dev_ops,itf,NULL);
 	if (!dev) {
 		kfree(dev_data);
-		MOD_DEC_USE_COUNT;
 		return itf == -1 ? -ENOMEM : -EBUSY;
 	}
 	dev->ci_range.vpi_bits = MAX_VPI_BITS;
diff -u -r linux-2.4.0-test11.clean/drivers/atm/fore200e.c linux-2.4.0-test11.atmrefcount/drivers/atm/fore200e.c
--- linux-2.4.0-test11.clean/drivers/atm/fore200e.c	Mon Oct 16 21:56:50 2000
+++ linux-2.4.0-test11.atmrefcount/drivers/atm/fore200e.c	Wed Nov 29 08:41:21 2000
@@ -1407,8 +1407,6 @@
     struct fore200e*     fore200e = FORE200E_DEV(vcc->dev);
     struct fore200e_vcc* fore200e_vcc;
     
-    MOD_INC_USE_COUNT;
-
     /* find a free VPI/VCI */
     fore200e_walk_vccs(vcc, &vpi, &vci);
 
@@ -1416,10 +1414,8 @@
     vcc->vci = vci;
 
     /* ressource checking only? */
-    if (vci == ATM_VCI_UNSPEC || vpi == ATM_VPI_UNSPEC) {
-    	MOD_DEC_USE_COUNT;
+    if (vci == ATM_VCI_UNSPEC || vpi == ATM_VPI_UNSPEC)
 	return 0;
-    }
 
     set_bit(ATM_VF_ADDR, &vcc->flags);
     vcc->itf    = vcc->dev->number;
@@ -1437,7 +1433,6 @@
 	down(&fore200e->rate_sf);
 	if (fore200e->available_cell_rate < vcc->qos.txtp.max_pcr) {
 	    up(&fore200e->rate_sf);
-    	    MOD_DEC_USE_COUNT;
 	    return -EAGAIN;
 	}
 	/* reserving the pseudo-CBR bandwidth at this point grants us
@@ -1454,7 +1449,6 @@
 	down(&fore200e->rate_sf);
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
 	up(&fore200e->rate_sf);
-    	MOD_DEC_USE_COUNT;
 	return -ENOMEM;
     }
 
@@ -1465,7 +1459,6 @@
 	down(&fore200e->rate_sf);
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
 	up(&fore200e->rate_sf);
-    	MOD_DEC_USE_COUNT;
 	return -EBUSY;
     }
     
@@ -1498,10 +1491,6 @@
     
     fore200e_activate_vcin(fore200e, 0, vcc, 0);
     
-#ifdef MODULE
-    MOD_DEC_USE_COUNT;
-#endif
-	
     kfree(FORE200E_VCC(vcc));
 	
     if ((vcc->qos.txtp.traffic_class == ATM_CBR) && (vcc->qos.txtp.max_pcr > 0)) {
@@ -2599,8 +2588,6 @@
 
     printk(FORE200E "FORE Systems 200E-series driver - version " FORE200E_VERSION "\n");
 
-    MOD_INC_USE_COUNT;
-
     /* for each configured bus interface */
     for (link = 0, bus = fore200e_bus; bus->model_name; bus++) {
 
@@ -2626,9 +2613,6 @@
 	}
     }
 
-    if (link <= 0)
-	MOD_DEC_USE_COUNT;
-
     return link;
 }
 
@@ -2943,21 +2927,15 @@
 
 static const struct atmdev_ops fore200e_ops =
 {
-    NULL, /* fore200e_dev_close   */
-    fore200e_open,
-    fore200e_close,
-    fore200e_ioctl,
-    fore200e_getsockopt,
-    fore200e_setsockopt,
-    fore200e_send,
-    NULL, /* fore200e_sg_send,    */
-    NULL, /* fore200e_send_oam,   */
-    NULL, /* fore200e_phy_put,    */
-    NULL, /* fore200e_phy_get,    */
-    NULL, /* fore200e_feedback,   */
-    fore200e_change_qos,
-    NULL, /* fore200e_free_rx_skb */
-    fore200e_proc_read
+	open:         fore200e_open,
+	close:        fore200e_close,
+	ioctl:        fore200e_ioctl,
+	getsockopt:   fore200e_getsockopt,
+	setsockopt:   fore200e_setsockopt,
+	send:         fore200e_send,
+	change_qos:   fore200e_change_qos,
+	proc_read:    fore200e_proc_read,
+	owner:        THIS_MODULE,
 };
 
 
diff -u -r linux-2.4.0-test11.clean/drivers/atm/horizon.c linux-2.4.0-test11.atmrefcount/drivers/atm/horizon.c
--- linux-2.4.0-test11.clean/drivers/atm/horizon.c	Fri Jul  7 06:37:24 2000
+++ linux-2.4.0-test11.atmrefcount/drivers/atm/horizon.c	Wed Nov 29 08:41:22 2000
@@ -2491,15 +2491,10 @@
     return -EINVAL;
   }
   
-  // prevent module unload while sleeping (kmalloc)
-  // doing this any earlier would complicate more error return paths
-  MOD_INC_USE_COUNT;
-  
   // get space for our vcc stuff and copy parameters into it
   vccp = kmalloc (sizeof(hrz_vcc), GFP_KERNEL);
   if (!vccp) {
     PRINTK (KERN_ERR, "out of memory!");
-    MOD_DEC_USE_COUNT;
     return -ENOMEM;
   }
   *vccp = vcc;
@@ -2531,7 +2526,6 @@
   if (error) {
     PRINTD (DBG_QOS|DBG_VCC, "insufficient cell rate resources");
     kfree (vccp);
-    MOD_DEC_USE_COUNT;
     return error;
   }
   
@@ -2550,7 +2544,6 @@
       error = hrz_open_rx (dev, channel);
     if (error) {
       kfree (vccp);
-      MOD_DEC_USE_COUNT;
       return error;
     }
     // this link allows RX frames through
@@ -2620,7 +2613,6 @@
   kfree (vcc);
   // say the VPI/VCI is free again
   clear_bit(ATM_VF_ADDR,&atm_vcc->flags);
-  MOD_DEC_USE_COUNT;
 }
 
 #if 0
@@ -2751,7 +2743,8 @@
   close:	hrz_close,
   send:		hrz_send,
   sg_send:	hrz_sg_send,
-  proc_read:	hrz_proc_read
+  proc_read:	hrz_proc_read,
+  owner:	THIS_MODULE,
 };
 
 static int __init hrz_probe (void) {
diff -u -r linux-2.4.0-test11.clean/drivers/atm/iphase.c linux-2.4.0-test11.atmrefcount/drivers/atm/iphase.c
--- linux-2.4.0-test11.clean/drivers/atm/iphase.c	Mon Aug  7 07:20:09 2000
+++ linux-2.4.0-test11.atmrefcount/drivers/atm/iphase.c	Wed Nov 29 08:41:22 2000
@@ -3143,7 +3143,8 @@
 	phy_put:	ia_phy_put,  
 	phy_get:	ia_phy_get,  
 	change_qos:	ia_change_qos,  
-        proc_read:	ia_proc_read
+	proc_read:	ia_proc_read,
+	owner:		THIS_MODULE,
 };  
 	  
   
@@ -3219,7 +3220,6 @@
 		printk(KERN_ERR DEV_LABEL ": no adapter found\n");  
 		return -ENXIO;  
 	}  
-	// MOD_INC_USE_COUNT; 
    	ia_timer.expires = jiffies + 3*HZ;
    	add_timer(&ia_timer); 
    
@@ -3235,7 +3235,6 @@
         int i, j= 0;
  
 	IF_EVENT(printk(">ia cleanup_module\n");)  
-        // MOD_DEC_USE_COUNT;
 	if (MOD_IN_USE)  
 		printk("ia: module in use\n");  
         del_timer(&ia_timer);
diff -u -r linux-2.4.0-test11.clean/drivers/atm/nicstar.c linux-2.4.0-test11.atmrefcount/drivers/atm/nicstar.c
--- linux-2.4.0-test11.clean/drivers/atm/nicstar.c	Tue Nov 14 22:16:33 2000
+++ linux-2.4.0-test11.atmrefcount/drivers/atm/nicstar.c	Wed Nov 29 08:41:22 2000
@@ -268,7 +268,8 @@
    send:	ns_send,
    phy_put:	ns_phy_put,
    phy_get:	ns_phy_get,
-   proc_read:	ns_proc_read
+   proc_read:	ns_proc_read,
+   owner:	THIS_MODULE,
 };
 static struct timer_list ns_timer;
 static char *mac[NS_MAX_CARDS];
@@ -1633,7 +1634,6 @@
    }
    
    set_bit(ATM_VF_READY,&vcc->flags);
-   MOD_INC_USE_COUNT;
    return 0;
 }
 
@@ -1762,7 +1762,6 @@
    vcc->dev_data = NULL;
    clear_bit(ATM_VF_PARTIAL,&vcc->flags);
    clear_bit(ATM_VF_ADDR,&vcc->flags);
-   MOD_DEC_USE_COUNT;
 
 #ifdef RX_DEBUG
    {
diff -u -r linux-2.4.0-test11.clean/include/linux/atm_tcp.h linux-2.4.0-test11.atmrefcount/include/linux/atm_tcp.h
--- linux-2.4.0-test11.clean/include/linux/atm_tcp.h	Wed Feb  9 03:23:13 2000
+++ linux-2.4.0-test11.atmrefcount/include/linux/atm_tcp.h	Wed Nov 29 08:55:45 2000
@@ -65,6 +65,7 @@
 	int (*attach)(struct atm_vcc *vcc,int itf);
 	int (*create_persistent)(int itf);
 	int (*remove_persistent)(int itf);
+	struct module *owner;
 };
 
 extern struct atm_tcp_ops atm_tcp_ops;
diff -u -r linux-2.4.0-test11.clean/include/linux/atmdev.h linux-2.4.0-test11.atmrefcount/include/linux/atmdev.h
--- linux-2.4.0-test11.clean/include/linux/atmdev.h	Sun Nov 19 05:58:55 2000
+++ linux-2.4.0-test11.atmrefcount/include/linux/atmdev.h	Wed Nov 29 08:55:45 2000
@@ -375,6 +375,7 @@
 	void (*free_rx_skb)(struct atm_vcc *vcc, struct sk_buff *skb);
 		/* @@@ temporary hack */
 	int (*proc_read)(struct atm_dev *dev,loff_t *pos,char *page);
+	struct module *owner;
 };
 
 
diff -u -r linux-2.4.0-test11.clean/net/atm/addr.c linux-2.4.0-test11.atmrefcount/net/atm/addr.c
--- linux-2.4.0-test11.clean/net/atm/addr.c	Wed Mar 22 08:38:26 2000
+++ linux-2.4.0-test11.atmrefcount/net/atm/addr.c	Wed Nov 29 08:41:22 2000
@@ -42,7 +42,7 @@
  */
 
 static DECLARE_MUTEX(local_lock);
-
+extern  spinlock_t atm_dev_lock;
 
 static void notify_sigd(struct atm_dev *dev)
 {
@@ -58,12 +58,14 @@
 	struct atm_dev_addr *this;
 
 	down(&local_lock);
+	spin_lock (&atm_dev_lock);		
 	while (dev->local) {
 		this = dev->local;
 		dev->local = this->next;
 		kfree(this);
 	}
 	up(&local_lock);
+	spin_unlock (&atm_dev_lock);
 	notify_sigd(dev);
 }
 
diff -u -r linux-2.4.0-test11.clean/net/atm/common.c linux-2.4.0-test11.atmrefcount/net/atm/common.c
--- linux-2.4.0-test11.clean/net/atm/common.c	Fri Jul  7 06:37:24 2000
+++ linux-2.4.0-test11.atmrefcount/net/atm/common.c	Wed Nov 29 08:41:22 2000
@@ -72,6 +72,7 @@
 #define DPRINTK(format,args...)
 #endif
 
+spinlock_t atm_dev_lock = SPIN_LOCK_UNLOCKED;
 
 static struct sk_buff *alloc_tx(struct atm_vcc *vcc,unsigned int size)
 {
@@ -139,13 +140,19 @@
 				vcc->dev->ops->free_rx_skb(vcc,skb);
 			else kfree_skb(skb);
 		}
+		spin_lock (&atm_dev_lock);	
+		fops_put (vcc->dev->ops);
 		if (atomic_read(&vcc->rx_inuse))
 			printk(KERN_WARNING "atm_release_vcc: strange ... "
 			    "rx_inuse == %d after closing\n",
 			    atomic_read(&vcc->rx_inuse));
 		bind_vcc(vcc,NULL);
-	}
+	} else
+		spin_lock (&atm_dev_lock);	
+
 	if (free_sk) free_atm_vcc_sk(sk);
+
+	spin_unlock (&atm_dev_lock);
 }
 
 
@@ -238,9 +245,11 @@
 	    vcc->qos.txtp.min_pcr,vcc->qos.txtp.max_pcr,vcc->qos.txtp.max_sdu);
 	DPRINTK("  RX: %d, PCR %d..%d, SDU %d\n",vcc->qos.rxtp.traffic_class,
 	    vcc->qos.rxtp.min_pcr,vcc->qos.rxtp.max_pcr,vcc->qos.rxtp.max_sdu);
+	fops_get (dev->ops);
 	if (dev->ops->open) {
 		error = dev->ops->open(vcc,vpi,vci);
 		if (error) {
+			fops_put (dev->ops);
 			bind_vcc(vcc,NULL);
 			return error;
 		}
@@ -252,10 +261,18 @@
 static int atm_do_connect(struct atm_vcc *vcc,int itf,int vpi,int vci)
 {
 	struct atm_dev *dev;
+	int return_val;
 
+	spin_lock (&atm_dev_lock);
 	dev = atm_find_dev(itf);
-	if (!dev) return -ENODEV;
-	return atm_do_connect_dev(vcc,dev,vpi,vci);
+	if (!dev)
+		return_val =  -ENODEV;
+	else
+		return_val = atm_do_connect_dev(vcc,dev,vpi,vci);
+
+	spin_unlock (&atm_dev_lock);
+
+	return return_val;
 }
 
 
@@ -285,8 +302,10 @@
 	else {
 		struct atm_dev *dev;
 
+		spin_lock (&atm_dev_lock);
 		for (dev = atm_devs; dev; dev = dev->next)
 			if (!atm_do_connect_dev(vcc,dev,vpi,vci)) break;
+		spin_unlock (&atm_dev_lock);
 		if (!dev) return -ENODEV;
 	}
 	if (vpi == ATM_VPI_UNSPEC || vci == ATM_VCI_UNSPEC)
@@ -523,57 +542,86 @@
 	struct atm_vcc *vcc;
 	int *tmp_buf;
 	void *buf;
-	int error,len,size,number;
+	int error,len,size,number, ret_val;
 
+	ret_val = 0;
+	spin_lock (&atm_dev_lock);
 	vcc = ATM_SD(sock);
 	switch (cmd) {
 		case SIOCOUTQ:
 			if (sock->state != SS_CONNECTED ||
-			    !test_bit(ATM_VF_READY,&vcc->flags))
-				return -EINVAL;
-			return put_user(vcc->sk->sndbuf-
+			    !test_bit(ATM_VF_READY,&vcc->flags)) {
+				ret_val =  -EINVAL;
+				goto done;
+			}
+			ret_val =  put_user(vcc->sk->sndbuf-
 			    atomic_read(&vcc->tx_inuse)-ATM_PDU_OVHD,
 			    (int *) arg) ? -EFAULT : 0;
+			goto done;
 		case SIOCINQ:
 			{
 				struct sk_buff *skb;
 
-				if (sock->state != SS_CONNECTED)
-					return -EINVAL;
+				if (sock->state != SS_CONNECTED) {
+					ret_val = -EINVAL;
+					goto done;
+				}
 				skb = skb_peek(&vcc->recvq);
-				return put_user(skb ? skb->len : 0,(int *) arg)
+				ret_val = put_user(skb ? skb->len : 0,(int *) arg)
 				    ? -EFAULT : 0;
+				goto done;
 			}
 		case ATM_GETNAMES:
 			if (get_user(buf,
-			    &((struct atm_iobuf *) arg)->buffer))
-				return -EFAULT;
+				     &((struct atm_iobuf *) arg)->buffer)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
 			if (get_user(len,
-			    &((struct atm_iobuf *) arg)->length))
-				return -EFAULT;
+				     &((struct atm_iobuf *) arg)->length)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
 			size = 0;
 			for (dev = atm_devs; dev; dev = dev->next)
 				size += sizeof(int);
-			if (size > len) return -E2BIG;
+			if (size > len) {
+				ret_val = -E2BIG;
+				goto done;
+			}
 			tmp_buf = kmalloc(size,GFP_KERNEL);
-			if (!tmp_buf) return -ENOMEM;
+			if (!tmp_buf) {
+				ret_val = -ENOMEM;
+				goto done;
+			}
 			for (dev = atm_devs; dev; dev = dev->next)
 				*tmp_buf++ = dev->number;
-			if (copy_to_user(buf,(char *) tmp_buf-size,size))
-				return -EFAULT;
-			return put_user(size,
+			if (copy_to_user(buf,(char *) tmp_buf-size,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
+		        ret_val = put_user(size,
 			    &((struct atm_iobuf *) arg)->length) ? -EFAULT : 0;
+			goto done;
 		case SIOCGSTAMP: /* borrowed from IP */
-			if (!vcc->timestamp.tv_sec) return -ENOENT;
+			if (!vcc->timestamp.tv_sec) {
+				ret_val = -ENOENT;
+				goto done;
+			}
 			vcc->timestamp.tv_sec += vcc->timestamp.tv_usec/1000000;
 			vcc->timestamp.tv_usec %= 1000000;
-			return copy_to_user((void *) arg,&vcc->timestamp,
+			ret_val = copy_to_user((void *) arg,&vcc->timestamp,
 			    sizeof(struct timeval)) ? -EFAULT : 0;
+			goto done;
 		case ATM_SETSC:
 			printk(KERN_WARNING "ATM_SETSC is obsolete\n");
-			return 0;
+			ret_val = 0;
+			goto done;
 		case ATMSIGD_CTRL:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
 			/*
 			 * The user/kernel protocol for exchanging signalling
 			 * info uses kernel pointers as opaque references,
@@ -581,175 +629,308 @@
 			 * on the kernel... so we should make sure that we
 			 * have the same privledges that /proc/kcore needs
 			 */
-			if (!capable(CAP_SYS_RAWIO)) return -EPERM;
+			if (!capable(CAP_SYS_RAWIO)) {
+				ret_val = -EPERM;
+				goto done;
+			}
 			error = sigd_attach(vcc);
 			if (!error) sock->state = SS_CONNECTED;
-			return error;
+			ret_val = error;
+			goto done;
 #ifdef CONFIG_ATM_CLIP
 		case SIOCMKCLIP:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-			return clip_create(arg);
+			if (!capable(CAP_NET_ADMIN))
+				ret_val = -EPERM;
+			else 
+				ret_val = clip_create(arg);
+			goto done;
 		case ATMARPD_CTRL:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
 			error = atm_init_atmarp(vcc);
 			if (!error) sock->state = SS_CONNECTED;
-			return error;
+			ret_val = error;
+			goto done;
 		case ATMARP_MKIP:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-			return clip_mkip(vcc,arg);
+			if (!capable(CAP_NET_ADMIN)) 
+				ret_val = -EPERM;
+			else 
+				ret_val = clip_mkip(vcc,arg);
+			goto done;
 		case ATMARP_SETENTRY:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-			return clip_setentry(vcc,arg);
+			if (!capable(CAP_NET_ADMIN)) 
+				ret_val = -EPERM;
+			else
+				ret_val = clip_setentry(vcc,arg);
+			goto done;
 		case ATMARP_ENCAP:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-			return clip_encap(vcc,arg);
+			if (!capable(CAP_NET_ADMIN)) 
+				ret_val = -EPERM;
+			else
+				ret_val = clip_encap(vcc,arg);
+			goto done;
 #endif
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
                 case ATMLEC_CTRL:
-                        if (!capable(CAP_NET_ADMIN)) return -EPERM;
+                        if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
                         if (atm_lane_ops.lecd_attach == NULL)
                                 atm_lane_init();
-                        if (atm_lane_ops.lecd_attach == NULL) /* try again */
-                                return -ENOSYS;
-                        error = atm_lane_ops.lecd_attach(vcc, (int)arg);
-                        if (error >= 0) sock->state = SS_CONNECTED;
-                        return error;
+                        if (atm_lane_ops.lecd_attach == NULL) { /* try again */
+				ret_val = -ENOSYS;
+				goto done;
+			}
+			error = atm_lane_ops.lecd_attach(vcc, (int)arg);
+			if (error >= 0) sock->state = SS_CONNECTED;
+			ret_val =  error;
+			goto done;
                 case ATMLEC_MCAST:
-                        if (!capable(CAP_NET_ADMIN)) return -EPERM;
-                        return atm_lane_ops.mcast_attach(vcc, (int)arg);
+			if (!capable(CAP_NET_ADMIN))
+				ret_val = -EPERM;
+			else
+				ret_val = atm_lane_ops.mcast_attach(vcc, (int)arg);
+			goto done;
                 case ATMLEC_DATA:
-                        if (!capable(CAP_NET_ADMIN)) return -EPERM;
-                        return atm_lane_ops.vcc_attach(vcc, (void*)arg);
+			if (!capable(CAP_NET_ADMIN))
+				ret_val = -EPERM;
+			else
+				ret_val = atm_lane_ops.vcc_attach(vcc, (void*)arg);
+			goto done;
 #endif
 #if defined(CONFIG_ATM_MPOA) || defined(CONFIG_ATM_MPOA_MODULE)
 		case ATMMPC_CTRL:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-                        if (atm_mpoa_ops.mpoad_attach == NULL)
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
+			if (atm_mpoa_ops.mpoad_attach == NULL)
                                 atm_mpoa_init();
-                        if (atm_mpoa_ops.mpoad_attach == NULL) /* try again */
-                                return -ENOSYS;
-                        error = atm_mpoa_ops.mpoad_attach(vcc, (int)arg);
-                        if (error >= 0) sock->state = SS_CONNECTED;
-                        return error;
+			if (atm_mpoa_ops.mpoad_attach == NULL) { /* try again */
+				ret_val = -ENOSYS;
+				goto done;
+			}
+			error = atm_mpoa_ops.mpoad_attach(vcc, (int)arg);
+			if (error >= 0) sock->state = SS_CONNECTED;
+			ret_val = error;
+			goto done;
 		case ATMMPC_DATA:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-			return atm_mpoa_ops.vcc_attach(vcc, arg);
+			if (!capable(CAP_NET_ADMIN)) 
+				ret_val = -EPERM;
+			else
+				ret_val = atm_mpoa_ops.vcc_attach(vcc, arg);
+			goto done;
 #endif
 #if defined(CONFIG_ATM_TCP) || defined(CONFIG_ATM_TCP_MODULE)
 		case SIOCSIFATMTCP:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-			if (!atm_tcp_ops.attach) return -ENOPKG;
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
+			if (!atm_tcp_ops.attach) {
+				ret_val = -ENOPKG;
+				goto done;
+			}
+			fops_get (&atm_tcp_ops);
 			error = atm_tcp_ops.attach(vcc,(int) arg);
 			if (error >= 0) sock->state = SS_CONNECTED;
-			return error;
+			else            fops_put (&atm_tcp_ops);
+			ret_val = error;
+			goto done;
 		case ATMTCP_CREATE:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-			if (!atm_tcp_ops.create_persistent) return -ENOPKG;
-			return atm_tcp_ops.create_persistent((int) arg);
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
+			if (!atm_tcp_ops.create_persistent) {
+				ret_val = -ENOPKG;
+				goto done;
+			}
+			error = atm_tcp_ops.create_persistent((int) arg);
+			if (error < 0) fops_put (&atm_tcp_ops);
+			ret_val = error;
+			goto done;
 		case ATMTCP_REMOVE:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
-			if (!atm_tcp_ops.remove_persistent) return -ENOPKG;
-			return atm_tcp_ops.remove_persistent((int) arg);
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
+			if (!atm_tcp_ops.remove_persistent) {
+				ret_val = -ENOPKG;
+				goto done;
+			}
+			error = atm_tcp_ops.remove_persistent((int) arg);
+			fops_put (&atm_tcp_ops);
+			ret_val = error;
+			goto done;
 #endif
 		default:
 			break;
 	}
-	if (get_user(buf,&((struct atmif_sioc *) arg)->arg)) return -EFAULT;
-	if (get_user(len,&((struct atmif_sioc *) arg)->length)) return -EFAULT;
-	if (get_user(number,&((struct atmif_sioc *) arg)->number))
-		return -EFAULT;
-	if (!(dev = atm_find_dev(number))) return -ENODEV;
+	if (get_user(buf,&((struct atmif_sioc *) arg)->arg)) {
+		ret_val = -EFAULT;
+		goto done;
+	}
+	if (get_user(len,&((struct atmif_sioc *) arg)->length)) {
+		ret_val = -EFAULT;
+		goto done;
+	}
+	if (get_user(number,&((struct atmif_sioc *) arg)->number)) {
+		ret_val = -EFAULT;
+		goto done;
+	}
+	if (!(dev = atm_find_dev(number))) {
+		ret_val = -ENODEV;
+		goto done;
+	}
+	
 	size = 0;
 	switch (cmd) {
 		case ATM_GETTYPE:
 			size = strlen(dev->type)+1;
-			if (copy_to_user(buf,dev->type,size)) return -EFAULT;
+			if (copy_to_user(buf,dev->type,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
 			break;
 		case ATM_GETESI:
 			size = ESI_LEN;
-			if (copy_to_user(buf,dev->esi,size)) return -EFAULT;
+			if (copy_to_user(buf,dev->esi,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
 			break;
 		case ATM_SETESI:
 			{
 				int i;
 
 				for (i = 0; i < ESI_LEN; i++)
-					if (dev->esi[i]) return -EEXIST;
+					if (dev->esi[i]) {
+						ret_val = -EEXIST;
+						goto done;
+					}
 			}
 			/* fall through */
 		case ATM_SETESIF:
 			{
 				unsigned char esi[ESI_LEN];
 
-				if (!capable(CAP_NET_ADMIN)) return -EPERM;
-				if (copy_from_user(esi,buf,ESI_LEN))
-					return -EFAULT;
+				if (!capable(CAP_NET_ADMIN)) {
+					ret_val = -EPERM;
+					goto done;
+				}
+				if (copy_from_user(esi,buf,ESI_LEN)) {
+					ret_val = -EFAULT;
+					goto done;
+				}
 				memcpy(dev->esi,esi,ESI_LEN);
-				return ESI_LEN;
+				ret_val =  ESI_LEN;
+				goto done;
 			}
 		case ATM_GETSTATZ:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
 			/* fall through */
 		case ATM_GETSTAT:
 			size = sizeof(struct atm_dev_stats);
 			error = fetch_stats(dev,buf,cmd == ATM_GETSTATZ);
-			if (error) return error;
+			if (error) {
+				ret_val = error;
+				goto done;
+			}
 			break;
 		case ATM_GETCIRANGE:
 			size = sizeof(struct atm_cirange);
-			if (copy_to_user(buf,&dev->ci_range,size))
-				return -EFAULT;
+			if (copy_to_user(buf,&dev->ci_range,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
 			break;
 		case ATM_GETLINKRATE:
 			size = sizeof(int);
-			if (copy_to_user(buf,&dev->link_rate,size))
-				return -EFAULT;
+			if (copy_to_user(buf,&dev->link_rate,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
 			break;
 		case ATM_RSTADDR:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
 			reset_addr(dev);
 			break;
 		case ATM_ADDADDR:
 		case ATM_DELADDR:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
 			{
 				struct sockaddr_atmsvc addr;
 
-				if (copy_from_user(&addr,buf,sizeof(addr)))
-					return -EFAULT;
+				if (copy_from_user(&addr,buf,sizeof(addr))) {
+					ret_val = -EFAULT;
+					goto done;
+				}
 				if (cmd == ATM_ADDADDR)
-					return add_addr(dev,&addr);
-				else return del_addr(dev,&addr);
+					ret_val = add_addr(dev,&addr);
+				else
+					ret_val = del_addr(dev,&addr);
+				goto done;
 			}
 		case ATM_GETADDR:
 			size = get_addr(dev,buf,len);
-			if (size < 0) return size;
+			if (size < 0)
+				ret_val = size;
+			else
 			/* may return 0, but later on size == 0 means "don't
 			   write the length" */
-			return put_user(size,
-			    &((struct atmif_sioc *) arg)->length) ? -EFAULT : 0;
+				ret_val = put_user(size,
+						   &((struct atmif_sioc *) arg)->length) ? -EFAULT : 0;
+			goto done;
 		case ATM_SETLOOP:
 			if (__ATM_LM_XTRMT((int) (long) buf) &&
 			    __ATM_LM_XTLOC((int) (long) buf) >
-			    __ATM_LM_XTRMT((int) (long) buf))
-				return -EINVAL;
+			    __ATM_LM_XTRMT((int) (long) buf)) {
+				ret_val = -EINVAL;
+				goto done;
+			}
 			/* fall through */
 		case ATM_SETCIRANGE:
 		case SONET_GETSTATZ:
 		case SONET_SETDIAG:
 		case SONET_CLRDIAG:
 		case SONET_SETFRAMING:
-			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
 			/* fall through */
 		default:
-			if (!dev->ops->ioctl) return -EINVAL;
+			if (!dev->ops->ioctl) {
+				ret_val = -EINVAL;
+				goto done;
+			}
 			size = dev->ops->ioctl(dev,cmd,buf);
-			if (size < 0)
-				return size == -ENOIOCTLCMD ? -EINVAL : size;
+			if (size < 0) {
+				ret_val = (size == -ENOIOCTLCMD ? -EINVAL : size);
+				goto done;
+			}
 	}
-	if (!size) return 0;
-	return put_user(size,&((struct atmif_sioc *) arg)->length) ?
-	    -EFAULT : 0;
+	
+	if (size)
+		ret_val =  put_user(size,&((struct atmif_sioc *) arg)->length) ?
+			-EFAULT : 0;
+
+ done:
+	spin_unlock (&atm_dev_lock); 
+	return ret_val;
 }
 
 
diff -u -r linux-2.4.0-test11.clean/net/atm/resources.c linux-2.4.0-test11.atmrefcount/net/atm/resources.c
--- linux-2.4.0-test11.clean/net/atm/resources.c	Wed Mar 22 08:38:26 2000
+++ linux-2.4.0-test11.atmrefcount/net/atm/resources.c	Wed Nov 29 08:41:22 2000
@@ -25,6 +25,7 @@
 struct atm_dev *atm_devs = NULL;
 static struct atm_dev *last_dev = NULL;
 struct atm_vcc *nodev_vccs = NULL;
+extern spinlock_t atm_dev_lock;
 
 
 static struct atm_dev *alloc_atm_dev(const char *type)
@@ -48,11 +49,15 @@
 
 static void free_atm_dev(struct atm_dev *dev)
 {
+	spin_lock (&atm_dev_lock);
+	
 	if (dev->prev) dev->prev->next = dev->next;
 	else atm_devs = dev->next;
 	if (dev->next) dev->next->prev = dev->prev;
 	else last_dev = dev->prev;
 	kfree(dev);
+	
+	spin_unlock (&atm_dev_lock);
 }
 
 
@@ -100,10 +105,12 @@
 		if (atm_proc_dev_register(dev) < 0) {
 			printk(KERN_ERR "atm_dev_register: "
 			    "atm_proc_dev_register failed for dev %s\n",type);
+			spin_unlock (&atm_dev_lock);		
 			free_atm_dev(dev);
 			return NULL;
 		}
 #endif
+	spin_unlock (&atm_dev_lock);		
 	return dev;
 }
 
diff -u -r linux-2.4.0-test11.clean/net/atm/signaling.c linux-2.4.0-test11.atmrefcount/net/atm/signaling.c
--- linux-2.4.0-test11.clean/net/atm/signaling.c	Wed Nov 15 08:36:01 2000
+++ linux-2.4.0-test11.atmrefcount/net/atm/signaling.c	Wed Nov 29 08:41:22 2000
@@ -33,6 +33,7 @@
 struct atm_vcc *sigd = NULL;
 static DECLARE_WAIT_QUEUE_HEAD(sigd_sleep);
 
+extern spinlock_t atm_dev_lock;
 
 static void sigd_put_skb(struct sk_buff *skb)
 {
@@ -219,7 +220,10 @@
 		printk(KERN_ERR "sigd_close: closing with requests pending\n");
 	while ((skb = skb_dequeue(&vcc->recvq))) kfree_skb(skb);
 	purge_vccs(nodev_vccs);
+
+	spin_lock (&atm_dev_lock);
 	for (dev = atm_devs; dev; dev = dev->next) purge_vccs(dev->vccs);
+	spin_unlock (&atm_dev_lock);
 }
 
 





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
