Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWILDIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWILDIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWILDIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:08:46 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:32438 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751175AbWILDIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:08:46 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=ILe7uU+iq/1IVqx1EA7cOPMN4FR+Q/CDIXKcjYTSwEFp/mqd5eF9kAEnc2+ESLwc02L6epGOIOMyZMB6WvIyu8ZE0gcpY1oyOgiSKIa3h3Xe67YAx4DO4BXvw3D+Y65C;
X-IronPort-AV: i="4.09,147,1157346000"; 
   d="scan'208"; a="78629945:sNHT16202124"
Date: Mon, 11 Sep 2006 22:08:48 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Message-ID: <20060912030848.GA18381@lists.us.dell.com>
References: <20060908031422.GA4549@lists.us.dell.com> <20060908155639.GJ28592@redhat.com> <20060908161817.GA12642@lists.us.dell.com> <1157734517.30730.103.camel@laptopd505.fenrus.org> <4505BAA6.20002@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505BAA6.20002@tmr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 03:36:06PM -0400, Bill Davidsen wrote:
> Arjan van de Ven wrote:
> >Maybe the kernel's initial ordering should do a numeric sort by mac
> >address or something.. (or userspace should)
> >
> That wouldn't match any existing setup, and would be subject to mid-list 
> insertions if a NIC were added/replaced. And that is fragile.
> 
> I was looking for an easy way to do PCI slot to MAC, and from there MAC 
> to IP, so any NIC plugged into a given slot could be called eth0 (for 
> instance) and given the "right" IP address, but that's not easy. Can be 
> done with some searching in /sys, but it's non-trivial.

So, I did almost this in
userspace. http://linux.dell.com/files/name_eths/.  It uses the PCI
IRQ Routing table to determine if a PCI device is embedded on the
motherboard, or is in an add-in slot, and if so, which slot.  It
orders the list of thereby possible PCI NICs with all the embeddeds
first, in ascending PCI breadth-first order, then orders all the
add-in NICs in PCI slot number ascending order, subsort PCI
breadth-first for those nifty multiport cards.  It rewrites
modprobe.conf to load network drivers 'proper' order and outputs an
/etc/mactab file that can be used by the second half of the script to
write HWADDR lines into Red Hat-style ifcfg-eth* files, and into
openSuSE udev ethernet rules file.

This works great, until you add another NIC into an add-in slot
somewhere in the middle (e.g. you have 2 embedded NICs eth0 and eth1,
and a NIC card in PCI slot 4 eth2, then at some later point you add a
NIC card into PCI slot 2).  You either have to manually configure a
name for the new card, or run name_eths again and expect the NIC in
PCI slot 2 to become eth2, and the one in slot4 to become eth3.

The pure C udev helper I'm working on behaves similarly, though would
negate the need to edit config files, as it assigns a name "on the
fly" at device discovery time.

For the relatively rare cases of adding a NIC, I'm OK with this.  I
don't have a better way to handle it, but am open to ideas.

We could assign names like eth-embedded-1, eth-embedded-2,
eth-slot2-1, eth-slot4-1 if we wanted to change how people think of
ethernet names (and this would be similar to how large network
switches work: blade N, port M.  We've got 15 usable chars in the name
after all...

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
