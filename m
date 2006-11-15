Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030608AbWKOPzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbWKOPzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbWKOPzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:55:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030608AbWKOPzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:55:40 -0500
Date: Wed, 15 Nov 2006 07:53:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
cc: Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <ada8xidz5zn.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0611150739110.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
 <20061114.190036.30187059.davem@davemloft.net> <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
 <20061114.192117.112621278.davem@davemloft.net> <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
 <455A938A.4060002@garzik.org> <ada8xidz5zn.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, Roland Dreier wrote:
> 
> Huh?  The device can't generate any legacy interrupts once MSI is
> enabled.  As the PCI spec says:

PLEASE.

The spec is just so much toilet paper. The ONLY thing that matters is what 
real hardware does. So please please please PLEASE don't start quoting 
specs as a way to "prove your point". It is totally meaningless.

The fact is, we _know_ there are broken devices out there. Not just wrt 
MSI - pretty much every single sentence of the PCI spec is probably broken 
by _some_ device or subsystem. For example, I would expect that the DMA 
ordering rule is likely broken by the big SGI boxes, because they do 
memory coherency traffic separately from the IO traffic.

This should be the #1 rule for every kernel programmer: read the 
documentation, but don't actually assume it's complete, or that it is 
always true.

One of the big reasons user-level programming is so much simpler than 
kernel programming is that you can basically "think" about your 
algorithms. You seldom have cases where you literally just need to test 
out whether all hardware really works that way.

The bottom line: MSI looks great on paper. I think we might make it a rule 
that we can enable it by default on bridges we trust (which would seem to 
be mainly just Intel). But even then, I think it makes sense for 
per-driver rules, because

 - some drivers may care more than others (sound, for example, certainly 
   doesn't really care at all), apart from irq routing issues, and right 
   now those are _worse_ with MSI due to bugs.

 - we definitely have the potential for per-driver bugs (eg the "disable 
   INTx explicitly" kind of situation), so even if MSI works on a system 
   level, I think we all know that it doesn't always work on a device 
   level, and the safe thing tends to be to keep it disabled unless you 
   have some really overriding concern to use it.

End result: I think that at least for 2.6.19, and at least for the HDA 
sound driver, keeping it disabled by default is the right choice. We 
should probably _also_ make "pci_msi_supported()" just return an error 
(probably by just clearing "pci_msi_enable") for any non-intel host bridge 
for now.

I don't dispute AT ALL that we should try to enable things more in the 
future. I'm just saying that we're better off being careful, and realizing 
that documentation and "official rules" seldom match reality.

(People seem to trust documentation, because for _most_ devices, the 
documentation is correct. But if it's wrong for 1% of all devices, you 
should still realize that IT IS WRONG. You can't quote "the standard" to 
prove a point - a single exception is enough to show that a standard is 
incomplete)

			Linus
