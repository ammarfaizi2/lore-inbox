Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271834AbRIQQfn>; Mon, 17 Sep 2001 12:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIQQfe>; Mon, 17 Sep 2001 12:35:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34061 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271832AbRIQQfP>; Mon, 17 Sep 2001 12:35:15 -0400
Date: Mon, 17 Sep 2001 09:34:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010917121435.A19884@cs.cmu.edu>
Message-ID: <Pine.LNX.4.33.0109170927160.8900-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Jan Harkes wrote:

> On Mon, Sep 17, 2001 at 02:33:12PM +0200, Daniel Phillips wrote:
> > The inactive queues have always had both mapped and unmapped pages on
> > them. The reason for unmapping a swap cache page page when putting it
>
> So the following code in refill_inactive_scan only exists in my
> imagination?
>
> 	    if (page_count(page) <= (page->buffers ? 2 : 1)) {
> 		    deactivate_page_nolock(page);

No, but I agree with Daniel that it's wrong.

The reason it exists there is because the current inactive_clean list
scanning doesn't have any pressure into VM scanning, so if we'd let mapped
pages on the inactive queue, then reclaim_page() would be unhappy about
them.

That can be solved several ways:
 - like we do now. Hackish and wrong, but kind-of-works.
 - make reclaim_page() have the ability to do vm scanning pressure (ie if
   it starts noticing that there are too many mapped pages on the reclaim
   list, it should cause VM scan)
 - physical maps

Actually, now that I look at it, the lack of de-activation actually hurts
page_launder() - which doesn't get to launder pages that are still mapped
(even though getting rid of buffers from them would almost certainly be
good under memory pressure).

		Linus

