Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVCBC0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVCBC0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 21:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVCBC0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 21:26:11 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:61584 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262139AbVCBCZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 21:25:58 -0500
Message-ID: <422524B1.10405@jp.fujitsu.com>
Date: Wed, 02 Mar 2005 11:28:01 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> I think what Jeff meant was "this new API handles none of this".
> And that's true, it doesn't handle DMA errors.  But I think that's just
> something that hasn't been written/designed yet.

Yes, this API just supports drivers wanting to be more RAS-aware.
It would be happy if how implement it could be separate in two part:
  - arch-specific part
     Capability would depend on arch, can only generic thing but couldn't
     be device specific. Device/bus isolation could be(with help of hotplug
     and so on), but re-enable them would not be easily.
  - generic part
     Capability would depend on drivers, should be more device specific.
How divide and connect them is now in discussion and consideration.

> So how should we handle it?  Obviously the driver may not be executing
> when a PCI parity error occurs, so we probably get to find out about
> this through some architecture-specific whole-system error, let's call
> it an MCA.
> 
> The MCA handler has to go and figure out what the hell just happened
> (was it a DIMM error, PCI bus error, etc).  OK, fine, it finds that it
> was an error on PCI bus 73.  At this point, I think the architecture
> error handler needs to call into the PCI subsystem and say "Hey, there
> was an error, you deal with it".
> 
> If we're lucky, we get all the information that allows us to figure
> out which device it was (eg a destination address that matches a BAR),
> then we could have a ->error method in the pci_driver that handles it.
> If there's no ->error method, at leat call ->remove so one device only
> takes itself down.
> 
> Does this make sense?

Note that here is a difficulty: the MCA handler on some arch would run on
special context - MCA environment. In other words, since some MCA handler
would be called by non-maskable interrupt(e.g. NMI), so it's difficult to
call some driver's callback using protected kernel locks from MCA context.

Therefore what MCA handler could do is just indicates a error was there,
by something like status flag which drivers can refer. And after possible
deley, we would be able to call callbacks.


Thanks,
H.Seto

