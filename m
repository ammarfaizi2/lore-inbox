Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWJKJPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWJKJPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWJKJPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:15:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53655 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965199AbWJKJPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:15:52 -0400
Message-ID: <452CB67A.4070702@in.ibm.com>
Date: Wed, 11 Oct 2006 14:46:42 +0530
From: Chandru <chandru@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060726 Red Hat/1.0.3-0.el4.1 SeaMonkey/1.0.3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC]: Possible race condition on an SMP between proc_lookupfd and
 tasks on other cpus
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I am running a RHEL5  distro kernel ( which seems to be quite close to 
Vannilla kernel ) and am having a problem on one of my system 
(PPC64).    The system crashes ( goes in to xmon ) every now and then 
while running TCP stress tests on the system.   The following is the 
backtrace and exception information ( from distro kernel, which might be 
of very little help).

f:mon> e
cpu 0xf: Vector: 300 (Data Access) at [c0000000eaa1b490]
    pc: c0000000001351e0: .tid_fd_revalidate+0x64/0x220
    lr: c0000000001351cc: .tid_fd_revalidate+0x50/0x220
    sp: c0000000eaa1b710
   msr: 8000000000009032
   dar: 6b6b6b6b6b6b6b6b
 dsisr: 40000000
  current = 0xc0000001182864f0
  paca    = 0xc000000000456300
    pid   = 24558, comm = netstat
f:mon> t
[c0000000eaa1b7b0] c000000000138118 .proc_lookupfd+0x17c/0x21c
[c0000000eaa1b860] c0000000000f359c .do_lookup+0x108/0x268
[c0000000eaa1b920] c0000000000f65f8 .__link_path_walk+0xc58/0x1364
[c0000000eaa1ba00] c0000000000f6da0 .link_path_walk+0x9c/0x184
[c0000000eaa1bb40] c0000000000f7364 .do_path_lookup+0x304/0x398
[c0000000eaa1bbf0] c0000000000f7db8 .__user_walk_fd+0x58/0x88
[c0000000eaa1bc90] c0000000000edcdc .sys_readlinkat+0x44/0x130
[c0000000eaa1bdc0] c000000000016784 .compat_sys_readlink+0x14/0x28
[c0000000eaa1be30] c00000000000871c syscall_exit+0x0/0x40


 From code analysis ( vannilla and distro kernel), it looks like there 
can exist a small time window between

 spin_unlock(&files->file_lock) in proc_fd_instantiate()

and fcheck_files() in tid_fd_revalidate()   during which the contents 
of  'struct files_struct files' of a task could be released/cleared by 
that task ( during an exec probably ).

i.e between....
static struct dentry *proc_fd_instantiate(struct inode *dir,....)
{
...
...
        if (file->f_mode & 2)
                inode->i_mode |= S_IWUSR | S_IXUSR;
        spin_unlock(&files->file_lock);                    <------- 1.
        put_files_struct(files);

        inode->i_op = &proc_pid_link_inode_operations;
        inode->i_size = 64;
        ei->op.proc_get_link = proc_fd_link;
        dentry->d_op = &tid_fd_dentry_operations;
        d_add(dentry, inode);
        /* Close the race of the process dying before we return the 
dentry */
        if (tid_fd_revalidate(dentry, NULL))         <-------- 2.
...
...
}


static int tid_fd_revalidate(struct dentry *dentry, struct nameidata *nd)
{
...
...
        if (task) {
                files = get_files_struct(task);
                if (files) {
                        rcu_read_lock();
                        if (fcheck_files(files, fd)) {           
<---------- 2
...
...
}

Could this code analysis be right? and can this race condition be fixed?.

Thanks,
Chandru
