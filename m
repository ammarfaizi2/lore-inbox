Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWJLTa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWJLTa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWJLTa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:30:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55454 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750838AbWJLTa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:30:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Chandru <chandru@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC]: Possible race condition on an SMP between proc_lookupfd and tasks on other cpus
References: <452CB67A.4070702@in.ibm.com>
Date: Thu, 12 Oct 2006 13:29:10 -0600
In-Reply-To: <452CB67A.4070702@in.ibm.com> (chandru@in.ibm.com's message of
	"Wed, 11 Oct 2006 14:46:42 +0530")
Message-ID: <m1hcy9ib95.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandru <chandru@in.ibm.com> writes:

> Hi All,
> I am running a RHEL5  distro kernel ( which seems to be quite close to Vannilla
> kernel ) and am having a problem on one of my system (PPC64).    The system
> crashes ( goes in to xmon ) every now and then while running TCP stress tests on
> the system.   The following is the backtrace and exception information ( from
> distro kernel, which might be of very little help).
>
> f:mon> e
> cpu 0xf: Vector: 300 (Data Access) at [c0000000eaa1b490]
>    pc: c0000000001351e0: .tid_fd_revalidate+0x64/0x220
>    lr: c0000000001351cc: .tid_fd_revalidate+0x50/0x220
>    sp: c0000000eaa1b710
>   msr: 8000000000009032
>   dar: 6b6b6b6b6b6b6b6b
> dsisr: 40000000
>  current = 0xc0000001182864f0
>  paca    = 0xc000000000456300
>    pid   = 24558, comm = netstat
> f:mon> t
> [c0000000eaa1b7b0] c000000000138118 .proc_lookupfd+0x17c/0x21c
> [c0000000eaa1b860] c0000000000f359c .do_lookup+0x108/0x268
> [c0000000eaa1b920] c0000000000f65f8 .__link_path_walk+0xc58/0x1364
> [c0000000eaa1ba00] c0000000000f6da0 .link_path_walk+0x9c/0x184
> [c0000000eaa1bb40] c0000000000f7364 .do_path_lookup+0x304/0x398
> [c0000000eaa1bbf0] c0000000000f7db8 .__user_walk_fd+0x58/0x88
> [c0000000eaa1bc90] c0000000000edcdc .sys_readlinkat+0x44/0x130
> [c0000000eaa1bdc0] c000000000016784 .compat_sys_readlink+0x14/0x28
> [c0000000eaa1be30] c00000000000871c syscall_exit+0x0/0x40
>
>
> From code analysis ( vannilla and distro kernel), it looks like there can exist
> a small time window between
>
> spin_unlock(&files->file_lock) in proc_fd_instantiate()
>
> and fcheck_files() in tid_fd_revalidate()   during which the contents of
> 'struct files_struct files' of a task could be released/cleared by that task (
> during an exec probably ).


> Could this code analysis be right? and can this race condition be fixed?.

The window you see exists, but it is there by design.

tid_fd_revalidate is designed to be called any time after prod_fd_instantiate()
runs.  So it requires all of the locks it needs.  It's purpose in life
is to verify the permissions.

We have earlier increased the reference count of everything when we grabbed
the dentry.

The final tid_fd_revalidate in proc_fd_instantiate was added recently
to ensure we have a consistent set of checks before returning a dentry
to a user. 

So I think you have a legitimate problem but it isn't because we drop
and reaquire the locks.

There was a little recent work making some of the fdtable access
no-rcu.   See commit ca99c1da080345e227cfb083c330a184d42e27f3.  But
I don't think that applies here.

You certain seem to be in one of the proc stress conditions so this
may not be a unique bug.

Digging through the disassembly and figuring out which access you died
on would be interesting, so we could know with precision which part
of tid_fd_revalidate we are dying in.  My ppc64 isn't good enough 
especially without the matching binaries to figure that out though.
All I know is that you are about 25 instructions into
tid_fd_revalidate.

I don't have a clue where to start to dig into this.

Eric
