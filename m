Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTE0Kkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbTE0Kkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:40:46 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:42756 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263212AbTE0Kko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:40:44 -0400
Date: Tue, 27 May 2003 12:53:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: mika.penttila@kolumbus.fi, <rmk@arm.linux.org.uk>,
       Andrew Morton <akpm@digeo.com>, <hugh@veritas.com>,
       <LW@karo-electronics.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
 least))
In-Reply-To: <20030526.153415.41663121.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305270111370.5042-100000@serv>
References: <3ED1A7E2.6080607@kolumbus.fi> <20030525.223655.123997551.davem@redhat.com>
 <Pine.LNX.4.44.0305261414060.12110-100000@serv> <20030526.153415.41663121.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 26 May 2003, David S. Miller wrote:

>    I'd prefer not to do this at driver level at all and rather let the
>    user of the data do it.
> 
> This is an easy thing to say, but you have to recognize that PIO
> based data transfers must retain the EXACT behavior required of
> real DMA transfers, which is that a subsequent user mapping of the
> data must be able to see the data without an intervening
> flush_dcache_page() or similar.
> 
> You can STILL optimize this the way you seem to want to.  The
> update_mmu_cache() routing exists as a point at which you can
> do such deferred situation-based flushing optimizations.
> 
> F.e. at ide_insw() time you mark pages as "might_need_flush" with
> some bit in page->flags, we even have bits allocated for arch specific
> use and we can allocate 1 or 2 more if you need them.  Then at
> update_mmu_cache() time you check this bit and act accordingly.

I thought about this before, but I don't think there is much to optimize. 
The PG_arch_1 bit is the only optimization which makes sense and setting 
it by default to dirty, makes it a lot easier for PIO drivers. PIO 
transfers are really the smallest problem as drivers write only into not 
uptodate and so not mapped pages. We have to be more careful with other 
writes, that they always call flush_dcache_page().
The point I don't like about update_mmu_cache() is that it's called 
_after_ set_pte(). Practically it's maybe not a problem right now, but 
the cache synchronization should happen before set_pte().

bye, Roman

