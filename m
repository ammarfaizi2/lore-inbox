Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753513AbWKLXyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbWKLXyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbWKLXyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 18:54:18 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:26127 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1753513AbWKLXyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 18:54:17 -0500
Date: Sun, 12 Nov 2006 23:54:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mikael Pettersson <mikpe@it.uu.se>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061112235410.GB31624@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Mikael Pettersson <mikpe@it.uu.se>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200611122047.kACKl8KP004895@harpo.it.uu.se> <20061112212941.GA31624@flint.arm.linux.org.uk> <20061112220318.GA3387@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112220318.GA3387@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 11:03:18PM +0100, Ingo Molnar wrote:
> 
> * Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > In which case isn't the real regression that it does IO?
> > 
> > Nevertheless, I give you two options:
> > 
> > 1. Abort all IO do inserted floppy disk after resume.
> > 2. Corrupt replaced floppy disk after resume.
> > 
> > You have to pick one and exactly one.  Which is inherently less risky 
> > to the end user?
> 
> this isnt about in-flight IO (suspend doesnt succeed if IO is in flight 
> anyway).

I wasn't talking about in-flight IO.  Take a moment to think about it.

- You have a floppy inserted and mounted.
- You write a file to it, and then suspend the machine.
  *** No IO was in progress when the suspend occurred.
- You remove the floppy disk and insert a different disk
- You resume
- The kernel submits the dirty buffers for writing out to the disk.

That would lead to a corrupted floppy disk.

> The bug is this:
> 
>   1) you use the floppy and then stop using it
>   2) 1 hour passes. Nothing uses the floppy.
>   3) you suspend and later resume
>   4) another hour passes. Nothing uses the floppy.
>   5) you try to use the floppy: you get a bunch of IO errors!
>   6) you try to use the floppy again: this time it works
> 
> that's the regression. For some reason suspend/resume puts the floppy 
> hardware into a state that confuses the floppy driver.
> 
> my patch adds all the right suspend/resume hooks for this, without 
> reintroducing the bug that was noticed by lockdep and which was fixed by 
> my patch that introduced this regression - we just have to figure out 
> what to do upon resume to get the floppy driver and the hardware match 
> up each other, without passing spurious IO errors to the user.

You need to step the head off track 0 and back again.  That clears the
disk changed status on the floppy drive hardware.

Now, if you'd actually taken the time to read my messages you'd have
realised that the floppy drive hardware defaults to reporting a
"disk changed" status after power on.  Ergo, after resume, it says
"disk changed" as well.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
