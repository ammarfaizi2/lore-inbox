Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWFNVHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWFNVHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWFNVHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:07:32 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:42717 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932323AbWFNVHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:07:31 -0400
Message-ID: <44907A8E.1080308@myri.com>
Date: Wed, 14 Jun 2006 17:07:26 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: arjan@linux.intel.com
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC] PCI extended conf space when MMCONFIG disabled because of e820
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

We have some machines here where MMCONFIG is disabled in 2.6.17 because
their MCFG area is not e820-reserved. It makes the extended PCI config
space unavailable to pci_read/write_config_foo(). I don't know if lots
of people out there use the extended config space, but at least we do in
our myri10ge driver.

What would you think of a patch implementing the following strategy:
1) if MMCONFIG works, always use it (no change)
2) if MMCONFIG is disabled and we are accessing the regular config
space, use direct conf (no change, should ensure that any machine will
still boot fine)
3) if MMCONFIG is disabled but we are accessing the _extended_ config
space, try mmconfig anyway since there's no other way to do it.

Actually, this problem seems to target nVidia chipsets, and we actually
know how to check this chipset's registers to be sure whether MMCONFIG
works. So it might be good to improve the current MMCONFIG disabling
code by adding some chipset-specific hacks (having nVidia and Intel
chipsets there may cover most of the cases). I don't think there's any
way to do that with PCI quirks. We might end up having these hacks in
the MMCONFIG initialization code.

Thanks,
Brice

