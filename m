Return-Path: <linux-kernel-owner+w=401wt.eu-S965028AbWL1WiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWL1WiU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWL1WiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:38:19 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:2684
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965028AbWL1WiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:38:17 -0500
Date: Thu, 28 Dec 2006 14:38:15 -0800 (PST)
Message-Id: <20061228.143815.41633302.davem@davemloft.net>
To: torvalds@osdl.org
Cc: akpm@osdl.org, guichaz@yahoo.fr, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com, a.p.zijlstra@chello.nl,
       andrei.popa@i-neo.ro, hugh@veritas.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
	<20061228114517.3315aee7.akpm@osdl.org>
	<Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 28 Dec 2006 12:14:31 -0800 (PST)

> I get corruption - but the whole point is that it's very much pdflush that 
> should be writing these pages out.

I think what might be happening is that pdflush writes them out fine,
however we don't trap writes by the application _during_ that writeout.

These corruptions look exactly as if:

1) pdflush begins writeback of page X
2) page goes to disk
3) application writes a chunk to the page
4) pdflush et al. think the page is clean, so it gets tossed, losing
   the writes done in #3

So there's a missing PTE change in there, so that we never get proper
re-dirtying of the page if the application tries to write to the page
during the writeback.

It's something that will only occur with writeback and MAP_SHARED
writable access to the file pages.  That's why we never see this
with normal filesystem writes, since those explicitly manage the
page dirty state.

I think the dirty balancing logic etc. isn't where the problems are,
to me it's a PTE state update issue for sure.
