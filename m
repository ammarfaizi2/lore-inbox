Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVHHTnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVHHTnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHHTnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:43:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:50560 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932240AbVHHTnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:43:23 -0400
Date: Mon, 8 Aug 2005 12:42:49 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
Message-ID: <20050808194249.GA6729@kroah.com>
References: <20050808.103304.55507512.davem@davemloft.net> <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com> <20050808.123209.59463259.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808.123209.59463259.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 12:32:09PM -0700, David S. Miller wrote:
> From: Greg KH <greg@kroah.com>
> Date: Mon, 8 Aug 2005 09:08:46 -0700
> 
> > On Mon, Aug 08, 2005 at 11:32:41AM -0700, Linus Torvalds wrote:
> > > 
> > > Not likely.
> > > 
> > > Sounds like fec59a711eef002d4ef9eb8de09dd0a26986eb77, which came in 
> > > through Greg. I'm surprised Greg didn't pick up on that one.
> > 
> > I didn't pick up on that one, as David acked it a while ago :)
> > 
> > {sigh}  I only pushed that one as Ralf insisted that he needed it for
> > some of his hardware and that there wasn't any bad side-affects.  Ralf,
> > any objections to removing this for 2.6.13?
> 
> But this is so puzzling, because this code path should only trigger
> if the device is not in D0 state.  There is no way any of the devices
> in my sparc64 box should be in any powered down state at bootup
> time.  Unless the kernel would do that, which I hope it does not.
> 
> Therefore, I can't figure out how this code path could even trigger.
> 
> It happens for every device in my machine, my primary framebuffer
> radeonfb, my e1000, the tg3 card in the machine.  In short, every
> single PCI device triggers this when it registers.
> 
> I think something fishy is going on here, and the sparc64 BUG()
> is just a symptom.  Why are devices in D3hot state at bootup?
> 
> And lo' and behold, we find the answer in the PCI probing code.
> It initializes every PCI device's PCI power state to "unknown":
>  
> 	/* "Unknown power state" */
> 	dev->current_state = 4;
> 
> and thus makes this test ">= D3hot" pass in the pci_set_power_state()
> code.

Crap, gotta love >= checks on enumerated types...

Linus, can you just revert that changeset for now?  That will sove
David's problem, and I'll work on getting this patch working properly
for after 2.6.13 is out.

Hm, how do you revert a git patch?

thanks,

greg k-h
