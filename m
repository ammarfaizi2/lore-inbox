Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTH0UJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTH0UJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 16:09:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:60072 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262056AbTH0UJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 16:09:13 -0400
Date: Wed, 27 Aug 2003 12:53:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: warudkar@vsnl.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
Message-Id: <20030827125310.15ebf8f9.akpm@osdl.org>
In-Reply-To: <200308272137.42632.kernel@kolivas.org>
References: <200308272138.h7RLciK29987@webmail2.vsnl.net>
	<200308272137.42632.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> On Thu, 28 Aug 2003 07:38, warudkar@vsnl.net wrote:
> > Trying out 2.6.0-test4-mm1. Inside KDE, I start OpenOffice.org, Rational
> > Rose and Konsole at a time. All of these take extremely long time to
> > startup. (approx > 5 minutes). Kswapd hogs the CPU all the time. X becomes
> > unusable till all of them startup, although I can telnet and run top. Same
> > thing run under 2.4.18 starts up in 3 minutes, X stays usable and kswapd
> > never take more than 2% CPU.
> 
> Yes I can reproduce this with a memory heavy load as well on low memory 
> (linking at the end of a big kernel compile is standard problem).

It could be that recent changes to page reclaim which improve I/O
scheduling have exacerbated this.

Does this make a difference?

diff -puN mm/vmscan.c~a mm/vmscan.c
--- 25/mm/vmscan.c~a	Wed Aug 27 12:51:36 2003
+++ 25-akpm/mm/vmscan.c	Wed Aug 27 12:51:48 2003
@@ -360,8 +360,6 @@ shrink_list(struct list_head *page_list,
 		 * See swapfile.c:page_queue_congested().
 		 */
 		if (PageDirty(page)) {
-			if (referenced)
-				goto keep_locked;
 			if (!is_page_cache_freeable(page))
 				goto keep_locked;
 			if (!mapping)

_

