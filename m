Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284307AbRLMQJU>; Thu, 13 Dec 2001 11:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284318AbRLMQJO>; Thu, 13 Dec 2001 11:09:14 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50620 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S284307AbRLMQJF>; Thu, 13 Dec 2001 11:09:05 -0500
Date: Thu, 13 Dec 2001 16:11:03 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Big Fish <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] v2.5.1-pre9-00_kvec.diff
In-Reply-To: <20011212162412.A28056@redhat.com>
Message-ID: <Pine.LNX.4.21.0112131541040.1428-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Benjamin LaHaise wrote:
> On Tue, Dec 11, 2001 at 11:33:32PM +0000, Hugh Dickins wrote:
> > Looks nice, but I think you need to update from atomic_inc(&map->count)
> > and __free_page(map) to page_cache_get(map) and page_cache_release(map)?
> > I haven't checked a 2.5.1-pre9 tree, but we had to change that in 2.4,
> > to avoid PageLRU BUGs.  page_cache_get end just tidiness, of course.
> 
> Hrm, the more I look at things, the more I'm convinced that this is wrong: 
> right now in the network code and other places we will use put_page() to 
> release a reference to a potential page cache page which could cause the 
> PageLRU BUG() to hit.  I'm sure there are lots of subtle cases like this 
> all over the tree that the change in semantics has introduced bugs in.

You'll know better than me.  A little suprising they haven't shown up yet,
but if those put_page()s might remove the last reference to an anonymous
page, which traditionally couldn't be on an LRU, but now can be, then yes:
either those put_page() calls must be replaced by page_cache_release()
calls, or the function formerly known as page_cache_release() should be
renamed put_page() (and macros and EXPORTs adjusted).

When Linus first put anonymous pages on LRU (2.4.14-pre), he started out
with a dedicated free_lru_page(); and once that had shown up the inter-
esting bugs, relaxed and rolled it into page_cache_release().  I think
if you can show the problem with the net ones (or more likely, it's as
obvious to Linus as it is to you), he might now happily relax and roll
it into put_page() instead.  Perhaps go the whole way to __free_pages(),
but I doubt it.  Linus?

Whatever, it appears not to be a high priority: sorry if I've diverted
you from the main thrust of your veclet (I love that name) work.

Hugh

