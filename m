Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVINURV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVINURV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVINURV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:17:21 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:39454 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932542AbVINURU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:17:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rCgHETsHxbaQKEXgTkZ+AtAugUMzmczGEb0X6WprqVTAxg1O/qbgAG4Hbm1BMnbaboqQbSt2f/EJ0M863TwfG97o47XuwgjnowIyWW4Us4PPq6+z0qhaM/hD+DM6ijux8BLEHDqekxxOokitJf57OT0rwkXgiy/4etdaKYtMeW4=
Message-ID: <2c1942a705091413171e63bf55@mail.gmail.com>
Date: Wed, 14 Sep 2005 23:17:07 +0300
From: Levent Serinol <lserinol@gmail.com>
Reply-To: lserinol@gmail.com
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] per process I/O statistics for userspace
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jlan@engr.sgi.com
In-Reply-To: <20050914092338.GA2260@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2c1942a7050912052759c7f730@mail.gmail.com>
	 <20050914092338.GA2260@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 You're right. Also, this information differs from other ones. So,
putting it into another file makes sense.
  Here is the better one which puts statistics in a file called iostat.

================================================================
--- linux-2.6.13/fs/proc/array.c.org    2005-08-29 02:41:01.000000000 +0300
+++ linux-2.6.13/fs/proc/array.c        2005-09-14 22:05:16.000000000 +0300
@@ -482,3 +482,8 @@ int proc_pid_statm(struct task_struct *t
        return sprintf(buffer,"%d %d %d %d %d %d %d\n",
                       size, resident, shared, text, lib, data, 0);
 }
+
+int proc_pid_iostat(struct task_struct *task, char *buffer)
+{
+       return sprintf(buffer,"%llu %llu\n",task->rchar,task->wchar);
+}
--- linux-2.6.13/fs/proc/base.c.org     2005-08-29 02:41:01.000000000 +0300
+++ linux-2.6.13/fs/proc/base.c 2005-09-14 22:04:03.000000000 +0300
@@ -86,6 +86,7 @@ enum pid_directory_inos {
        PROC_TGID_FD_DIR,
        PROC_TGID_OOM_SCORE,
        PROC_TGID_OOM_ADJUST,
+       PROC_TGID_IOSTAT,
        PROC_TID_INO,
        PROC_TID_STATUS,
        PROC_TID_MEM,
@@ -123,6 +124,7 @@ enum pid_directory_inos {
        PROC_TID_FD_DIR = 0x8000,       /* 0x8000-0xffff */
        PROC_TID_OOM_SCORE,
        PROC_TID_OOM_ADJUST,
+       PROC_TID_IOSTAT,
 };

  struct pid_entry {
@@ -169,6 +171,7 @@ static struct pid_entry tgid_base_stuff[
  #ifdef CONFIG_AUDITSYSCALL
        E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
  #endif
+       E(PROC_TGID_IOSTAT,    "iostat",   S_IFREG|S_IRUGO),
        {0,0,NULL,0}
 };
  static struct pid_entry tid_base_stuff[] = {
@@ -205,6 +208,7 @@ static struct pid_entry tid_base_stuff[]
  #ifdef CONFIG_AUDITSYSCALL
        E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
  #endif
+       E(PROC_TID_IOSTAT,     "iostat",   S_IFREG|S_IRUGO),
        {0,0,NULL,0}
 };

@@ -1596,6 +1600,11 @@ static struct dentry *proc_pident_lookup
                        inode->i_fop = &proc_loginuid_operations;
                        break;
  #endif
+               case PROC_TID_IOSTAT:
+               case PROC_TGID_IOSTAT:
+                       inode->i_fop = &proc_info_file_operations;
+                       ei->op.proc_read = proc_pid_iostat;
+                       break;
                default:
                        printk("procfs: impossible type (%d)",p->type);
                        iput(inode);
--- linux-2.6.13/fs/proc/internal.h.org 2005-09-14 22:07:07.000000000 +0300
+++ linux-2.6.13/fs/proc/internal.h     2005-09-14 22:06:41.000000000 +0300
@@ -36,6 +36,7 @@ extern int proc_tid_stat(struct task_str
  extern int proc_tgid_stat(struct task_struct *, char *);
  extern int proc_pid_status(struct task_struct *, char *);
  extern int proc_pid_statm(struct task_struct *, char *);
+extern int proc_pid_iostat(struct task_struct *, char *);

  static inline struct task_struct *proc_task(struct inode *inode)
 {
=================================================================

On 9/14/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > with following patch, userspace processes/utilities will be able to
> > access per process I/O statistics. for example, top like utilites can
> > use this information.
> 
> Nice, but should not this perhaps go into the other file? Adding more
> integers into long line does not seem nice...
>                                                                         Pavel
> 
> >
> > --- linux-2.6.13/fs/proc/array.c.org    2005-08-29 02:41:01.000000000 +0300
> > +++ linux-2.6.13/fs/proc/array.c        2005-09-12 10:22:55.000000000 +0300
> > @@ -408,7 +408,7 @@ static int do_task_stat(struct task_stru
> >
> >         res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
> >  %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
> > -%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
> > +%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu %llu\n",
> >                 task->pid,
> >                 tcomm,
> >                 state,
> > @@ -453,7 +453,9 @@ static int do_task_stat(struct task_stru
> >                 task->exit_signal,
> >                 task_cpu(task),
> >                 task->rt_priority,
> > -               task->policy);
> > +               task->policy,
> > +               task->rchar,
> > +               task->wchar);
> >         if(mm)
> >                 mmput(mm);
> >         return res;
> > --
> > Signed-off-by: Levent Serinol <lserinol@gmail.com>
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> --
> if you have sharp zaurus hardware you don't need... you know my address
> 


-- 

Stay out of the road, if you want to grow old. 
~ Pink Floyd ~.
