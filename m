Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWEXToc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWEXToc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 15:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWEXToc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 15:44:32 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:48857 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S1751259AbWEXTob
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 15:44:31 -0400
Message-ID: <4474B7DB.8000304@moving-picture.com>
Date: Wed, 24 May 2006 20:45:31 +0100
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 4096 byte limit to /proc/PID/environ ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
>> 
>> I'm not worried about that - more the fact that when I do:
>> 
>> % cat /proc/$$/environ | wc -c
>> 4096
>> % env | wc -c
>> 7329
>> 
>> /proc/PID/environ is truncated ...
>> 
> 
> Funny enough, I was looking at this yesterday.  I think there is a
> pretty clean solution for it, I just haven't had a chance to attack it
> yet.

Having a poke about in fs/proc/, I came up with this - probably isn't 
pretty or clean, but it works ...

James Pearson

--- ./include/linux/proc_fs.h.dist      2006-05-11 02:56:24.000000000 +0100
+++ ./include/linux/proc_fs.h   2006-05-24 13:43:55.964159897 +0100
@@ -250,7 +250,7 @@
         int type;
         union {
                 int (*proc_get_link)(struct inode *, struct dentry **, 
struct vfsmount **);
-               int (*proc_read)(struct task_struct *task, char *page);
+               int (*proc_read)(struct task_struct *task, char *page, 
loff_t *pos);
         } op;
         struct proc_dir_entry *pde;
         struct inode vfs_inode;
--- ./fs/proc/base.c.dist       2006-05-11 02:56:24.000000000 +0100
+++ ./fs/proc/base.c    2006-05-24 13:54:26.370965292 +0100
@@ -409,15 +409,27 @@
          (task->state == TASK_STOPPED || task->state == TASK_TRACED) && \
          security_ptrace(current,task) == 0))

