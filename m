Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbRE1XNt>; Mon, 28 May 2001 19:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbRE1XNj>; Mon, 28 May 2001 19:13:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37897 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261616AbRE1XNd>;
	Mon, 28 May 2001 19:13:33 -0400
Date: Tue, 29 May 2001 00:12:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Vadim Lebedev <vlebedev@aplio.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel
Message-ID: <20010529001256.F9203@flint.arm.linux.org.uk>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP>; from vlebedev@aplio.fr on Mon, May 28, 2001 at 11:43:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 11:43:38PM +0200, Vadim Lebedev wrote:
> Please correct me if i'm wrong but it seems to me that i've stumbled on
> really BIG security hole in the signal handling code.

I don't think there's problem, unless I'm missing something.

> The problem IMO is that the signal handling code stores a processor context
> on the user-mode stack frame which is active while
> the signal handler is running.

User context (defined by 'regs') is stored onto the user stack.
However, when context is restored, certain checks are done, including
making sure that the segment registers cs and ss are their user mode
versions (or'd with 3), and the processor flags are non-privileged.

This means that when the kernel does eventually return to user space,
if the user has pointed the EIP address at panic(), by the time we
jump there the processor will not be in a privileged mode, and panic()
won't do anything (you'll probably end up with a page fault caused by
the processor fetching instructions from kernel space).

However, that said, I don't know x86 in depth (I'm the ARM guy), so
don't take this as gospel, but should be sufficient to point you in
the right direction.  (check the segment registers, check the eflags
register, hell, try it out for real and see what happens)!

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

