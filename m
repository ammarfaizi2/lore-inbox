Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWEBG57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWEBG57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWEBG56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:57:58 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:55148 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932417AbWEBG55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:57:57 -0400
Date: Tue, 2 May 2006 08:57:55 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060502065755.GB9482@osiris.boeblingen.de.ibm.com>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it> <20060426154607.GA8628@ccure.user-mode-linux.org> <200604282228.46681.blaisorblade@yahoo.it> <20060429084907.GD9463@osiris.boeblingen.de.ibm.com> <20060501170233.GC4592@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501170233.GC4592@ccure.user-mode-linux.org>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This sounds more complicated than what we are proposing.  
> 
> This would make the process care about the number of system calls
> implemented by the kernel, which is something that doesn't even come
> up in the normal case with the current interface.  You only care about
> it if you get a -EINVAL and want to figure out exactly why.
> 
> From a practical point of view, you would want code that looks like
> this:

Yes.

[1]
> 	n = nsyscalls();
> 	mask = malloc((n + 7)/8);
> 	if(mask == NULL)
> 		return;
> 
> 	/* Zero mask, set bits, call ptrace */
> 
> 	free(mask);
> 

[2]
> rather than code like this:
> 
> 	int mask[(BIGGEST_SYSCALL_I_CARE_ABOUT + 7) / 8];
> 
> 	/* Zero mask, set bits, call ptrace */


> That doesn't seem like an improvement to me.
> 
> The second case would be more complicated if it wanted to figure out
> what the problem was if ptrace returned -EINVAL.  However, some users

That is actually my point. If you're checking for errors you will end up
first doing [2] and later on doing something like [1] anyway...

> > In addition your proposal would already introduce a rather complicated
> > interface to figure out how many syscalls the kernel has. I'm sure this
> > will be (mis)used sooner or later.
> 
> How?  And, if so, why is that a problem?

>From the proposal:

<snip>
> Semantics:
>
> in both cases, the mask is first zero-extended to the right (for syscalls not
> known to userspace), bits for syscall not known to the kernel are checked and
> the call fails if any of them is 1, and in the failure case E2BIG or
> EOVERFLOW is returned (I want to avoid EINVAL and ENOSYS to avoid confusion)
> and the part of the mask known to the kernel is 0-ed.
<snip>

So you just need to pass a large enough bitmask with all ones and the kernel
will put zeroes in the bitmask up to the bit number NR_sycalls - 1.
Counting the zeroes should work...
