Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272199AbRIEMjP>; Wed, 5 Sep 2001 08:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272151AbRIEMi4>; Wed, 5 Sep 2001 08:38:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:37248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272137AbRIEMix> convert rfc822-to-8bit; Wed, 5 Sep 2001 08:38:53 -0400
Date: Wed, 5 Sep 2001 08:39:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?Q?=22Hammond=2C_Jean-Fran=E7ois=22?= 
	<Jean-Francois.Hammond@mindready.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Scheduling in interrup
In-Reply-To: <F50B5436A4CED31190DA000629386F010168AB67@CHOPIN>
Message-ID: <Pine.LNX.3.95.1010905081115.9922A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, [iso-8859-1] "Hammond, Jean-François" wrote:

> Hi,
> 
> >o	Are you attempting to access paged RAM?
> 
> I am using kmalloc to reserve my memory.
> kmalloc as the options GFP_KERNEL and GFP_DMA.
> I am not using any command to reserve memory in
> the interrupt handler.
> 

This is okay. These will not be paged.

> >o	Are you accessing anything that sleeps?
> 
> Not in the interrupt handler.
> 
> >o	Are you enabling interrupts without protecting against
> 	re-entry first?
> 
> I am not sure what do you mean, but I am attaching the interrupt
> handler with the function request_irq with the option SA_INTERRUPT &
> SA_SHIRQ.
> Does the kernel prevent re-entry of the interrupt handler ?
> 

The kernel keeps the interrupts OFF when executing your interrupt
handler. However, if your handler turns the interrupts back on
you can get re-entered. The easiest way to prevent this is:

static spinlock_t my_lock = SPINLOCK_UNLOCKED;

static void some_isr(int irq, void *p, struct pt_regs, *ignored)
{
     SOME_LOCAL_ALLOCATIONS;
     spin_lock(&my_lock);

     CODE_THAT_LOOPS_WITH_INTERRUPTS_ENABLED;

     spin_unlock(&my_lock);
}

You don't need spin_lock_irqsave/restore because we already know how
the flags will be handled.


[SNIPPED schedule...]
When the kernel is in an interrupt handler (any handler), it sets
a flag. If the scheduler operates and sees this flag true, it means
that somehow, the scheduler got control from an interrupt handler,
which it must not. It can't "get back" if this happens because
the original process that got interrupted will have its context lost.

>From within an interrupt handler, the ONLY kernel service that does I/O
that you can use is printk(). Any other I/O services schedule while
waiting for I/O to complete. Of course your ISR can call
wake_up_interruptible() and timer-queue routines. That's what they
are for.

When compiling your module, make sure that some 'C' runtime library
routine didn't slip in. Truly amazing things can happen if the
shared library needs to be paged in from the kernel. I use this
in a project directory:

#
#	Common rules for all the source-files.
#
SLIB= libplatinum.so
SLINK= /lib/$(SLIB)
MFLAGS = -r
VRS = $(VERS_MAJOR).$(VERS_MINOR)
INC = $(TOPDIR)/common
LIB = $(TOPDIR)/lib
TST = $(TOPDIR)/tests
WARNINGS = -Werror -Wall -Wstrict-prototypes -Wwrite-strings -Wshadow -Wsign-compare
INCLUDES = -I. -I$(INC) -I/usr/src/linux-$(VER)/include
OPTIONS = -fno-builtin -pipe -O2 -fomit-frame-pointer
DEFINES = -DVRS=\"$(VRS)\"
CFLAGS += $(DEFINES) $(OPTIONS) $(WARNINGS) $(INCLUDES)
CC= $(GCC) $(CFLAGS)

... for common rules, plus add -D__KERNEL__ -DMODULE in lower-level
Makefiles.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


