Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTEZNFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTEZNFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:05:50 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:8965 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264372AbTEZNFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:05:49 -0400
Date: Mon, 26 May 2003 15:18:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: mika.penttila@kolumbus.fi, <rmk@arm.linux.org.uk>, <akpm@digeo.com>,
       <hugh@veritas.com>, <LW@karo-electronics.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
 least))
In-Reply-To: <20030525.223655.123997551.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305261414060.12110-100000@serv>
References: <3ED1A0FE.3000101@kolumbus.fi> <20030525.220852.42800415.davem@redhat.com>
 <3ED1A7E2.6080607@kolumbus.fi> <20030525.223655.123997551.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 May 2003, David S. Miller wrote:

> flush_dcache_page() or some architecture level equivalent belongs
> whereever the kernel uses CPU store instructions to modify a page's
> contents.
> 
> When IDE uses PIO to do a data transfer, the flush belongs there.
> Right now this is occuring in the architecture defined IDE insw/outsw
> macros.  It very well might be more efficient to do this at a higher
> level where the total extent of the I/O is known.

I'd prefer not to do this at driver level at all and rather let the user 
of the data do it. The driver doesn't know how this page will be used, so 
it has to assume the worst case.
E.g. for normal read calls there isn't a cache flush needed after a PIO 
transfer and if the page is mapped nonexecutable, there is no page flush 
needed either for physical caches.
It's also not just IO, a normal write call will dirty the page as well, so 
before we map a page into userspace it's IMO the best time to synchronize 
the caches. update_mmu_cache() might be a bad place for this as this is 
called after set_pte().

bye, Roman


