Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268974AbTCASYv>; Sat, 1 Mar 2003 13:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268977AbTCASYu>; Sat, 1 Mar 2003 13:24:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5642 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268974AbTCASYt>; Sat, 1 Mar 2003 13:24:49 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] New dcache / inode hash tuning patch
Date: Sat, 1 Mar 2003 18:34:52 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3qugc$3kt$1@penguin.transmeta.com>
References: <p73n0kg7qi7.fsf@amdsimf.suse.de> <20030301004942.GA16973@delft.aura.cs.cmu.edu> <20030301011723.GA31126@wotan.suse.de> <20030301043131.7D5301058@oscar.casa.dyndns.org>
X-Trace: palladium.transmeta.com 1046543700 16747 127.0.0.1 (1 Mar 2003 18:35:00 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Mar 2003 18:35:00 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030301043131.7D5301058@oscar.casa.dyndns.org>,
Ed Tomlinson  <tomlins@cam.org> wrote:
>
>I wonder what would happen if you reordered the chains moving a 'found'
>dentry to the front of the chain?  If this could be done without 
>excessive locking it might help keep hot entries quickly accessable.

The original dentry code actually did that. It sucks.

The reason it sucks is not so much just the locking, but the fact that
you dirty the cache lines, which means that not only are you blowing
your cache on that CPU, you also caused the other CPU's to blow _their_
caches (the lines that are in the cache can no longer be shared) AND you
caused excessive bus traffic for the writeouts. 

In other words: it makes sense if there is one or two really hot
entries.  But it does not make sense in general.  But you might have
some heuristic that does it "every 1000 lookups" or something like that,
to avoid the problems but still statistically getting the really hot
entries closer to the top. 

This cache behaviour is, btw, something that rcu made worse - with the
pre-rcu stuff, we avoided taking the dcache locks and incrementing the
dcache counters for intermediate cached lookups, and we only did it for
the leaf entry (or misses). 

I hope that we can re-do that optimization _with_ rcu in 2.7.x.

		Linus
