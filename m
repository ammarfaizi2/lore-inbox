Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWI1H40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWI1H40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWI1H40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:56:26 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:49400 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751755AbWI1H4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:56:25 -0400
Date: Thu, 28 Sep 2006 00:56:08 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Message-ID: <20060928075608.GB18245@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060926143420.GF14550@frankl.hpl.hp.com> <20060926220951.39bd344f.akpm@osdl.org> <20060927224832.GA17883@frankl.hpl.hp.com> <p7364f8jvjc.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7364f8jvjc.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Thu, Sep 28, 2006 at 09:32:39AM +0200, Andi Kleen wrote:
> Stephane Eranian <eranian@hpl.hp.com> writes:
> > 
> > [ak] : separate patch for _TIF_WORK_CTXSW
> > 	- I think I submitted a TIF patch for x86-64, but unlike i386 it is not yet in mainline
> 
> If it's not in mainline yet I lost it somehow and you should resubmit.
> 
Will do.

> > [ak] : may have to add __kprobes to some functions
> > 	- started doing this on some functions. Need better understanding on when to use this
> 
> Basically when you could recurse in kprobes. 
> 
My understanding is that kprobes are triggered by breakpoints, so I am think that any 
perfmon function that can be called along the same path, i.e., traps, needs to have the
__kprobes prefix.

> > [ak] : cleaner integration with NMI watchdog
> > 	- integration done on AMD K8. Issues on P4, P6, due to PMU design
> 
> What are the issues?

This is ugly!

The P6 PMU actually has only one enable bit for all counters and it is in PERFEVTSEL0 which
you are using for NMI. Thus counters are NOT independent. Architectural perfmon looks like
it is fixing this issue.  I am not sure this is actually true based on the findings of the
PAPI people for instance.

The P4 PMU has independent counters, i.e., enable bits. The issue is that to stop a counter
requires clearing the CCCR which also contains the overflow information (has the counter
overflowed?). So you need to read the CCCR, save the value somewhere, clear the CCCR.
You need some save area that you can safely access without grabbing any lock (because you
are in the NMI handler). I cannot use the perfmon context because it could be accessed from
other processors, and I would need to grab the context lock. I need to investigate how to
do this in a different way. Maybe change the logic used to detect which counters overflowed
by not using CCCR.

> 
> > [akpm]: documentation for syscall? Is there an API specification?
> > 	- answered. In short, there exists a specification but it needs to be updated
> 
> Probably you should have man pages ready for submission to the manpage maintainer.
> That might also the second review pass on l-k easier if you supply
> them in the description.

I don't have the man pages ready yet.

-- 
-Stephane
