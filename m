Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVK3HhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVK3HhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 02:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVK3HhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 02:37:21 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:51109 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1751102AbVK3HhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 02:37:20 -0500
Subject: Re: [Fastboot] Re: [PATCH 1/4] stack overflow safe kdump (i386) -
	safe_smp_processor_id
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1d5kkf5rf.fsf@ebiederm.dsl.xmission.com>
References: <1133200833.2425.100.camel@localhost.localdomain>
	 <p738xv8id6r.fsf@verdi.suse.de>  <m1d5kkf5rf.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 30 Nov 2005 16:32:46 +0900
Message-Id: <1133335966.2412.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 21:16 -0700, Eric W. Biederman wrote: 
> Andi Kleen <ak@suse.de> writes:
> 
> > Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:
> >> 
> >> To circumvent this problem I suggest implementing
> >> "safe_smp_processor_id()" (it already exists on x86_64) for i386 and
> >> IA64 and use it as a replacement to smp_processor_id in the reboot path
> >> to the dump capture kernel. This is a possible implementation for i386.
> >
> > It's not fully safe, because a SMP kernel might run on a 32bit
> > system without APIC. Then hard_smp_processor_id() would fault. 
> > (this cannot happen on x86-64)
> >
> > You probably need to check one of the globals set by apic.c
> > when its disabled.
> 
> Right.  An SMP kernel on a uniprocessor, without apics.
> 
> To my knowledge all SMP systems that linux supports have
> apics.

Thank you for the comments. I have modified safe_smp_processor_id so
that it now checks whether APICs are enabled before using
hard_smp_processor_id. Would this check suffice?

int safe_smp_processor_id(void) {
        int apicid, cpuid;

        if (!boot_cpu_has(X86_FEATURE_APIC))
                return 0;

        apicid = hard_smp_processor_id();
        if (apicid == BAD_APICID)
                return 0;

        cpuid = convert_apicid_to_cpu(apicid);

        return cpuid >= 0 ? cpuid : 0;
}

I will be resending the stack overflow patches reflecting this change.
They should apply cleanly against kernel 2.6.15-rc3. I will send the nmi
handler-related patches separately once I have tested the code properly.

Regards,

Fernando

