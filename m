Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbTGHStU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbTGHStU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:49:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30732 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265234AbTGHStT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:49:19 -0400
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re:  siimage, 2.5.74 and irq 19: nobody cared!
Date: Tue, 08 Jul 2003 12:03:48 -0700
Organization: Open Source Development Labs
Message-ID: <1057691029.191785@palladium.transmeta.com>
References: <bee8s6$jqf$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: palladium.transmeta.com 1057691029 27164 127.0.0.1 (8 Jul 2003 19:03:49 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Jul 2003 19:03:49 GMT
User-Agent: KNode/0.7.2
Cache-Post-Path: palladium.transmeta.com!unknown@torvalds-home.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
>
> I was running 2.5.72-mm2 on our transit usenet news server
> (700 GB in/day and 1 TB out/day) which ran just fine, until I
> had some ext3 corruption on the /news partition. I remember
> having seen something about this in the -mm changelogs.
> 
> So I tried 2.5.74 and 2.5.74-mm2, but with those kernels the
> siimage.c driver doesn't work. The card is detected, but a bit
> later in the boot process its IRQ is disabled and it won't work.

Ok. Can you send me the "lspci -vxx" output for your IDE chip?

The most likely reason for the breakage is that the siimage thing claims it
isn't a proper IDE storage device in legacy mode, and that means that newer
kernels won't try to probe for interrupts: they will just use the PCI
interrupt directly. That helps on machines with shared interrupts where
probing really doesn't work that well, but it can cause problems if the
PCI IDE controller is confused (and tries to implement a legacy IDE device,
but does it wrong).

If this is indeed the problem, then you could try fixing it by adding these
two lines to the top of  init_chipset_siimage():

        /* Mark it as a IDE device in legacy mode! */
        dev->class = (PCI_CLASS_STORAGE_IDE << 8) | 0;

which just tells the IDE layer that it's not a regular PCI device and might
be using the legacy ISA interrupts - so that the code will know to probe
for them.

                Linus

