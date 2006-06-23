Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932933AbWFWIaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbWFWIaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWFWIaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:30:20 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:13505 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932933AbWFWIaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:30:19 -0400
Date: Fri, 23 Jun 2006 10:30:18 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: [patch] i386: cpu_relax() in crash.c and doublefault.c
Message-ID: <20060623083018.GA12273@rhlx01.fht-esslingen.de>
References: <200606230343_MC3-1-C33B-67CA@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606230343_MC3-1-C33B-67CA@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 23, 2006 at 03:40:25AM -0400, Chuck Ebbert wrote:
> Add cpu_relax() to infinite loops in crash.c and
> doublefault.c.  This is the safest change.

Thanks for your continued work on this!

What's the reasoning for not running halt() in doublefault_fn()?


In order to consolidate those places to safely halt a CPU,
I could think of (possibly in a header file):

/* very, very safely halt CPU:
   - do minimal checking in case CPU might already be overheated (unreliable!)
     (also use inlining to avoid call overhead on an unreliable CPU)
   - try to use halt() and cpu_relax() very liberally to keep the crashed
     CPU as cool as possible (crash might have happened due to CPU fan failure!)
     While ACPI specifies CPU shutdown on over-temperature, we really don't
     want to rely on this since it might be broken or we simply don't use ACPI
     mode at all...
*/ 
inline void safely_halt_cpu(int do_minimal_checking)
{
	/* inlining will optimize the branching away */
	if (!do_minimal_checking) {
		if (cpu_data[smp_processor_id()].hlt_works_ok)
			for (;;) {
				halt();
				/* halt failed? still make sure to cpu_relax()! */
				cpu_relax();
			}
		else
			for (;;) {
				cpu_relax();
				cpu_relax();
				cpu_relax();
			}
	} else {
		halt();
		/* halt didn't work, so still keep as cool as possible: */
		for (;;) {
			cpu_relax();
			cpu_relax();
			cpu_relax();
		}
	}
}

Does my preliminary code even make any sense at all? ;)
Might want to cleverly rearrange it to try to get rid of the cpu_relax()
duplication while not abandoning any advantage of those different
conditions.

Andreas Mohr
