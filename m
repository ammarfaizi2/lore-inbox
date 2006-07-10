Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWGJLis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWGJLis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGJLis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:38:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26282 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932334AbWGJLir convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:38:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
Cc: Keith Owens <kaos@ocs.com.au>, akpm@osdl.org, James.Bottomley@steeleye.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [Fastboot] [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) - safe_smp_processor_id
References: <5742.1152520068@ocs3.ocs.com.au>
	<1152526550.3003.24.camel@localhost.localdomain>
Date: Mon, 10 Jul 2006 05:37:26 -0600
In-Reply-To: <1152526550.3003.24.camel@localhost.localdomain> (Fernando Luis
	=?iso-8859-1?Q?V=E1zquez?= Cao's message of "Mon, 10 Jul 2006 19:15:50
 +0900")
Message-ID: <m1u05ppu6h.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> writes:

> Hi Keith,
>
> Thank you for the comments.
>
> On Mon, 2006-07-10 at 18:27 +1000, Keith Owens wrote:
>> Fernando Luis Vazquez Cao (on Mon, 10 Jul 2006 16:50:52 +0900) wrote:
>> >On the event of a stack overflow critical data that usually resides at
>> >the bottom of the stack is likely to be stomped and, consequently, its
>> >use should be avoided.
>> >
>> >In particular, in the i386 and IA64 architectures the macro
>> >smp_processor_id ultimately makes use of the "cpu" member of struct
>> >thread_info which resides at the bottom of the stack. x86_64, on the
>> >other hand, is not affected by this problem because it benefits from
>> >the use of the PDA infrastructure.
>> >
>> >To circumvent this problem I suggest implementing
>> >"safe_smp_processor_id()" (it already exists in x86_64) for i386 and
>> >IA64 and use it as a replacement for smp_processor_id in the reboot path
>> >to the dump capture kernel. This is a possible implementation for i386.
>> 
>> I agree with avoiding the use of thread_info when the stack might be
>> corrupt.  However your patch results in reading apic data and scanning
>> NR_CPU sized tables for each IPI that is sent, which will slow down the
>> sending of all IPIs, not just dump.
> This patch only affects IPIs sent using send_IPI_allbutself which is
> rarely called, so the impact in performance should be negligible.

Well smp_call_function uses it so I don't know if rarely called applies.

However when called with the NMI vector every instance of send_IPI_allbutself
transforms this into send_IPI_mask.  Which is why we need to know our current
cpu in the first place.

Therefore why don't we just do that explicitly in crash.c
i.e.

static void smp_send_nmi_allbutself(void)
{
	cpumask_t mask = cpu_online_map;
	cpu_clear(safe_smp_processor_id(), mask);
	send_IPI_mask(mask, NMI_VECTOR);
}

That will guarantee that any effects this code paranoia may have
are only seen in the crash dump path.


>> It would be far cheaper to define
>> a per-cpu variable containing the logical cpu number, set that variable
>> once as each cpu is brought up and just read it in cases where you
>> might not trust the integrity of struct thread_info.  safe_smp_processor_id()
>> resolves to just a read of the per cpu variable.
> But to read a per-cpu variable you need to index the corresponding array
> with processor id of the current CPU (see code below), but that is
> precisely what we are trying to figure out. Anyway as
> send_IPI_allbutself is not a fast path (correct if this assumption is
> wrong) the current implementation of safe_smp_processor_id should be
> fine.
>
> #define get_cpu_var(var) (*({ preempt_disable();
> &__get_cpu_var(var); }))
> #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
>
> Am I missing something obvious?

No.  Except that other architectures have cheaper per pointers so they
don't have that problem.

Eric
