Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315317AbSDWTqC>; Tue, 23 Apr 2002 15:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315318AbSDWTqB>; Tue, 23 Apr 2002 15:46:01 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:58869 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S315317AbSDWTp7>; Tue, 23 Apr 2002 15:45:59 -0400
Subject: [PATCH] 2.5.9 TUN/TAP driver readv/writev support
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: davem@readhat.com, jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019590988.1357.87.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 23 Apr 2002 12:43:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following patch adds proper support for readv/writev in TUN/TAP driver.
http://bluez.sourceforge.net/patches/tun-readv-writev-2.5.9.gz

Pleas apply

Thanks
Max

--- /opt/kernel/linux-2.5/drivers/net/tun.c	Mon Apr 22 15:29:04 2002
+++ linux-2.5/drivers/net/tun.c	Tue Apr 23 12:23:56 2002
@@ -1,6 +1,6 @@
 /*
  *  TUN - Universal TUN/TAP device driver.
- *  Copyright (C) 1999-2000 Maxim Krasnyansky <max_mk@yahoo.com>
+ *  Copyright (C) 1999-2002 Maxim Krasnyansky <maxk@qualcomm.com>
*
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -12,7 +12,7 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  *  GNU General Public License for more details.
  *
- *  $Id: tun.c,v 1.12 2001/03/08 03:29:27 maxk Exp $
+ *  $Id: tun.c,v 1.15 2002/03/01 02:44:24 maxk Exp $
  */
 
 /*
@@ -20,7 +20,7 @@
  *    Modifications for 2.3.99-pre5 kernel.
  */
 
-#define TUN_VER "1.4"
+#define TUN_VER "1.5"
 
 #include <linux/config.h>
#include <linux/module.h>
@@ -181,50 +181,26 @@
 }
 
 /* Get packet from user space buffer(already verified) */
