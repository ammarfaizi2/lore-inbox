Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWF1Tlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWF1Tlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWF1Tlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:41:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55789 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751109AbWF1Tln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:41:43 -0400
Date: Wed, 28 Jun 2006 21:09:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] i386: cpu_relax() in crash.c and doublefault.c
Message-ID: <20060628190903.GC9426@elf.ucw.cz>
References: <200606230343_MC3-1-C33B-67CA@compuserve.com> <20060623083018.GA12273@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623083018.GA12273@rhlx01.fht-esslingen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-06-23 10:30:18, Andreas Mohr wrote:
> Hi,
> 
> On Fri, Jun 23, 2006 at 03:40:25AM -0400, Chuck Ebbert wrote:
> > Add cpu_relax() to infinite loops in crash.c and
> > doublefault.c.  This is the safest change.
> 
> Thanks for your continued work on this!
> 
> What's the reasoning for not running halt() in doublefault_fn()?
> 
> 
> In order to consolidate those places to safely halt a CPU,
> I could think of (possibly in a header file):
> 
> /* very, very safely halt CPU:
>    - do minimal checking in case CPU might already be overheated (unreliable!)
>      (also use inlining to avoid call overhead on an unreliable CPU)
>    - try to use halt() and cpu_relax() very liberally to keep the crashed
>      CPU as cool as possible (crash might have happened due to CPU fan failure!)
>      While ACPI specifies CPU shutdown on over-temperature, we really don't
>      want to rely on this since it might be broken or we simply don't use ACPI
>      mode at all...
> */ 
> inline void safely_halt_cpu(int do_minimal_checking)
> {
> 	/* inlining will optimize the branching away */
> 	if (!do_minimal_checking) {
> 		if (cpu_data[smp_processor_id()].hlt_works_ok)
> 			for (;;) {
> 				halt();
> 				/* halt failed? still make sure to cpu_relax()! */
> 				cpu_relax();
> 			}
> 		else
> 			for (;;) {
> 				cpu_relax();
> 				cpu_relax();
> 				cpu_relax();
> 			}

Ouch and... on cpus without working hlt (old i386s) "rep nop" magic
(from pentium 4!) is not going to help. 

Also, AFAIK all cpus supporting "rep nop" have good thermal
protection, anyway. So it should be enough to KISS and do 

local_irq_disable();
while (1)
	halt();


> 	} else {
> 		halt();

Here you halt without minimal checking. Actually you probably do not
need to check -- you want to kill the machine, and hlt's only problem
was that it occassionally killed the machine on old i386s :-).

> Does my preliminary code even make any sense at all? ;)
> Might want to cleverly rearrange it to try to get rid of the cpu_relax()
> duplication while not abandoning any advantage of those different
> conditions.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
