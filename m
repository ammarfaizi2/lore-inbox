Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbUDPQJV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUDPQJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:09:21 -0400
Received: from mproxy.gmail.com ([216.239.56.247]:23754 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S263284AbUDPQJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:09:18 -0400
Message-ID: <73979326.58EE2AD2@mail.gmail.com>
Date: Fri, 16 Apr 2004 09:09:14 -0700
From: Ross Biro <ross.biro@gmail.com>
To: root@chaos.analogic.com
Subject: Re: Kernel writes to RAM it doesn't own on 2.4.24
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.53.0404161150450.542@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mem= isn't there to tell the kernel what ram it owns and what ram it
doesn't own.  It's there to tell the kernel what ram is in the system.
 Since you told the system it only has 500m, it assumes the rest of
the 3.5G of address space is available for things like memory mapped
i/o.  If you cat /proc/iomem, you'll probably see something has
reserved the memory range in question.

I added a hack to make the kernel assume the greater of the mem= and
what is passed to in from the BIOS via the e820 maps is where the
unused address space starts.  It seems to eliminate such problems.

    Ross

On Fri, 16 Apr 2004 11:55:28 -0400 (EDT), Richard B. Johnson
<root@chaos.analogic.com> wrote:
> 
> 
> Hello again,
> 
> If I start a system that has 1 Gb of memory with mem=500m,
> the value of the kernel's num_physpages is 0x20000 as would
> be expected. If I multiply that by PAGE_SIZE, I get 0x20000000,
> also as expected. If I observe that memory region, I note
> that somebody has written something there!
> 
> This is not good. The kernel touches RAM it doesn't own. I have
> booted the system with only the internal floppy controller
> and no other modules installed. I see the same thing.
> 
> Script started on Fri Apr 16 11:33:39 2004
> # monitor
>                   TMD Platinum(tm) Control System Version 2.0
>                  Copyright(c) 1999-2003, Analogic Corporation
> 
>   Enter "help" for commands
> 
> PLATINUM> dump=20000000
> 20000000  78 56 34 12 21 43 65 87-FF FF FF FF FF FF FF FF   xV4.!Ce.........
> 20000010  FF FF FF FF FF FF FF FD-FF FF FF FF FF FF FF FF   ................
> 20000020  FF FF FF FF FF FE FF FF-FF FF FE FF FF FF FF FF   ................
> [SNIPPED...]
> 
> My temporary work around for the kernel's destroying a
> precious DMA buffer is to start one page higher. However,
> whomever is writing to that RAM is likely writing other
> places it doesn't belong also. This could lead to some
> very interesting bugs.
> 
> Note that the value written there is 0x12345678, twice, once
> in little endian and another in swap-nibble big endian, like
> a mirror. This is evil.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine (5596.77 BogoMips).
>             Note 96.31% of all statistics are fiction.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
