Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVLICqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVLICqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 21:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVLICqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 21:46:00 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:7808 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751252AbVLICp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 21:45:59 -0500
Subject: Re: [PATCH 00/07][RFC] Remove mapcount from struct page
From: Magnus Damm <magnus@valinux.co.jp>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, andrea@suse.de
In-Reply-To: <Pine.LNX.4.61.0512081352530.8950@goblin.wat.veritas.com>
References: <20051208112940.6309.39428.sendpatchset@cherry.local>
	 <Pine.LNX.4.61.0512081352530.8950@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 11:48:44 +0900
Message-Id: <1134096525.9588.96.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 14:16 +0000, Hugh Dickins wrote:
> On Thu, 8 Dec 2005, Magnus Damm wrote:
> > This patchset tries to remove page->_mapcount.
> 
> Interesting.  I share your feeling that it ought to be possible to
> get along without page->_mapcount, but I've not succeeded yet.  And
> perhaps the system without page->_mapcount would perform worse.
> 
> Unfortunately, I don't have time to study your patches at the moment,
> nor get into a discussion on them.  Sorry if that sounds dismissive:
> not my intention, I hope others will take up the discussion instead.

Your comments so far are very valuable to me. Thank you.

> But it looked to me as if you've done the easy part without doing the
> hard part yet: vmscanning can get along very well with an approximate
> idea of page_mapped, but can_share_swap_page really needs to know.
> 
> At present you're just saying "no" there, which appears safe but
> slow; but there's a get_user_pages fork case where it's very bad
> for it to say "no" when it should say "yes".  See try_to_unmap_one
> comment on get_user_pages in 2.6.12 mm/rmap.c.

Ah, I thought it was safe to always say no. ATM I have no good idea how
to solve the get_user_pages() fork case in a good way, so any
suggestions are very welcome. =)

> It looked as if you were doing a separate scan to update PG_mapped,
> which would better be incorporated in the page_referenced scan.

My first non public version did just that. But then I decided to
implement the scan separately. Mainly because the anonymous
page_referenced() scan could be done without PG_locked held, but in my
case the page locking is always needed to protect us from a racing
page_add_*_rmap(). And I could not find any reason to actually count the
number of pages mapped, except for can_share_swap_page() that I thought
was safe to change into the constant 0, so the idea was to improve
performance by returning when the first mapping was found.

> I found locking to be a problem.  lock_page is held at many of
> the right points, but not all, and may be bad to extend its use.

Yes. Locking is tricky. I studied where page_add_*_rmap() was called and
figured out that only one extra PG_locked was needed. In all other cases
the page was either newly allocated, the zero page or already locked.

This extra lock probably result in worse scalability for large machines.
But OTOH the patch will save memory, and for smaller systems such as
laptops the scalability might not be such a big issue.

> Your patches looked over-split to me (a rare criticism!): you don't
> need a separate patch to delete each little thing that's no longer
> used, nor a separate patch to introduce each new definition before
> it's used.

Indeed. Looking at them today and I totally agree with you. My plan was
to be able to test each broken out patch separately to be able to locate
bugs and performance bottle necks. But I could still do that and reduce
the number of patches to 4 or so.

Many thanks,

/ magnus

