Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751557AbWCOWDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWCOWDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWCOWDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:03:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:60351 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751557AbWCOWDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:03:08 -0500
Date: Wed, 15 Mar 2006 23:00:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315220046.GA20469@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315215848.GB18241@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> in this particular case there's only very simple (and non-IO) 
> instructions in that codepath (no loops either), except for 
> ata_bmdma_status() which does IO ops: so i agree with you that the 
> most likely candidate for the delay is the readb() or the inb() in 
> ata_bdma_status().
> 
> I'm wondering which one of the two. inb()s are known to be horrible on 
> some systems - but i've never seen them take 16 milliseconds. If it's 
> the inb(), then that could also involve SMM mode and IO 
> emulation/bug-workaround BIOS hackery - which could indeed cause such 
> delays. [but i havent seen such a thing either.]
> 
> the other option is that this is a random delay [e.g. DMA starvation] 
> hitting ata_bmdma_status() only by accident. (That looks a bit 
> unlikely though, given how related this codepath seems to the whole 
> problem area.)

i'd exclude this option based on the second latency trace: that too 
shows a delay in ata_bmdma_status().

so my guess would be that this device doesnt do MMIO, and the PIO inb() 
causes some bad BIOS-based SMM handler/emulator to trigger, which takes 
16.6 msecs. If indeed the device is not in MMIO mode, is there a way to 
force it into MMIO mode, to test this theory?

	Ingo
