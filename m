Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWDLROk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWDLROk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWDLROk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:14:40 -0400
Received: from detroit.securenet-server.net ([209.51.153.26]:36515 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932258AbWDLROj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:14:39 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ian Romanick <idr@us.ibm.com>
Subject: Re: Special handling of sysfs device resource files?
Date: Wed, 12 Apr 2006 10:14:35 -0700
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <443C1ECA.1040308@us.ibm.com> <443C42EA.1050608@us.ibm.com>
In-Reply-To: <443C42EA.1050608@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604121014.35765.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 11, 2006 4:59 pm, Ian Romanick wrote:
> Ian Romanick wrote:
> > I'm in the process of modifying X to be civilized in it's handling
> > of PCI devices on Linux.  As part of that, I've modified it to map
> > the /sys/bus/pci/device/*/resource[0-6] files instead of mucking
> > about with /dev/mem.
> >
> > This seems to mostly work, but I am having one problem.  I map the
> > region by opening the file with O_RDWR, then mmap with
> > (PROT_READ|PROT_WRITE) and MAP_SHARED.  In all cases, the open and
> > mmap succeed.  However, for I/O BARs, the resulting pointer from
> > mmap is invalid.  Any access to it results in a segfault and GDB
> > says it's "out of range".
>
> I was a little mistaken about this.  The BAR that causes the problem
> is not I/O.  It *is* memory.
>
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450
> (rev 03) (prog-if 00 [VGA])
>         Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
>         Flags: bus master, medium devsel, latency 64, IRQ 11
>         Memory at cc000000 (32-bit, prefetchable) [size=32M]
>         Memory at cfefc000 (32-bit, non-prefetchable) [size=16K]
>         Memory at cf000000 (32-bit, non-prefetchable) [size=8M]
>         Expansion ROM at cfee0000 [disabled] [size=64K]
>
> When I open and mmap resource0 (the framebuffer) I get 0x2b9aa48ea000.
> When I open and mmap resource1 (the card's registers) I get
> 0x2b9aa68ea000.  I can access the resource0 pointer all day long
> without problems.  The firs access to the resource1 pointer results in
> a segfault.

Hm, that's strange.  On my via machine I can access all my VGA resources 
correctly, but that's not x86-64.  Maybe the x86-64 implementation of 
pci_mmap_page_range is doing the wrong thing for uncacheable, non-WC 
regions somehow?

Jesse
