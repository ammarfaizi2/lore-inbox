Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWDRRyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWDRRyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWDRRx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:53:59 -0400
Received: from smtp-out.google.com ([216.239.45.12]:58850 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932229AbWDRRx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:53:59 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=E2V2e79gv5PTjzthdak+JnwTTOVm4rSGUwEzaU5lZaxQ+mMvs98rHJNNm0Ihb0W5t
	AaTlVpsMGv9Qc/wkrA/wQ==
Message-ID: <44452786.1010303@google.com>
Date: Tue, 18 Apr 2006 10:53:10 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Lee Revell <rlrevell@joe-job.com>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org,
       Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: Re: irqbalance mandatory on SMP kernels?
References: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net> <4443A6D9.6040706@mbligh.org> <1145286094.16138.22.camel@mindpipe> <20060418163539.GB10933@thunk.org>
In-Reply-To: <20060418163539.GB10933@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Mon, Apr 17, 2006 at 11:01:33AM -0400, Lee Revell wrote:
> 
>>>There is an in-kernel IRQ balancer. Redhat just choose to turn it
>>>off, and do it in userspace instead. You can re-enable it if you
>>>compile your own kernel.
>>
>>Round-robin IRQ balancing is inefficient anyway.  You'd get better cache
>>utilization letting one CPU take them all.
> 
> 
> IIRC, Van Jacobsen at his Linux.conf.au presentation made a pretty
> strong argument that irq balancing was never a good idea, describing
> them as a George Bush-like policy.  "Ooh, interrupts are hurting one
> CPU --- let's hurt them **all** and trash everybody's cache!"

Nothing nowadays does round-robin of interrupts, either the in-kernel
or userspace balancers ... but we do migrate them occasionally (in the
order of 1s or so)

> Which brings up an interesting question --- why do we have an IRQ
> balancer in the kernel at all?  Maybe the scheduler's load balancer
> should take this into account so that processes that have the
> misfortune of getting assigned to the wrong CPU don't get hurt too
> badly (or maybe if we have enough cores/CPU's we can afford to
> dedicate one or two CPU's to doing nothing but handling interrupts);
> but spreading IRQ's across all of the CPU's doesn't seem like it's
> ever the right answer.

Because *something* has to be balanced, and moving processes around
is expensive too. Personally I find the process model cleaner, but
maybe it's less efficient - you'd also add extra overhead for accounting
to each interrupt, which we don't do now.

I'm not claiming that moving irqs is worse or better than moving
processes - just that it's a tradeoff, both suck. Perhaps the
real answer is that we shouldn't be getting that many interrupts
anyway - technologies like NAPI and simpler device interrupt collation
should reduce the load, and most of the work should be done in the
back-ends anyhow (though those are often locally bonded to the CPU
the irq arrived on).

M.
