Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbULJRir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbULJRir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbULJRir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:38:47 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47317 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261764AbULJRiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:38:16 -0500
Date: Fri, 10 Dec 2004 10:38:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.10-rc3] Add missing __KERNEL__ (or other) protections
Message-ID: <20041210173810.GM18825@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  As of 2.6.10-rc3, the following is needed to allow various
userland packages (sysvinit, dhcp, ppp, libcap, libpcap, lilo) to
compile as parts that userland needs (e.g. for ioctls) is in files with
stuff userland isn't allowed to see.

This adds __KERNEL__ around <linux/ata.h> and some defines
(<linux/ata.h> isn't needed by userland, and is unhappy right now).
sysvinit and some other packages need <linux/hdreg.h> for HDIO_DRIVE_CMD
and other IOCTL things.  In <linux/types.h> we were unsafely typedef'ing
__le64/__be64 as __u64 only exists when __GNUC__ && !__STRICT_ANSI__
(causing libcap to fail, for example).  Finally, <asm/atomic.h> provides
routines userland simply cannot use on all arches, but <linux/filter.h>
is needed by iputils for example.   While not all arches put __KERNEL__
around their header, on MIPS including this header currently blows up
the build.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux/include/linux/hdreg.h
===================================================================
--- linux.orig/include/linux/hdreg.h
+++ linux/include/linux/hdreg.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_HDREG_H
 #define _LINUX_HDREG_H
 
+#ifdef __KERNEL__
 #include <linux/ata.h>
 
 /*
@@ -57,7 +58,7 @@
 #define IO			0x02
 #define REL			0x04
 #define TAG_MASK		0xf8
-
+#endif /* __KERNEL__ */
 
 /*
  * Command Header sizes for IOCTL commands
Index: linux/include/linux/types.h
===================================================================
--- linux.orig/include/linux/types.h
+++ linux/include/linux/types.h
@@ -157,8 +157,10 @@ typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
 typedef __u32 __bitwise __le32;
 typedef __u32 __bitwise __be32;
+#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
+#endif
 
 struct ustat {
 	__kernel_daddr_t	f_tfree;
Index: linux/include/linux/filter.h
===================================================================
--- linux.orig/include/linux/filter.h
+++ linux/include/linux/filter.h
@@ -8,7 +8,9 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+#ifdef __KERNEL__
 #include <asm/atomic.h>
+#endif
 
 /*
  * Current version of the filter code architecture.

-- 
Tom Rini
http://gate.crashing.org/~trini/
