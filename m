Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVBPIIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVBPIIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 03:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVBPIIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 03:08:20 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15241 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261910AbVBPIID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 03:08:03 -0500
Date: Wed, 16 Feb 2005 08:07:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Erik de Castro Lopo <erik.de.castro.lopo@sensorynetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 : kernel BUG at mm/rmap.c:483!
In-Reply-To: <20050216120752.4da9c36b.erik.de.castro.lopo@sensorynetworks.com>
Message-ID: <Pine.LNX.4.61.0502160655330.16056@goblin.wat.veritas.com>
References: <20050216120752.4da9c36b.erik.de.castro.lopo@sensorynetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, Erik de Castro Lopo wrote:
> 
> The problem is triggered by a user space application which 
> mmaps memory space on a custom PCI card via /dev/mem, reads 
> some data and munmaps it. The program works perfectly on a 
> 2.4.26 kernel. On 2.6.10 I get this on the console:
> 
> kernel BUG at mm/rmap.c:483!
> EIP is at page_remove_rmap+0x26/0x40
>  [<c0135a38>] zap_pte_range+0x138/0x250 ...
>  [<c0139870>] sys_munmap+0x40/0x70
> 
> Is there anything I have missed? Does /dev/mem on a 2.6
> kerel behave the same way as on a 2.4 kernel?

Yes, I believe /dev/mem handling on 2.4 and 2.6 is much the same,
but the rmap.c BUG you're hitting in 2.6 had no equivalent in 2.4 -
maybe the 2.4 case has actually been unsafe too, or maybe not.

Though there have been other reports of this BUG, some remaining
mysterious, some down to bad ram, your case is almost certainly
due to mismatched PageReserved accounting.

mmap of /dev/mem only works usefully when the mapped pages are
outside of ordinary ram, or temporarily marked PageReserved,
normally by the relevant driver.

It seems that when the user space application mapped that part of
/dev/mem, the pages were marked PageReserved, and rmap accounting
skipped.  But when the user space application unmapped that part
of /dev/mem, the pages were no longer marked PageReserved, so
rmap accounting hit the BUG.

I may be wrong, but I think it's fair to say that usually when
there's to be cooperation between driver and user space of this
kind, the driver would offer its own device and mmap entry point,
user space would be mapping that rather than /dev/mem, and file
reference counting would avoid the possibility that driver clears
PageReserved while the page is mapped.

Beyond this particular BUG, clearing PageReserved too soon is
likely to lead to freeing an already freed page - noticed with
a warning if the page is still free, but mayhem if by then reused.

Which is the driver involved?

Or, might the user space application be (arguably) at fault,
mmap'ing an indeterminate uncontrolled area of /dev/mem, some
pages of which may or may not be PageReserved at any instant?

(Yes, PageReserved is an unsatisfactory notion we should have
weaned the kernel off long ago.)

Hugh
