Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291434AbSBMHjH>; Wed, 13 Feb 2002 02:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291436AbSBMHi4>; Wed, 13 Feb 2002 02:38:56 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:20124 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S291434AbSBMHis>; Wed, 13 Feb 2002 02:38:48 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15466.6058.686853.295549@argo.ozlabs.ibm.com>
Date: Wed, 13 Feb 2002 18:37:14 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: smp_send_reschedule vs. smp_migrate_task
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at the updates for PPC that are needed because of the
changes to the scheduler in 2.5.x.  I need to implement
smp_migrate_task(), but I do not have another IPI easily available;
the Open PIC interrupt controller used in a lot of SMP PPC machines
supports 4 IPIs in hardware and we are already using all of them.

Thus I was thinking of using the same IPI for smp_migrate_task and
smp_send_reschedule.  The idea is that smp_send_reschedule(cpu) will
be effectively smp_migrate_task(cpu, NULL), and the code that receives
that IPI will check for the NULL and do set_need_resched() instead of
sched_task_migrated().

At present the i386 version of smp_migrate_task uses a single global
spinlock, thus only one task can be migrating at a time.  If I make
smp_send_reschedule and smp_migrate_task both use the same global
spinlock, is that likely to cause deadlocks or unacceptable
contention?  In fact it would not be hard to have a spinlock per cpu.
Would we ever be likely to do smp_migrate_task and set_need_resched
for the same target cpu at the same time?

Paul.
