Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUDOKmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUDOKmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:42:25 -0400
Received: from ns.suse.de ([195.135.220.2]:5842 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261865AbUDOKmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:42:20 -0400
Date: Thu, 15 Apr 2004 12:39:15 +0200
From: Andi Kleen <ak@suse.de>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mbligh@aracnet.com
Subject: Re: NUMA API for Linux
Message-Id: <20040415123915.016523df.ak@suse.de>
In-Reply-To: <1081989517.1206.206.camel@arrakis>
References: <1081373058.9061.16.camel@arrakis>
	<20040407232712.2595ac16.ak@suse.de>
	<1081989517.1206.206.camel@arrakis>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 17:38:37 -0700
Matthew Dobson <colpatch@us.ibm.com> wrote:



> 1) Redefine the value of some of the MPOL_* flags

I don't want to merge the flags the and the mode argument. It's ugly.

> 2) Rename check_* to mpol_check_*

I really don't understand why you insist on renaming all my functions? 
I like the current naming, thank you.

> 3) Remove get_nodes().  This should be done in the same manner as
> sys_sched_setaffinity().  We shouldn't care about unused high bits.

I disagree on that. This would break programs that are first tested
on a small machine and then later run on a big machine (common case)

> 4) Create mpol_check_flags() to, well, check the flags.  As the number
> of flags and modes grows, it will be easier to do this check in its own
> function.
> 5) In the syscalls (sys_mbind() & sys_set_mempolicy()), change 'len' to
> a size_t, add __user to the declaration of 'nmask', change 'maxnode' to

unsigned long is the standard for system calls.  Check some others. 

> 'nmask_len', and condense 'flags' and 'mode' into 'flags'.  The
> motivation here is to make this syscall similar to
> sys_sched_setaffinity().  These calls are basically the memory
> equivalent of set/getaffinity, and should look & behave that way.  Also,
> dropping an argument leaves an opening for a pid argument, which I
> believe would be good.  We should allow processes (with appropriate
> permissions, of course) to mbind other processes.

Messing with other process' VM is a recipe for disaster. There 
used to be tons of exploitable races in /proc/pid/mem, I don't want to repeat that.
Adding pid to set_mem_policy would be a bit easier, but it would require
to add a lock to the task struct for this. Currently it is nice and lockless
because it relies on the fact that only the current process can change 
its own policy. I prefer to keep it lockless, because that keeps the memory 
allocation fast paths faster.

> 6) Change how end is calculated as follows:
> 	end = PAGE_ALIGN(start+len);
> 	start &= PAGE_MASK;
> Basically, this allows users to pass in a non-page aligned 'start', and
> makes sure we mbind all pages from the page containing 'start' to the
> page containing 'start'+'len'.

mprotect() does the EINVAL check on unalignment. I think it's better
to follow mprotect here.

-Andi
