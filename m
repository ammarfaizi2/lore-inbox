Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030682AbWKOQiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbWKOQiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWKOQiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:38:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53483 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030681AbWKOQiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:38:00 -0500
Date: Wed, 15 Nov 2006 08:36:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Takashi Iwai <tiwai@suse.de>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <1163607889.31358.132.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> 
 <20061114.190036.30187059.davem@davemloft.net>  <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
  <20061114.192117.112621278.davem@davemloft.net>  <s5hbqn99f2v.wl%tiwai@suse.de>
  <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org>
 <1163607889.31358.132.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2006, Arjan van de Ven wrote:
> 
> well we could cheat some. And have the generic code for this just
> register the irq handler for both somehow.

Well, not generic code. It would have to be the driver itself that does 
it, since generic code doesn't even know (at irq request time - and when 
they are generated - it just gets the irq number).

And the thing is, once you do that, all the advantages of MSI totally go 
away - both the "nice" ones and the "really good ones" (the latter being 
the hopeful eventual removal of irq routing confusions). So if you do 
that, the better solution is for the driver to say "I won't use MSI at 
all".

Really.

It all boils down to the same thing: either we have to know that MSI works 
(where "know" is obviously relative - it's not like you can avoid _all_ 
bugs, but dammit, even a single report of "not working" means that there 
are probably a ton of machines like that, and we did something wrong), or 
we shouldn't use it. There is no middle ground. You can't really safely 
"test" for it, and while you _can_ say "just do both", it doesn't really 
help anything (and potentially exposes you to just more bugs: if enablign 
MSI actually _does_ disable INTx, but then doesn't work, at a minimum you 
end up with a device that doesn't work, even if the rest of the kernel 
might be ok).

And btw, I say this as a person whose new main machine used to have HDA 
routed over MSI, and the decision to default to it off meant that it went 
back to the regular INTx thing.

(Btw, MSI interrupts also seem to not participate in CPU balancing:

 22:      41556      43005   IO-APIC-fasteoi   HDA Intel
506:     110417          0   PCI-MSI-edge      eth0

which is another semantic change introduced by using MSI)

			Linus
