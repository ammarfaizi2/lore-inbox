Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWGKEoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWGKEoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWGKEoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:44:37 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:50564 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP id S964787AbWGKEog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:44:36 -0400
Subject: Re: [Fastboot] [PATCH 1/3] stack overflow safe
	kdump	(2.6.18-rc1-i386) - safe_smp_processor_id
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@osdl.org, James.Bottomley@steeleye.com, Keith Owens <kaos@ocs.com.au>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <1152591661.2414.11.camel@localhost.localdomain>
References: <5742.1152520068@ocs3.ocs.com.au>
	 <1152526550.3003.24.camel@localhost.localdomain>
	 <m1u05ppu6h.fsf@ebiederm.dsl.xmission.com>
	 <1152591661.2414.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Tue, 11 Jul 2006 13:44:33 +0900
Message-Id: <1152593073.2414.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 13:21 +0900, Fernando Luis Vázquez Cao wrote:
> Hi Eric!
> 
> On Mon, 2006-07-10 at 05:37 -0600, Eric W. Biederman wrote:
> > Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> writes:
> > 
> > > Hi Keith,
> > >
> > > Thank you for the comments.
> > >
> > > On Mon, 2006-07-10 at 18:27 +1000, Keith Owens wrote:
> > >> Fernando Luis Vazquez Cao (on Mon, 10 Jul 2006 16:50:52 +0900) wrote:
> > >> >On the event of a stack overflow critical data that usually resides at
> > >> >the bottom of the stack is likely to be stomped and, consequently, its
> > >> >use should be avoided.
> > >> >
> > >> >In particular, in the i386 and IA64 architectures the macro
> > >> >smp_processor_id ultimately makes use of the "cpu" member of struct
> > >> >thread_info which resides at the bottom of the stack. x86_64, on the
> > >> >other hand, is not affected by this problem because it benefits from
> > >> >the use of the PDA infrastructure.
> > >> >
> > >> >To circumvent this problem I suggest implementing
> > >> >"safe_smp_processor_id()" (it already exists in x86_64) for i386 and
> > >> >IA64 and use it as a replacement for smp_processor_id in the reboot path
> > >> >to the dump capture kernel. This is a possible implementation for i386.
> > >> 
> > >> I agree with avoiding the use of thread_info when the stack might be
> > >> corrupt.  However your patch results in reading apic data and scanning
> > >> NR_CPU sized tables for each IPI that is sent, which will slow down the
> > >> sending of all IPIs, not just dump.
> > > This patch only affects IPIs sent using send_IPI_allbutself which is
> > > rarely called, so the impact in performance should be negligible.
> > 
> > Well smp_call_function uses it so I don't know if rarely called applies.
> > 
> > However when called with the NMI vector every instance of send_IPI_allbutself
> > transforms this into send_IPI_mask.  Which is why we need to know our current
> > cpu in the first place.
> > 
> > Therefore why don't we just do that explicitly in crash.c
> > i.e.
> > 
> > static void smp_send_nmi_allbutself(void)
> > {
> > 	cpumask_t mask = cpu_online_map;
> > 	cpu_clear(safe_smp_processor_id(), mask);
> > 	send_IPI_mask(mask, NMI_VECTOR);
> > }
> > 
> > That will guarantee that any effects this code paranoia may have
> > are only seen in the crash dump path.
> 
> That is a good idea, but I have on concern. In mach-default by default
> we use __send_IPI_shortcut (no_broadcast==0) instead of send_IPI_mask.
> Is it always safe to ignore the no_broadcast setting? In other words,
> can __send_IPI_shortcut be replaced by send_IPI_mask safely?
>From reading the code, it seems that send_IPI_mask is always safer (we
avoid the risk of sending an IPI to an offline CPU) and with it we can
certainly accomplish what we want. I will prepare new patches taking all
your comments and advices.

Thank you,

Fernando

P.S.: Sorry for replying to myself...

> 
> The implementation of send_IPI_allbutself in the different architectures
> follows:
> 
> smp_send_nmi_allbutself
>   send_IPI_allbutself
> 
> * mach-bigsmp
> send_IPI_allbutself
>   cpu_clear(smp_processor_id(), mask)
>   send_IPI_mask
>     send_IPI_mask_sequence
>       apic_wait_icr_idle
> 
> * mach-default
> send_IPI_allbutself
>   __local_send_IPI_allbutself
>     if (no_broadcast) {
>       cpu_clear(smp_processor_id(), mask)
>       send_IPI_mask(mask, vector)
>         send_IPI_mask_bitmask
>           apic_wait_icr_idle
>     } else {
>       __send_IPI_shortcut(APIC_DEST_ALLBUT, vector)
>         apic_wait_icr_idle
>     }
> 
> * mach-es7000
> send_IPI_allbutself
>   cpu_clear(smp_processor_id(), mask);
>   send_IPI_mask
>     send_IPI_mask_sequence
>       apic_wait_icr_idle
> 
> * mach-numaq
> send_IPI_allbutself
>   cpu_clear(smp_processor_id(), mask)
>   send_IPI_mask
>     send_IPI_mask_sequence
>       apic_wait_icr_idle
> 
> * mach-summit
> send_IPI_allbutself
>   cpu_clear(smp_processor_id(), mask)
>   send_IPI_mask
>     send_IPI_mask_sequence
>       apic_wait_icr_idle
> 
> Regards,
> 
> Fernando
> 
> > 
> > 
> > >> It would be far cheaper to define
> > >> a per-cpu variable containing the logical cpu number, set that variable
> > >> once as each cpu is brought up and just read it in cases where you
> > >> might not trust the integrity of struct thread_info.  safe_smp_processor_id()
> > >> resolves to just a read of the per cpu variable.
> > > But to read a per-cpu variable you need to index the corresponding array
> > > with processor id of the current CPU (see code below), but that is
> > > precisely what we are trying to figure out. Anyway as
> > > send_IPI_allbutself is not a fast path (correct if this assumption is
> > > wrong) the current implementation of safe_smp_processor_id should be
> > > fine.
> > >
> > > #define get_cpu_var(var) (*({ preempt_disable();
> > > &__get_cpu_var(var); }))
> > > #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
> > >
> > > Am I missing something obvious?
> > 
> > No.  Except that other architectures have cheaper per pointers so they
> > don't have that problem.
> > 
> > Eric
> 
> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/fastboot

