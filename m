Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264709AbRGCPBu>; Tue, 3 Jul 2001 11:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264692AbRGCPBk>; Tue, 3 Jul 2001 11:01:40 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:48400 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264769AbRGCPB3>; Tue, 3 Jul 2001 11:01:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marco Colombo <marco@esi.it>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: VM Requirement Document - v0.0
Date: Tue, 3 Jul 2001 17:04:58 +0200
X-Mailer: KMail [version 1.2]
Cc: <mike_phillips@urscorp.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107030932510.4236-100000@Megathlon.ESI>
In-Reply-To: <Pine.LNX.4.33.0107030932510.4236-100000@Megathlon.ESI>
MIME-Version: 1.0
Message-Id: <01070317045806.00338@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 July 2001 12:33, Marco Colombo wrote:
> Oh, yes, since that PAGE_AGE_BG_INTERACTIVE_MINIMUM is applied only
> when background aging, maybe it's not enough to keep processes like
> updatedb from causing interactive pages to be evicted.
> That's why I said we should have another way to detect that kind of
> activity... well, the application could just let us know (no need to
> embed an autotuning-genetic-page-replacement-optimizer into the kernel).
> We should just drop all FS metadata accessed by updatedb, since we
> know that's one-shot only, without raising pressure at all.

Note that some of updatedb's metadata pages are of the accessed-often kind, 
e.g., directory blocks and inodes.  A blanket low priority on all the pages 
updatedb touches just won't do.

> Just like
> (not that I'm proposing it) putting those "one-shot" pages directly on
> the inactive-clean list instead of the active list. How an application
> could declare such a behaviour is an open question, of course. Maybe it's
> even possible to detect it. And BTW that's really fine tuning.
> Evicting an 8 hours old page may be a mistake sometime, but it's never
> a *big* mistake.

IMHO, updatedb *should* evict all the "interactive" pages that aren't 
actually doing anything[1].  That way it should run faster, provided of 
course its accessed-once pages are properly given low priority.

I see three page priority levels:

  0 - accessed-never/aged to zero
  1 - accessed-once/just loaded
  2 - accessed-often

with these transitions:

  0 -> 1, if a page is accessed
  1 -> 2, if a page is accessed a second time
  1 -> 0, if a page gets old
  2 -> 0, if a page gets old

The 0 and 1 level pages are on a fifo queue, the 2 level pages are scanned 
clock-wise, relying on the age computation[2].  Eviction candidates are taken 
from the cold end of the 0 level list, unless it is empty, in which case they 
are taken from the 1 level list. In desperation, eviction candidates are 
taken from the 2 level list, i.e., random eviction policy, as opposed to what 
we do now which is to initiate an emergency scan of the active list for new 
inactive candidates - rather like calling a quick board meeting when the 
building is on fire.

Note that the above is only a very slight departure from the current design.  
And by the way, this is just brainstorming, it hasn't reached the 'proposal' 
stage yet.

[1] It would be nice to have a mechanism whereby the evicted 'interactive' 
pages are automatically reloaded when updatedb has finished its work.  This 
is a case of scavenging unused disk bandwidth for something useful, i.e., 
improving the interactive experience.

[2] I much prefer the hot/cold terminology over old/young.  The latter gets 
confusing because a 'high' age is 'young'.  I'd rather think of a high value 
as being 'hot'.

--
Daniel
