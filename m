Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVKVXCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVKVXCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVKVXCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:02:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19338 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030227AbVKVXCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:02:05 -0500
Date: Tue, 22 Nov 2005 17:01:40 -0600
From: Greg Edwards <edwardsg@sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, dgc@sgi.com,
       Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: shrinker->nr = LONG_MAX means deadlock for icache
Message-ID: <20051122230140.GA5058@sgi.com>
References: <20051118171249.GJ24970@opteron.random> <20051118232904.4231ad87.akpm@osdl.org> <20051119103723.GA18782@opteron.random> <20051119030306.3049837d.akpm@osdl.org> <20051119113834.GB18782@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119113834.GB18782@opteron.random>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 12:38:34PM +0100, Andrea Arcangeli wrote:
| On Sat, Nov 19, 2005 at 03:03:06AM -0800, Andrew Morton wrote:
| > It would be nice to understand exactly what's gone wrong.
| 
| I found something more, see below.

Looks like Andrea found the real culprit.


| > I guess so, although I worry that this way we'll obscure the real bug,
| > whatever it is.
| 
| Now that I understand better the math around scanned and lru_pages I
| believe their caller could be the reason they have this huge number in
| "nr" is because they pass 0 to shrink all slabs entries. As said in the
| previous email they lockup when invoking the slab shrinking with the
| toss-cache feature.  They should have passed "tossed" as third parameter
| too, not 0.
| 
| 			int tossed = atomic_read(&npgs_tossed);
| 			shrink_slab(tossed, GFP_KERNEL, 0 /* shrink max */);
| 			atomic_set(&npgs_tossed, 0);
| 
| The zero as thrid parameter means nr will be "max_pass * scanned", so if
| both the page-lru is huge and the icache is huge, that can lead to an
| huge value.
| 
| They should also add a WARN_ON to be sure that "tossed" is never
| negative just in case: when the "tossed" gets sign zero extended during
| the int2unsigned-long conversion, that could generate the huge number if
| tossed was negative.
| 
| So the caller has to be fixed too, even if now it would be ok to pass 0
| without risking huge nr values (after fixing the unrelated __GFP_IO bug).
| 
| So hopefully the "0" as third parameter is good enough to explain the
| (other) real bug and we won't be hiding more bugs with this fix.
| 
| > Sure.  You've limited the number of scanned objects in one pass to twice
| > the number of objects - there's no point in doing more work than that.
| 
| Agreed.
| 
| > A return value of 3 is very odd.  I'd be suspecting a mismeasurement. 
| > Unless someone had altered vfs_cache_pressure.
| 
| Exactly.
|
| > OK.  Well If Edward&co could do a bit more investigation it'd be great -
| > meanwhile I'll hang onto this (and might add some mm-only debugging,
| > depending on how Edward gets on):
| 
| Looks good to me, thanks!

CC'ed some of the folks who debugged this, in case they have anything to
add.

Greg
