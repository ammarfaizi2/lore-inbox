Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318630AbSHENnb>; Mon, 5 Aug 2002 09:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSHENna>; Mon, 5 Aug 2002 09:43:30 -0400
Received: from dsl-213-023-043-082.arcor-ip.net ([213.23.43.82]:14230 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318630AbSHENn3>;
	Mon, 5 Aug 2002 09:43:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
Date: Mon, 5 Aug 2002 15:48:26 +0200
X-Mailer: KMail [version 1.3.2]
References: <E17aiJv-0007cr-00@starship> <3D4DB9E4.E785184E@zip.com.au> <3D4E23C4.F746CF3D@zip.com.au>
In-Reply-To: <3D4E23C4.F746CF3D@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17biDi-0000w7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 09:05, Andrew Morton wrote:
> Andrew Morton wrote:
> It makes basically no difference at all.  Maybe pulled back 10 of the lost
> 50%.  The kernel is still spending much time in the pte_chain walk in
> page_remove_rmap().

I wouldn't call that 'no difference', just not as much as hoped for.

Well, I'm not quite out of tricks yet.  There's one more to go, and it just 
might be worth more than all the others.  It's a little subtle though, and 
I'm still working out some wrinkles, so I'll write it up in detail tomorrow.

For now, consider that our rmaps tend to form a lot of parallel chains.  That 
is, if you look at the chains for two pages whose index differs by one, the 
pte fields of each of the pte_chain nodes differs by 4.  This relationship 
tends to hold quite consistently over rather large groups of pages, a fact 
that I took advantage of in the lock batching.  Now, if we put a relative 
number in the pte field instead of an absolute pointer, the corresponding 
pte_chain nodes for all those parallel chains become identical.  How nice it 
would be if we could share those pte chain nodes between pages.

I've convinced myself that this is possible.  It's a little tricky though: we 
have to handle CoW unsharing, and the possibility of the index changing (as 
with the lock batching, but in this case there's a little more work to do).
My feeling is that the implementation will not be particularly messy, even 
though it sounds scary on first blush.

> Despite the fact that the number of pte_chain references in
> page_add/remove_rmap now just averages two in that test.

It's weird that it only averages two.  It's a four way and your running 10 in
parallel, plus a process to watch for completion, right?

-- 
Daniel
