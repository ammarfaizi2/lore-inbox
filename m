Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSHDSrT>; Sun, 4 Aug 2002 14:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318186AbSHDSrT>; Sun, 4 Aug 2002 14:47:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50703 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318184AbSHDSrS>; Sun, 4 Aug 2002 14:47:18 -0400
Date: Sun, 4 Aug 2002 11:50:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Hans Reiser <reiser@namesys.com>, Andreas Gruenbacher <agruen@suse.de>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
In-Reply-To: <Pine.LNX.4.44L.0208041543450.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208041146380.10314-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 Aug 2002, Rik van Riel wrote:
> 
> Linus has indicated that he would like to have it page based,
> but implementation issues point towards letting the subcache
> manage its objects by itself ;)

The two are not mutually incompatible.

I think we've all seen that non-global shrinking just doesn't work very
well, because one cache that grows too large will end up asking everybody
else to shrink, even if a global shrinking policy would have realized that
the memory pressure is due to that one overly large cache. The resulting
balancing problems are "interesting".

Being purely page-based, together with support for the sub-caches knowing 
about the page-based aging, should be fine.

In particular, it is useless for the sub-caches to try to maintain their 
own LRU lists and their own accessed bits. But that doesn't mean that they 
can _act_ as if they updated their own accessed bits, while really just 
telling the page-based thing that that page is active.

This is what the buffer cache has been doing for the last two years, ie 
"touch_buffer()" actually ends up touching the page. Which seems to be 
working quite well.

		Linus

