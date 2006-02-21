Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWBUVSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWBUVSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWBUVSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:18:32 -0500
Received: from fnord.at ([217.160.110.113]:4872 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S932790AbWBUVSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:18:31 -0500
Date: Tue, 21 Feb 2006 22:18:30 +0100
From: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs fixes for inotify/dnotify
Message-ID: <20060221211830.GB26413@rescue.iwoars.net>
References: <20060221211623.GA26413@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20060221211623.GA26413@rescue.iwoars.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry, forgot the patch...

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inotify.diff"

diff -uNr -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/kernel/fork.c linux-2.6.15.4/kernel/fork.c
--- linux-2.6.15/kernel/fork.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.4/kernel/fork.c	2006-02-18 14:09:54.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/rmap.h>
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
+#include <linux/proc_fs.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1141,6 +1142,7 @@
 	write_unlock_irq(&tasklist_lock);
 	proc_fork_connector(p);
 	cpuset_fork(p);
+	proc_root_notify(pid);
 	retval = 0;
 
 fork_out:
--- linux-2.6.15/include/linux/proc_fs.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.4/include/linux/proc_fs.h	2006-02-18 13:55:52.000000000 +0100
@@ -4,6 +4,8 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/fsnotify.h>
+#include <linux/mount.h>
 #include <asm/atomic.h>
 
 /*
@@ -194,6 +196,13 @@
 	remove_proc_entry(name,proc_net);
 }
 
+static inline void proc_root_notify (pid_t pid)
+{
+	char buf[20];
+	snprintf (buf, sizeof (buf), "%d", pid);
+	fsnotify_mkdir (proc_mnt->mnt_root->d_inode, buf);
+}
+
 #else
 
 #define proc_root_driver NULL
@@ -224,6 +233,8 @@
 	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
 	{ return NULL; }
 
+static inline void proc_root_notify (pid_t pid) {}
+
 struct tty_driver;
 static inline void proc_tty_register_driver(struct tty_driver *driver) {};
 static inline void proc_tty_unregister_driver(struct tty_driver *driver) {};
diff -uNr -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/fs/proc/base.c linux-2.6.15.4/fs/proc/base.c
--- linux-2.6.15/fs/proc/base.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.4/fs/proc/base.c	2006-02-19 10:44:28.000000000 +0100
@@ -1945,6 +1945,7 @@
 	if(proc_dentry != NULL) {
 		shrink_dcache_parent(proc_dentry);
 		dput(proc_dentry);
+		fsnotify_nameremove (proc_dentry, 1);
 	}
 }
 

--9jxsPFA5p3P2qPhR--
