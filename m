Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWI2JaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWI2JaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWI2JaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:30:24 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:61175 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1751343AbWI2JaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:30:23 -0400
Date: Fri, 29 Sep 2006 02:30:01 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.18 perfmon new code base + libpfm + pfmon
Message-ID: <20060929093001.GI20238@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060926143420.GF14550@frankl.hpl.hp.com> <p7364f8jvjc.fsf@verdi.suse.de> <20060928075608.GB18245@frankl.hpl.hp.com> <200609281005.08518.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609281005.08518.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Thu, Sep 28, 2006 at 10:05:08AM +0200, Andi Kleen wrote:
> > PAPI people for instance.
> > 
> > The P4 PMU has independent counters, i.e., enable bits. The issue is that to stop a counter
> > requires clearing the CCCR which also contains the overflow information (has the counter
> > overflowed?). So you need to read the CCCR, save the value somewhere, clear the CCCR.
> > You need some save area that you can safely access without grabbing any lock (because you
> > are in the NMI handler).
> 
> Not sure what the lock would be needed for. It is only a per CPU variable that doesn't
> need synchronization no?

The CCCR register is by definition a per-CPU entity. However, the perfmon context where the
CCCR is saved is not. Any thread with access to the file descriptor can gain access to the
context. This can occur from any CPU. Of course, we do have checks in place but they
run after the context lock is held. The main restriction is that a thread cannot operate on
a context attached to another thread unless that thread is stopped (checked via ptrace_check_attach).
Yet there are a few perfmon syscalls, for which this restriction does not apply because they
do not need to touch the PMU hardware, yet they modify the context state.

I think this could work on P4, if we could clear the CCCR and yet retain enough state to detect
which counter(s) overflowed. On P6, where there is not overflow bit in the control register, we
simply check the upper bits on the counters. We could probably do the same for P4.

-- 
-Stephane
