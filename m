Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVJOHoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVJOHoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVJOHoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:44:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:49333 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751115AbVJOHoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:44:34 -0400
Subject: Re: Possible memory ordering bug in page reclaim?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0510150705240.22534@goblin.wat.veritas.com>
References: <4350776D.1060304@yahoo.com.au>
	 <Pine.LNX.4.61.0510150705240.22534@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Sat, 15 Oct 2005 17:43:16 +1000
Message-Id: <1129362196.7620.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-15 at 07:17 +0100, Hugh Dickins wrote:
> On Sat, 15 Oct 2005, Nick Piggin wrote:
> > 
> > Is there anything that prevents PageDirty from theoretically being
> > speculatively loaded before page_count here? (see patch)
> > 
> > It would result in pagecache corruption in the following situation:
> > 
> > 1                                2
> > find_get_page();
> > write to page                    write_lock(tree_lock);
> > SetPageDirty();                  if (page_count != 2
> > put_page();                          || PageDirty())
> > 
> > Now I'm worried that 2 might see PageDirty *before* SetPageDirty in
>                                   page->flags
> > 1, and page_count *after* put_page in 1.
> 
> I think you're right.  But I'm the last person to ask
> barrier/ordering questions of.  CC'ed Ben and Andrea.

yup, now the question is wether PG_Dirty will be visible to CPU 2 before
the page count is decremented right ? That depends on put_page, I
suppose. If it's doing a simple atomic, there is an issue. But atomics
with return has been so often abused as locks that they may have been
implemented with a barrier... (On ppc64, it will do an eieio, thus I
think it should be ok).

There is also a problem the other way around. Write to page, then set
page dirty... those writes may be visible to CPU 2 (that is the page
content be dirty) before find_get_page even increased the page count,
unless there is a barrier in there too.

Paul, Anton ?

Ben.


