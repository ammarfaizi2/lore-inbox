Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWFTIGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWFTIGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWFTIGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:06:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5533 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965149AbWFTIGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:06:16 -0400
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to
	1 min
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, ccb@acm.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060619125531.4c72b8cc.akpm@osdl.org>
References: <1150142023.3621.22.camel@cbox.memecycle.com>
	 <20060617100710.ec05131f.akpm@osdl.org> <20060619070229.GA8293@elte.hu>
	 <20060619005955.b05840e8.akpm@osdl.org> <20060619081252.GA13176@elte.hu>
	 <20060619013238.6d19570f.akpm@osdl.org> <20060619083518.GA14265@elte.hu>
	 <20060619021314.a6ce43f5.akpm@osdl.org> <20060619113943.GA18321@elte.hu>
	 <20060619125531.4c72b8cc.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 10:06:06 +0200
Message-Id: <1150790766.2891.160.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 12:55 -0700, Andrew Morton wrote:

> I get that impression ;) If it takes 1-2 seconds to get this lock then it
> can take five seconds.  a) that's just gross and b) the NMI watchdog will
> nuke the box.
> 
> Why is it taking so long to get the lock?

on a high level, this is a "feature" of unfair read/write locks in
general. Just have enough processors and a lock that can be taken for
read as a result from a userspace action, and BLAM you have this as a
user triggerable condition... which is effectively a DoS security issue.

> What do we do about it?

read/write spinlocks are effectively silly. There is NO scalability
advantage in practice (well, there would be if you have really long hold
times, which you don't for spinlocks, rwsems are obviously different
there). This may sound counter intuitive.... but nowadays the
scalability cost for taking a lock is in the cache miss for bouncing the
cacheline of the lock to your cpu for write. (once this is done the
actual locked cycle tends to be free or near free)

In this cache bounce aspect, read/write spinlocks are no better than
normal spinlocks. In fact, in the ">1 concurrent readers" case, they are
*worse* than normal spinlocks! 

So I'm entirely on Ingo's side with the "we should get rid of rw
spinlocks as much as we can" proposal; they make no sense whatsoever for
scalability, the only reason they are useful is for recursion...

(well there is a border line case with the rare writer in user context
but the normal users for read in irq context, but even there the
scalability is horrible and this should consider rcu or per-cpu data
realistically)



