Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbSJ1IUA>; Mon, 28 Oct 2002 03:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSJ1IUA>; Mon, 28 Oct 2002 03:20:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40502 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263193AbSJ1ITw>; Mon, 28 Oct 2002 03:19:52 -0500
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<3DBCEB2E.BC3956FD@daimi.au.dk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Oct 2002 01:24:02 -0700
In-Reply-To: <3DBCEB2E.BC3956FD@daimi.au.dk>
Message-ID: <m1hef7j7j1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> writes:

> "Eric W. Biederman" wrote:
> > 
> > +static void i8259A_remove(struct device *dev)
> > +{
> > +       /* Restore the i8259A to it's legacy dos setup.
> > +        * The kernel won't be using it any more, and it
> > +        * just might make reboots, and kexec type applications
> > +        * more stable.
> > +        */
> > +       outb(0xff, 0x21);       /* mask all of 8259A-1 */
> > +       outb(0xff, 0xA1);       /* mask all of 8259A-1 */
> > +
> > +       outb_p(0x11, 0x20);     /* ICW1: select 8259A-1 init */
> > +       outb_p(0x08, 0x21);     /* ICW2: 8259A-1 IR0-7 mappend to 0x8-0xf */
> > +       outb_p(0x01, 0x21);     /* Normal 8086 auto EOI mode */
> > +
> > +       outb_p(0x11, 0xA0);     /* ICW1: select 8259A-2 init */
> > + outb_p(0x08, 0xA1); /* ICW2: 8259A-2 IR0-7 mappend to 0x70-0x77 */
> 
>                  ^^^^                                               ^^^^
> 
> This looks wrong to me.

Thanks that was a clear cut and paste bug.  

I am in the process of moving the i8259A setup code into my kexec user
space program.  I believe it is inappropriate to assume the interrupt
controller is going to be used by dos when it is shut down.  So my
latest version (just published) simply masks all interrupts through
the pic. 

The pic setup code I am in the process of moving into kexec-tools, and
since the pic is well know I will do this piece of setup work
there.

Another bug worth noting in this code, is that as of 2.5.44 only the
->shutdown methods are called on reboot and not the ->remove methods
so I actually hooked the wrong routine.  Just in case someone else is
trying to hook that moving target.

Eric
