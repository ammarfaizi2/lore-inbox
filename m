Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTKIUEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 15:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTKIUEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 15:04:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21779 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262770AbTKIUEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 15:04:33 -0500
Date: Sun, 9 Nov 2003 20:04:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: crashme on ARM - unkillable processes
Message-ID: <20031109200430.A2278@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20031109114322.A29553@flint.arm.linux.org.uk> <Pine.LNX.4.44.0311090927350.1648-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0311090927350.1648-100000@home.osdl.org>; from torvalds@osdl.org on Sun, Nov 09, 2003 at 09:43:27AM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 09:43:27AM -0800, Linus Torvalds wrote:
> 
> On Sun, 9 Nov 2003, Russell King wrote:
> > 
> > Looking at next_signal(), the kernel treats signals 1-8 as having higher
> > priority than signal 9.  Since we only ever dequeue one signal on return
> > to user space, we always find the SIGILL before SIGKILL, and the kill
> > signal remains indefinitely queued.
> 
> Interesting. I wonder why it shows up only now. We've run crashme as a 
> sanity-test before, and I don't think this is a new thing..

Ok, I've been doing a bit more digging to work out what's going on.

The code which crashme generated corrupted the user stack pointer.  We
then tried to deliver a signal, found the user stack pointer invalid,
and tried to deliver a SEGV to the process via force_sig().  Unfortunately,
this signal never made it through for the reasons described previously.
(We dequeued the ILL, found we couldn't setup the stack frame, force_sig,
returned to userspace, generated another undefined instruction exception
on the same instruction, etc.)

So, not only is userspace not able to kill off processes with SIGKILL,
but the system can't kill off a process with a seriously corrupt stack.

Should the signal code be using something more forceful than force_sig()
(ie, something which is guaranteed to work) when the stack is corrupted ?

> This is definitely a bug. I'd be inclined to just special-case SIGKILL in 
> next_signal(). Better ideas?

>From the above, I think the problem is a little larger than just SIGKILL.

I think this problem happens on ARM because when we return to user space
after being unable to deliver a signal, we try to re-execute the illegal
instruction.  I believe on x86 this does not occur - it returns to the
next instruction.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
