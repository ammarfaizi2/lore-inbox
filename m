Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVBRXob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVBRXob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVBRXob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:44:31 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:31151 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261562AbVBRXoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:44:20 -0500
Date: Sat, 19 Feb 2005 00:44:19 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] add umask parameter to procfs
Message-ID: <20050218234419.GA26311@lsrfire.ath.cx>
References: <20050217212859.GA24403@lsrfire.ath.cx> <20050217154119.1f237921.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217154119.1f237921.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: lsr@lsrfire.ath.cx (Debian User)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 03:41:19PM -0800, Andrew Morton wrote:
> The feature seems fairly obscure, although very simple.  Is anyone actually
> likely to use this?

Yes, it's an obscure obscurity feature. :)  There certainly seems to be
some interest in it: both GrSecurity and OpenWall contain something
similar.  They set the mask at compile time, though.  But being able to
change it at boot time makes it much easier for mainstream distros to
include it in their kernels.

Personally I felt the need for the feature when I was a student sharing
a server with hundreds others.  Sure, it's not very useful on machines
offering no shell access at all.

> > +static umode_t umask = 0;
> 
> a) I think the above should be called proc_umask.
> 
> b) You shouldn't initialise it.
> 
> c) When adding a kernel parameter you should update
>    Documentation/kernel-parameters.txt

Like below?

Hrm, maybe the option should be named pidumask instead of simply umask?


diff -urp linux-2.6.11-rc4/Documentation/kernel-parameters.txt linux-2.6.11-rc4+/Documentation/kernel-parameters.txt
--- linux-2.6.11-rc4/Documentation/kernel-parameters.txt	2005-02-11 21:16:00.000000000 +0100
+++ linux-2.6.11-rc4+/Documentation/kernel-parameters.txt	2005-02-12 01:37:42.000000000 +0100
@@ -1037,16 +1037,19 @@ running once the system is up.
 			[ISAPNP] Exclude memory regions for the autoconfiguration
 			Ranges are in pairs (memory base and size).
 
+	processor.max_cstate=   [HW, ACPI]
+			Limit processor to maximum C-state
+			max_cstate=9 overrides any DMI blacklist limit.
+
+	proc.umask=	[KNL] Restrict permissions of process specific
+			entries in /proc (i.e. the numerical directories).
+
 	profile=	[KNL] Enable kernel profiling via /proc/profile
 			{ schedule | <number> }
 			(param: schedule - profile schedule points}
 			(param: profile step/bucket size as a power of 2 for
 				statistical time based profiling)
 
-	processor.max_cstate=   [HW, ACPI]
-			Limit processor to maximum C-state
-			max_cstate=9 overrides any DMI blacklist limit.
-
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.
 			See Documentation/ramdisk.txt.
diff -urp linux-2.6.11-rc4/fs/proc/base.c linux-2.6.11-rc4+/fs/proc/base.c
--- linux-2.6.11-rc4/fs/proc/base.c	2005-02-11 21:16:13.000000000 +0100
+++ linux-2.6.11-rc4+/fs/proc/base.c	2005-02-12 01:33:14.000000000 +0100
@@ -32,8 +32,14 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include "internal.h"
 
+static umode_t proc_umask;
+module_param_named(umask, proc_umask, ushort, 0);
+MODULE_PARM_DESC(umask, "umask for the numerical directories in /proc");
+
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
  * Feel free to change the macro below - just keep the range distinct from
@@ -1369,7 +1375,7 @@ static struct dentry *proc_pident_lookup
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = p->mode;
+	inode->i_mode = p->mode & ~(proc_umask & S_IALLUGO);
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
@@ -1699,7 +1705,7 @@ struct dentry *proc_pid_lookup(struct in
 		put_task_struct(task);
 		goto out;
 	}
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = S_IFDIR | ((S_IRUGO|S_IXUGO) & ~proc_umask);
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_nlink = 3;
@@ -1754,7 +1760,7 @@ static struct dentry *proc_task_lookup(s
 
 	if (!inode)
 		goto out_drop_task;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = S_IFDIR | ((S_IRUGO|S_IXUGO) & ~proc_umask);
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_nlink = 3;
