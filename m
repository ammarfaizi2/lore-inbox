Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUBYHzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbUBYHzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:55:48 -0500
Received: from fmr03.intel.com ([143.183.121.5]:38346 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262492AbUBYHzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:55:45 -0500
Subject: Re: [RFC] ACPI power-off on P4 HT
From: Len Brown <len.brown@intel.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20040225070019.GA30971@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4>
	 <20040208082059.GD29363@alpha.home.local>
	 <20040208090854.GE29363@alpha.home.local>
	 <20040214081726.GH29363@alpha.home.local>
	 <1076824106.25344.78.camel@dhcppc4>
	 <20040225070019.GA30971@alpha.home.local>
Content-Type: text/plain
Organization: 
Message-Id: <1077695701.5911.130.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Feb 2004 02:55:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy,
I do think we need a generic way to be sure that certain routines are
run only on cpu0.

I don't see it in the ACPI spec, but it seems that on some platforms,
some register accesses (such as writing to the sleep control reg) are
reliable only when accessed from cpu0.

This issue has been with us for some time:
http://bugzilla.kernel.org/show_bug.cgi?id=1141

I am hopeful that the prepare-shutdown sequence you suggest below will
not be necessary.

thanks,
-Len


On Wed, 2004-02-25 at 02:00, Willy Tarreau wrote:
> Hi Len & Marcelo,
> 
> as I previously said, the patch I sent which fixes the poweroff on my VAIO is
> not enough to shut down the supermicro P4 HT. So I borrowed some code from
> machine_restart() to try to :
>   - disable APIC  => was not enough, but I must retry on the VAIO
>   - stop the second CPU => was not enough either
>   - bounce on boot_cpu and stop the others => it did work.
> 
> So I think that ACPI is not SMP-proof nor HT-proof on some hardware. My new
> problem is that I feel like the code I have included in acpi_power_off() to
> do this is a bit too much x86 specific, so I'd like to move this to
> arch/i386/kernel/process.c with all the rest, but I don't know how to cut
> this. I think that a general function such as machine_prepare_shutdown() or
> something like this would be useful and could be shared by both ACPI and
> machine_restart(). It would basically to everything that is needed in such
> a case :
>   - on SMP, bounce on boot_cpu, then halt the current CPU if != boot_cpu
>   - on SMP, stop all other CPUs
>   - on UP, disable IOAPIC
>   - disable local APIC
> 
> I suspect that this function would be useful for some suspend cases, but I'm
> not sure. My other problem is to know what we should do then with other
> arches. Create an identical function for everyone, or just call it from
> ACPI on CONFIG_X86, or even add a CONFIG_MACHINE_PREPARE_SHUTDOWN ?
> 
> I need some feedback here. Any suggestions ?
> 
> Regards,
> Willy
> 

