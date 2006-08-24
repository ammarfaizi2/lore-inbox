Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWHXQeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWHXQeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWHXQeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:34:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15027 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030375AbWHXQeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:34:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Amnon Shiloh <amnons@cs.huji.ac.il>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, gregkh@suse.de
Subject: Re: [2.6.18 patch] fix mem_write return value (was: Re: bug report: mem_write)
References: <E1GGAWv-0001uP-Mu@lucifer.cs.huji.ac.il>
	<20060824140001.GE1543@slug>
Date: Thu, 24 Aug 2006 10:33:20 -0600
In-Reply-To: <20060824140001.GE1543@slug> (Frederik Deweerdt's message of
	"Thu, 24 Aug 2006 14:00:01 +0000")
Message-ID: <m17j0ym6un.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt <deweerdt@free.fr> writes:

> On Thu, Aug 24, 2006 at 11:25:37AM +0300, Amnon Shiloh wrote:
>> Hi,
>> 
>> Alright, I know that "mem_write" (fs/proc/base.c) is a "security hazard",
>> but I need to use it anyway (as super-user only), and find it broken,
>> somewhere between Linux-2.6.17 and Linux-2.6.18-rc4.
>> 
>> The point is that in the beginning of the routine, "copied" is set to 0,
>> but it is no good because in lines 805 and 812 it is set to other values.
>> Finally, the routine returns as if it copied 12 (=ENOMEM) bytes less than
>> it actually did.
> True, it looks like the faulty commit is:
> de7587343bfebc186995ad294e3de0da382eb9bc

Actually it was: 99f895518368252ba862cc15ce4eb98ebbe1bec6
Which is what you url points to, odd.

> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=99f895518368252ba862cc15ce4eb98ebbe1bec6;hp=8578cea7509cbdec25b31d08b48a92fcc3b1a9e3
>
> The attached patch should fix it. Maybe that should go to 2.6.18.
> Thanks for the bug report,

The patch looks correct.  Although this won't cause anyone problems as the code
is disabled.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>

As for enabling this.  I believe we need an extra permission check just before
we copy the data from our temporary buffer to the target task, to ensure
nothing has changed.  The history does not really capture why this code
was disabled, but before this gets enabled I would like to understand more
than just the comment.  I believe with a little care this can be safely enabled
as it doesn't let you do anything ptrace wouldn't do, and it should let you do
it anytime except when ptrace would allow it.  Thus not introducing any new
security holes.

> Frederik
>
> Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
>
> --- fs/proc/base.c.orig	2006-08-24 13:57:22.000000000 +0200
> +++ fs/proc/base.c	2006-08-24 13:57:10.000000000 +0200
> @@ -797,7 +797,7 @@
>  static ssize_t mem_write(struct file * file, const char * buf,
>  			 size_t count, loff_t *ppos)
>  {
> -	int copied = 0;
> +	int copied;
>  	char *page;
>  	struct task_struct *task = get_proc_task(file->f_dentry->d_inode);
>  	unsigned long dst = *ppos;
> @@ -814,6 +814,7 @@
>  	if (!page)
>  		goto out;
>  
> +	copied = 0;
>  	while (count > 0) {
>  		int this_len, retval;
>  
