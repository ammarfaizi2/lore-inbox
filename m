Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWJVIh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWJVIh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWJVIh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:37:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44475 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932222AbWJVIhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:37:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Yinghai Lu <yinghai.lu@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	<20061022035109.GM5211@rhun.haifa.ibm.com>
Date: Sun, 22 Oct 2006 02:35:19 -0600
In-Reply-To: <20061022035109.GM5211@rhun.haifa.ibm.com> (Muli Ben-Yehuda's
	message of "Sun, 22 Oct 2006 05:51:09 +0200")
Message-ID: <m1psck21fc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <muli@il.ibm.com> writes:

> On Sat, Oct 21, 2006 at 09:00:17PM +0000, Linux Kernel Mailing List wrote:
>
>> commit 45edfd1db02f818b3dc7e4743ee8585af6b78f78
>> tree cc7a524069ee23c49237c417299e5aa2f93205e0
>> parent 926fafebc48a3218fac675f12974f9a46473bd40
>> author Yinghai Lu <yinghai.lu@amd.com> 1161448621 +0200
>> committer Andi Kleen <andi@basil.nowhere.org> 1161448621 +0200
>> 
>> [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and
> offset
>> 
>> typo with cpu instead of new_cpu
>
> This patch breaks my x366 machine:
>  
> aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 8
> enabled phys, flash present, BIOS build 1323
> aic94xx: couldn't get irq 25 for 0000:01:02.0
> ACPI: PCI interrupt for device 0000:01:02.0 disabled
> aic94xx: probe of 0000:01:02.0 failed with error -38
>
> Reverting it allows it to boot again. Since the patch is "obviously
> correct", it must be uncovering some other problem with the genirq
> code.
>

Ugh.  This is no fun at all.  I am assuming this is with cpu hotplug
disabled in flat mode.

I need to step back and read the code but it appears that
request_irq(25) is failing.
Which implies that the vector assignment is failing for some strange
reason.

So what we need to do is figure out what those data structures
look like on your machine and see if we can figure out a plausible
explanation for why there would be no free vectors.

Taking a wild stab in the dark my hunch it is this bit of code that is
failing.
		for_each_cpu_mask(new_cpu, domain)
			if (per_cpu(vector_irq, new_cpu)[vector] != -1)
				goto next;

Which would suggest that vector_irq is improperly setup on one of the cpus
I am looking at.  It might be something stupid like I need to filter
domain with cpu_online_map.

If my wild set of hypothesis are true the patch below might make those
symptoms go away.  It isn't a real fix by any means but it is an
easy test patch I can generate to generate these giant leaps 
of deduction, I'm taking in the middle of the night :)

Eric


diff --git a/arch/x86_64/kernel/genapic_flat.c b/arch/x86_64/kernel/genapic_flat.c
index 7c01db8..986fa4b 100644
--- a/arch/x86_64/kernel/genapic_flat.c
+++ b/arch/x86_64/kernel/genapic_flat.c
@@ -33,7 +33,7 @@ static cpumask_t flat_vector_allocation_
         * hyperthread was specified in the interrupt desitination.
         */
        cpumask_t domain = { { [0] = APIC_ALL_CPUS, } };
-       return domain;
+       return cpu_online_map;
 }
 
 /*
