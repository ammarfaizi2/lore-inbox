Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268887AbTB0BXd>; Wed, 26 Feb 2003 20:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269149AbTB0BXd>; Wed, 26 Feb 2003 20:23:33 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10429 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268887AbTB0BXc>; Wed, 26 Feb 2003 20:23:32 -0500
Date: Wed, 26 Feb 2003 17:33:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ion Badulescu <ionut@badula.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Mikael Pettersson <mikpe@user.it.uu.se>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <12910000.1046309616@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302262008280.6844-100000@moisil.badula.org>
References: <Pine.LNX.4.44.0302262008280.6844-100000@moisil.badula.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, look further down in apic.c: APIC_init_uniprocessor() calls 
> setup_IO_APIC() which then calls setup_ioapic_ids_from_mpc(). This
> happens  after the code quoted above runs.

OK, sounds good - I might be twisting it with the SMP code, which I'm much
more familiar with.
 
>> boot_cpu_physical_apicid = hard_smp_processor_id();
>> phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
> 
> But is it necessarily true that hard_smp_processor_id() equals the APIC
> id?

Well it should be. Except that someone did this for some odd reason
#define hard_smp_processor_id()                 0
on non-SMP rather than non-local-apic.

But we could just substitute the real code:
static __inline int hard_smp_processor_id(void)
{
        /* we don't want to mark this access volatile - bad code generation
*/
        return GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID));
}
which is in smp.h, but wrapped in #ifdef CONFIG_X86_LOCAL_APIC.
All very twisted. Probably not worth it.

> and that's just about as good as it gets, certainly the CPU knows best 
> what its APIC id is.

Absolutely ;-)

M.

