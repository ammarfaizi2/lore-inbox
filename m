Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbTAHTuz>; Wed, 8 Jan 2003 14:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267880AbTAHTuz>; Wed, 8 Jan 2003 14:50:55 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:31753 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267879AbTAHTuy>; Wed, 8 Jan 2003 14:50:54 -0500
Date: Wed, 8 Jan 2003 19:59:34 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: [PATCH] /proc/sys/kernel/pointer_size
Message-ID: <20030108195934.GA35912@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18WMMR-000CXc-00*L0DcvXtlbec*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OProfile needs to know the pointer size being used for the kernel,
on platforms with 32-bit userspace and 64-bit kernel. This patch adds
a simple ro sysctl that exports this information as suggested by davem

thanks,
john


diff -X dontdiff -Naur linux-linus/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-linus/include/linux/sysctl.h	2003-01-03 02:59:14.000000000 +0000
+++ linux/include/linux/sysctl.h	2003-01-03 03:14:44.000000000 +0000
@@ -129,6 +129,7 @@
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
+	KERN_POINTER_SIZE=57,	/* size_t: sizeof(void *) */
 };
 
 
diff -X dontdiff -Naur linux-linus/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-linus/kernel/sysctl.c	2002-12-16 04:09:26.000000000 +0000
+++ linux/kernel/sysctl.c	2002-12-16 04:13:58.000000000 +0000
@@ -56,6 +56,9 @@
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
 
+/* Needed when user-space is 32-bit with 64-bit kernel */
+static int pointer_size = (int)sizeof(void *);
+ 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -180,6 +183,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),
 	 0600, NULL, &proc_dointvec_bset},
+	{KERN_POINTER_SIZE, "pointer_size", &pointer_size, sizeof(int),
+	 0444, NULL, &proc_dointvec},
 #ifdef CONFIG_BLK_DEV_INITRD
 	{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(int),
 	 0644, NULL, &proc_dointvec},
