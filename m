Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTBJBBX>; Sun, 9 Feb 2003 20:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTBJBBX>; Sun, 9 Feb 2003 20:01:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267484AbTBJBBX>; Sun, 9 Feb 2003 20:01:23 -0500
Date: Sun, 9 Feb 2003 17:07:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <200302091156.h19BuoH07869@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302091703220.13648-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Feb 2003, Roland McGrath wrote:
> 
> There is a similar failure to take the lock before using zap_other_threads.
> I thought I sent this patch before, but it's not in 2.5 yet.

Hmm.. From looking at this patch, it seems as if you believe that 
spinlocks must next correctly. They don't have to.

The ABBA kind of deadlock only means that you have to _take_ the spinlocks 
in the right order, you can release them in any order you like (as long as 
you release all of them).

So if the only requirement is that zap_other_threads() is called with the
tasklist lock held, I would suggest just dropping the tasklist lock after
the zap_other threads thing, despite the fact that you still want to hold 
on to the siglock for a while longer. That simplifies the patch, and means 
that you don't have to worry about dropping and re-taking the tasklist 
lock in the loop that follows.

		Linus

