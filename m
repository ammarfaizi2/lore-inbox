Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267707AbUBTCjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUBTCjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:39:45 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:56821 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S267707AbUBTCjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:39:42 -0500
Date: Thu, 19 Feb 2004 18:39:28 -0800
From: Tim Hockin <thockin@sun.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
Subject: PATCH: report NGROUPS_MAX via a sysctl (read-only)
Message-ID: <20040220023927.GN9155@sun.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nLMor0SRtNCuLS/8"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nLMor0SRtNCuLS/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a simple patch to expose NGROUPS_MAX via sysctl.  Nothing fancy,
just a read-only variable.  glibc can use this to sysconf() the value
properly, so apps will stop relying on NGROUPS_MAX as a real constant.

Is this the right path?  Or should there be a sysconf-specific mechanism?
-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's

--nLMor0SRtNCuLS/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ngroups-sysctl-1.diff"

===== include/linux/sysctl.h 1.64 vs edited =====
--- 1.64/include/linux/sysctl.h	Wed Feb 18 19:43:21 2004
+++ edited/include/linux/sysctl.h	Thu Feb 19 17:00:34 2004
@@ -129,6 +129,7 @@
 	KERN_HPPA_UNALIGNED=59,	/* int: hppa unaligned-trap enable */
 	KERN_PRINTK_RATELIMIT=60, /* int: tune printk ratelimiting */
 	KERN_PRINTK_RATELIMIT_BURST=61,	/* int: tune printk ratelimiting */
+	KERN_NGROUPS_MAX=62,	/* int: NGROUPS_MAX */
 };
 
 
===== kernel/sysctl.c 1.61 vs edited =====
--- 1.61/kernel/sysctl.c	Wed Feb 18 19:43:21 2004
+++ edited/kernel/sysctl.c	Thu Feb 19 17:05:47 2004
@@ -38,6 +38,7 @@
 #include <linux/security.h>
 #include <linux/initrd.h>
 #include <linux/times.h>
+#include <linux/limits.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_ROOT_NFS
@@ -68,6 +69,8 @@
 static int maxolduid = 65535;
 static int minolduid;
 
+static int ngroups_max = NGROUPS_MAX;
+
 #ifdef CONFIG_KMOD
 extern char modprobe_path[];
 #endif
@@ -591,6 +594,14 @@
 		.data		= &printk_ratelimit_burst,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_NGROUPS_MAX,
+		.procname	= "ngroups_max",
+		.data		= &ngroups_max,
+		.maxlen		= sizeof (int),
+		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
 	{ .ctl_name = 0 }

--nLMor0SRtNCuLS/8--
