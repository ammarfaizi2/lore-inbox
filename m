Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318406AbSHGQKF>; Wed, 7 Aug 2002 12:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSHGQKE>; Wed, 7 Aug 2002 12:10:04 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:42184 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id <S318406AbSHGQKC>; Wed, 7 Aug 2002 12:10:02 -0400
From: "Kathy Frazier" <kfrazier@daetwyler.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Interrupt trouble due to IRQ router VIA?
Date: Wed, 7 Aug 2002 12:16:35 -0400
Message-ID: <000701c23e2d$cdafdbe0$7ac809bf@mdcdayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <1028162093.13008.24.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your response.  I have tried other methods for sleeping to avoid
the race condition you are speaking of, but have not had any luck.  At this
point, I am using the wait_event_interruptible, but this routine never
returns - I must Cntrl C to stop my test program.  So now, the driver looks
something like this:

In routine called from ioctl:

/* a global, declared static int */
RcvIntr = 0;

/* cause H/W to interrupt */
writel(Data, HardwareAddress);
wait_event_interruptible(RcvIntrrcvQ, RcvIntr);


In ISR:

if (USER_INTERRUPTING(pslState)
   {
    ResetReceiverInterrupt(pslState); /* clear the board's interrupt */
    RcvIntr = 1;
    wake_up_interruptible(&RcvIntrrcvQ);
   }


Since I never get into my ISR, I added some [nasty] kernel hacks in
/arch/i386/kernel/irq.c to see if the O/S ever hears of the interrupt.  In a
nutshell:

Global (after the #includes):
static unsigned myIRQ = 0;

In request_irq:

   if (!action)
      return = -ENOMEM;

+  if (strcmp(devname,"pslengrave") == 0)
+     {
+     myIRQ = irq;
+     printk(KERN_INFO "KJF: monitor pslengrave IRQ\n");
+     }

   action->handler = handler;

In do_IRQ:

   kstat.irqs[cpu][irq]++;

+  if ((myIRQ !=0) && (irq == myIRQ)) printk (KERN_INFO "KJF: Get spin lock
for IRQ %d\n", irq);
   spin_lock(&desc->lock);

+  if ((myIRQ != 0) && (irq == myIRQ)) printk (KERN_INFO "KJF: Calling ack
handler for IRQ %d\n", irq);

   desc->handler ->ack(irq);

Told you it was nasty!  Note that my driver requests the IRQ (as specified
in the pci_dev structure) as sharable.  However,in the current
configuration, no other device is using this IRQ. The request_irq routine
completes successfully and displays my message, but no sign of myIRQ in the
do_IRQ routine.

I appreciate any advice on how to solve this.  I am also open to doing any
testing that may be necessary to determine why the OS never hears of the
interrupt.  Once our logic analyzer is freed up, I can verify that the board
is interrupting . . . although we have been that route before when I was
testing in my original developement system.  The device was interrupting
fine . . .

Thanks in advance for your help!

Kathy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Wednesday, July 31, 2002 8:35 PM
To: Kathy Frazier
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupt trouble due to IRQ router VIA?


On Wed, 2002-07-31 at 21:15, Kathy Frazier wrote:
> another system.  In this system, the driver times out on the
> interruptible_sleep_on_timeout waiting for the interrupt.  One thing that
I

There is a classic kernel programming error which goes something like
this


my_interrupt()
{
	foo->ready = 1;
	wake_up(&foo_pending);
}


foo_read()
{
	while(!foo->ready && !signal_pending(current))
		interruptible_sleep_on(&foo_pending);

}

What happens then is this

	foo->ready = 0 - true
	signal pending = 0 - ok

		INTERRUPT
			foo->ready=1
			wake up
		END INTERRUPT

	interruptible_sleep_on(&foo_pending);


Waits forever


It could be your timings have changed so such a bug now shows up

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

