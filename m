Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUIWWjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUIWWjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUIWWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:35:29 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:26244 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S267526AbUIWWeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:34:14 -0400
Date: Fri, 24 Sep 2004 02:33:57 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Sort generic PCI fixups after specific ones
Message-ID: <20040924023357.A2526@jurassic.park.msu.ru>
References: <20040922214304.GS16153@parcelfarce.linux.theplanet.co.uk> <20040923172038.GA8812@kroah.com> <20040923173151.GX16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040923173151.GX16153@parcelfarce.linux.theplanet.co.uk>; from matthew@wil.cx on Thu, Sep 23, 2004 at 06:31:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 06:31:51PM +0100, Matthew Wilcox wrote:
> Not really.  There's two types of fixup (well, four if you multiply by
> the header vs later possibility).  There's the incredibly specific ("this
> device from this manufacturer forgets to set something properly") and
> the incredibly general ("if this is a cardbus / IDE device, then ...").
> This patch simply distinguishes between the two.  Obviously the general
> ones run after the specific ones -- there's specific devices that forget
> to set their class code, for example.

This is way not obvious. Example: some architecture requires to put
_all_ PCI IDE devices in native mode (obviously with a general fixup),
but what if some specific chips need additional "native mode only"
workarounds? Your logic won't work then.

I believe we do need third level of fixups, specifically for devices like
IDE which can change the PCI header contents (class code, BAR layout etc.)
depending on some magic bits in their registers.
Such "early" or "pre-header" fixups should be called right after the device
discovery, before probing the BARs. Apparently pci_setup_device()
is a proper place for that.

Ivan.
