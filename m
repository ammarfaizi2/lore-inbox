Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264208AbUEDFnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbUEDFnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 01:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbUEDFnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 01:43:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51455 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264208AbUEDFnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 01:43:03 -0400
Date: Tue, 4 May 2004 11:16:27 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       anton@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH][PPC64] Fix incorrect signal handler argument
Message-ID: <20040504054627.GB2900@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <16532.18958.658706.900954@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16532.18958.658706.900954@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 11:08:30AM +1000, Paul Mackerras wrote:
> Andrew & Linus,
> 
> This patch fixes a bug in the ppc64 signal delivery code where the
> signal number argument to a signal handler can get corrupted before
> the handler is called.  The specific scenario is that a process is in
> a blocking system call when two signals get generated for it, both of
> which have handlers.
> 
> The signal code will stack up two signal frames on the process stack
> (assuming the mask for the first signal delivered doesn't block the
> second signal) and return to userspace to run the handler for the
> second signal.  On return from that handler the first handler gets run
> with an incorrect signal number argument because we end up with
> regs->result still having a negative value (left over from when the
> system call was interrupted) when it should be zero.  This patch sets
> it to zero when we set up the signal frame (in three places; for
> 64-bit processes, and for 32-bit processes for RT and non-RT signals).
> 
> The way we handle signal delivery and signal handler return using the
> regs->result field in ppc64 is more complicated than it needs to be.
> In ppc32 I have already simplified it and eliminated use of the
> regs->result field.  I am going to do the same in the ppc64 code, but
> I think this patch should go in for now to fix the bug.
> 
> The patch also fixes a couple of places where we were unnecessarily
> and incorrectly truncating the regs->result value to 32 bits
> (sys32_sigreturn and sys32_rt_sigreturn return a long value, as all
> syscalls do, and if regs->result is negative we need those syscalls to
> return a negative value).
> 
> Thanks to Maneesh Soni for identifying the specific circumstances
> under which this bug shows up.
> 
> Please apply.
> 

I verified the fix. The testcase passes this time. The testcase
is T.abort from LSB (lsb-runtime-test-2.0.2-1) for scenarios 8 & 9.

Regards,
Maneesh

--

Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
