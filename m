Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318893AbSHMArW>; Mon, 12 Aug 2002 20:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318894AbSHMArV>; Mon, 12 Aug 2002 20:47:21 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:5519 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S318893AbSHMArV>;
	Mon, 12 Aug 2002 20:47:21 -0400
Date: Mon, 12 Aug 2002 19:44:54 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: Re: pte_chain leak in rmap code (2.5.31)
In-Reply-To: <Pine.LNX.4.44L.0208121119270.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208121942371.25611-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Rik van Riel wrote:

> On Mon, 12 Aug 2002, Christian Ehrhardt wrote:
> 
> > Note the strange use of continue and break which both achieve the same!
> > What was meant to happen (judging from rmap-13c) is that we break
> > out of the for-Loop once SWAP_FAIL or SWAP_ERROR is returned from
> > try_to_unmap_one. However, this doesn't happen and a subsequent call
> > to pte_chain_free will use the wrong value for prev_pc.
> 
> Excellent hunting!   Thank you!
> 
> Your fix should work too, although in my opinion it's a
> little bit too subtle, so I've changed it into:
> 
> 	                                case SWAP_FAIL:
>                                         ret = SWAP_FAIL;
>                                         goto give_up;
>                                 case SWAP_ERROR:
>                                         ret = SWAP_ERROR;
>                                         goto give_up;
>                         }
>                 }
> give_up:

Any chance this is the cause of the following? 

---------------extract-----------------------

Subject:  Re: [patch 1/21] random fixes
From:     Adam Kropelin <akropel1@rochester.rr.com>
Date:     2002-08-12 2:54:31

FYI, just got this while un-tarring a kernel tree with 
2.5.31+everything.gz:
(no nvidia ;)

Date: Sun, 11 Aug 2002 20:40:31 -0700
From: Andrew Morton <akpm@zip.com.au>

That'll be this one:

                BUG_ON(page->pte.chain != NULL);

we've had a few reports of this dribbling in since rmap went in.  But
nothing repeatable enough for it to be hunted down.

But we do have a repeatable inconsistency happening with ntpd and
memory pressure.  That may be related, but in that case it's probably
related to mlock().

So.  An open bug, alas.



