Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUHWVCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUHWVCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUHWU7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:59:08 -0400
Received: from holomorphy.com ([207.189.100.168]:21894 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267747AbUHWUWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:22:06 -0400
Date: Mon, 23 Aug 2004 13:21:58 -0700
From: wli@holomorphy.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-ID: <20040823202158.GJ4418@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822013402.5917b991.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 01:34:02AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm4/
> - Added the kexec code.  Again.  This was in -mm a year or so ago but didn't
>   make it.
> - This kernel has an x86 patch which alters the copy_*_user() functions so
>   they will return -EFAULT on a fault rather than the number of bytes which
>   remain to be copied.  This is a bit of an experiment, because this seems to
>   be the preferred API for those functions.   It's a see-what-breaks thing.
>   And things will break.  If weird behaviour is observed, please revert
>   usercopy-return-EFAULT.patch and send a report.

task_vsize() doesn't need mm->mmap_sem for the CONFIG_MMU case; the
semaphore doesn't prevent mm->total_vm from going stale or getting
inconsistent with other numbers regardless. Also, KSTK_EIP() and
KSTK_ESP() don't want or need protection from mm->mmap_sem either. So
this pushes mm->mmap_sem to task_vsize() in the CONFIG_MMU=n task_vsize().

Also, hoist the prototype of task_vsize() into proc_fs.h

The net result of this is a small speedup of procps for CONFIG_MMU.


Index: mm4-2.6.8.1/fs/proc/array.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/array.c	2004-08-23 10:16:52.126977417 -0700
+++ mm4-2.6.8.1/fs/proc/array.c	2004-08-23 10:20:24.268576381 -0700
@@ -300,7 +300,6 @@
 	return buffer - orig;
 }
 
-extern unsigned long task_vsize(struct mm_struct *);
 int proc_pid_stat(struct task_struct *task, char * buffer)
 {
 	unsigned long vsize, eip, esp, wchan;
@@ -320,11 +319,9 @@
 	vsize = eip = esp = 0;
 	mm = get_task_mm(task);
 	if (mm) {
-		down_read(&mm->mmap_sem);
 		vsize = task_vsize(mm);
 		eip = KSTK_EIP(task);
 		esp = KSTK_ESP(task);
-		up_read(&mm->mmap_sem);
 	}
 
 	get_task_comm(tcomm, task);
Index: mm4-2.6.8.1/fs/proc/task_nommu.c
===================================================================
--- mm4-2.6.8.1.orig/fs/proc/task_nommu.c	2004-08-14 03:55:33.000000000 -0700
+++ mm4-2.6.8.1/fs/proc/task_nommu.c	2004-08-23 10:21:10.930685184 -0700
@@ -68,11 +68,12 @@
 	struct mm_tblock_struct *tbp;
 	unsigned long vsize = 0;
 
+	down_read(&mm->mmap_sem);
 	for (tbp = &mm->context.tblock; tbp; tbp = tbp->next) {
 		if (tbp->rblock)
 			vsize += kobjsize(tbp->rblock->kblock);
 	}
-
+	up_read(&mm->mmap_sem);
 	return vsize;
 }
 
Index: mm4-2.6.8.1/include/linux/proc_fs.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/proc_fs.h	2004-08-14 03:56:25.000000000 -0700
+++ mm4-2.6.8.1/include/linux/proc_fs.h	2004-08-23 10:22:38.627949735 -0700
@@ -90,6 +90,7 @@
 struct dentry *proc_pid_unhash(struct task_struct *p);
 void proc_pid_flush(struct dentry *proc_dentry);
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);
+unsigned long task_vsize(struct mm_struct *);
 
 extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 						struct proc_dir_entry *parent);
