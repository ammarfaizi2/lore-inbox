Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135749AbRDTHrZ>; Fri, 20 Apr 2001 03:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135760AbRDTHrQ>; Fri, 20 Apr 2001 03:47:16 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55559 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135749AbRDTHrJ>;
	Fri, 20 Apr 2001 03:47:09 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15071.59798.751500.870953@argo.ozlabs.ibm.com.au>
Date: Fri, 20 Apr 2001 17:47:34 +1000 (EST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org, alan@redhat.com
Cc: buhr@stat.wisc.edu
Subject: [PATCH] PPP update against 2.4.4-pre5
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,

The patch below does two things:

- It takes out the rest of the compatibility stuff that is no longer
  used, and which has the possibility of accessing memory that has
  been kfree'd (this could happen if you did a blocking read on a tty
  in PPP line discipline, and the tty hangs up).  This possibility was
  pointed out by Kevin Buhr.

- It adds packet filtering to the PPP driver.  The main point of this
  is so that you can specify that certain sorts of packets don't count
  as activity, so they don't reset the idle timer and they don't bring
  up a demand-dialled link.  This is a useful feature that I get asked
  for periodically, it's a small amount of code (in fact it's no extra
  code if you don't enable CONFIG_PPP_FILTER), and it's something I have
  had in my tree since last July without any problems.

Linus, could this go in 2.4.4 please?

Thanks,
Paul.

diff -urN linux/Documentation/Configure.help pmac/Documentation/Configure.help
--- linux/Documentation/Configure.help	Fri Apr 20 17:04:13 2001
+++ pmac/Documentation/Configure.help	Fri Apr 20 17:45:20 2001
@@ -1756,6 +1756,10 @@
   certain types of data to get through the socket. Linux Socket
   Filtering works on all socket types except TCP for now. See the text
   file Documentation/networking/filter.txt for more information.
+
+  You need to say Y here if you want to use PPP packet filtering
+  (see the CONFIG_PPP_FILTER option below).
+
   If unsure, say N.
 
 Network packet filtering
@@ -7087,6 +7091,17 @@
 
   If unsure, say N.
 
+PPP filtering (EXPERIMENTAL)
+CONFIG_PPP_FILTER
+  Say Y here if you want to be able to filter the packets passing over
+  PPP interfaces.  This allows you to control which packets count as
+  activity (i.e. which packets will reset the idle timer or bring up
+  a demand-dialled link) and which packets are to be dropped entirely.
+  You need to say Y here if you wish to use the pass-filter and
+  active-filter options to pppd.
+
+  If unsure, say N.
+
 PPP support for async serial ports
 CONFIG_PPP_ASYNC
   Say Y (or M) here if you want to be able to use PPP over standard
diff -urN linux/drivers/net/Config.in pmac/drivers/net/Config.in
--- linux/drivers/net/Config.in	Fri Apr 20 17:04:33 2001
+++ pmac/drivers/net/Config.in	Fri Apr 20 17:24:04 2001
@@ -227,6 +227,7 @@
 tristate 'PPP (point-to-point protocol) support' CONFIG_PPP
 if [ ! "$CONFIG_PPP" = "n" ]; then
    dep_bool '  PPP multilink support (EXPERIMENTAL)' CONFIG_PPP_MULTILINK $CONFIG_EXPERIMENTAL
+   bool '  PPP filtering' CONFIG_PPP_FILTER
    dep_tristate '  PPP support for async serial ports' CONFIG_PPP_ASYNC $CONFIG_PPP
    dep_tristate '  PPP support for sync tty ports' CONFIG_PPP_SYNC_TTY $CONFIG_PPP
    dep_tristate '  PPP Deflate compression' CONFIG_PPP_DEFLATE $CONFIG_PPP
