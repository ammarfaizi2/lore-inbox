Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWCOWBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWCOWBL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWCOWBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:01:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:6626 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751356AbWCOWBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:01:10 -0500
Date: Wed, 15 Mar 2006 22:58:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315215848.GB18241@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <1142459152.1671.64.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142459152.1671.64.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Wed, 2006-03-15 at 16:36 -0500, Bill Rugolsky Jr. wrote:
> >    <...>-2913  0d.h.    9us : ata_host_intr (nv_interrupt)
> >    <...>-2913  0d.h.    9us!: ata_bmdma_status (ata_host_intr)
> >    <...>-2913  0d.h. 16641us : nv_check_hotplug_ck804 (nv_interrupt)
> >    <...>-2913  0d.h. 16642us : _spin_unlock_irqrestore (nv_interrupt) 
> 
> There's your problem - it looks like ata_bmdma_status() stalled the 
> machine for almost 17ms.

i agree. Here's a bit more detailed analysis: the tracer timestamps 
function entry points. So what we know is that from the call to 
ata_bdma_status(), up to the call to nv_check_hotplug_ck804(), 16.6 
msecs passed. The codepath includes:

 - the whole of the ata_bdma_status() function

 - a small portion of ata_host_intr() [from the point where it returns 
   from the ops->bdma_status() call up to the return]

 - and a small portion of nv_interrupt(), from the ata_host_intr() 
   return to the ->check_hotplug() call.

in this particular case there's only very simple (and non-IO) 
instructions in that codepath (no loops either), except for 
ata_bmdma_status() which does IO ops: so i agree with you that the most 
likely candidate for the delay is the readb() or the inb() in 
ata_bdma_status().

I'm wondering which one of the two. inb()s are known to be horrible on 
some systems - but i've never seen them take 16 milliseconds. If it's 
the inb(), then that could also involve SMM mode and IO 
emulation/bug-workaround BIOS hackery - which could indeed cause such 
delays. [but i havent seen such a thing either.]

the other option is that this is a random delay [e.g. DMA starvation] 
hitting ata_bmdma_status() only by accident. (That looks a bit unlikely 
though, given how related this codepath seems to the whole problem 
area.)

	Ingo
