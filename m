Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWJXGz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWJXGz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 02:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWJXGz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 02:55:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:9132 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932279AbWJXGz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 02:55:28 -0400
Subject: pci_set_power_state() failure and breaking suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux1394-devel@lists.sourceforge.net
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 16:54:58 +1000
Message-Id: <1161672898.10524.596.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I noticed a small regression that I think might uncover a deeper
issue...

Recently, ohci1394 grew some "proper" error handling in its suspend
function, something that looks like:

        err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
        if (err)
                goto out;

First, it breaks some old PowerBooks where the internal OHCI had PM
feature exposed on PCI (the pmac specific code that follows those lines
is enough on those machines).

That can easily be fixed by removing the if (err) goto out; statement
and having the pmac code set err to 0 in certain conditions, and I'll be
happy to submit a patch for this.

However, this raises the question of do we actually want to prevent
machines to suspend when they have a PCI device that don't have the PCI
PM capability ? I'm asking that because I can easily imagine that sort
of construct growing into more drivers (sounds logical if you don't
think) and I can even imagine somebody thinking it's a good idea to slap
a __must_check on pci_set_power_state() ... 

I think the answer is not simple. For a lot of devices, it will be
harmless, they will be either unaffected by the sleep transition or
powered down and back up, and the driver will cope just fine. I suppose
there can be issues for devices that do not support it, though none
obvious comes to mind.

It's one of those policies that are hard to define. But I think the best
approach for now is to not fail the suspend when pci_set_power_state()
returns an error.

Ben.


