Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVAKDap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVAKDap (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVAKD3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:29:43 -0500
Received: from holomorphy.com ([207.189.100.168]:15801 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262557AbVAKD1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:27:11 -0500
Date: Mon, 10 Jan 2005 19:26:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: panic when munmap()ping the stack
Message-ID: <20050111032655.GF2696@holomorphy.com>
References: <1105401719.4153.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105401719.4153.2.camel@localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 04:01:58PM -0800, Jeremy Fitzhardinge wrote:
> This program causes an instant panic for me:
>         #include <sys/mman.h>
>         int main(int argc, char **argv)
>         {
>         	munmap((char *)(((unsigned long)&argc) & ~4095), 4096*2);
>         
>         	return 0;
>         }
> I'm not sure if setting the signal handler is necessary or not.  My
> environment is largeish, so the stack is 2 pages; you might need to
> adjust it.
> There's a message on the console saying something like "panic: bad pgd:
> 0x00000e13".  It was a bit too quick to see.
> Plain 2.6.10 segfaults as expected; I haven't tried -mm1 to see what it
> does.
> Config attached.

$ grep -nr pgd_ERROR .
./arch/i386/kernel/vm86.c:151:          pgd_ERROR(*pgd);
./arch/arm/mm/fault-armv.c:67:  pgd_ERROR(*pgd);
./arch/sh/mm/init.c:94:         pgd_ERROR(*pgd);
./arch/m68k/atari/stram.c:679:          pgd_ERROR(*dir);
./arch/ppc64/mm/init.c:327:             pgd_ERROR(*dir);
./arch/parisc/kernel/pci-dma.c:206:             pgd_ERROR(*dir);
./arch/parisc/mm/kmap.c:116:            pgd_ERROR(*dir);
./mm/swapfile.c:530:            pgd_ERROR(*pgd);
./mm/msync.c:106:               pgd_ERROR(*pgd);
./mm/memory.c:162:              pgd_ERROR(*pgd);
./mm/memory.c:446:                      pgd_ERROR(*src_pgd);
./mm/memory.c:580:              pgd_ERROR(*pgd);
./mm/vmalloc.c:95:              pgd_ERROR(*pgd);
./mm/mprotect.c:100:            pgd_ERROR(*pgd);
(includes etc.)

Anyway, it's blatant pagetable corruption. Does binary searching -mm2
reveal anything?


-- wli
