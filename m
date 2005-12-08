Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVLHORG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVLHORG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVLHORE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:17:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:22338 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932114AbVLHORD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:17:03 -0500
Date: Thu, 8 Dec 2005 14:16:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Magnus Damm <magnus@valinux.co.jp>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [PATCH 00/07][RFC] Remove mapcount from struct page
In-Reply-To: <20051208112940.6309.39428.sendpatchset@cherry.local>
Message-ID: <Pine.LNX.4.61.0512081352530.8950@goblin.wat.veritas.com>
References: <20051208112940.6309.39428.sendpatchset@cherry.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Dec 2005 14:16:14.0480 (UTC) FILETIME=[F292C900:01C5FC01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Magnus Damm wrote:
> This patchset tries to remove page->_mapcount.

Interesting.  I share your feeling that it ought to be possible to
get along without page->_mapcount, but I've not succeeded yet.  And
perhaps the system without page->_mapcount would perform worse.

Unfortunately, I don't have time to study your patches at the moment,
nor get into a discussion on them.  Sorry if that sounds dismissive:
not my intention, I hope others will take up the discussion instead.

But it looked to me as if you've done the easy part without doing the
hard part yet: vmscanning can get along very well with an approximate
idea of page_mapped, but can_share_swap_page really needs to know.

At present you're just saying "no" there, which appears safe but
slow; but there's a get_user_pages fork case where it's very bad
for it to say "no" when it should say "yes".  See try_to_unmap_one
comment on get_user_pages in 2.6.12 mm/rmap.c.

It looked as if you were doing a separate scan to update PG_mapped,
which would better be incorporated in the page_referenced scan.
I found locking to be a problem.  lock_page is held at many of
the right points, but not all, and may be bad to extend its use.

Your patches looked over-split to me (a rare criticism!): you don't
need a separate patch to delete each little thing that's no longer
used, nor a separate patch to introduce each new definition before
it's used.

Hugh