diff -urN linux/drivers/net/ppp_async.c pmac/drivers/net/ppp_async.c
--- linux/drivers/net/ppp_async.c	Thu Feb 22 14:25:14 2001
+++ pmac/drivers/net/ppp_async.c	Thu Mar 29 13:47:47 2001
@@ -244,11 +244,6 @@
 		err = 0;
 		break;
 
-	case PPPIOCATTACH:
-	case PPPIOCDETACH:
-		err = ppp_channel_ioctl(&ap->chan, cmd, arg);
-		break;
-
 	default:
 		err = -ENOIOCTLCMD;
 	}
diff -urN linux/drivers/net/ppp_generic.c pmac/drivers/net/ppp_generic.c
--- linux/drivers/net/ppp_generic.c	Fri Apr 20 17:04:35 2001
+++ pmac/drivers/net/ppp_generic.c	Fri Apr 20 17:31:04 2001
@@ -19,7 +19,7 @@
  * PPP driver, written by Michael Callahan and Al Longyear, and
  * subsequently hacked by Paul Mackerras.
  *
- * ==FILEVERSION 20000417==
+ * ==FILEVERSION 20000902==
  */
 
 #include <linux/config.h>
@@ -32,6 +32,7 @@
 #include <linux/netdevice.h>
 #include <linux/poll.h>
 #include <linux/ppp_defs.h>
+#include <linux/filter.h>
 #include <linux/if_ppp.h>
 #include <linux/ppp_channel.h>
 #include <linux/ppp-comp.h>
@@ -121,6 +122,10 @@
 	struct sk_buff_head mrq;	/* MP: receive reconstruction queue */
 #endif /* CONFIG_PPP_MULTILINK */
 	struct net_device_stats stats;	/* statistics */
+#ifdef CONFIG_PPP_FILTER
+	struct sock_fprog pass_filter;	/* filter for packets to pass */
+	struct sock_fprog active_filter;/* filter for pkts to reset idle */
+#endif /* CONFIG_PPP_FILTER */
 };
 
 /*
@@ -621,6 +626,43 @@
 		err = 0;
 		break;
 
+#ifdef CONFIG_PPP_FILTER
+	case PPPIOCSPASS:
+	case PPPIOCSACTIVE:
+	{
+		struct sock_fprog uprog, *filtp;
+		struct sock_filter *code = NULL;
+		int len;
+
+		if (copy_from_user(&uprog, (void *) arg, sizeof(uprog)))
+			break;
+		if (uprog.len > 0) {
+			err = -ENOMEM;
+			len = uprog.len * sizeof(struct sock_filter);
+			code = kmalloc(len, GFP_KERNEL);
+			if (code == 0)
+				break;
+			err = -EFAULT;
+			if (copy_from_user(code, uprog.filter, len))
+				break;
+			err = sk_chk_filter(code, uprog.len);
+			if (err) {
+				kfree(code);
+				break;
+			}
+		}
+		filtp = (cmd == PPPIOCSPASS)? &ppp->pass_filter: &ppp->active_filter;
+		ppp_lock(ppp);
+		if (filtp->filter)
+			kfree(filtp->filter);
+		filtp->filter = code;
+		filtp->len = uprog.len;
+		ppp_unlock(ppp);
+		err = 0;
+		break;
+	}
+#endif /* CONFIG_PPP_FILTER */
+
 #ifdef CONFIG_PPP_MULTILINK
 	case PPPIOCSMRRU:
 		if (get_user(val, (int *) arg))
@@ -890,6 +932,33 @@
 	int len;
 	unsigned char *cp;
 
