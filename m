Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTDOEnt (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 00:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbTDOEnt (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 00:43:49 -0400
Received: from [12.47.58.203] ([12.47.58.203]:48434 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264262AbTDOEns (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 00:43:48 -0400
Date: Mon, 14 Apr 2003 21:55:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-Id: <20030414215541.0aff47bc.akpm@digeo.com>
In-Reply-To: <20030415043947.GD706@holomorphy.com>
References: <20030414015313.4f6333ad.akpm@digeo.com>
	<20030415020057.GC706@holomorphy.com>
	<20030415041759.GA12487@holomorphy.com>
	<20030414213114.37dc7879.akpm@digeo.com>
	<20030415043947.GD706@holomorphy.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2003 04:55:31.0996 (UTC) FILETIME=[3E391DC0:01C3030B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Page clustering wants something similar but slightly different. The
> unit it wants as its stride (MMUPAGE_SIZE) isn't present so this doesn't
> really help or hurt it. I believe I actually dodged this bullet by
> ensuring (or incorrectly assuming) the callers used sizes <= MMUPAGE_SIZE
> and left it either unaltered and suboptimal or (worst-case) buggy.

Callers will use sizes between 1 and PAGE_CACHE_SIZE, with arbitrary
alignment.  So you may need to fault in up to

	(PAGE_CACHE_SIZE / MMUPAGE_SIZE) + 1
	
pte's.  And up to two PAGE_CACHE_SIZE pages.

Sort-of.  The code is doing two things.

a) Make sure that all the relevant pte's are established in the correct
   state so we don't take a fault while holding the subsequent atomic kmap.

   This is just an optimisation.  If we _do_ take the fault while holding
   an atomic kmap, we fall back to sleeping kmap, and do the whole copy
   again.  It almost never happens.

b) Making sure that the pagecache page is present before we lock it.  This
   is to handle the icky deadlock which occurs when someone is doing a
   write() into a MAP_SHARED region of the file, where the source and dest of
   the copy are the same physical page.  If we take a fault and then try to
   bring the page uptodate in the fault handler we deadlock because the page
   is already locked.

   The fault-by-hand-before-locking-the-page is racy - if the VM steals
   the page again before we lock it (rare), the deadlock can still occur.

   I've been able to trigger the fault which causes fallback to kmap()
   occasionally, under heavy load.  But never the deadlock.

   We don't know how to fix this for real.  I had patch for a while which
   added current->locked_page, and filemap_nopage() would compare that with
   the to-be-locked page and say "ah-hah!" and take avoiding action.

   But then Hugh rudely pointed out that the deadlock was still present if
   two tasks were involved, each trying to fault in the other's locked page.


> I'm just going down the list of FIXME's in the VM I turned up by grepping.
> Should we do the following instead?

OK ;)

