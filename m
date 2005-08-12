Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVHLWdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVHLWdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 18:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVHLWdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 18:33:46 -0400
Received: from nef2.ens.fr ([129.199.96.40]:8208 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932114AbVHLWdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 18:33:45 -0400
Date: Sat, 13 Aug 2005 00:33:42 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel Mailing-List <linux-kernel@vger.kernel.org>
Subject: [slightly OT] what's in RAM at 0x3ffe5000 ?
Message-ID: <20050812223342.GA283@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sat, 13 Aug 2005 00:33:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have ECC RAM on my system and I wanted to check it, so (because
there doesn't seem to be any Linux ECC support for my P5WD2
motherboard) I wrote my own kernel module[#] to interrogate the
northbridge.  I was a little annoyed to find that the northbridge had
reported an ECC error, and a multi-bit uncorrectable error at that!,
at memory location 0x3ffe5000.  I cleared the error flag and ran
multiple checks and couldn't find any other error, so I stared
thinking about this address I realized that it was very near the top
of memory (I have 1GB RAM).  In fact, it is reported as "reserved" by
Linux:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 000000003ff8e000 (ACPI data)
 BIOS-e820: 000000003ff8e000 - 000000003ffe0000 (ACPI NVS)
 BIOS-e820: 000000003ffe0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)

Now /dev/mem won't work that far so I can't read what's there, but I
suspect there's something very strange in that place and the ECC error
reported by the northbridge is not really an error.  Interestingly
enough, I always get an error at 0x3ffe5000 when I boot, and then
later on I get an error at 0x3fff0580.  This is consistent: I always
get those "errors" at the same memory locations, and they're always
multiple-bit errors.

So here are my questions:

* What does "reserved" mean in the BIOS physical RAM table?  Reserved
by whom?  Who owns my memory?  Do all my base are belong to him?

* What's the simplest way, under Linux (whether in userspace or in
kernel), to read the contents of a _physical_ memory location, given
that /dev/mem won't do it:

vega david ~ $ sudo dd if=/dev/mem bs=4096 count=1 skip=262117 of=/tmp/page
dd: reading `/dev/mem': Bad address
0+0 records in
0+0 records out
0 bytes transferred in 0.000118 seconds (0 bytes/sec)

* Why am I getting ECC errors in this strange place, and only there?
Do I need to worry about them?  (I mean, if it's something strange
like memory-mapped I/O I would expect the northbridge to know about it
and not report an error!)

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )

[#] Source available on demand - it's pretty damn ugly, I wouldn't
want Mr. Torvalds to see it!
