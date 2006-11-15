Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030844AbWKOSkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030844AbWKOSkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030845AbWKOSkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:40:12 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:5264 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030841AbWKOSkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:40:10 -0500
Message-ID: <455B5F01.7020601@garzik.org>
Date: Wed, 15 Nov 2006 13:40:01 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@infradead.org>, Takashi Iwai <tiwai@suse.de>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>  <20061114.190036.30187059.davem@davemloft.net>  <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>  <20061114.192117.112621278.davem@davemloft.net>  <s5hbqn99f2v.wl%tiwai@suse.de>  <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org> <1163607889.31358.132.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And the thing is, once you do that, all the advantages of MSI totally go 
> away - both the "nice" ones and the "really good ones" (the latter being 
> the hopeful eventual removal of irq routing confusions). So if you do 
> that, the better solution is for the driver to say "I won't use MSI at 
> all".

I certainly agree with this.

The driver should either (a) know MSI works for the device [it calls 
pci_msi_enable()] or (b) never bothers with MSI.

Combine that with accurate pci_msi_enable() failure, and life is good.

No 'test if MSI works' crapola in drivers.  I've disliked such tests 
since the day MSI was introduced into Linux.


> It all boils down to the same thing: either we have to know that MSI works 
> (where "know" is obviously relative - it's not like you can avoid _all_ 
> bugs, but dammit, even a single report of "not working" means that there 
> are probably a ton of machines like that, and we did something wrong), or 
> we shouldn't use it. There is no middle ground. You can't really safely 
> "test" for it, and while you _can_ say "just do both", it doesn't really 
> help anything (and potentially exposes you to just more bugs: if enablign 
> MSI actually _does_ disable INTx, but then doesn't work, at a minimum you 
> end up with a device that doesn't work, even if the rest of the kernel 
> might be ok).

Agreed.


> And btw, I say this as a person whose new main machine used to have HDA 
> routed over MSI, and the decision to default to it off meant that it went 
> back to the regular INTx thing.

Yeah, but you don't care if that happens, so this is an ineffective 
'btw'  It's not like you went to sleep crying over the loss, like I did 
[just kidding!]


> (Btw, MSI interrupts also seem to not participate in CPU balancing:
> 
>  22:      41556      43005   IO-APIC-fasteoi   HDA Intel
> 506:     110417          0   PCI-MSI-edge      eth0
> 
> which is another semantic change introduced by using MSI)

No, that's most likely because ethernet is always intentionally locked 
to a single CPU by irqbalance.

	Jeff



