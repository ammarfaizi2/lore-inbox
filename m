Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWJXWnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWJXWnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbWJXWnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:43:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65511
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422772AbWJXWnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:43:43 -0400
Date: Tue, 24 Oct 2006 15:43:47 -0700 (PDT)
Message-Id: <20061024.154347.77057163.davem@davemloft.net>
To: matthew@wil.cx
Cc: rdreier@cisco.com, jeff@garzik.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, johnip@sgi.com
Subject: Re: Ordering between PCI config space writes and MMIO reads?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061024223631.GT25210@parisc-linux.org>
References: <20061024214724.GS25210@parisc-linux.org>
	<adar6wxbcwt.fsf@cisco.com>
	<20061024223631.GT25210@parisc-linux.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <matthew@wil.cx>
Date: Tue, 24 Oct 2006 16:36:32 -0600

> This is only really a problem for setup (when we program the BARs), so
> it seems silly to enforce an ordering at any other time.  Reluctantly, I
> must disagree with Jeff -- drivers need to fix this.

One thing is that we definitely don't want to fix this by,
for example, reading back the PCI_COMMAND register or something
like that.  That causes two problems:

1) Some PCI config writes shut the device down and make it
   no respond to some kinds of PCI config transactions.
   One example is putting the device into D3 or similar
   power state, another is performing a device reset.

2) Several drivers use PCI config space accesses to touch the
   main registers in order to workaround bugs in the PCI-X
   implementation of their chip or similar (tg3 has a few
   cases like this), doing a PCI config space readback will
   kill performance quite a bit for an already slow situation.

In fact, I do recall that one of the x86 PCI config space access
implementations did a readback like this, and we had to remove
it because it caused problems when doing a reset on tg3 chips
when using PCI config space register write to do the reset.
