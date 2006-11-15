Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030944AbWKOTiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030944AbWKOTiD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030942AbWKOTiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:38:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030944AbWKOTiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:38:00 -0500
Date: Wed, 15 Nov 2006 11:35:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Krzysztof Halasa <khc@pm.waw.pl>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       Olivier Nicolas <olivn@trollprod.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <455B688F.8070007@garzik.org>
Message-ID: <Pine.LNX.4.64.0611151127560.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
 <20061114.190036.30187059.davem@davemloft.net> <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
 <20061114.192117.112621278.davem@davemloft.net> <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
 <455A938A.4060002@garzik.org> <m3fyckdeam.fsf@defiant.localdomain>
 <455B5F78.5060401@garzik.org> <Pine.LNX.4.64.0611151052580.3349@woody.osdl.org>
 <455B688F.8070007@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2006, Jeff Garzik wrote:
> 
> The reason we cannot do this in the generic layer for non-PCI-Ex is only the
> driver knows whether that PCI 2.2 bit was actually implemented in the device
> or mapped to some other weird behavior we don't want to touch.  DISABLE-INTX
> is a new bit not present in PCI 2.1 (alas!!).

Ok, I would have a few suggestions, then:

 - devices that don't support INTx disable should basically be considered 
   to not support MSI at all (ie a driver simply shouldn't even try to 
   enable MSI, since enabling MSI includes the implicit DISABLE-INTX)

   This is likely ok, since MSI wasn't in PCI 2.1 _either_ afaik. So if 
   your hardware has MSI, it probably _does_ have DISABLE-INTX (or at 
   least that bit doesn't do anything bad, which is the other case)

 - add a flag to "pci_enable_msi()". There really aren't that many users, 
   and they basically _all_ want this functionality. Making them call 
   another function is just a recipe for disaster, since somebody will 
   forget. Having to just say "do I support INTx disable" is much better, 
   since it makes the driver writer aware of having to _explicitly_ make 
   that choice.

> Maybe a better solution is letting the driver say "pci_dev->intx_ok = 1" right
> before it calls pci_enable_device().

I hate that, for exactly the same reason I hate "pci_intx()". It just 
means that most drivers won't do it, because it's not even part of the 
normal sequence, and most people don't care. So again, it would actually 
be better in that case to just add a "flags" field to pci_enable_device(), 
although that's a _hell_ of a lot more painful than it would be to do the 
same to "pci_enable_msi()".

> And if we do this, we can follow through on another suggestion I made:
> disabling INTx on driver exit, to help eliminate any possibility of screaming
> interrupts after driver unload.

The thing is, I think that's a bad idea for the same reason it's a bad 
idea to disable the BAR's (which we tried and then reverted). It's just 
going to cause problems for soft rebooting etc with firmware that doesn't 
expect it.

A driver should obviously quiesce the device on shutdown, and if it leaves 
a device in a state where it may still generate interrupts, that's a 
_bug_, so disabling INTx is just papering over a much more serious issue.

		Linus
