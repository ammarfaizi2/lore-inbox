Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTE2AAF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 20:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTE2AAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 20:00:05 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:49420 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S261743AbTE2AAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 20:00:04 -0400
Date: Thu, 29 May 2003 02:12:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: mika.penttila@kolumbus.fi, <rmk@arm.linux.org.uk>,
       Andrew Morton <akpm@digeo.com>, <hugh@veritas.com>,
       <LW@karo-electronics.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at
 least))
In-Reply-To: <20030528.154720.74745668.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305290151470.5042-100000@serv>
References: <Pine.LNX.4.44.0305270111370.5042-100000@serv>
 <20030527.142233.71088632.davem@redhat.com> <Pine.LNX.4.44.0305281827290.5042-100000@serv>
 <20030528.154720.74745668.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 May 2003, David S. Miller wrote:

>    set_pte() establishes the mapping, this means another cpu can get the pte 
>    and start reading the data e.g. into the instruction cache, but if that 
>    cpu still has dirty data in the data cache (e.g. a write() or a disk 
>    read), the following update_mmu_cache() might be too late.
>    
> If that really matters for you, your set_pte() could add this
> operation to a list of pending set_pte()'s in the mm_struct arch
> specific context area.  Then at update_mmu_cache() it runs this
> list of todo items.
> 
> I don't see the problem.

This would require quite some magic in set_pte(), as update_mmu_cache() is 
not always called after set_pte(). I'd prefer to keep flush_icache_page() 
for this, there are only a few places, which require this and it doesn't 
hurt to keep this explicit.
BTW it's a bit unfortunate that flush_dcache_page() is called for reads 
and writes. This might be needed for virtual indexed caches, but for 
icache/dcache synchronization I'm only interested in writes (so that 
write()/exec() works, but not every read() causes a cache flush). Could we 
split that interface?

bye, Roman

