Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbUJ1V5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUJ1V5o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbUJ1VzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:55:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:182 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262920AbUJ1Vvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:51:38 -0400
Date: Thu, 28 Oct 2004 16:31:39 -0500
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: Concerns about our pci_{save,restore}_state()
Message-ID: <20041028213139.GC10049@kroah.com>
References: <1098677182.26697.21.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098677182.26697.21.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 02:06:22PM +1000, Benjamin Herrenschmidt wrote:
> Hi Greg !
> 
> I was looking at our "generic" pci_save_state() and pci_restore_state()
> and I have various concerns with them, I was wondering what you though
> about them...

Note, these concerns are the same before the last pci_save_state()
changes, right?  I didn't break anything new did I?  :)

>  - We should always write the command register after all the BARs,
> typically that mean write it back _last_

Hm, probably.  I'm away from my PCI book, so I don't really know about
that one.  For some reason we've been ok so far...

>  - We shouldn't write to the BIST register, it is defined as having
> side effects and writing to it any value may trigger a BIST on the
> card, with all the possible bad consequences that has

yeah, good point.  I guess most of these cards don't have BIST stuff in
them.  Or just writing back the read value is sane.  I'll dig through
the PCI book next week.

>  - What about saving/restoring more registers ? I'm not sure wether it
> should be the responsibility of the driver to save and restore things
> above dword 15, but we should at least deal with the case of P2P bridges
> who have more "standard" registers

We need to have a "bridge" driver for something like that.  I think lots
of things would benifit if we had that.  But if we had that, we need a
way to overload (or weight) different drivers that might bind to the
same device.  This is something that we've talked about for a while now,
and it's on my list of things to do in the near future.  I think once we
get that, a "generic" bridge driver will be ok to have.  Any hardware
specific quirks needed can also just be their own driver (I think Red
Hat ran into odd issues when they tried to add a pci bridge driver to
one of their older kernel trees.)

Oh, and yeah, we should probably save and restore pci express config
space too.  I need to go look to see if pci x 2.0 also has a expanded
config or not...

thanks,

greg k-h
