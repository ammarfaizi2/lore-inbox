Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317339AbSFCJpL>; Mon, 3 Jun 2002 05:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSFCJpK>; Mon, 3 Jun 2002 05:45:10 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:33299 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S317339AbSFCJpJ>; Mon, 3 Jun 2002 05:45:09 -0400
Message-ID: <3CFB3B87.74C7E9DF@zip.com.au>
Date: Mon, 03 Jun 2002 02:48:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
In-Reply-To: <1023096034.19717.62.camel@storm.christs.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> Hi,
> 
> Just got this (reproducible) kernel panic (BUG in
> asm-i386/highmem.h::kmap_atomic(), the if (!pte_none(*(kmap_pte-idx)))
> BUG(); triggers). It happens every time I boot and on an NFS mount do a
> ./configure.

Dunno about this one.  I'm seeing some (totally different) NFS funnies
at present - pagecache data on the client is coming up zeroes under
memory pressure.  Trond mentioned that NFS recently went to kmap_atomic,
so there is a common thread there.

> I am now seeing this error during boot as well. Don't know if it is
> related:
> 
> ---snip---
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 00:09.0: 3Com PCI 3c590 Vortex 10Mbps at 0xe800. Vers LK1.1.17
> 00:09.0: Overriding PCI latency timer (CFLT) setting of 32, new value is
> 248.
>  ***INVALID CHECKSUM 002f*** phy=0, phyx=24, mii_status=0x782d
> ---snip---
> 
> Note that on previous kernels it says:
> 
> ---snip---
> PCI: Assigned IRQ 11 for device 00:09.0
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 00:09.0: 3Com PCI 3c905C Tornado at 0xe800. Vers LK1.1.17
> phy=0, phyx=24, mii_status=0x782d
> ---snip---

It misidentified the device.  How bizarre.  3c590 is 0x10B7, 0x5900
and 3c905C is 0x10B7, 0x9200.  lspci saw the 905C OK.  Possibly the
PCI device table walking got broken or miscompiled.  Works OK here,
as does NFS client on SMP+highmem.

-
