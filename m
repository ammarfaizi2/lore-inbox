Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWJEXVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWJEXVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWJEXVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:21:09 -0400
Received: from mail.suse.de ([195.135.220.2]:7348 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751417AbWJEXVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:21:06 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Fri, 6 Oct 2006 01:21:01 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <200610060052.46538.ak@suse.de> <Pine.LNX.4.64.0610051600440.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051600440.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060121.01461.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If we had the
> 
> 	void __iomem *cfg = mmiocfg_remap(dev);
> 
> interface, we could (fairly easily) blacklist known-bad motherboards if we 
> needed to,

With the bad Intel reference BIOS that's far too many.

I've considered using PCI-IDs but even with that it would be quite messy.

> For example, for some devices, maybe they'd lose some error handling 
> capability, but they'd still be able to work otherwise.

AFAIK that's always the case right now. Jeff's secret NDA device
is the only known exception so far.
 
> We _can_ do the same thing with checking the error return value from 
> "pci_read_config_xxxx()",

Problem is you get a hang at least on the Intel boards, not a -1

> I dunno. I'm not likely to care _that_ deeply about this all, but I do 
> think that machines that hang on device discovery is just about the worst 
> possible thing, so I'd much rather have ten machines that can't use their 
> very rare devices without some explicit kernel command line than have even 
> _one_ machine that just hangs because MMIOCFG is buggered.

Actually they don't hang at discovery, but at the verify step we early use
to decide if mcfg works or not (we go through a few busses and compare
type 1 and mcfg). This is currently separate from the normal discovery
to not burden the generic code with it.

To be fair one issue is that the verify step current ignores the ACPI
information about how many busses there are, but iirc the Intel board hung 
pretty early so it likely wouldn't have helped there anyways.

At some point there was hope if checking the MCFG against other
ACPI resources would catch it, but it didn't at least on the board
I tested on.

> (And we should probably have the "pci=mmiocfg" kernel command line entry 
> that forces MMIOCFG regardless of any e820 issues, even for normal 
> accesses).

Yes that would be a good change.

-Andi