+	if (proto < 0x8000) {
+#ifdef CONFIG_PPP_FILTER
+		/* check if we should pass this packet */
+		/* the filter instructions are constructed assuming
+		   a four-byte PPP header on each packet */
+		*skb_push(skb, 2) = 1;
+		if (ppp->pass_filter.filter
+		    && sk_run_filter(skb, ppp->pass_filter.filter,
+				     ppp->pass_filter.len) == 0) {
+			if (ppp->debug & 1) {
+				printk(KERN_DEBUG "PPP: outbound frame not passed\n");
+				kfree_skb(skb);
+				return;
+			}
+		}
+		/* if this packet passes the active filter, record the time */
+		if (!(ppp->active_filter.filter
+		      && sk_run_filter(skb, ppp->active_filter.filter,
+				       ppp->active_filter.len) == 0))
+			ppp->last_xmit = jiffies;
+		skb_pull(skb, 2);
+#else
+		/* for data packets, record the time */
+		ppp->last_xmit = jiffies;
+#endif /* CONFIG_PPP_FILTER */
+	}
+
 	++ppp->stats.tx_packets;
 	ppp->stats.tx_bytes += skb->len - 2;
 
@@ -962,10 +1031,6 @@
 		}
 	}
 
-	/* for data packets, record the time */
-	if (proto < 0x8000)
-		ppp->last_xmit = jiffies;
-
 	/*
 	 * If we are waiting for traffic (demand dialling),
 	 * queue it up for pppd to receive.
@@ -1400,7 +1465,29 @@
 
 	} else {
 		/* network protocol frame - give it to the kernel */
+
+#ifdef CONFIG_PPP_FILTER
+		/* check if the packet passes the pass and active filters */
+		/* the filter instructions are constructed assuming
+		   a four-byte PPP header on each packet */
+		*skb_push(skb, 2) = 0;
+		if (ppp->pass_filter.filter
+		    && sk_run_filter(skb, ppp->pass_filter.filter,
+				     ppp->pass_filter.len) == 0) {
+			if (ppp->debug & 1)
+				printk(KERN_DEBUG "PPP: inbound frame not passed\n");
+			kfree_skb(skb);
+			return;
+		}
+		if (!(ppp->active_filter.filter
+		      && sk_run_filter(skb, ppp->active_filter.filter,
+				       ppp->active_filter.len) == 0))
+			ppp->last_recv = jiffies;
+		skb_pull(skb, 2);
+#else
 		ppp->last_recv = jiffies;
+#endif /* CONFIG_PPP_FILTER */
+
 		if ((ppp->dev->flags & IFF_UP) == 0
 		    || ppp->npmode[npi] != NPMODE_PASS) {
 			kfree_skb(skb);
@@ -1806,70 +1893,6 @@
 }
 
 /*
- * This is basically temporary compatibility stuff.
- */
-ssize_t
-ppp_channel_read(struct ppp_channel *chan, struct file *file,
-		 char *buf, size_t count)
-{
-	struct channel *pch = chan->ppp;
-
-	if (pch == 0)
-		return -ENXIO;
-	return ppp_file_read(&pch->file, file, buf, count);
-}
-
-ssize_t
-ppp_channel_write(struct ppp_channel *chan, const char *buf, size_t count)
-{
-	struct channel *pch = chan->ppp;
-
-	if (pch == 0)
-		return -ENXIO;
-	return ppp_file_write(&pch->file, buf, count);
-}
-
-/* No kernel lock - fine */
-unsigned int
-ppp_channel_poll(struct ppp_channel *chan, struct file *file, poll_table *wait)
-{
-	unsigned int mask;
-	struct channel *pch = chan->ppp;
-
-	mask = POLLOUT | POLLWRNORM;
-	if (pch != 0) {
-		poll_wait(file, &pch->file.rwait, wait);
-		if (skb_peek(&pch->file.rq) != 0)
-			mask |= POLLIN | POLLRDNORM;
-	}
-	return mask;
-}
-
-int ppp_channel_ioctl(struct ppp_channel *chan, unsigned int cmd,
-		      unsigned long arg)
-{
-	struct channel *pch = chan->ppp;
-	int err = -ENOTTY;
-	int unit;
-
-	if (!capable(CAP_NET_ADMIN))
-		return -EPERM;
-	if (pch == 0)
-		return -EINVAL;
-	switch (cmd) {
-	case PPPIOCATTACH:
-		if (get_user(unit, (int *) arg))
-			break;
-		err = ppp_connect_channel(pch, unit);
-		break;
-	case PPPIOCDETACH:
-		err = ppp_disconnect_channel(pch);
-		break;
-	}
-	return err;
-}
-
-/*
  * Compression control.
  */
 
