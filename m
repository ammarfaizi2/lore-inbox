Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966567AbWKOEL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966567AbWKOEL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966570AbWKOEL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:11:59 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:11743 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966567AbWKOEL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:11:58 -0500
Message-ID: <455A938A.4060002@garzik.org>
Date: Tue, 14 Nov 2006 23:11:54 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <20061114.190036.30187059.davem@davemloft.net> <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org> <20061114.192117.112621278.davem@davemloft.net> <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> HOWEVER - that's only true on systems with no other PCI bridges. Even if 
> you have an Intel NB/SB, what about other bridges in that same system, and 
> the devices behind them? 
> 
> Now, I think that a MSI thing should look like a PCI write to a magic 
> address (I'm really not very up on it, so correct me if I'm wrong), and 
> thus maybe bridges are bound to get it right, and the only thing we really 
> need to worry about is the host bridge. Maybe. In that case, it might be 
> sensible to have a host-bridge white-table, and if we know all Intel 
> bridges that claim to support MSI do so correctly, then maybe we can just 
> say "ok, always enable it for Intel host bridges".

That's pretty much the idea behind MSI... it looks like any other PCI 
bus transaction, rather than needing a separate pin.


> But right now I'm not convinced we really know what all goes wrong. Maybe 
> it's just broken NVidia and AMD bridges. But maybe it's also individual 
> devices that continue to (for example) raise _both_ the legacy IRQ line 
> _and_ send an MSI request.

That reminds me of a potential driver bug -- MSI-aware drivers need to 
call pci_intx(pdev,0) to turn off the legacy PCI interrupt, before 
enabling MSI interrupts.

So far, MSI history on x86 has always followed these rules:
* it works on Intel
* it doesn't work [well | at all] on AMD/NV

The only thing that has changed recently is that people are trying to 
get it working on AMD/NV as well.  (Brice Goglin's stuff starting at 
6397c75cbc4d7dbc3d07278b57c82a47dafb21b5 in 'git log')

Seems to me this hda-intel driver patch is fallout from 
pci_msi_enabled() not failing on enough systems (all AMD/NV?).

Anyway, if you want your master switch, put it there, not in each driver...

	Jeff


