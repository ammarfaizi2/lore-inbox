Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUBNQZy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUBNQZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:25:54 -0500
Received: from ns.suse.de ([195.135.220.2]:24238 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262128AbUBNQZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:25:51 -0500
Date: Sat, 14 Feb 2004 17:23:28 +0100
From: Karsten Keil <kkeil@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: BUG Fix for PPP activ/passiv filter in 2.6
Message-ID: <20040214162328.GA5931@pingi3.kke.suse.de>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I found a bug in the PPPIOCSPASS PPPIOCSACTIVE IOCTL implementation in
kernel 2.5/2.6.

The current pppd code use a empty filter (uprog.len=0) to detach the filter
in the kernel, but this code was removed in 2.5.71 while fixing a compiler
warning.

Here the new patch, also with better limit checking.

The second patch check for flen == 0 in the filter check too, since later in
this code a filter[flen - 1] access is done, which is not so funny with flen
0. Maybe it's not really needed anymore, since with the first patch it would
not longer called with flen=0.

diff -urN linux-2.6.3-rc2-bk4.org/drivers/net/ppp_generic.c linux-2.6.3-rc2-bk4/drivers/net/ppp_generic.c
--- linux-2.6.3-rc2-bk4.org/drivers/net/ppp_generic.c	2004-02-11 15:31:33.000000000 +0100
+++ linux-2.6.3-rc2-bk4/drivers/net/ppp_generic.c	2004-02-14 16:39:39.000000000 +0100
@@ -675,20 +675,25 @@
 
 		if (copy_from_user(&uprog, (void __user *) arg, sizeof(uprog)))
 			break;
-		err = -ENOMEM;
-		len = uprog.len * sizeof(struct sock_filter);
-		code = kmalloc(len, GFP_KERNEL);
-		if (code == 0)
-			break;
-		err = -EFAULT;
-		if (copy_from_user(code, (void __user *) uprog.filter, len)) {
-			kfree(code);
-			break;
-		}
-		err = sk_chk_filter(code, uprog.len);
-		if (err) {
-			kfree(code);
+		err = -EINVAL;
+		if (uprog.len > BPF_MAXINSNS)
 			break;
+		err = -ENOMEM;
+		if (uprog.len > 0) {
+			len = uprog.len * sizeof(struct sock_filter);
+			code = kmalloc(len, GFP_KERNEL);
+			if (code == NULL)
+				break;
+			err = -EFAULT;
+			if (copy_from_user(code, (void __user *) uprog.filter, len)) {
+				kfree(code);
+				break;
+			}
+			err = sk_chk_filter(code, uprog.len);
+			if (err) {
+				kfree(code);
+				break;
+			}
 		}
 		filtp = (cmd == PPPIOCSPASS)? &ppp->pass_filter: &ppp->active_filter;
 		ppp_lock(ppp);
diff -urN linux-2.6.3-rc2-bk4.org/net/core/filter.c linux-2.6.3-rc2-bk4/net/core/filter.c
--- linux-2.6.3-rc2-bk4.org/net/core/filter.c	2003-12-18 03:58:39.000000000 +0100
+++ linux-2.6.3-rc2-bk4/net/core/filter.c	2004-02-14 16:39:39.000000000 +0100
@@ -332,7 +332,7 @@
 	struct sock_filter *ftest;
 	int pc;
 
-	if ((unsigned int)flen >= (~0U / sizeof(struct sock_filter)))
+	if (((unsigned int)flen >= (~0U / sizeof(struct sock_filter))) || flen == 0)
 		return -EINVAL;
 
 	/* check the filter code now */


-- 
Karsten Keil
SuSE Labs
ISDN development
