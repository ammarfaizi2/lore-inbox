Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWAXRMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWAXRMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWAXRMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:12:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62100 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030461AbWAXRMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:12:47 -0500
Date: Tue, 24 Jan 2006 18:11:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] suspend-to-ram: allow video options to be set at runtime
Message-ID: <20060124171140.GA1949@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, acpi video options can only be set on kernel command
line. That's little inflexible; I'd like userland s2ram application
that just works, and modifying kernel command line according to
whitelist is not fun. It is better to just allow s2ram application to
set video options juts before suspend (according to the
whitelist). This implements sysctl to allow setting suspend video
options without reboot.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 7f47212..164e096 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -146,6 +146,7 @@ enum
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
+	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 };
 
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f5d69b6..692b56c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -44,14 +44,12 @@
 #include <linux/limits.h>
 #include <linux/dcache.h>
 #include <linux/syscalls.h>
+#include <linux/nfs_fs.h>
+#include <linux/acpi.h>
 
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 
-#ifdef CONFIG_ROOT_NFS
-#include <linux/nfs_fs.h>
-#endif
-
 #if defined(CONFIG_SYSCTL)
 
 /* External variables not in a header file. */
@@ -658,6 +656,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_ACPI_SLEEP
+	{
+		.ctl_name	= KERN_ACPI_VIDEO_FLAGS,
+		.procname	= "acpi_video_flags",
+		.data		= &acpi_video_flags,
+		.maxlen		= sizeof (unsigned long),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 

-- 
Thanks, Sharp!
