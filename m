Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTIUVmt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 17:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTIUVmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 17:42:49 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:54013 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262573AbTIUVmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 17:42:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16238.6997.367589.302883@gargle.gargle.HOWL>
Date: Sun, 21 Sep 2003 23:42:45 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Matt Hahnfeld <matth@everysoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SLOW machine when HIGHMEM enabled (1gb memory, kernel 2.4.22)
In-Reply-To: <Pine.LNX.4.44.0309211657470.12232-100000@sotec>
References: <16238.2932.99763.591328@gargle.gargle.HOWL>
	<Pine.LNX.4.44.0309211657470.12232-100000@sotec>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Hahnfeld writes:
 > Mikael --
 > 
 > Thanks for the help!
 > 
 > I have posted my /proc/mtrr and /proc/meminfo to
 > http://www.layover.com/matt/kernel/ .

Hmm, I wanted the list to seem them because I'm not myself
very good at decoding memory maps and mtrrs.

Anyway, Matt's E820 map is

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f730000 (usable)
 BIOS-e820: 000000003f730000 - 000000003f740000 (ACPI data)
 BIOS-e820: 000000003f740000 - 000000003f7f0000 (ACPI NVS)
 BIOS-e820: 000000003f7f0000 - 000000003f800000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
119MB HIGHMEM available.
896MB LOWMEM available.

while his /proc/mtrr is

reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
reg05: base=0x3e000000 ( 992MB), size=  16MB: write-back, count=1

Hmm, it looks like your mtrr mappings end just before 0x3f000000,
but your E820 map marked 0x3f000000 to 0x3f730000 as "usable".

This probably means that some piece of memory the kernel is using
isn't cached. No wonders your performance sucks.

The BIOS seems to have done a poor job here. I guess the safest
workaround is to pass a mem= parameter to the kernel, causing
it to skip that problematic uncached portion.

mem=1008M perhaps?

/Mikael
