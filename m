Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131327AbRCHLew>; Thu, 8 Mar 2001 06:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131333AbRCHLem>; Thu, 8 Mar 2001 06:34:42 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:742 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131330AbRCHLec>; Thu, 8 Mar 2001 06:34:32 -0500
Message-ID: <3AA76E46.71B99B7C@uow.edu.au>
Date: Thu, 08 Mar 2001 22:34:30 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: spinlock help
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2715F@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" wrote:
> 
> OK guys, you were right. The bug was in our code - sorry for trouble.
> Turns out that while I was away, the problem was solved by someone else. The
> problem is probably related to the fact that when we did
> 'spin_lock_irqsave(c,d)', 'd' was a global variable. The fix was to wrap the
> call with another function and declare 'd' as local. I can't quite explain,
> but I think that changing from a static to automatic variable made the
> difference. My best guess is that since 'd' is passed by value and not by
> reference, the macro expansion of spin_lock_irqsave() relies on the location
> of 'd' in the stack and if 'd' was on the heap instead, it might get
> trashed.
> 

Yes, that makes sense.

spin_lock_irqsave() really means "save the current irq mask
on the stack, then disable interrupts". spin_lock_irqrestore()
says "restore the current interrupt mask from the stack".  So they
nest, and spin_lock_irqsave() doesn't have to care whether or
not interrupts are currently enabled.

Using a global variable you could get something like:

CPU0:                                     CPU1
         
__cli();                                  
spin_lock_irqsave(lock, global)
                                          __sti();
                                          spin_lock_irqsave(lock2, global)
                                          spin_lock_irqrestore(lock2, global)
spin_unlock_irqrestore(lock, global)
/* interrupts should be disabled */

Here, CPU1 will set `global' to "interrupts enabled".  So when
CPU0 restores its flags from `global' it will be picking up
CPU1's flags, not its own!

There are probably less subtle failure modes than this..

-
