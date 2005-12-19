Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVLSPCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVLSPCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 10:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVLSPCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 10:02:24 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:11143 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S932179AbVLSPCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 10:02:23 -0500
Date: Mon, 19 Dec 2005 07:00:15 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog logic on X86-64
Message-ID: <20051219150015.GG2690@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051213161557.GF12669@frankl.hpl.hp.com> <20051217123649.dd2743f4.akpm@osdl.org> <m1mziz77l9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mziz77l9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

On Sat, Dec 17, 2005 at 02:10:42PM -0700, Eric W. Biederman wrote:
> >> I would like to make sure that the logic of the code is that ONLY one
> >> processor does the NMI watchdog timer?
> 
> That much I answer.  The logic is that each processor does the NMI watchdog.
> 
I checked again and there is something that looks broken to me. I agree with you
that the NMI watchdog must be per-CPU. In fact it is setup per local APIC in
smpboot.c. Yet what is confusing is that the owner variable lapic_nmi_owner
is shared with spinlock. So you either setup NMI on all CPUs or none. 

That also implies that the reserve_lapic_nmi() function must be called only
once. If called for each CPU, it will fail for the second caller because
it will see the lapic_nmi_owner already set to RESERVED. But if called only
once, then the the disable logic in reserve_lapic_nmi() is wrong:

int reserve_lapic_nmi(void)
{
        unsigned int old_owner;

        spin_lock(&lapic_nmi_owner_lock);
        old_owner = lapic_nmi_owner;
        lapic_nmi_owner |= LAPIC_NMI_RESERVED;
        spin_unlock(&lapic_nmi_owner_lock);
        if (old_owner & LAPIC_NMI_RESERVED)
                return -EBUSY;
        if (old_owner & LAPIC_NMI_WATCHDOG)
                disable_lapic_nmi_watchdog();
        return 0;
}

If reserve_lapic_nmi() is called only once, then it will call
disable_lapic_nmi_watchdog() on ONLY one CPU even though it was
setup on all CPUs in smpboot.c. The function disable_lapic_nmi_watchdog()
should be called on all CPUs (once nmi_active, nmi_watchdog are moved
out of it). 

It appears to me that the lapic_nmi_owner variable somehow needs
to become a per-cpu variable. Then the reserve_lapic_nmi() would
have to be called on CPUs as necessary.

-- 
-Stephane
