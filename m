Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVCAQ7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVCAQ7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCAQ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:59:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36011 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261972AbVCAQ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:59:09 -0500
Date: Tue, 1 Mar 2005 16:59:04 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 08:49:45AM -0800, Linus Torvalds wrote:
> On Tue, 1 Mar 2005, Jeff Garzik wrote:
> > A new API handles none of this.
> 
> Ehh? 

I think what Jeff meant was "this new API handles none of this".
And that's true, it doesn't handle DMA errors.  But I think that's just
something that hasn't been written/designed yet.

So how should we handle it?  Obviously the driver may not be executing
when a PCI parity error occurs, so we probably get to find out about
this through some architecture-specific whole-system error, let's call
it an MCA.

The MCA handler has to go and figure out what the hell just happened
(was it a DIMM error, PCI bus error, etc).  OK, fine, it finds that it
was an error on PCI bus 73.  At this point, I think the architecture
error handler needs to call into the PCI subsystem and say "Hey, there
was an error, you deal with it".

If we're lucky, we get all the information that allows us to figure
out which device it was (eg a destination address that matches a BAR),
then we could have a ->error method in the pci_driver that handles it.
If there's no ->error method, at leat call ->remove so one device only
takes itself down.

Does this make sense?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
