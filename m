Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbUJZXrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUJZXrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUJZXrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:47:04 -0400
Received: from [202.136.32.45] ([202.136.32.45]:42931 "EHLO
	relay02.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S261546AbUJZXpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:45:30 -0400
From: Grant <grant_nospam@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL] 2.4.28-rc1 RFC remove three compiler warnings
Date: Wed, 27 Oct 2004 09:45:17 +1000
Message-ID: <nfntn0pli2in9qv5i3hj90fchhk2omvka5@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Three compiler warnings are related and due to comparison of 
an unsigned char against 256, resulting in these warnings:

vt.c: In function `do_kdsk_ioctl':
vt.c:166: warning: comparison is always false due to limited range of data type
vt.c: In function `do_kdgkb_ioctl':
vt.c:283: warning: comparison is always false due to limited range of data type
keyboard.c: In function `do_fn':
keyboard.c:640: warning: comparison is always true due to limited range of data type

Related constants:
include/linux/keyboard.h:#define MAX_NR_KEYMAPS 256
include/linux/keyboard.h:#define MAX_NR_FUNC    256
drivers/char/defkeymap.c:char *func_table[MAX_NR_FUNC] = {

Compiler: gcc (GCC) 3.3.4, system is slackware-10.0 on a pII box. 

Is removing useless comparisions the correct solution?

Dot config, dmesg, patch files at:
  http://users.netconnect.com.au/~gcoady/2.4.28-rc1/

Cheers,
Grant Coady.
--

diff -urN -X dontdiff linux-2.4.28-rc1-orig/drivers/char/keyboard.c linux-2.4.28-rc1/drivers/char/keyboard.c
--- linux-2.4.28-rc1-orig/drivers/char/keyboard.c	2003-11-29 05:26:20.000000000 +1100
+++ linux-2.4.28-rc1/drivers/char/keyboard.c	2004-10-26 19:02:24.000000000 +1000
@@ -637,11 +637,8 @@
 {
 	if (up_flag)
 		return;
-	if (value < SIZE(func_table)) {
-		if (func_table[value])
-			puts_queue(func_table[value]);
-	} else
-		printk(KERN_ERR "do_fn called with value=%d\n", value);
+	if (func_table[value])
+		puts_queue(func_table[value]);
 }
 
 static void do_pad(unsigned char value, char up_flag)
diff -urN -X dontdiff linux-2.4.28-rc1-orig/drivers/char/vt.c linux-2.4.28-rc1/drivers/char/vt.c
--- linux-2.4.28-rc1-orig/drivers/char/vt.c	2002-11-29 10:53:12.000000000 +1100
+++ linux-2.4.28-rc1/drivers/char/vt.c	2004-10-26 19:00:29.000000000 +1000
@@ -163,7 +163,7 @@
 
 	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
-	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
+	if (i >= NR_KEYS)
 		return -EINVAL;	
 
 	switch (cmd) {
@@ -280,8 +280,6 @@
 	if (copy_from_user(&tmp, user_kdgkb, sizeof(struct kbsentry)))
 		return -EFAULT;
 	tmp.kb_string[sizeof(tmp.kb_string)-1] = '\0';
-	if (tmp.kb_func >= MAX_NR_FUNC)
-		return -EINVAL;
 	i = tmp.kb_func;
 
 	switch (cmd) {