-static __inline__ ssize_t
-tun_get_user(struct tun_struct *tun, const struct iovec *iov,
-	     unsigned long count, size_t total)
+static __inline__ ssize_t tun_get_user(struct tun_struct *tun, struct iovec *iv, size_t count)
 {
 	struct tun_pi pi = { 0, __constant_htons(ETH_P_IP) };
-	const struct iovec *vector = &iov[0];
-	register const char *ptr = vector->iov_base;
-	register int len = vector->iov_len;
 	struct sk_buff *skb;
-	ssize_t sent = 0;
+	size_t len = count;
 
 	if (!(tun->flags & TUN_NO_PI)) {
 		if ((len -= sizeof(pi)) < 0)
 			return -EINVAL;
 
-		copy_from_user(&pi, ptr, sizeof(pi));
-		ptr += sizeof(pi);
-
-		if (len == 0) {
-			vector++;
-			count--;
-
-			ptr = vector->iov_base;
-			len = vector->iov_len;
-		}
+		memcpy_fromiovec((void *)&pi, iv, sizeof(pi));
 	}
  
-	if (!(skb = alloc_skb(total + 2, GFP_KERNEL))) {
+	if (!(skb = alloc_skb(len + 2, GFP_KERNEL))) {
 		tun->stats.rx_dropped++;
 		return -ENOMEM;
 	}
 
 	skb_reserve(skb, 2);
-
-	while (count > 0) {
-		copy_from_user(skb_put(skb, len), ptr, len); 
-		sent += len;
-
-		vector++;
-		count--;
-
-		ptr = vector->iov_base;
-		len = vector->iov_len;
-	}
+	memcpy_fromiovec(skb_put(skb, len), iv, len);
 
 	skb->dev = &tun->dev;
 	switch (tun->flags & TUN_TYPE_MASK) {
@@ -243,60 +219,48 @@
 	netif_rx_ni(skb);
    
 	tun->stats.rx_packets++;
-	tun->stats.rx_bytes += sent;
+	tun->stats.rx_bytes += len;
 
-	return total;
+	return count;
 } 
 
-/* Write */
-static ssize_t tun_chr_write(struct file * file, const char * buf, 
-			     size_t count, loff_t *pos)
-{
-	struct tun_struct *tun = (struct tun_struct *)file->private_data;
-	struct iovec iov;
-
-	if (!tun)
-		return -EBADFD;
-
-	DBG(KERN_INFO "%s: tun_chr_write %d\n", tun->name, count);
-
-	if (verify_area(VERIFY_READ, buf, count))
-		return -EFAULT;
-
-	iov.iov_base = (char *) buf;
-	iov.iov_len = count;
-
-	return tun_get_user(tun, &iov, 1, count);
-}
-
 /* Writev */
-static ssize_t tun_chr_writev(struct file * file, const struct iovec *iov,
+static ssize_t tun_chr_writev(struct file * file, const struct iovec *iv, 
 			      unsigned long count, loff_t *pos)
 {
 	struct tun_struct *tun = (struct tun_struct *)file->private_data;
-	size_t total = 0;
 	unsigned long i;
+	size_t len;
 
 	if (!tun)
 		return -EBADFD;
 
-	for (i = 0; i < count; i++) {
-		if (verify_area(VERIFY_READ, iov[i].iov_base, iov[i].iov_len))
+	DBG(KERN_INFO "%s: tun_chr_write %d\n", tun->name, count);
+
+	for (i = 0, len = 0; i < count; i++) {
+		if (verify_area(VERIFY_READ, iv[i].iov_base, iv[i].iov_len))
 			return -EFAULT;
-		total += iov[i].iov_len;
+		len += iv[i].iov_len;
 	}
 
-	return tun_get_user(tun, iov, count, total);
+	return tun_get_user(tun, (struct iovec *) iv, len);
+}
+
+/* Write */
+static ssize_t tun_chr_write(struct file * file, const char * buf, 
+			     size_t count, loff_t *pos)
+{
+	struct iovec iv = { (void *) buf, count };
+	return tun_chr_writev(file, &iv, 1, pos);
 }
 
-/* Put packet to user space buffer(already verified) */
+/* Put packet to the user space buffer (already verified) */
 static __inline__ ssize_t tun_put_user(struct tun_struct *tun,
 				       struct sk_buff *skb,
-				       char *buf, int count)
+				       struct iovec *iv, int len)
 {
 	struct tun_pi pi = { 0, skb->protocol };
-	int len = count, total = 0;
-	char *ptr = buf;
+	ssize_t total = 0;
 
 	if (!(tun->flags & TUN_NO_PI)) {
 		if ((len -= sizeof(pi)) < 0)
@@ -307,14 +271,13 @@
 			pi.flags |= TUN_PKT_STRIP;
 		}
  
-		copy_to_user(ptr, &pi, sizeof(pi));
-
+		memcpy_toiovec(iv, (void *) &pi, sizeof(pi));
 		total += sizeof(pi);
-		ptr += sizeof(pi);
 	}       
 
-	len = MIN(skb->len, len); 
-	copy_to_user(ptr, skb->data, len); 
+	len = MIN(skb->len, len);
+
+	skb_copy_datagram_iovec(skb, 0, iv, len);
 	total += len;
 
 	tun->stats.tx_packets++;
@@ -323,22 +286,29 @@
 	return total;
 }
 
-/* Read */
-static ssize_t tun_chr_read(struct file * file, char * buf, 
-			    size_t count, loff_t *pos)
+/* Readv */
+static ssize_t tun_chr_readv(struct file *file, const struct iovec *iv,
+			    unsigned long count, loff_t *pos)
 {
 	struct tun_struct *tun = (struct tun_struct *)file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
 	struct sk_buff *skb;
-	ssize_t ret = 0;
+	ssize_t len, ret = 0;
+	unsigned long i;
 
 	if (!tun)
 		return -EBADFD;
 
 	DBG(KERN_INFO "%s: tun_chr_read\n", tun->name);
 
+	for (i = 0, len = 0; i < count; i++) {
+		if (verify_area(VERIFY_WRITE, iv[i].iov_base, iv[i].iov_len))
+			return -EFAULT;
+		len += iv[i].iov_len;
+	}
+
 	add_wait_queue(&tun->read_wait, &wait);
-	while (count) {
+	while (len) {
 		current->state = TASK_INTERRUPTIBLE;
 
 		/* Read frames from the queue */
@@ -358,10 +328,7 @@
 		}
 		netif_start_queue(&tun->dev);
 
-		if (!verify_area(VERIFY_WRITE, buf, count))
-			ret = tun_put_user(tun, skb, buf, count);
-		else
-			ret = -EFAULT;
+		ret = tun_put_user(tun, skb, (struct iovec *) iv, len);
 
 		kfree_skb(skb);
 		break;
@@ -373,6 +340,14 @@
 	return ret;
 }
 
+/* Read */
+static ssize_t tun_chr_read(struct file * file, char * buf, 
+			    size_t count, loff_t *pos)
+{
+	struct iovec iv = { buf, count };
+	return tun_chr_readv(file, &iv, 1, pos);
+}
+
 static int tun_set_iff(struct file *file, struct ifreq *ifr)
 {
 	struct tun_struct *tun;
@@ -592,6 +567,7 @@
 	owner:	THIS_MODULE,	
 	llseek:	no_llseek,
 	read:	tun_chr_read,
+	readv:	tun_chr_readv,
 	write:	tun_chr_write,
 	writev:	tun_chr_writev,
 	poll:	tun_chr_poll,
@@ -611,7 +587,7 @@
 int __init tun_init(void)
 {
 	printk(KERN_INFO "Universal TUN/TAP device driver %s " 
-	       "(C)1999-2001 Maxim Krasnyansky\n", TUN_VER);
+	       "(C)1999-2002 Maxim Krasnyansky\n", TUN_VER);
 
 	if (misc_register(&tun_miscdev)) {
 		printk(KERN_ERR "tun: Can't register misc device %d\n", TUN_MINOR);




