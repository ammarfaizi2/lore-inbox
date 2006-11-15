Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030886AbWKOTF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030886AbWKOTF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030896AbWKOTFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:05:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36024 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030886AbWKOTFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:05:54 -0500
Date: Wed, 15 Nov 2006 11:04:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Krzysztof Halasa <khc@pm.waw.pl>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       Olivier Nicolas <olivn@trollprod.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <455B5F78.5060401@garzik.org>
Message-ID: <Pine.LNX.4.64.0611151052580.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
 <20061114.190036.30187059.davem@davemloft.net> <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
 <20061114.192117.112621278.davem@davemloft.net> <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
 <455A938A.4060002@garzik.org> <m3fyckdeam.fsf@defiant.localdomain>
 <455B5F78.5060401@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2006, Jeff Garzik wrote:
>
> Though OTOH, the driver wasn't calling pci_intx() nor setting irq flags
> correctly, so who knows.

The thing is, if the HDA driver happened to be alone on its legacy INTx 
vector, and it is now empty, then the kernel won't ever care about the 
fact that INTx may be still being generated. The legacy vector won't be 
enabled unless somebody else is on that vector.

So yes, this NV HDA sound breakage could easily be because of the 
interrupt being sent both over legacy INTx _and_ MSI. It would only break 
for people who happened to have another device sharing the INTx pin (like 
the report that caused us to disable it by default).

However, I really think that this should be a generic PCI layer thing. If 
some device asks for MSI interrupts, the PCI layer should try to turn off 
a INTx routing on its own. Asking drivers to do both is just silly, 
especially since driver writers really shouldn't be expected to know about 
all these issues (sure, the best ones do, but a lot of driver writers will 
just say "it works for me").

So I don't think the HDA driver should need disable INTx on its own 
explicitly.

If somebody were to write up such a patch and send it to Olivier (and 
others - I think there was another report of this) for testing (he'd now 
need to ask for msi irqs explicitly), that might be interesting. Hint, 
hint.

(See the original http://lkml.org/lkml/2006/11/8/98 report for one broken 
case, although it does seem different: we literally have a

	hda_intel: No response from codec, disabling MSI...

indicating that the MSI case simply didn't work at _all_ rather than 
duplicating interrupts).

		Linus
