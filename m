Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263115AbUJ1W4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbUJ1W4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUJ1WzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:55:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:42887 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263041AbUJ1WzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:55:03 -0400
Subject: Re: Concerns about our pci_{save,restore}_state()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20041028213139.GC10049@kroah.com>
References: <1098677182.26697.21.camel@gaston>
	 <20041028213139.GC10049@kroah.com>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 08:50:09 +1000
Message-Id: <1099003810.29689.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-28 at 16:31 -0500, Greg KH wrote:
> On Mon, Oct 25, 2004 at 02:06:22PM +1000, Benjamin Herrenschmidt wrote:
> > Hi Greg !
> > 
> > I was looking at our "generic" pci_save_state() and pci_restore_state()
> > and I have various concerns with them, I was wondering what you though
> > about them...
> 
> Note, these concerns are the same before the last pci_save_state()
> changes, right?  I didn't break anything new did I?  :)

Yes, those are generic concerns I had for a while :)

> >  - We should always write the command register after all the BARs,
> > typically that mean write it back _last_
> 
> Hm, probably.  I'm away from my PCI book, so I don't really know about
> that one.  For some reason we've been ok so far...

Proably not a problem in 99% of the cases, but sounds saner to do (oh,
and did I tell you that Darwin does this ? :) I think it may even be
better to 1) turn IO & MEM off in the command reg, 2) restore the stuff,
3) restore the command reg.

> >  - We shouldn't write to the BIST register, it is defined as having
> > side effects and writing to it any value may trigger a BIST on the
> > card, with all the possible bad consequences that has
> 
> yeah, good point.  I guess most of these cards don't have BIST stuff in
> them.  Or just writing back the read value is sane.  I'll dig through
> the PCI book next week.

Well, some cards will have side effects, whatever you write there (like
going offline for a while, remember that thread about those nasty IBM
scsi controllers needing special workaround for this ? :)

> We need to have a "bridge" driver for something like that.  I think lots
> of things would benifit if we had that.  But if we had that, we need a
> way to overload (or weight) different drivers that might bind to the
> same device.

Yes, which is why, in the meantime, just knowing about them in
save/restore and just saving/restoring a bit more is an acceptable
solution I think ....
 
>   This is something that we've talked about for a while now,
> and it's on my list of things to do in the near future.  I think once we
> get that, a "generic" bridge driver will be ok to have.  Any hardware
> specific quirks needed can also just be their own driver (I think Red
> Hat ran into odd issues when they tried to add a pci bridge driver to
> one of their older kernel trees.)
> 
> Oh, and yeah, we should probably save and restore pci express config
> space too.  I need to go look to see if pci x 2.0 also has a expanded
> config or not...
> 
> thanks,
> 
> greg k-h
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