@@ -2192,6 +2215,7 @@
 	ppp->file.index = unit;
 	ppp->mru = PPP_MRU;
 	init_ppp_file(&ppp->file, INTERFACE);
+	ppp->file.hdrlen = PPP_HDRLEN - 2;	/* don't count proto bytes */
 	for (i = 0; i < NUM_NP; ++i)
 		ppp->npmode[i] = NPMODE_PASS;
 	INIT_LIST_HEAD(&ppp->channels);
@@ -2263,6 +2287,16 @@
 #ifdef CONFIG_PPP_MULTILINK
 	skb_queue_purge(&ppp->mrq);
 #endif /* CONFIG_PPP_MULTILINK */
+#ifdef CONFIG_PPP_FILTER
+	if (ppp->pass_filter.filter) {
+		kfree(ppp->pass_filter.filter);
+		ppp->pass_filter.filter = NULL;
+	}
+	if (ppp->active_filter.filter) {
+		kfree(ppp->active_filter.filter);
+		ppp->active_filter.filter = 0;
+	}
+#endif /* CONFIG_PPP_FILTER */
 	dev = ppp->dev;
 	ppp->dev = 0;
 	ppp_unlock(ppp);
@@ -2429,9 +2463,5 @@
 EXPORT_SYMBOL(ppp_output_wakeup);
 EXPORT_SYMBOL(ppp_register_compressor);
 EXPORT_SYMBOL(ppp_unregister_compressor);
-EXPORT_SYMBOL(ppp_channel_read);
-EXPORT_SYMBOL(ppp_channel_write);
-EXPORT_SYMBOL(ppp_channel_poll);
-EXPORT_SYMBOL(ppp_channel_ioctl);
 EXPORT_SYMBOL(all_ppp_units); /* for debugging */
 EXPORT_SYMBOL(all_channels); /* for debugging */
diff -urN linux/drivers/net/ppp_synctty.c pmac/drivers/net/ppp_synctty.c
--- linux/drivers/net/ppp_synctty.c	Thu Feb 22 14:25:14 2001
+++ pmac/drivers/net/ppp_synctty.c	Sat Mar 31 07:39:03 2001
@@ -233,31 +233,25 @@
 }
 
 /*
- * Read a PPP frame, for compatibility until pppd is updated.
+ * Read does nothing - no data is ever available this way.
+ * Pppd reads and writes packets via /dev/ppp instead.
  */
 static ssize_t
 ppp_sync_read(struct tty_struct *tty, struct file *file,
 	       unsigned char *buf, size_t count)
 {
-	struct syncppp *ap = tty->disc_data;
-
-	if (ap == 0)
-		return -ENXIO;
-	return ppp_channel_read(&ap->chan, file, buf, count);
+	return -EAGAIN;
 }
 
 /*
- * Write a ppp frame, for compatibility until pppd is updated.
+ * Write on the tty does nothing, the packets all come in
+ * from the ppp generic stuff.
  */
 static ssize_t
 ppp_sync_write(struct tty_struct *tty, struct file *file,
 		const unsigned char *buf, size_t count)
 {
-	struct syncppp *ap = tty->disc_data;
-
-	if (ap == 0)
-		return -ENXIO;
-	return ppp_channel_write(&ap->chan, buf, count);
+	return -EAGAIN;
 }
 
 static int
@@ -308,30 +302,6 @@
 		err = 0;
 		break;
 
