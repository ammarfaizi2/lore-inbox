Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVAEOV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVAEOV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVAEOV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:21:58 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49124 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262444AbVAEOVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:21:48 -0500
In-Reply-To: <20050105110833.GA14956@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Nathan Lynch <nathanl@austin.ibm.com>,
       paulus@au1.ibm.com, rusty@rustcorp.com.au
MIME-Version: 1.0
Subject: Re: [BUG] mm_struct leak on cpu hotplug (s390/ppc64)
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF31A98EFF.23948757-ONC1256F80.004ECB94-C1256F80.004EE553@de.ibm.com>
From: Heiko Carstens <Heiko.Carstens@de.ibm.com>
Date: Wed, 5 Jan 2005 15:22:08 +0100
X-MIMETrack: S/MIME Sign by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 01/05/2005 03:21:45 PM,
	Serialize by Notes Client on Heiko Carstens/Germany/IBM(Release 6.0.2CF1|June
 9, 2003) at 01/05/2005 03:21:45 PM,
	Serialize complete at 01/05/2005 03:21:45 PM,
	S/MIME Sign failed at 01/05/2005 03:21:45 PM: The cryptographic key was not
 found,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.51HF338 | June 21, 2004) at
 05/01/2005 15:22:10,
	Serialize complete at 05/01/2005 15:22:10
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the correct solution i think would be to call back into the scheduler
> from cpu_die():
> 
> void cpu_die(void)
> {
>         if (ppc_md.cpu_die)
>                 ppc_md.cpu_die();
> +   idle_task_exit();
>         local_irq_disable();
>         for (;;);
> }
> 
> and then in idle_task_exit(), do something like:
> 
> void idle_task_exit(void)
> {
>    struct mm_struct *mm = current->active_mm;
> 
>    if (mm != &init_mm)
>       switch_mm(mm, &init_mm, current);
>    mmdrop(mm);
> }
> 
> (completely untested.) This makes sure that the idle task uses the
> init_mm (which always has valid pagetables), and also ensures correct
> reference-counting. Hm?

Looks good and works for me.

Thanks,
Heiko

