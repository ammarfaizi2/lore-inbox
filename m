Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291969AbSBNX2d>; Thu, 14 Feb 2002 18:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291971AbSBNX2X>; Thu, 14 Feb 2002 18:28:23 -0500
Received: from host194.steeleye.com ([216.33.1.194]:11532 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S291969AbSBNX2I>; Thu, 14 Feb 2002 18:28:08 -0500
Message-Id: <200202142324.g1ENOGs03741@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: smp_send_reschedule vs. smp_migrate_task
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Feb 2002 18:24:16 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In that post I was really asking the following questions:
> * how often does smp_send_reschedule get called? * how often does
> smp_migrate_task get called? * if smp_send_reschedule and
> smp_migrate_task were mutually exclusive,
>   i.e. both used the same spinlock, could that lead to deadlock?

> James Bottomley answered the first two for me but not the third.

I think the answer to the third is yes.

The potential deadlock is inherent in smp_migrate_task().  Any code which 
takes a spinlock on one CPU and unlocks it on another via an IPI is asking for 
a deadlock.

Here's the scenario:

CPU 1 does a smp_migrate_task() to CPU 2 at the same time CPU 2 does the same 
thing to CPU 1.  They both contend for the migration lock.  CPU 1 wins, 
acquires the migration lock and sends the IPI to CPU 2.  If CPU 2 is spinning 
on the migration lock *with interrupts disabled* then you have a deadlock (it 
can never accept the IPI and release the lock).

The way out is to make sure interrupts are always enabled when taking the 
migration lock (which is true for all the task migration code paths).  This, 
in turn imposes a condition:  the lock may never be taken from an interrupt 
(otherwise it may deadlock itself).

Since smp_send_reschedule() is called down many process wake up code paths, 
I'm not sure you can comply with the no calling from interrupt requirement if 
you make it share a lock with smp_migrate_task().

James


