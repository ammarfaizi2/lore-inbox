Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVGEO1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVGEO1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 10:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVGEO1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 10:27:05 -0400
Received: from nevyn.them.org ([66.93.172.17]:7903 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261871AbVGEOHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 10:07:30 -0400
Date: Tue, 5 Jul 2005 10:07:24 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: ptrace ia32 BP fix
Message-ID: <20050705140724.GA19552@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200507050931.j659VFEa028271@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507050931.j659VFEa028271@magilla.sf.frob.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 02:31:15AM -0700, Roland McGrath wrote:
> 
> When the 32-bit vDSO is used to make a system call, the %ebp register for
> the 6th syscall arg has to be loaded from the user stack (where it's pushed
> by the vDSO user code).  The native i386 kernel always does this before
> stopping for syscall tracing, so %ebp can be seen and modified via ptrace
> to access the 6th syscall argument.  The x86-64 kernel fails to do this,
> presenting the stack address to ptrace instead.  This makes the %rbp value
> seen by 64-bit ptrace of a 32-bit process, and the %ebp value seen by a
> 32-bit caller of ptrace, both differ from the native i386 behavior.
> 
> This patch fixes the problem by putting the word loaded from the user stack
> into %rbp before calling syscall_trace_enter, and reloading the 6th syscall
> argument from there afterwards (so ptrace can change it).  This makes the
> behavior match that of i386 kernels.

Wouldn't this  to botch a debugger which supported both backtracing and
PTRACE_SYSCALL, when stopped in a syscall?  We have unwind information
for the VDSO and it's not going to tell us that the kernel has done
something clever to the value of %ebp.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
