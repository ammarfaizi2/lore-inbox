Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbUKEQln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbUKEQln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbUKEQln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:41:43 -0500
Received: from fsmlabs.com ([168.103.115.128]:30340 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S262666AbUKEQlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:41:40 -0500
Date: Fri, 5 Nov 2004 09:41:36 -0700 (MST)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IO_APIC NMI Watchdog not handled by suspend/resume.
In-Reply-To: <1099643612.3793.3.camel@desktop.cunninghams>
Message-ID: <Pine.LNX.4.61.0411050825370.4441@musoma.fsmlabs.com>
References: <1099643612.3793.3.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel

On Fri, 5 Nov 2004, Nigel Cunningham wrote:

> Tracking down SMP problems, I've found that if you boot with
> nmi_watchdog=1 (IO_APIC), the watchdog continues to run while suspend is
> doing sensitive things like restoring the original kernel. I don't know
> enough to provide a patch to disable it so thought I'd ask if someone
> could volunteer to fix this?

Use enable/disable_lapic_nmi_watchdog but first  check to see whether 
nmi_watchdog == NMI_IO_APIC in which case you'd then call 
disable/enable_timer_nmi_watchdog. Something like;

void swsuspend_disable_nmi_watchdog(void)
{
	if ((nmi_watchdog == NMI_IO_APIC) && (smp_processor_id() == 0)) {
		disable_timer_nmi_watchdog();
		return;
	}

	disable_lapic_nmi_watchdog();
}

void swsuspend_enable_nmi_watchdog(void)
{
	if ((nmi_watchdog == NMI_IO_APIC) && (smp_processor_id() == 0)) {
		enable_timer_nmi_watchdog();
		return;
	}

	enable_lapic_nmi_watchdog();
}

Do note that this has to be run on all processors, holla if there is 
anything else.

Thanks,
	Zwane