-static int proc_pid_environ(struct task_struct *task, char * buffer)
+static int proc_pid_environ(struct task_struct *task, char * buffer, 
loff_t *pos)
  {
         int res = 0;
+       int p = *pos;
         struct mm_struct *mm = get_task_mm(task);
+
+       /* proc_pid_environ is a 'special case' - the required data could
+          be larger than a page, so we read sequential chunks of the
+          environment data into the buffer using the supplied offset */
+       if (p < 0)
+               return -EINVAL;
+
         if (mm) {
-               unsigned int len = mm->env_end - mm->env_start;
+               unsigned int len = mm->env_end - (mm->env_start + p);
                 if (len > PAGE_SIZE)
                         len = PAGE_SIZE;
-               res = access_process_vm(task, mm->env_start, buffer, 
len, 0);
+               res = access_process_vm(task, (mm->env_start + p), 
buffer, len, 0);
+               /* the calling routine (proc_info_read) needs to know we've
+                  used the offset to read the pid data */
+               *pos += res;
+
                 if (!ptrace_may_attach(task))
                         res = -ESRCH;
                 mmput(mm);
@@ -425,7 +437,7 @@
         return res;
  }

-static int proc_pid_cmdline(struct task_struct *task, char * buffer)
+static int proc_pid_cmdline(struct task_struct *task, char * buffer, 
loff_t *pos)
  {
         int res = 0;
         unsigned int len;
@@ -462,7 +474,7 @@
         return res;
  }

-static int proc_pid_auxv(struct task_struct *task, char *buffer)
+static int proc_pid_auxv(struct task_struct *task, char *buffer, loff_t 
*pos)
  {
         int res = 0;
         struct mm_struct *mm = get_task_mm(task);
@@ -486,7 +498,7 @@
   * Provides a wchan file via kallsyms in a proper one-value-per-file 
format.
   * Returns the resolved symbol.  If that fails, simply return the address.
   */
-static int proc_pid_wchan(struct task_struct *task, char *buffer)
+static int proc_pid_wchan(struct task_struct *task, char *buffer, 
loff_t *pos)
  {
         char *modname;
         const char *sym_name;
@@ -506,7 +518,7 @@
  /*
   * Provides /proc/PID/schedstat
   */
-static int proc_pid_schedstat(struct task_struct *task, char *buffer)
+static int proc_pid_schedstat(struct task_struct *task, char *buffer, 
loff_t *pos)
  {
         return sprintf(buffer, "%lu %lu %lu\n",
                         task->sched_info.cpu_time,
@@ -517,7 +529,7 @@

  /* The badness from the OOM killer */
  unsigned long badness(struct task_struct *p, unsigned long uptime);
-static int proc_oom_score(struct task_struct *task, char *buffer)
+static int proc_oom_score(struct task_struct *task, char *buffer, 
loff_t *pos)
  {
         unsigned long points;
         struct timespec uptime;
@@ -745,16 +757,30 @@
         unsigned long page;
         ssize_t length;
         struct task_struct *task = proc_task(inode);
+       loff_t pos = *ppos;

         if (count > PROC_BLOCK_SIZE)
                 count = PROC_BLOCK_SIZE;
         if (!(page = __get_free_page(GFP_KERNEL)))
                 return -ENOMEM;

-       length = PROC_I(inode)->op.proc_read(task, (char*)page);
+       length = PROC_I(inode)->op.proc_read(task, (char*)page, &pos);

-       if (length >= 0)
-               length = simple_read_from_buffer(buf, count, ppos, (char 
*)page, length);
+       if (length >= 0) {
+               if (pos != *ppos) {
+                       /* we are using the buffer to store subsequent 
sections
+                          of the proc_pid data - so the offset into the 
buffer
+                          will always be 0 - the offset is used to get the
+                          original data */
+                       pos = 0;
+                       length = simple_read_from_buffer(buf, count, 
&pos, (char *)page, length);
+                       /* need to update the 'real' offset into the data we
+                          are reading ... */
+                       *ppos += length;
+               }
+               else
+                       length = simple_read_from_buffer(buf, count, 
ppos, (char *)page, length);
+       }
         free_page(page);
         return length;
  }
--- ./fs/proc/internal.h.dist   2006-05-11 02:56:24.000000000 +0100
+++ ./fs/proc/internal.h        2006-05-24 13:52:53.568391757 +0100
@@ -32,10 +32,10 @@

  extern void create_seq_entry(char *name, mode_t mode, struct 
file_operations *f);
  extern int proc_exe_link(struct inode *, struct dentry **, struct 
vfsmount **);
-extern int proc_tid_stat(struct task_struct *,  char *);
-extern int proc_tgid_stat(struct task_struct *, char *);
-extern int proc_pid_status(struct task_struct *, char *);
-extern int proc_pid_statm(struct task_struct *, char *);
+extern int proc_tid_stat(struct task_struct *,  char *, loff_t *);
+extern int proc_tgid_stat(struct task_struct *, char *, loff_t *);
+extern int proc_pid_status(struct task_struct *, char *, loff_t *);
+extern int proc_pid_statm(struct task_struct *, char *, loff_t *);

  void free_proc_entry(struct proc_dir_entry *de);

--- ./fs/proc/array.c.dist      2006-05-11 02:56:24.000000000 +0100
+++ ./fs/proc/array.c   2006-05-24 13:43:09.327905203 +0100
@@ -293,7 +293,7 @@
                             cap_t(p->cap_effective));
  }

-int proc_pid_status(struct task_struct *task, char * buffer)
+int proc_pid_status(struct task_struct *task, char * buffer, loff_t *pos)
  {
         char * orig = buffer;
         struct mm_struct *mm = get_task_mm(task);
@@ -465,17 +465,17 @@
         return res;
  }

-int proc_tid_stat(struct task_struct *task, char * buffer)
+int proc_tid_stat(struct task_struct *task, char * buffer, loff_t *pos)
  {
         return do_task_stat(task, buffer, 0);
  }

-int proc_tgid_stat(struct task_struct *task, char * buffer)
+int proc_tgid_stat(struct task_struct *task, char * buffer, loff_t *pos)
  {
         return do_task_stat(task, buffer, 1);
  }

-int proc_pid_statm(struct task_struct *task, char *buffer)
+int proc_pid_statm(struct task_struct *task, char *buffer, loff_t *pos)
  {
         int size = 0, resident = 0, shared = 0, text = 0, lib = 0, data 
= 0;
         struct mm_struct *mm = get_task_mm(task);

