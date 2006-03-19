Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWCSTCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWCSTCr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 14:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWCSTCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 14:02:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751315AbWCSTCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 14:02:47 -0500
Date: Sun, 19 Mar 2006 11:02:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2006, Linus Torvalds wrote:
> 
> Actually, looking at it a bit more, I think we can do better even 
> _without_ fixing the "calling convention".

Here's the "before and after" example of nr_context_switches() from 
kernel/sched.c with this patch on x86-64 (selected because the whole 
function is just basically one simple "loop over all possible CPU's and 
return the sum of context switches").

I'll do the "after" first, because it's actually readable:

	nr_context_switches:
	        pushq   %rbp
	        xorl    %esi, %esi
	        xorl    %ecx, %ecx
	        movq    %rsp, %rbp
	.L210:
	#APP
	        btl %ecx,cpu_possible_map(%rip)
	        sbbl %eax,%eax
	#NO_APP
	        testl   %eax, %eax
	        je      .L211
	        movq    _cpu_pda(,%rcx,8), %rdx
	        movq    $per_cpu__runqueues, %rax
	        addq    8(%rdx), %rax
	        addq    40(%rax), %rsi
	.L211:
	        incq    %rcx
	        cmpq    $8, %rcx
	        jne     .L210
	        leave
	        movq    %rsi, %rax
	        ret

ie the loop starts at .L210, end basically iterates %rcx from 0..7, and 
you can read the assembly and it actually makes sense.

(Whether it _works_ is another matter: I haven't actually booted the 
patched kernel ;)

Compare that to the "before" state:

	nr_context_switches:
	        pushq   %rbp
	        movl    $8, %eax
	        movq    cpu_possible_map(%rip), %rdi
	#APP
	        bsfq %rdi,%rdx ; cmovz %rax,%rdx
	#NO_APP
	        cmpl    $9, %edx
	        movq    %rdx, %rax
	        movl    $8, %edx
	        cmovge  %edx, %eax
	        movq    %rsp, %rbp
	        pushq   %rbx
	        movslq  %eax,%rcx
	        xorl    %r8d, %r8d
	        jmp     .L261
	.L262:
	        movq    _cpu_pda(,%rcx,8), %rdx
	        movl    $8, %esi
	        movq    $per_cpu__runqueues, %rax
	        movq    %rdi, %rbx
	        movq    8(%rdx), %rdx
	        addq    40(%rax,%rdx), %r8
	        movl    %ecx, %edx
	        movl    %esi, %eax
	        leal    1(%rdx), %ecx
	        subl    %edx, %eax
	        decl    %eax
	        shrq    %cl, %rbx
	        cltq
	        movq    %rbx, %rcx
	#APP
	        bsfq %rcx,%rbx ; cmovz %rax,%rbx
	#NO_APP
	        leal    1(%rdx,%rbx), %edx
	        cmpl    $9, %edx
	        cmovge  %esi, %edx
	        movslq  %edx,%rcx
	.L261:
	        cmpq    $7, %rcx
	        jbe     .L262
	        popq    %rbx
	        leave
	        movq    %r8, %rax
	        ret

which is not only obviously bigger (40 instructions vs just 18), I also 
dare anybody to actually read and understand the assembly.

Now, the simple version will iterate 8 times over the loop, while the more 
complex version will iterate just as many times as there are CPU's in the 
actual system. So there's a trade-off. The "load the CPU mask first and 
then shift it down by one every time" thing (that required different 
syntax) would have been able to exit early. This one isn't. So the syntax 
change would still help a lot (and would avoid the "btl").

Of course, if people were to set CONFIG_NR_CPUS appropriately for their 
system, the shorter version gets increasingly better (since it then won't 
do any unnecessary work).

			Linus
