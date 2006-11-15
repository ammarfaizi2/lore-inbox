Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030917AbWKOTU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030917AbWKOTU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030926AbWKOTU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:20:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:58002 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030917AbWKOTUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:20:54 -0500
Message-ID: <455B688F.8070007@garzik.org>
Date: Wed, 15 Nov 2006 14:20:47 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Krzysztof Halasa <khc@pm.waw.pl>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       Olivier Nicolas <olivn@trollprod.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <20061114.190036.30187059.davem@davemloft.net> <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org> <20061114.192117.112621278.davem@davemloft.net> <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org> <455A938A.4060002@garzik.org> <m3fyckdeam.fsf@defiant.localdomain> <455B5F78.5060401@garzik.org> <Pine.LNX.4.64.0611151052580.3349@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611151052580.3349@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> However, I really think that this should be a generic PCI layer thing. If 
> some device asks for MSI interrupts, the PCI layer should try to turn off 
> a INTx routing on its own. Asking drivers to do both is just silly, 
> especially since driver writers really shouldn't be expected to know about 
> all these issues (sure, the best ones do, but a lot of driver writers will 
> just say "it works for me").
> 
> So I don't think the HDA driver should need disable INTx on its own 
> explicitly.

Your thinking is correct, but there is one hitch.

As Roland noted, PCI layer /already/ does this for PCI-Express devices.

The reason we cannot do this in the generic layer for non-PCI-Ex is only 
the driver knows whether that PCI 2.2 bit was actually implemented in 
the device or mapped to some other weird behavior we don't want to 
touch.  DISABLE-INTX is a new bit not present in PCI 2.1 (alas!!).

pci_intx() was my five minute solution to this problem, and it got moved 
outside of libata as soon as somebody needed the same thing :)

Maybe a better solution is letting the driver say "pci_dev->intx_ok = 1" 
right before it calls pci_enable_device().

And if we do this, we can follow through on another suggestion I made: 
disabling INTx on driver exit, to help eliminate any possibility of 
screaming interrupts after driver unload.

	Jeff


