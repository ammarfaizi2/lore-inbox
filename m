Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279779AbRJ0ESr>; Sat, 27 Oct 2001 00:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279780AbRJ0ES2>; Sat, 27 Oct 2001 00:18:28 -0400
Received: from zero.tech9.net ([209.61.188.187]:58890 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279779AbRJ0ESS>;
	Sat, 27 Oct 2001 00:18:18 -0400
Subject: [PATCH] mtrr compile fix when no procfs/devfs
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 27 Oct 2001 00:18:51 -0400
Message-Id: <1004156333.981.42.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/mtrr.c does not compile when neither CONFIG_PROC_FS and
CONFIG_DEVFS_FS are set.  mtrr has interfaces that are defined when
either are set.

The problem is that both devfs_handle and struct mtrr_fops are declared
inside the section of code for these interfaces, but are referenced
outside of them.

Note that yes, the devfs code does not need to be explicitly ifdef'ed
since it is all defined as nops.  But then we would have to pull out the
devfs_handle typedef and mtrr_fops struct, which is just as pointless.

The attached is against 2.4.13-ac2.  Alan, please apply.


diff -ur linux-2.4.13-ac2/arch/i386/kernel/mtrr.c linux/arch/i386/kernel/mtrr.c
--- linux-2.4.13-ac2/arch/i386/kernel/mtrr.c	Fri Oct 26 15:48:14 2001
+++ linux/arch/i386/kernel/mtrr.c	Sat Oct 27 00:04:09 2001
@@ -2249,9 +2249,11 @@
 	proc_root_mtrr->proc_fops = &mtrr_fops;
     }
 #endif
+#ifdef CONFIG_DEVFS_FS
     devfs_handle = devfs_register (NULL, "cpu/mtrr", DEVFS_FL_DEFAULT, 0, 0,
 				   S_IFREG | S_IRUGO | S_IWUSR,
 				   &mtrr_fops, NULL);
+#endif
     init_table ();
     return 0;
 }   /*  End Function mtrr_init  */


	Robert Love

