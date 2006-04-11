Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWDLAAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWDLAAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDLAAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:00:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:17836 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751093AbWDLAAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:00:24 -0400
Message-ID: <443C42EA.1050608@us.ibm.com>
Date: Tue, 11 Apr 2006 16:59:38 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Special handling of sysfs device resource files?
References: <443C1ECA.1040308@us.ibm.com>
In-Reply-To: <443C1ECA.1040308@us.ibm.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ian Romanick wrote:
> I'm in the process of modifying X to be civilized in it's handling of
> PCI devices on Linux.  As part of that, I've modified it to map the
> /sys/bus/pci/device/*/resource[0-6] files instead of mucking about with
> /dev/mem.
> 
> This seems to mostly work, but I am having one problem.  I map the
> region by opening the file with O_RDWR, then mmap with
> (PROT_READ|PROT_WRITE) and MAP_SHARED.  In all cases, the open and mmap
> succeed.  However, for I/O BARs, the resulting pointer from mmap is
> invalid.  Any access to it results in a segfault and GDB says it's "out
> of range".

I was a little mistaken about this.  The BAR that causes the problem is
not I/O.  It *is* memory.

01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev
03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at cc000000 (32-bit, prefetchable) [size=32M]
        Memory at cfefc000 (32-bit, non-prefetchable) [size=16K]
        Memory at cf000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at cfee0000 [disabled] [size=64K]

When I open and mmap resource0 (the framebuffer) I get 0x2b9aa48ea000.
When I open and mmap resource1 (the card's registers) I get
0x2b9aa68ea000.  I can access the resource0 pointer all day long without
problems.  The firs access to the resource1 pointer results in a segfault.

> The base address of the BAR is page aligned, so its not a problem with
> the alignment of mmap vs. the alignment of the BAR.  What else could it
> be?  I'm pretty stumped.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEPELpX1gOwKyEAw8RAjT+AJ0ZzDb49tr5WwKWE7eyKWdT7hRLUQCgkOSS
twDrsx8VrWG5xEf+hbbkFvg=
=im+D
-----END PGP SIGNATURE-----
