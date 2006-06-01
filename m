Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWFAOL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWFAOL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWFAOL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:11:28 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:58802 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S1750771AbWFAOL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:11:28 -0400
Message-ID: <447EF58C.6000605@moving-picture.com>
Date: Thu, 01 Jun 2006 15:11:24 +0100
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 4096 byte limit to /proc/PID/environ ?
References: <4474B7DB.8000304@moving-picture.com> <200605242029.k4OKTn9C031700@terminus.zytor.com>
In-Reply-To: <200605242029.k4OKTn9C031700@terminus.zytor.com>
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
> I think this is the wrong approach.
> 
> Many of these should probably be converted to seq_file, but in the
> particular case of environ, the right approach is to observe the fact
> that reading environ is just like reading /proc/PID/mem, except:
> 
>  a. the access restrictions are less strict, and
>  b. there is a range restriction, which needs to be enforced, and
>  c. there is an offset.
> 
> Pretty much, take the guts from /proc/PID/mem and generalize it
> slightly, and you have the code that can run either /proc/PID/mem or
> /proc/PID/environ.

The following patch is based on the /proc/PID/mem code appears to work fine.

James Pearson


--- ./fs/proc/base.c.dist       2006-05-11 02:56:24.000000000 +0100
+++ ./fs/proc/base.c    2006-06-01 13:40:50.865851007 +0100
@@ -409,22 +409,6 @@
          (task->state == TASK_STOPPED || task->state == TASK_TRACED) && \
          security_ptrace(current,task) == 0))

-static int proc_pid_environ(struct task_struct *task, char * buffer)
-{
-       int res = 0;
-       struct mm_struct *mm = get_task_mm(task);
-       if (mm) {
-               unsigned int len = mm->env_end - mm->env_start;
-               if (len > PAGE_SIZE)
-                       len = PAGE_SIZE;
-               res = access_process_vm(task, mm->env_start, buffer, 
len, 0);
-               if (!ptrace_may_attach(task))
-                       res = -ESRCH;
-               mmput(mm);
-       }
-       return res;
-}
-
  static int proc_pid_cmdline(struct task_struct *task, char * buffer)
  {
         int res = 0;
@@ -897,6 +881,80 @@
         .open           = mem_open,
  };

+static ssize_t env_read(struct file * file, char __user * buf,
+                       size_t count, loff_t *ppos)
+{
+       struct task_struct *task = proc_task(file->f_dentry->d_inode);
+       char *page;
+       unsigned long src = *ppos;
+       int ret = -ESRCH;
+       struct mm_struct *mm;
+       size_t max_len;
+
+       if (!ptrace_may_attach(task))
+               goto out;
+
+       ret = -ENOMEM;
+       page = (char *)__get_free_page(GFP_USER);
+       if (!page)
+               goto out;
+
+       ret = 0;
+
+       mm = get_task_mm(task);
+       if (!mm)
+               goto out_free;
+
+       ret = 0;
+       max_len = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+
+       while (count > 0) {
+               int this_len, retval;
+
+               this_len = mm->env_end - (mm->env_start + src);
+
+               if (this_len <= 0) {
+                       break;
+               }
+
+               if (this_len > max_len)
+                       this_len = max_len;
+
+               retval = access_process_vm(task, (mm->env_start + src), 
page, this_len, 0);
+
+               if (!ptrace_may_attach(task)) {
+                       ret = -ESRCH;
+                       break;
+               }
+
+               if (retval <= 0) {
+                       ret = retval;
+                       break;
+               }
+
+               if (copy_to_user(buf, page, retval)) {
+                       ret = -EFAULT;
+                       break;
+               }
+
+               ret += retval;
+               src += retval;
+               buf += retval;
+               count -= retval;
+       }
+       *ppos = src;
+
+       mmput(mm);
+out_free:
+       free_page((unsigned long) page);
+out:
+       return ret;
+}
+
+static struct file_operations proc_env_operations = {
+       .read           = env_read,
+};
+
  static ssize_t oom_adjust_read(struct file *file, char __user *buf,
                                 size_t count, loff_t *ppos)
  {
@@ -1675,11 +1733,6 @@
                         inode->i_op = &proc_pid_link_inode_operations;
                         ei->op.proc_get_link = proc_root_link;
                         break;
-               case PROC_TID_ENVIRON:
-               case PROC_TGID_ENVIRON:
-                       inode->i_fop = &proc_info_file_operations;
-                       ei->op.proc_read = proc_pid_environ;
-                       break;
                 case PROC_TID_AUXV:
                 case PROC_TGID_AUXV:
                         inode->i_fop = &proc_info_file_operations;
@@ -1723,6 +1776,10 @@
                         inode->i_op = &proc_mem_inode_operations;
                         inode->i_fop = &proc_mem_operations;
                         break;
+               case PROC_TID_ENVIRON:
+               case PROC_TGID_ENVIRON:
+                       inode->i_fop = &proc_env_operations;
+                       break;
  #ifdef CONFIG_SECCOMP
                 case PROC_TID_SECCOMP:
                 case PROC_TGID_SECCOMP:
