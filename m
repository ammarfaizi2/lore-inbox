Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271532AbTGRLSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271609AbTGRLSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:18:24 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:34319 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271532AbTGRLSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:18:22 -0400
Date: Fri, 18 Jul 2003 12:33:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: torvalds@osdl.org, Gergely Nagy <algernon@gandalph.mad.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [devfs] Use before initialisation in devfs_mk_cdev()
Message-ID: <20030718123314.A24143@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
	Gergely Nagy <algernon@gandalph.mad.hu>,
	linux-kernel@vger.kernel.org
References: <83he5mm3jt.wl@iluvatar.bonehunter.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <83he5mm3jt.wl@iluvatar.bonehunter.rulez.org>; from algernon@gandalph.mad.hu on Thu, Jul 17, 2003 at 01:53:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 01:53:42AM +0200, Gergely Nagy wrote:
> Hi!
> 
> While playing around with implementing my first linux 2.5 module, I
> stumbled upon a buglet in devfs (though, if used properly, it probably
> won't surface ever). The problem - as I see it - is that
> devfs_mk_cdev() first checks the mode passed to it, and if it thinks
> it is not a char device, it prints a warning and aborts. Now, this
> printing involves the local variable `buf' (char buf[64]), which is
> not initialised at that point.

Sorry, my fault.  I had a report on this earlier but didn't submit
a patch yet.  The same problem also affects devfs_mk_bdev.

Linus, please apply the patch below.


--- 1.95/fs/devfs/base.c	Fri Jul 11 01:24:00 2003
+++ edited/fs/devfs/base.c	Fri Jul 18 11:36:24 2003
@@ -1432,12 +1432,6 @@
 	va_list args;
 	int error, n;
 
-	if (!S_ISBLK(mode)) {
-		printk(KERN_WARNING "%s: invalide mode (%u) for %s\n",
-				__FUNCTION__, mode, buf);
-		return -EINVAL;
-	}
-
 	va_start(args, fmt);
 	n = vsnprintf(buf, 64, fmt, args);
 	if (n >= 64 || !buf[0]) {
@@ -1445,6 +1439,12 @@
 				__FUNCTION__);
 		return -EINVAL;
 	}
+	
+	if (!S_ISBLK(mode)) {
+		printk(KERN_WARNING "%s: invalide mode (%u) for %s\n",
+				__FUNCTION__, mode, buf);
+		return -EINVAL;
+	}
 
 	de = _devfs_prepare_leaf(&dir, buf, mode);
 	if (!de) {
@@ -1478,17 +1478,17 @@
 	va_list args;
 	int error, n;
 
-	if (!S_ISCHR(mode)) {
-		printk(KERN_WARNING "%s: invalide mode (%u) for %s\n",
-				__FUNCTION__, mode, buf);
-		return -EINVAL;
-	}
-
 	va_start(args, fmt);
 	n = vsnprintf(buf, 64, fmt, args);
 	if (n >= 64 || !buf[0]) {
 		printk(KERN_WARNING "%s: invalid format string\n",
 				__FUNCTION__);
+		return -EINVAL;
+	}
+
+	if (!S_ISCHR(mode)) {
+		printk(KERN_WARNING "%s: invalide mode (%u) for %s\n",
+				__FUNCTION__, mode, buf);
 		return -EINVAL;
 	}
 
