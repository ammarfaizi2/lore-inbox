Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUFZBWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUFZBWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUFZBWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:22:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:14900 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266910AbUFZBWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:22:23 -0400
Date: Sat, 26 Jun 2004 02:22:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm lock ordering summary
In-Reply-To: <20040625174150.7ad7ee97.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0406260153380.20414-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Andrew Morton wrote:
> 
> Yes, but what does
> 
> 	a
> 	b
> 	  c
> 	  d
> 
> mean?
> 
> The above graph tells us that one or more of (swap_device_lock,
> mapping->private_lock and inode_lock) nests inside one or more of
> (swap_list_lock, zone->lru_lock and page->flags PG_maplock).

Yes.  I think I ordered it so that it meant c and d nest inside b,
and a's a leaf of less interest; but of course it's just good luck
if any such ordering is possible.

> And has no way of telling us _where_, say, swap_device_lock nests inside
> zone->lru_lock.

Hence the comments, or search the source: this is only a summary.

> And it alleges that tree_lock nests inside lru_lock, which isn't so.  Is
> it?  These guys used to have no locking relationship.  Hopefully that's
> still the case.  But how to represent that?

It's alleging that you'll be okay if you write code with tree_lock
nesting inside lru_lock, and you need to worry if you do the reverse.

How is this summary used?  I use it to check whether I've got my locks
in the right order.  Look at the summary and if what I've written fits
with the sequence shown, I'm okay.  If not, I need to enquire further:
think about changing around my new code to fit the ordering shown; if
that's difficult then look through the source to find where those rules
come from, think about changing them around; or, complicate (refine?)
the summary to show that actually my new case is not a problem after all.

I'm suggesting it be a checklist, rather than a declaration of truth:
easier to maintain the checklist.  But I doubt I'm persuading you:
please add page_map_lock and anon_vma->lock (but where and how many?).

Hugh

