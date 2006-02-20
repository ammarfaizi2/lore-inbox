Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWBTL0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWBTL0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWBTL0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:26:03 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:32690 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932586AbWBTL0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:26:02 -0500
Date: Mon, 20 Feb 2006 14:26:00 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, bjk@luxsci.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Bugzilla: PCI resource address mismatch
Message-ID: <20060220142600.A25613@jurassic.park.msu.ru>
References: <43F91283.4050307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <43F91283.4050307@gmail.com>; from adaplas@gmail.com on Mon, Feb 20, 2006 at 08:51:15AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:51:15AM +0800, Antonino A. Daplas wrote:
> Ben Kibbey reported that vesafb has stopped working for him for kernels newer than
> 2.6.12. His display is completely blanked. After a long debugging session, we noted
> that the address of resource 0 of his VGA controller as reported by lspci does not
> match what is reported by the BIOS.
> 
> More details:
> 
> In the working kernel (2.6.12.x), vesafb correctly ioremap's the framebuffer memory
> located at 0xff000000.  lspci reports the same thing:
> 
> PCI: Using IRQ router SIS [1039/0008] at 0000:00:01.0
> PCI: Cannot allocate resource region 9 of bridge 0000:00:02.0

There are two bogus entries in the BIOS memory map table which are
conflicting with a prefetchable memory range of the AGP bridge:

 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

0000:00:02.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e7e00000-e7efffff
	Prefetchable memory behind bridge: fec00000-ffcfffff
					   ^^^^^^^^^^^^^^^^^

Starting from 2.6.13, kernel tries to resolve that sort of conflicts,
so that prefetch window of the bridge and the framebuffer memory behind
it get moved to 0x10000000.
Unfortunately, video BIOS still expects the framebuffer to be at 0xff000000,
that's why vesafb doesn't work.

Booting with "mem=64M" (or what amount of RAM he has) should fix that,
as it causes the kernel to ignore e820 entries above 64M.

Ivan.
