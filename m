Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUG2TSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUG2TSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUG2TSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:18:37 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:57279 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264704AbUG2TQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:16:53 -0400
Date: Thu, 29 Jul 2004 21:16:34 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix BSD accounting cross-platform compatibility
Message-ID: <Pine.LNX.4.53.0407292104470.6898@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

it would be nice to have this patch in before 2.6.8-final.

BSD accounting cross-platform compatibility is a new feature of 2.6.8 and 
thus not crucial, but it'd be nice not to have kernels writing wrong file 
formats out in the wild.

Tim

***********************************************************************


The endianness detection logic I wanted to suppose for userspace turned 
out to be bogus. So just do it the simple way and store endianness info 
together with the version number.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de> 


--- linux-2.6.8-rc1/include/linux/acct.h	2004-07-15 16:58:16.000000000 +0200
+++ linux-2.6.8-rc1-acct/include/linux/acct.h	2004-07-15 17:16:34.000000000 +0200
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <asm/param.h>
+#include <asm/byteorder.h>
 
 /* 
  *  comp_t is a 16-bit "floating" point number with a 3-bit base 8
@@ -104,7 +105,12 @@ struct acct_v3
 #define ACOMPAT		0x04	/* ... used compatibility mode (VAX only not used) */
 #define ACORE		0x08	/* ... dumped core */
 #define AXSIG		0x10	/* ... was killed by a signal */
-#define ABYTESEX	0x80	/* always set, allows to detect byteorder */
+
+#ifdef __BIG_ENDIAN
+#define ACCT_BYTEORDER	0x80	/* accounting file is big endian */
+#else
+#define ACCT_BYTEORDER	0x00	/* accounting file is little endian */
+#endif
 
 #ifdef __KERNEL__
 
--- linux-2.6.8-rc1/include/linux/acct.h	2004-07-15 16:58:16.000000000 +0200
+++ linux-2.6.8-rc1-acct/include/linux/acct.h	2004-07-15 17:16:34.000000000 +0200
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <asm/param.h>
+#include <asm/byteorder.h>
 
 /* 
  *  comp_t is a 16-bit "floating" point number with a 3-bit base 8
@@ -104,7 +105,12 @@ struct acct_v3
 #define ACOMPAT		0x04	/* ... used compatibility mode (VAX only not used) */
 #define ACORE		0x08	/* ... dumped core */
 #define AXSIG		0x10	/* ... was killed by a signal */
-#define ABYTESEX	0x80	/* always set, allows to detect byteorder */
+
+#ifdef __BIG_ENDIAN
+#define ACCT_BYTEORDER	0x80	/* accounting file is big endian */
+#else
+#define ACCT_BYTEORDER	0x00	/* accounting file is little endian */
+#endif
 
 #ifdef __KERNEL__
 
--- linux-2.6.8-rc1/kernel/acct.c	2004-07-15 16:58:16.000000000 +0200
+++ linux-2.6.8-rc1-acct/kernel/acct.c	2004-07-15 17:18:50.000000000 +0200
@@ -398,7 +398,7 @@ static void do_acct_process(long exitcod
 	 */
 	memset((caddr_t)&ac, 0, sizeof(acct_t));
 
-	ac.ac_version = ACCT_VERSION;
+	ac.ac_version = ACCT_VERSION | ACCT_BYTEORDER;
 	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
 
 	elapsed = jiffies_64_to_AHZ(get_jiffies_64() - current->start_time);
@@ -441,8 +441,7 @@ static void do_acct_process(long exitcod
 		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
 	read_unlock(&tasklist_lock);
 
-	/* ABYTESEX is always set to allow byte order detection */
-	ac.ac_flag = ABYTESEX;
+	ac.ac_flag = 0;
 	if (current->flags & PF_FORKNOEXEC)
 		ac.ac_flag |= AFORK;
 	if (current->flags & PF_SUPERPRIV)
