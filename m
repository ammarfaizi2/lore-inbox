Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265212AbRFUUlV>; Thu, 21 Jun 2001 16:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265207AbRFUUlL>; Thu, 21 Jun 2001 16:41:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265208AbRFUUlE>; Thu, 21 Jun 2001 16:41:04 -0400
Date: Thu, 21 Jun 2001 16:40:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, D.A.Fedorov@inp.nsk.su,
        Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <3B325206.3EB44DDD@alsa-project.org>
Message-ID: <Pine.LNX.3.95.1010621161215.4263A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Abramo Bagnara wrote:

> Alan Cox wrote:
> > 
> > > (i.e. counted). An alternative to queuing (user selectable) is to block
> > > interrupt generation at hardware level in kernel space immediately
> > > before notification.
> > >
> > > I'm missing something?
> > 
> > IRQ 9 shared between user space app and disk. IRQ arrives is disabled and
> > reported, app wakes up, app wants to page in code, IRQ is disabled, box dies
> > 
> > You have to handle that in kernel space, at least enough to handle the
> > irq event, ack it and queue the data
> 
> I try to be more clear:
> 
> Kernel space:
> - irq 9 arrives from our device
> - interrupts are disabled
> - our kernel space micro handler is invoked
> - interrupt source is checked
> - if no notification is pending a signal is notificated for user space
> (or a process is marked runnable)
> - optionally our device interrupt generation is disabled
> - handler returns
> - interrupts are enabled

It just broke. The handler returned before the cause of the interrupt
was handled. Think LEVEL interrupts. The same interrupt will again
be entered, looping over and over again, until the tiny bit if CPU
resource available for the few instants the handler was not in the
ISR, was enough for the user-mode signal-handler to shut the
damn thing off, pull the plug, and figure this will never work.

> 
> User space:
> - signal arrive (or process is restarted)
> - action is done
> - notification is acknowledged (using an ioctl)
> 

Way too late see above.


> Kernel space:
> - if we have other notifications to do, do one
> - optionally our device interrupt generation is reenabled
> 
> -- 

Over and over again, I find more and more persons who haven't
a clue about what an interrupt is and how it relates to the
rest of the system. The start of this debacle occurred when
CPUs became fast enough so sloppy 'C'-coders were able to
make so-called interrupt handlers that kind of worked. Then
others, looking at the code, said; "Oh! This is just ordinary
'C' code. Good, I can do this stuff too....". Ultimately we
will have so-called Software Engineers reading and writing
files in interrupt service routines.

There is no such thing as a "user mode" interrupt service routine.
There never was one, and there will never be one on any machine
that fetches instructions from memory for execution. Remember
the Dr. Dobbs articles about "Interrupt THUNKS", you could
use in real-mode interrupt service routines? No need to answer.
They never worked, and they could never work. Remember "Call-backs"
from interrupt service routines? They never worked either. These
are all creations of coders, not Engineers, not even Technicians,
coders who learned how to use a tool (a compiler), who came up
with these "brilliant" ideas! Just because somebody published an
article, doesn't mean that anything written therein was correct.

FYI. The purpose of an interrupt service routine is to handle
the immediate needs of the hardware. That's all!  There is
nothing "immediate" in user-mode.

In a virtual memory system, the user's handler probably isn't
even in memory at the time an interrupt arrives. And, it can't
be paged into memory because the interrupt was for Disk I/O.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


