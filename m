Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbTA3SSB>; Thu, 30 Jan 2003 13:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTA3SSA>; Thu, 30 Jan 2003 13:18:00 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:62382 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267578AbTA3SR7>; Thu, 30 Jan 2003 13:17:59 -0500
Date: Thu, 30 Jan 2003 10:35:25 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: pci_set_mwi() ... why isn't it used more?
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Message-id: <3E39706D.6080400@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3E2C42DF.1010006@pacbell.net> <20030120190055.GA4940@gtf.org>
 <3E2C4FFA.1050603@pacbell.net> <20030130135215.GF6028@krispykreme>
 <3E3951E3.7060806@pacbell.net> <20030130195944.A4966@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> 
> Hmm, what happens if you boot the kernel configured for 80386
> on P4 and enable MWI?

Which answer is better?

  - It works safely:  pci cache line size not less than the real one.

  - There's I/O-pattern dependant breakage caused by that config goof.

I think the first answer is better, but it looks like 2.5.59 will
set the pci cache line size to 16 bytes not 128 bytes in that case.

The generic pci code to set cacheline size uses SMP_CACHE_BYTES,
which is usually L1_CACHE_BYTES ... and looks incorrect at least on
non-SMP ia64.  Only sparc64 seems to have non-generic code to set
the line size but it's done for all devices, as they're probed.

Maybe i386 should HAVE_ARCH_PCI_MWI, smart enough to use the actual
CPU's cache line size (boot code saves that, yes?) and maybe even
check for that particular class of breakage Anton mentioned.

Another option would be to do like SPARC64 and set the cacheline
sizes as part of DMA enable (which is what I'd first thought of).
And have the breakage test in the ARCH_PCI_MWI code -- something
that sparc64 doesn't do, fwiw.

- Dave




