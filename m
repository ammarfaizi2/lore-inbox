Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSHKPT6>; Sun, 11 Aug 2002 11:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSHKPT6>; Sun, 11 Aug 2002 11:19:58 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:44304 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318310AbSHKPT6>; Sun, 11 Aug 2002 11:19:58 -0400
Date: Sun, 11 Aug 2002 12:23:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/21] batched addition of pages to the LRU
In-Reply-To: <3D56149B.C6E9414@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208111213180.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002, Andrew Morton wrote:

> Also.  This whole patch series improves the behaviour of the system
> under heavy writeback load.  There is a reduction in page allocation
> failures, some reduction in loss of interactivity due to page
> allocators getting stuck on writeback from the VM.  (This is still bad
> though).

> It appears that this simply had the effect of pushing dirty, unwritten
> data closer to the tail of the inactive list, making things worse.

This nicely points out the weak points in having the VM block
on individual pages ... the fact that there are so damn many
of those pages.

Every time the VM is shifting workloads we can run into the
problem of having a significant part (or even the whole) of
the inactive list full of dirty pages and with the inactive
list being 1/3rd of RAM you could easily run into 200 MB of
dirty pages.

If you insist on deferring the "waiting on IO" for these
pages too much, you'll end up blocking in __get_request_wait
instead, until you've scheduled all 200 MB of dirty pages
for IO.

By the time you've gotten out of __get_request_wait and
scheduled the last page for IO, you can be pretty sure the
first 120 MB of dirty pages have been written to disk already
and would have been reclaimable for many seconds already.

I really need to look at fixing this thing right ...

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

