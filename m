Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268439AbUHLHni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268439AbUHLHni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUHLHnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:43:35 -0400
Received: from gprs214-50.eurotel.cz ([160.218.214.50]:21636 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268439AbUHLHn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:43:29 -0400
Date: Thu, 12 Aug 2004 09:43:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nathan Bryant <nbryant@optonline.net>
Cc: ncunningham@linuxmail.org,
       "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: [PATCH] SCSI midlayer power management
Message-ID: <20040812074304.GD29466@elf.ucw.cz>
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net> <1092262602.3553.14.camel@laptop.cunninghams> <411AA24C.6050303@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411AA24C.6050303@optonline.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I tried it on an OSDL machine and could suspend (suspend 2), but only
> >resume as far as copying back the original kernel. The problem then
> >looked to me like it was request ids not matching what the drive was
> >expecting (but I'm ignorant of scsi, so might be completely wrong
> >there).
> > 
> >
> I saw "no match for command buffer" interrupt storms when I was fixing 
> up aic7xxx for S3. The problem was due to not reprogramming the address 
> of our SCB's on resume. Needed to tell the card the base address for all 
> the DMA structures.
> 
> Just to speculate about what would be required for swsusp: you probably 
> need to be using a SCSI LLD that properly implements pci suspend/resume, 
> which implies you need to make sure the card's DMA state machine is 
> flushed and idle before suspend completes. I've got a patch that fixes 
> this much up for aic7xxx. And my other midlayer-level patch may also 
> help... What happens during resume is interesting. I think maybe the 
> problem is not what the drive is expecting, but what the card's state 
> engine is expecting when it tries to map commands to command buffers in 
> DMA space.  Maybe you need to suspend the LLD from the context of the 
> kernel that is doing the image load, and then resume from the context of 
> the kernel that was just loaded.

Ideally, suspended driver should have no state at all. Like if I send
card to suspend with 2.6.8, and when I send it to suspend in 2.6.11,
it should be in same state.

> Sounds like this is why Pavel is asking about DMA. So he'll need to 
> manage calling the host adapter's suspend callbacks, not just 
> generic_scsi_suspend. DMA base addresses are likely to change when you 
> load the new kernel image

sysfs should call host adapter's suspend callbacks... It should work
today.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
