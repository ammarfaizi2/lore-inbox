Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752109AbWCOWXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbWCOWXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWCOWXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:23:08 -0500
Received: from mail.dvmed.net ([216.237.124.58]:28298 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752109AbWCOWXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:23:07 -0500
Message-ID: <441893AB.1070300@garzik.org>
Date: Wed, 15 Mar 2006 17:22:35 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
 ticks on PM timer]
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu>
In-Reply-To: <20060315215848.GB18241@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> in this particular case there's only very simple (and non-IO) 
> instructions in that codepath (no loops either), except for 
> ata_bmdma_status() which does IO ops: so i agree with you that the most 
> likely candidate for the delay is the readb() or the inb() in 
> ata_bdma_status().
> 
> I'm wondering which one of the two. inb()s are known to be horrible on 
> some systems - but i've never seen them take 16 milliseconds. If it's 
> the inb(), then that could also involve SMM mode and IO 


ata_bmdma_status() is just a single IO read, and even 1ms is highly 
improbable.

I'd look elsewhere.  There are a ton of udelay() calls in the legacy PCI 
IDE BMDMA code paths (sata_nv uses these), so I'm not surprised there is 
latency in general, in a libata+sata_nv configuration.  Status checks 
for example (ata_busy_wait in libata.h) are basically

	while (ioreadX() != condition)
		udelay(10)

That delay is mainly a "don't pound too hard on the hardware" delay.  If 
the hardware is really slow completing a command after signalling 
completion, you'll potentially wait up to 1000*10 us in some cases.  And 
there are other delays, such as the per-command ndelay() plus ioread().

Welcome to the wonderful world of IDE.

	Jeff


