Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317907AbSG2BGG>; Sun, 28 Jul 2002 21:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318017AbSG2BGG>; Sun, 28 Jul 2002 21:06:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:41231 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317907AbSG2BGF>; Sun, 28 Jul 2002 21:06:05 -0400
Date: Sun, 28 Jul 2002 22:09:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
In-Reply-To: <20020729005612.GM1201@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0207282205300.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002, Andrea Arcangeli wrote:

> if you look at DaveM first full rmap implementation it never had a
> pte-chain. He used the same rmap logic we always hand in linux since the
> first 2.1 kernel I looked at, to handle correctly truncate against
> MAP_SHARED. Unfortunately that's not very efficient and requires some
> metadata allocation for anonymous pages (that's the address space
> pointer, anon pages regularly doesn't have a dedicated address space),

Together with the K42 people we found a way to avoid the
badnesses of an object-based VM.

The space overhead will be a "double wide" radix tree
per anonymous memory object, where each entry has a
copy-on-write count and either the page frame number
or the position in swap.

Added benefits are not having to modify page->count for
most pages on fork(), exec(), etc. and being able to just
throw away page tables.

This scheme doesn't have deep tree walking of memory objects,
doesn't have the disadvantage of leaving 'stale' pages behind
in parent objects after COW and can still do refcounting on an
object basis instead of a page by page basis.

It'll also allow us to drop the usage count for swap entries,
turning those into a simple bitmap (or maybe a better form?).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