-	/*
-	 * Compatibility calls until pppd is updated.
-	 */
-	case PPPIOCGFLAGS:
-	case PPPIOCSFLAGS:
-	case PPPIOCGASYNCMAP:
-	case PPPIOCSASYNCMAP:
-	case PPPIOCGRASYNCMAP:
-	case PPPIOCSRASYNCMAP:
-	case PPPIOCGXASYNCMAP:
-	case PPPIOCSXASYNCMAP:
-	case PPPIOCGMRU:
-	case PPPIOCSMRU:
-		err = -EPERM;
-		if (!capable(CAP_NET_ADMIN))
-			break;
-		err = ppp_sync_ioctl(&ap->chan, cmd, arg);
-		break;
-
-	case PPPIOCATTACH:
-	case PPPIOCDETACH:
-		err = ppp_channel_ioctl(&ap->chan, cmd, arg);
-		break;
-
 	default:
 		err = -ENOIOCTLCMD;
 	}
@@ -343,16 +313,7 @@
 static unsigned int
 ppp_sync_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 {
-	struct syncppp *ap = tty->disc_data;
-	unsigned int mask;
-
-	mask = POLLOUT | POLLWRNORM;
-	/* compatibility for old pppd */
-	if (ap != 0)
-		mask |= ppp_channel_poll(&ap->chan, file, wait);
-	if (test_bit(TTY_OTHER_CLOSED, &tty->flags) || tty_hung_up_p(file))
-		mask |= POLLHUP;
-	return mask;
+	return 0;
 }
 
 static int
diff -urN linux/include/linux/filter.h pmac/include/linux/filter.h
--- linux/include/linux/filter.h	Fri Apr 28 08:55:09 2000
+++ pmac/include/linux/filter.h	Mon Mar  5 12:16:09 2001
@@ -135,6 +135,7 @@
 #ifdef __KERNEL__
 extern int sk_run_filter(struct sk_buff *skb, struct sock_filter *filter, int flen);
 extern int sk_attach_filter(struct sock_fprog *fprog, struct sock *sk);
+extern int sk_chk_filter(struct sock_filter *filter, int flen);
 #endif /* __KERNEL__ */
 
 #endif /* __LINUX_FILTER_H__ */
diff -urN linux/net/irda/irnet/irnet_ppp.c pmac/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet/irnet_ppp.c	Sun Nov 12 13:11:23 2000
+++ pmac/net/irda/irnet/irnet_ppp.c	Sat Mar 31 07:41:31 2001
@@ -476,7 +476,7 @@
 
   /* If we are connected to ppp_generic, let it handle the job */
   if(ap->ppp_open)
-    return ppp_channel_write(&ap->chan, buf, count);
+    return -EAGAIN;
   else
     return irnet_ctrl_write(ap, buf, count);
 }
@@ -500,7 +500,7 @@
 
   /* If we are connected to ppp_generic, let it handle the job */
   if(ap->ppp_open)
-    return ppp_channel_read(&ap->chan, file, buf, count);
+    return -EAGAIN;
   else
     return irnet_ctrl_read(ap, file, buf, count);
 }
@@ -523,9 +523,7 @@
   DABORT(ap == NULL, mask, FS_ERROR, "ap is NULL !!!\n");
 
   /* If we are connected to ppp_generic, let it handle the job */
-  if(ap->ppp_open)
-    mask |= ppp_channel_poll(&ap->chan, file, wait);
-  else
+  if(!ap->ppp_open)
     mask |= irnet_ctrl_poll(ap, file, wait);
 
   DEXIT(FS_TRACE, " - mask=0x%X\n", mask);
@@ -597,15 +595,6 @@
 	  ap->ppp_open = 0;
 	  err = 0;
 	}
-      break;
-
-      /* Attach this PPP instance to the PPP driver (set it active) */
-    case PPPIOCATTACH:
-    case PPPIOCDETACH:
-      if(ap->ppp_open)
-	err = ppp_channel_ioctl(&ap->chan, cmd, arg);
-      else
-	DERROR(FS_ERROR, "Channel not registered !\n");
       break;
 
       /* Query PPP channel and unit number */
