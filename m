Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWI1IFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWI1IFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWI1IFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:05:25 -0400
Received: from mail.suse.de ([195.135.220.2]:35267 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751765AbWI1IFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:05:23 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Date: Thu, 28 Sep 2006 10:05:08 +0200
User-Agent: KMail/1.9.3
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060926143420.GF14550@frankl.hpl.hp.com> <p7364f8jvjc.fsf@verdi.suse.de> <20060928075608.GB18245@frankl.hpl.hp.com>
In-Reply-To: <20060928075608.GB18245@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609281005.08518.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 09:56, Stephane Eranian wrote:
> Andi,
> 
> 
> > > [ak] : may have to add __kprobes to some functions
> > > 	- started doing this on some functions. Need better understanding on when to use this
> > 
> > Basically when you could recurse in kprobes. 
> > 
> My understanding is that kprobes are triggered by breakpoints, so I am think that any 
> perfmon function that can be called along the same path, i.e., traps, needs to have the
> __kprobes prefix.

Only when you call perfmon from the int3 path or any code that is shared.

But it is actually more complicated because page faults can be used by
kprobes too.

> > > [ak] : cleaner integration with NMI watchdog
> > > 	- integration done on AMD K8. Issues on P4, P6, due to PMU design
> > 
> > What are the issues?
> 
> This is ugly!
> 
> The P6 PMU actually has only one enable bit for all counters and it is in PERFEVTSEL0 which
> you are using for NMI. Thus counters are NOT independent. Architectural perfmon looks like
> it is fixing this issue.  I am not sure this is actually true based on the findings of the
> PAPI people for instance.
> 
> The P4 PMU has independent counters, i.e., enable bits. The issue is that to stop a counter
> requires clearing the CCCR which also contains the overflow information (has the counter
> overflowed?). So you need to read the CCCR, save the value somewhere, clear the CCCR.
> You need some save area that you can safely access without grabbing any lock (because you
> are in the NMI handler).

Not sure what the lock would be needed for. It is only a per CPU variable that doesn't
need synchronization no? 

-Andi
