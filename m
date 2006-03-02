Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWCBEb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWCBEb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWCBEb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:31:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751163AbWCBEb0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:31:26 -0500
Date: Wed, 1 Mar 2006 20:20:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: pj@sgi.com, greg@kroah.com, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org, yanmin.zhang@intel.com,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060301202058.42975408.akpm@osdl.org>
In-Reply-To: <20060301154040.a7cb2afd.pj@sgi.com>
References: <20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
	<20060228234807.55f1b25f.pj@sgi.com>
	<20060301002631.48e3800e.akpm@osdl.org>
	<20060301015338.b296b7ad.pj@sgi.com>
	<20060301192103.GA14320@kroah.com>
	<20060301125802.cce9ef51.pj@sgi.com>
	<20060301213048.GA17251@kroah.com>
	<20060301142631.22738f2d.akpm@osdl.org>
	<20060301151000.5fff8ec5.pj@sgi.com>
	<20060301154040.a7cb2afd.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
>  > But Paul bisected it down to a particular not-merged patch,
>  > gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch, which I'll
>  > admit doesn't look like it'll cause this.
> 
>  Verified.

All very strange.  afaict that patch is a no-op.  The changelog claims that
"This patch also uses sysfs_notify to allow /sys/block/md*/md/sync_action
to be pollable", except that part is AWOL.

It'd be interesting to see if just the data structure expansion:

--- gregkh-2.6.orig/fs/sysfs/file.c
+++ gregkh-2.6/fs/sysfs/file.c
@@ -6,6 +6,7 @@
 #include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
+#include <linux/poll.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -57,6 +58,7 @@ struct sysfs_buffer {
 	struct sysfs_ops	* ops;
 	struct semaphore	sem;
 	int			needs_read_fill;
+	int			event;
 };
 
 
--- gregkh-2.6.orig/include/linux/kobject.h
+++ gregkh-2.6/include/linux/kobject.h
@@ -24,6 +24,7 @@
 #include <linux/rwsem.h>
 #include <linux/kref.h>
 #include <linux/kernel.h>
+#include <linux/wait.h>
 #include <asm/atomic.h>
 
 #define KOBJ_NAME_LEN			20
@@ -56,6 +57,7 @@ struct kobject {
 	struct kset		* kset;
 	struct kobj_type	* ktype;
 	struct dentry		* dentry;
+	wait_queue_head_t	poll;
 };
 
 extern int kobject_set_name(struct kobject *, const char *, ...)
--- gregkh-2.6.orig/include/linux/sysfs.h
+++ gregkh-2.6/include/linux/sysfs.h
@@ -74,6 +74,7 @@ struct sysfs_dirent {
 	umode_t			s_mode;
 	struct dentry		* s_dentry;
 	struct iattr		* s_iattr;
+	atomic_t		s_event;
 };
 
 #define SYSFS_ROOT		0x0001


is sufficient to break it.


Somewhat OT, but why is that patch dinking around with the attribute's
parent directory?  Why not just poll the attribute's sysfs file directly? 
<xenuflects>.  Possibly because we want the poller to be woken when an
attribute actually gets instantiated within the directory??  Dunno.

And it's a bit sad that poll() on an unpollable attribute will just hang. 
One would expect poll() to come back with -EINVAL.
