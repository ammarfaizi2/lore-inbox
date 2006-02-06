Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWBFGBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWBFGBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 01:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWBFGBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 01:01:52 -0500
Received: from web33013.mail.mud.yahoo.com ([68.142.206.77]:16551 "HELO
	web33013.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750998AbWBFGBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 01:01:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cUVlMaCm07MqMXpFRu3ZfY4dN3sVLLaGoOjYexKoLmkMO72/XTMON9w5bVUfFmaQyxXvRx/XcPl4+cTGHj7ZjBc9sJGQEhdN/3OrCfVeW2ZzY7wQ2S32+jo2S1viqNM00zhgfnZRYIwc5cXbH0BtnhBad475YXSymOpXsI2bE60=  ;
Message-ID: <20060206060147.13989.qmail@web33013.mail.mud.yahoo.com>
Date: Sun, 5 Feb 2006 22:01:47 -0800 (PST)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060206010506.GA30318@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Marcelo Tosatti <marcelo.tosatti@cyclades.com>
wrote:

> Hi Shantanu,
> 

Hi Marcelo.

> I guess that big issue here is that the pgrotate
> logic is completly
> useless for common cases (and no one stepped up to
> fix it, here's a
> chance).
> 

I am all for this.  The motivation in my case is the
VM scanner seems to be rather severe on mapped memory
in the case where the inactive list is full of dirty
pages.  For instance, with the default values of
swappiness (60), dirty_background_ratio (10) and
dirty_ratio (40), if the mapped memory is just under
the 80% mark, the unmapped_ratio logic in
page-writeback.c does not kick in with the dd test I
described in my original email.  Now most pages
encountered by kswapd will be dirty.  One scan will
require pushing these pages to the backing store. 
However, generic_buffered_write() marks all dirty
pages as referenced with the result, it will take 2
iterations before any I/O is performed since the
scanner skips inactive/dirty/referenced pages.  This
causes the priority to drop enough that we start
reclaiming mapped memory.  What's worse is we scan
mapped memory at a higher priority.  Reducing
swappiness does not help completely because that
effectively increases the priority at which we do the
first mapped scan.

Ideally, for workloads that want to avoid paging as
much as possible, we should perhaps have a mode where
we never activate unmapped pages and let them all
reside on the inactive list.  mark_page_accessed()
would simply move an unmapped page to the head of the
inactive list on the 2nd reference.  The page scanner
would then reclaim unmapped pages in a strict LRU
fashion regardless of whether the page is dirty.  I
have a patch that implements this but it does not
perform well for dbench type workloads so a special
/proc/sys/vm option enables/disables it.  If there is
any interest I can post it.

> Marking PG_writeback pages as PG_rotated once
> they're chosen candidates
> for eviction increases the number of rotated pages
> dramatically, but
> that does not necessarily increase performance (I
> was unable to see any
> performance increase under the limited testing I've
> done, even though
> the pgrotated numbers were _way_ higher).

It is a win for the "most memory is mapped with
occasional large file copying" scenario in my
experience.  The patch I mentioned above does this as
well.

> 
> Another issue is that increasing the number of
> rotated pages increases
> lru_lock contention, which might not be an advantage
> for certain
> workloads.

The code as posted is certainly sub-optimal in this
regard.  I have not given this much thought yet but
you do raise a good point.

Shantanu

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
