Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVHHOMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVHHOMU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVHHOMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:12:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24451
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932069AbVHHOMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:12:19 -0400
Date: Mon, 08 Aug 2005 07:12:11 -0700 (PDT)
Message-Id: <20050808.071211.74753610.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: linville@redhat.com, torvalds@osdl.org
Subject: pci_update_resource() getting called on sparc64
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some recent change last week causes pci_update_resource()
to be invoked on sparc64 now, and this is why my workstation
couldn't cleanly boot into current 2.6.13 when I tried to
remotely try out some new kernels while I was in the UK.

This thing is supposed to only be invoked if you support
power management, and therefore we made it just BUG() on
sparc64.

But some change last week causes it to be invoked when
the radeonfb driver registers a device, and that's why
my workstation failed to boot up current 2.6.13 kernels.

pci_restore_bars() is the only invoker of pci_update_resource()
and that should only be invoked by pci_set_power_state() if
the local variable "need_restore" is set, which occurs if

	if (dev->current_state >= PCI_D3hot) {
		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
			need_restore = 1;

and I don't see how that can happen to my radeon which is
fully operational when the kernel boots and the radeon device
is registered.

I'm tempted to just make pci_update_resource() not BUG() any
longer, but that definitely feels like the wrong way to fix
this.  And in any event, I'd like to get this fixed before
2.6.13 goes out the door.

Does anyone have a clue what change made last week could have
made this start happening?
