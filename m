Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVHHTcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVHHTcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVHHTcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:32:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6377
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932210AbVHHTcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:32:20 -0400
Date: Mon, 08 Aug 2005 12:32:09 -0700 (PDT)
Message-Id: <20050808.123209.59463259.davem@davemloft.net>
To: greg@kroah.com
Cc: torvalds@osdl.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050808160846.GA7710@kroah.com>
References: <20050808.103304.55507512.davem@davemloft.net>
	<Pine.LNX.4.58.0508081131540.3258@g5.osdl.org>
	<20050808160846.GA7710@kroah.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Mon, 8 Aug 2005 09:08:46 -0700

> On Mon, Aug 08, 2005 at 11:32:41AM -0700, Linus Torvalds wrote:
> > 
> > Not likely.
> > 
> > Sounds like fec59a711eef002d4ef9eb8de09dd0a26986eb77, which came in 
> > through Greg. I'm surprised Greg didn't pick up on that one.
> 
> I didn't pick up on that one, as David acked it a while ago :)
> 
> {sigh}  I only pushed that one as Ralf insisted that he needed it for
> some of his hardware and that there wasn't any bad side-affects.  Ralf,
> any objections to removing this for 2.6.13?

But this is so puzzling, because this code path should only trigger
if the device is not in D0 state.  There is no way any of the devices
in my sparc64 box should be in any powered down state at bootup
time.  Unless the kernel would do that, which I hope it does not.

Therefore, I can't figure out how this code path could even trigger.

It happens for every device in my machine, my primary framebuffer
radeonfb, my e1000, the tg3 card in the machine.  In short, every
single PCI device triggers this when it registers.

I think something fishy is going on here, and the sparc64 BUG()
is just a symptom.  Why are devices in D3hot state at bootup?

And lo' and behold, we find the answer in the PCI probing code.
It initializes every PCI device's PCI power state to "unknown":
 
	/* "Unknown power state" */
	dev->current_state = 4;

and thus makes this test ">= D3hot" pass in the pci_set_power_state()
code.

That looks very wrong.
