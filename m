Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWFTHuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWFTHuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWFTHuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:50:18 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:10194 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S965143AbWFTHuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:50:16 -0400
Date: Tue, 20 Jun 2006 09:50:15 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] i386: halt the CPU on serious errors
Message-ID: <20060620075015.GB3030@rhlx01.fht-esslingen.de>
References: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 20, 2006 at 12:55:25AM -0400, Chuck Ebbert wrote:
> Halt the CPU when serious errors are encountered and we
> deliberately go into an infinite loop.
> 
> Suggested by Andreas Mohr.

Thanks for the very fast patch, but:

>       /* Assume hlt works */
> -     halt();
> -     for(;;);
> +     for (;;)
> +             halt();

The comment above seems to hint at this code in arch/i386/kernel/smp.c/
stop_this_cpu() which does proper hlt checks:

        if (cpu_data[smp_processor_id()].hlt_works_ok)
                for(;;) halt();
        for (;;);

So I'm unsure what happens if hlt is not supported properly. Maybe
there's an invalid opcode exception in a loop then.

I think a patch should do the following (or more):

- try to group various CPU emergency stop places together
- comment about trying to avoid overheating, mentioning ACPI
  thermal protection specifications and possibly *missing protection*
  in non-ACPI systems/modes (APM!)
- if (hlt_works_ok), do hlt loop
- if not, do a cpu_relax() loop (or even: for (;;) 3 times cpu_relax()
  for lower activity?)

One thing that may be worth pondering about is whether using cpu_relax()
might actually keep the CPU slightly below the ACPI shutdown temperature
limit and thus do *more* harm with a broken fan. In that case we might
want to check for active ACPI mode and if active do a busy loop instead.
This however may cause temperature to cycle (will a CPU shutdown reactivate
itself after cooling down again?), so a cpu_relax() might still be better.

Andreas Mohr
