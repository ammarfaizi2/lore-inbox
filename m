Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbUBYHIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 02:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbUBYHIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 02:08:07 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41221 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262639AbUBYHIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 02:08:04 -0500
Date: Wed, 25 Feb 2004 08:00:19 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Len Brown <len.brown@intel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: [RFC] ACPI power-off on P4 HT
Message-ID: <20040225070019.GA30971@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4> <20040208082059.GD29363@alpha.home.local> <20040208090854.GE29363@alpha.home.local> <20040214081726.GH29363@alpha.home.local> <1076824106.25344.78.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076824106.25344.78.camel@dhcppc4>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len & Marcelo,

as I previously said, the patch I sent which fixes the poweroff on my VAIO is
not enough to shut down the supermicro P4 HT. So I borrowed some code from
machine_restart() to try to :
  - disable APIC  => was not enough, but I must retry on the VAIO
  - stop the second CPU => was not enough either
  - bounce on boot_cpu and stop the others => it did work.

So I think that ACPI is not SMP-proof nor HT-proof on some hardware. My new
problem is that I feel like the code I have included in acpi_power_off() to
do this is a bit too much x86 specific, so I'd like to move this to
arch/i386/kernel/process.c with all the rest, but I don't know how to cut
this. I think that a general function such as machine_prepare_shutdown() or
something like this would be useful and could be shared by both ACPI and
machine_restart(). It would basically to everything that is needed in such
a case :
  - on SMP, bounce on boot_cpu, then halt the current CPU if != boot_cpu
  - on SMP, stop all other CPUs
  - on UP, disable IOAPIC
  - disable local APIC

I suspect that this function would be useful for some suspend cases, but I'm
not sure. My other problem is to know what we should do then with other
arches. Create an identical function for everyone, or just call it from
ACPI on CONFIG_X86, or even add a CONFIG_MACHINE_PREPARE_SHUTDOWN ?

I need some feedback here. Any suggestions ?

Regards,
Willy

