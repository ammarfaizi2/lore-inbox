Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUAFBMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266057AbUAFBMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:12:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:32960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266056AbUAFBL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:11:59 -0500
Date: Mon, 5 Jan 2004 17:11:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Hinds <dhinds@sonic.net>
cc: linux-kernel@vger.kernel.org, Amit <mehrotraamit@yahoo.co.in>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <20040105164423.A30738@sonic.net>
Message-ID: <Pine.LNX.4.58.0401051707390.2170@home.osdl.org>
References: <20040105120707.A18107@sonic.net> <Pine.LNX.4.58.0401051630190.2170@home.osdl.org>
 <20040105164423.A30738@sonic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, David Hinds wrote:
> 
> The original problem was actually that grub was passing a bogus mem=
> parameter to the kernel that was 4K too small, I guess because it was
> intending to indicate the amount of "available" memory (the top 4K is
> reserved for ACPI).  If highmem had not been enabled, the above code
> would have corrected the problem; but with highmem, the computed
> low_mem_size was incorrect.  I would say that grub is just broken and
> is misusing the mem= parameter, but this has been a problem for years
> and they don't seem interested in fixing it.

Hmm.. I suspect that it might be ok to check "max_pfn" for being less than 
4GB, and use that if so. Add something like

	if (max_pfn < 0x100000)
		if (pci_mem_start < (max_pfn << PAGE_SHIFT))
			pci_mem_start  = max_pfn << PAGE_SHIFT;

to that sequence too.. I dunno. Ugly as hell. The basic issue is that if
the kernel doesn't know the RAM layout, there's no way it will get things
right all the time, so e820 or another other "good" memory layout should
really always be used.

"mem=xxx" really doesn't work too well on modern machines. The issue is 
just too complex, with RAM that is reserved etc..

		Linus
