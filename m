Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030880AbWKOTUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030880AbWKOTUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030926AbWKOTUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:20:49 -0500
Received: from hera.kernel.org ([140.211.167.34]:36741 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030880AbWKOTUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:20:48 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 11:20:14 -0800
Organization: OSDL
Message-ID: <20061115112014.54de5b2c@freekitty>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	<20061114.190036.30187059.davem@davemloft.net>
	<Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	<20061114.192117.112621278.davem@davemloft.net>
	<s5hbqn99f2v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1163618415 10909 10.8.0.54 (15 Nov 2006 19:20:15 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 15 Nov 2006 19:20:15 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 11:31:04 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 14 Nov 2006 19:21:17 -0800 (PST),
> David Miller wrote:
> > 
> > From: Linus Torvalds <torvalds@osdl.org>
> > Date: Tue, 14 Nov 2006 19:10:42 -0800 (PST)
> > 
> > > Yours was still an example of "nice". And it had absolutely nothing
> > > to do with the _PROBLEM_.
> > 
> > Understood.
> > 
> > BTW, some drivers have taken the approch to add MSI self-tests
> > inside of the driver to ensure correct option of MSI on a given
> > machine.  There's a lot of resistence to that, the reasons for
> > which I grok fully, but I'm not sure other suggestions such as
> > black lists are any better.
> 
> The snd-hda-intel driver has a test of MSI, but it seems not working
> on every machine.  It caused non-cared interrupts and the kernel
> disabled that irq.
> 
> > Given current experience maybe white-lists are in fact the way
> > to go.
> 
> Could it be whitelisted in the PCI driver side?  I don't think it's
> good to have a huge white/blacklist in each device driver.
> 

A whitelist is an awkward solution, the problem is the number of
chipsets available with MSI will continue to grow. And the assumption
is that after Microsoft OS supports MSI, that newer chipsets will work.

So by having a whitelist, you force a growing whitelist (in the kernel)
to know about all the possible chipsets.  Since non-whitelisted systems
will end up using INTX and working fine, most users will never try MSI
and the whitelist will end up stale.

A better solution is to have more robust IRQ management that can
deal with misrouted IRQ's and try and recover correctly. How hard would
it be to:
	* remember original IRQ before MSI was enabled
	* make sure all MSI irq's are not flagged SHARED
	* in case of bogus IRQ walk the list and try and correct
	  the problem by reverting to INTX mode.
	* add interface?
		pci_request_irq_msi(pdev, regular_irq_handler, msi_irq_handler, flags, name, context)

All this should be done by the MSI layer, not the device drivers.

-- 
Stephen Hemminger <shemminger@osdl.org>
