Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSHCVb6>; Sat, 3 Aug 2002 17:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSHCVb6>; Sat, 3 Aug 2002 17:31:58 -0400
Received: from dsl-213-023-022-101.arcor-ip.net ([213.23.22.101]:28605 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317852AbSHCVb5>;
	Sat, 3 Aug 2002 17:31:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Sat, 3 Aug 2002 23:36:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0208031803050.23404-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0208031803050.23404-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17b6Zl-0002mj-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 23:05, Rik van Riel wrote:
> On Fri, 2 Aug 2002, Andrew Morton wrote:
> 
> > No joy, I'm afraid.
> 
> > Guess we should instrument it up and make sure that the hashing
> > and index thing is getting the right locality.
> 
> Could it be that your quad needs to go to RAM to grab a cacheline
> that's exclusive on the other CPU while Daniel's machine can just
> shove cachelines from CPU to CPU ?
> 
> What I'm referring to is the fact that the pte_chain_locks in
> Daniel's patch are all packed into a few cachelines, instead of
> having each lock on its own cache line...
> 
> This could explain the fact that the locking overhead plummeted
> on Daniel's box while it didn't change at all on your machine.

To put each lock in its own cacheline:

 static inline unsigned rmap_lockno(pgoff_t index)
 {
- 	return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 1);
+ 	return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 64);
 }

a quick hack, notable mainly for being obscure ;-)

I did try this and noticed scarcely any difference.

-- 
Daniel
