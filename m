Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265179AbSJPQef>; Wed, 16 Oct 2002 12:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSJPQef>; Wed, 16 Oct 2002 12:34:35 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:61149 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S265179AbSJPQe2>; Wed, 16 Oct 2002 12:34:28 -0400
Date: Wed, 16 Oct 2002 11:41:22 -0500
From: Patrick Jennings <jennings@red-river.com>
Subject: Userland ISRs
To: LKML <linux-kernel@vger.kernel.org>
Message-id: <NFBBJBMDCLFFHHFEAKNAMEDJCCAA.jennings@red-river.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All:

I am writing a device driver for a pci card.  We have to have "userland
isrs" in that we need to allow the top level user to run a thread that
responds to differnent isr bits n our card (a digital transever)

The approch i have been using is to create an ioctl that sleeps on interupt,
then waked up and notifies the user land program when and isr is triggired.

So the ioctl part:

	//Enable interupt
			*(redriver_device_data.bar0ptr+0x584/4) = intr_wait.interrupt;

			if(intr_wait.timeout != 0)
			{
				*(redriver_device_data.bar0ptr+0x584/4) = intr_wait.interrupt;
				timeout = interruptible_sleep_on_timeout(&waiter->wq, intr_wait.timeout
* HZ / 1000);

				if(timeout == 0)
				{
					intr_wait.result = RRENG_WAIT_TIMEOUT;
					printk("<1> ISR Timeout\n");
				}
				else
				{
					intr_wait.result = RRENG_WAIT_SUCCESS | waiter->status;
					printk("Timed ISR OK\n");
				}
			}
			else
			{
				interruptible_sleep_on(&waiter->wq);
				intr_wait.result = RRENG_WAIT_SUCCESS | waiter->status;
				printk("<1>Untimed ISR ok\n");
			}

and the isr part

for(i=0; i<RRENG_MAX_INTR_WAITERS; i++)
		{
			waiter = card->waiters[i];
			printk("<1>Comparing %x and %x on waiter %d\n", statusisr, waiter.mask,
i);
			printk("<1>Flagval is %d\n", waiter.flagval);
			if(waiter.mask & statusisr)
			{
				*(card->bar0ptr+enableregadr/4) = 0x0;  //Diable;
				printk("<1>Waking up waiter %d with mask 0x%x\n",i , waiter.mask);

				wake_up = (waiter.status) ? FALSE : TRUE;
				waiter.status |= status;

				if(wake_up)
					wake_up_interruptible(&waiter.wq);
			}
		}


This all works well and good, execpt when the isr bit is already true when
isrs are enabled.  Then as soon as they are enabled the isr routine gets
called, before the sleep has got a chance to get set up.  Any ideas around
this?

/patrick

+========================================================+
Patrick Jennings       | jennings@red-river.com
Red River              | Direct Phone   (972) 671-9636
Radio Products Group   | Main Phone     (972) 671-9570
797 North Grove Road   | Fax            (972) 671-9572
Suite 101              | www.red-river.com
Richardson,TX  75081   |

