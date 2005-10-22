Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVJVPX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVJVPX6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 11:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVJVPX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 11:23:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44217 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751271AbVJVPX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 11:23:58 -0400
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
	<20051021133306.GC3799@in.ibm.com>
	<m1ach3dj47.fsf@ebiederm.dsl.xmission.com>
	<20051022145207.GA4501@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 22 Oct 2005 09:23:34 -0600
In-Reply-To: <20051022145207.GA4501@in.ibm.com> (Vivek Goyal's message of
 "Sat, 22 Oct 2005 20:22:08 +0530")
Message-ID: <m11x2deft5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Fri, Oct 21, 2005 at 08:45:12AM -0600, Eric W. Biederman wrote:
>> Vivek Goyal <vgoyal@in.ibm.com> writes:
>> 
>
> [..]
>
>> >> +	/*
>> >> +	 * Should not be necessary because the MP table should list the boot
>> >> +	 * CPU too, but we do it for the sake of robustness anyway.
>> >> +	 * Makes no sense to do this check in clustered apic mode, so skip it
>> >> +	 */
>> >> +	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
>> >> +		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
>> >> +				boot_cpu_physical_apicid);
>> >
>> >
>> > I am testing kdump on i386 and I am hitting this message while second kernel
>> > is booting. I am doing testing with 2.6.14-rc4-mm1. Logs are pasted below.
>> 
>> The check has been there for a while.  All it is saying is that
>> our boot cpu has apicid #1.   So I suspect you are either on
>> an Opteron system or a hyperthreaded Xeon system.
>> 
>
> I am using Pentium. No hyperthreading.

Weird.  I would have that the BIOS would have listed the second cpu...
It might be worth tracking down later why the message appears but
the real problem is that the map is not getting filled in.

>> > Also kdump testing fails almost 50% of the time on my machine with
>> > 2.6.14-rc4-mm1.  It works fine with 2.6.14-rc4 though.
>> 
>> Is the failure that happens 50% represented by the bootlog below?
>> 
>
> Yes. But this problem is not happening all the time. Now in 4 trials
> I got it once again. The message in all the failures remains the same. 

It seems to only happen when this all starts on the second cpu,
with apic id #1.  Which explains the randomness.


>> apic_id_registered expands to:
>> static inline int apic_id_registered(void)
>> {
>> return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
>> }
>> 
>> Which indicates to me that the code that, there is something
>> wrong in the logic of:
>> 	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
>> 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
>> 				boot_cpu_physical_apicid);
>> 		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
>> 	}
>> 
>> Currently we are refering to the boot cpus apicid with 3 different expressions
>> one of them appears to be wrong.
>> 
>
> Looks like apic_id_registered() is failing. I had put two debug printk()
> statements and to my surprise hard_smp_processor_id() is returning different
> value then GET_APIC_ID(apic_read(APIC_ID)).
>
> source code of hard_smp_processor_id() shows that it is also reading APIC_ID
> register only. Then how can two values be different. (Until and unless
> somebody modified the value in between two reads).

It appears the buggy expression is hard_smp_processor_id.  Quite
possibly because it doesn't call apic_read() and instead open codes
it.

boot_cpu_physical_apicid also returns apicid #1, before we have
a problem.

So either we want to change hard_smp_processor_id to use apic_read()
or we can just use boot_cpu_physical_apicid when fixing the apicid present
bitmap.

> I am pasting another failure log with my debug messages(prefixed with "Debug:").
> My debug patch is also attached with the mail.

See above but I am pretty certain we know enough to get farther.  For
testing you may want to hard code your first kernel to use the second
cpu.

The fact that hard_smp_processor_id gets the wrong value makes me wonder
if your kernel will boot all of the way once we get past this problem.

I suspect if you disassemble the code for hard_smp_processor_id we
will see the compiler doing the wrong thing.

Eric
