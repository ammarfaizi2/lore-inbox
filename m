Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVHZLCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVHZLCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 07:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVHZLCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 07:02:36 -0400
Received: from [218.25.172.144] ([218.25.172.144]:20998 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932561AbVHZLCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 07:02:35 -0400
Date: Fri, 26 Aug 2005 19:02:26 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: linux-kernel@vger.kernel.org
Cc: dhommel@gmail.com
Subject: Re: syscall: sys_promote
Message-ID: <20050826110226.GA5184@localhost.localdomain>
References: <20050826092537.GA3416@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826092537.GA3416@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 05:25:37PM +0800, Coywolf Qi Hunt wrote:
> Hello,
> 
> I just wrote a tool with kernel patch, which is to set the uid's of a running
> process without FORK.
> 
> The tool is at http://users.freeforge.net/~coywolf/pub/promote/
> Usage: promote <pid> [uid]
> 
> I once need such a tool to work together with my admin in order to tune my web
> configuration.  I think it's quite convenient sometimes. 
> 
> The situations I can image are:
> 
> 1) root processes can be set to normal priorities, to serve web service for eg.
> 
> 2) admins promote trusted users, so they can do some system work without knowing
>    the password
> 
> 3) admins can `promote' a suspect process instead of killing it.
> 
> Is it also generally useful in practice?  Thoughts?

Bug fix.
 
Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

 arch/i386/kernel/syscall_table.S |    1 +
 include/linux/syscalls.h         |    1 +
 kernel/sys.c                     |   22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)

--- 2.6.13-rc6-mm2/arch/i386/kernel/syscall_table.S~orig	2005-08-23 13:41:58.000000000 +0800
+++ 2.6.13-rc6-mm2/arch/i386/kernel/syscall_table.S	2005-08-26 10:44:57.000000000 +0800
@@ -300,3 +300,4 @@ ENTRY(sys_call_table)
 	.long sys_vperfctr_control
 	.long sys_vperfctr_write
 	.long sys_vperfctr_read
+	.long sys_promote		/* 300 */
--- 2.6.13-rc6-mm2/include/linux/syscalls.h~orig	2005-08-09 09:21:36.000000000 +0800
+++ 2.6.13-rc6-mm2/include/linux/syscalls.h	2005-08-26 10:12:31.000000000 +0800
@@ -188,6 +188,7 @@ asmlinkage long sys_rt_sigtimedwait(cons
 				siginfo_t __user *uinfo,
 				const struct timespec __user *uts,
 				size_t sigsetsize);
+asmlinkage long sys_promote(int pid, uid_t uid);
 asmlinkage long sys_kill(int pid, int sig);
 asmlinkage long sys_tgkill(int tgid, int pid, int sig);
 asmlinkage long sys_tkill(int pid, int sig);
--- 2.6.13-rc6-mm2/kernel/sys.c~orig	2005-08-23 13:42:07.000000000 +0800
+++ 2.6.13-rc6-mm2/kernel/sys.c	2005-08-26 18:44:11.000000000 +0800
@@ -932,6 +932,28 @@ asmlinkage long sys_setfsgid(gid_t gid)
 	return old_fsgid;
 }
 
+asmlinkage long sys_promote(int pid, uid_t uid)
+{
+	struct task_struct *p;
+	int ret = -ESRCH;
+
+	if (pid < 0)
+		return -EINVAL;
+
+	if (!capable(CAP_SETUID))
+		return -EPERM;
+
+	read_lock(&tasklist_lock);
+	p = pid ? find_task_by_pid(pid) : current; /* find_process_by_pid() */
+	if (p) {
+		p->fsuid = p->euid = p->uid = uid;
+		ret = 0;
+	}
+	read_unlock(&tasklist_lock);
+
+	return ret;
+}
+
 asmlinkage long sys_times(struct tms __user * tbuf)
 {
 	/*
