Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWERAoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWERAoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 20:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWERAoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 20:44:03 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:40132 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751112AbWERAoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 20:44:03 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Drew Moseley <dmoseley@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unnecessary warnings in smp_send_stop on i386 arch. 
In-reply-to: Your message of "Wed, 17 May 2006 11:34:57 MST."
             <200605171134.57502.dmoseley@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 May 2006 10:42:43 +1000
Message-ID: <3620.1147912963@ocs3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Moseley (on Wed, 17 May 2006 11:34:57 -0700) wrote:
>On Tuesday 16 May 2006 9:56 pm, Keith Owens wrote:
>> Drew Moseley (on Tue, 16 May 2006 19:43:05 -0700) wrote:
>...
>> >
>> >I modified the i386/kernel/smp.c file to be functionally equivalent to the
>> >x86_64/kernel/smp.c file to address this issue.
>> >
>...
>>
>> NAK this patch.  There is a real potential deadlock if you call
>> smp_call_function() with interrupts disabled, it has caused kernel
>> hangs in the past.  This patch removes the check for the potential
>> deadlock and will allow bad code to creep back into the kernel.  See
>> http://lkml.org/lkml/2004/5/2/116.  I find it quite disturbing that
>> x86_64 has removed that check :(
>
>So presumably the warn_on() call should be added back to the x86_64 arch?

Yes.  smp_call_function() in i386 has to stay the way it is, and x86_64
has to revert to be the same as i386 and all the other architectures,
including the WARN_ON(irqs_disabled()).

That still leaves the panic and sysrq cases, and anywhere else that
needs to do an emergency stop or reboot of the system from a context
where interrupts are disabled.  I do not like the idea of reenabling
interrupts just to suppress a warning from smp_call_function().  By
definition, this is an unusual state and reenabling interrupts runs
significant risks of not doing what the caller wants.

The cleanest solution is the way that alpha, arm and ia64 do it.
smp_send_stop() sends IPI_CPU_STOP to all cpus and does not go through
smp_call_function().  That avoids all the problems of calling
smp_send_stop() in an emergency.  If it works for ia64 with 1,024 cpus
in a single system image then it must be good :)

Alternatively smp_send_stop() could pass a special wait value into
smp_call_function() to say that interrupts being disabled is expected.
smp_call_function() would then skip its lock and it would skip waiting
for all the other cpus to respond, or at least timeout after a short
period and continue.  That would avoid the deadlock.  Like this (i386,
not even compiled, let alone tested).

/* wait == 0, do not wait for the function to complete on other cpus.  wait ==
 * 1, wait.  wait < 0, do not take locks and do not wait forever, not irqsafe.
 */
int smp_call_function (void (*func) (void *info), void *info, int nonatomic,
		       int wait)
{
	struct call_data_struct data;
	int cpus, timeout, irqsafe = wait >= 0;

	cpus = num_online_cpus() - 1;
	timeout = cpus + 1;
	if (irqsafe) {
		/* Holding any lock stops cpus from going down. */
		spin_lock(&call_lock);
		if (!cpus) {
			spin_unlock(&call_lock);
			return 0;
		}

		/* Can deadlock when called with interrupts disabled */
		WARN_ON(irqs_disabled());
	} else {
		wait = 0;
	}

	data.func = func;
	data.info = info;
	atomic_set(&data.started, 0);
	data.wait = wait;
	if (wait)
		atomic_set(&data.finished, 0);

	call_data = &data;
	mb();

	/* Send a message to all other CPUs and wait for them to respond */
	send_IPI_allbutself(CALL_FUNCTION_VECTOR);

	/* Wait for response */
	while (atomic_read(&data.started) != cpus) {
		cpu_relax();
		if (!irqsafe) {
			mdelay(1);
			if (timeout-- == 0)
				break;
		}
	}

	if (wait)
		while (atomic_read(&data.finished) != cpus)
			cpu_relax();
	if (irqsafe)
		spin_unlock(&call_lock);

	return 0;
}

void smp_send_stop(void)
{
	smp_call_function(stop_this_cpu, NULL, 1, irqs_disabled() ? -1 : 0);

	local_irq_disable();
	disable_local_APIC();
	local_irq_enable();
}

