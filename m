Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287840AbSBMQ7j>; Wed, 13 Feb 2002 11:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287841AbSBMQ7Y>; Wed, 13 Feb 2002 11:59:24 -0500
Received: from host194.steeleye.com ([216.33.1.194]:18704 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S287840AbSBMQ7P>; Wed, 13 Feb 2002 11:59:15 -0500
Message-Id: <200202131659.g1DGx7Y02165@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re:smp_send_reschedule vs. smp_migrate_task
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Feb 2002 11:59:07 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am looking at the updates for PPC that are needed because of the
> changes to the scheduler in 2.5.x.  I need to implement
> smp_migrate_task(), but I do not have another IPI easily available;
> the Open PIC interrupt controller used in a lot of SMP PPC machines
> supports 4 IPIs in hardware and we are already using all of them.

I have this problem with the older voyager architectures that effectively have 
only one IPI.  I solved it by using a per-cpu area mailbox for IPIs (to send 
an IPI, set the bit in the per CPU area for all CPUs you want to send it to 
and then send of the global IPI.  Each receiving CPU clears the bit in their 
area before they begin processing the particular IPI).  It's not very 
efficient through (especially with cache transfers from sender to recipient), 
so using what you have is probably better.

> Thus I was thinking of using the same IPI for smp_migrate_task and
> smp_send_reschedule.  The idea is that smp_send_reschedule(cpu) will
> be effectively smp_migrate_task(cpu, NULL), and the code that receives
> that IPI will check for the NULL and do set_need_resched() instead of
> sched_task_migrated().

I wouldn't necessarily do this.  smp_send_reschedule is used a lot by the 
scheduler and is designed to be fast execution (i.e. you just send out the IPI 
and continue).  Adding spinlocks to this code will slow it down and add cache 
thrashing contention.

smp_migrate_task is designed to be fast executing, but it is only used in 
set_cpus_allowed(), which is rarely called and is not time critical.  Why not 
use the smp_call_function interface instead?  The semantics aren't entirely 
the same, but I don't believe the impact to set_cpus_allowed() will be felt at 
all.

James Bottomley


