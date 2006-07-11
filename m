Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWGKHxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWGKHxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWGKHxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:53:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26304 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750708AbWGKHxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:53:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<20060710211951.7bf8320b.akpm@osdl.org>
	<m1bqrwiq74.fsf@ebiederm.dsl.xmission.com>
	<20060711000434.6c25d9c2.akpm@osdl.org>
Date: Tue, 11 Jul 2006 01:52:57 -0600
In-Reply-To: <20060711000434.6c25d9c2.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 11 Jul 2006 00:04:34 -0700")
Message-ID: <m14pxoh92e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Tue, 11 Jul 2006 00:57:35 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> Andrew Morton <akpm@osdl.org> writes:
>> 
>> > On Mon, 10 Jul 2006 16:38:59 -0600
>> > ebiederm@xmission.com (Eric W. Biederman) wrote:
>> >
>> >> Since sys_sysctl is deprecated start allow it to be compiled out.
>> >
>> > This could be a tough one to get rid of (looks at sys_bdflush() again).
>> >
>> > I'd suggest we put a sys_bdflush()-style warning in there, see what that
>> > flushes out.
>> 
>> Sounds sane.  I know I have booted several kernels with it compiled out
>> but just because you can do without it doesn't mean that something
>> isn't using it.
>> 
>> Hmm.  The question is where do I want the put the warning message?
>> 
>> When the code is compiled out?
>> When the code is compiled in?
>
> Both.  We want to find out who is using it.
>
>> Probably both places at this point, and using the rate limited printk
>> I think instead of just the 5 printks that sys_bdflush uses...
>
> No, I think five is enough.  If something's using sys_sysctl() then it
> might be using it a lot - there's no point in irritating people over it.

You are right, especially if that user is glibc.  Here is my updated patch:

From: Eric W. Biederman <ebiederm@xmission.com>
Subject: [PATCH] sysctl:  Scream if someone uses sys_sysctl

As far as I can tell we never use sys_sysctl so I never expect to see
these messages.  But if we do see these it means that there are user
space applications that need to be fixed before we can safely
remove sys_sysctl.

Limited to only 5 messages in case something like glibc is using sys_sysctl.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/sysctl.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 42610e6..b7f7dcb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1303,9 +1303,15 @@ int do_sysctl(int __user *name, int nlen
 
 asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
 {
+	static int msg_count;
 	struct __sysctl_args tmp;
 	int error;
 
+	if (msg_count++ < 5)
+		printk(KERN_INFO
+			"warning: process `%s' used the obsolete sysctl "
+			"system call\n", current->comm);
+
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
 
@@ -2688,6 +2694,12 @@ #else /* CONFIG_SYSCTL_SYSCALL */
 
 asmlinkage long sys_sysctl(struct __sysctl_args __user *args)
 {
+	static int msg_count;
+
+	if (msg_coutn++ < 5)
+		printk(KERN_INFO
+			"warning: process `%s' used the removed sysctl "
+			"system call\n", current->comm);
 	return -ENOSYS;
 }
 
-- 
1.4.1.gac83a

