Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRIQAeZ>; Sun, 16 Sep 2001 20:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRIQAeQ>; Sun, 16 Sep 2001 20:34:16 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43530 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273261AbRIQAd7>; Sun, 16 Sep 2001 20:33:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Date: Mon, 17 Sep 2001 02:37:53 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <1000653836.2440.0.camel@gromit.house> <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva> <9o2vct$889$1@penguin.transmeta.com>
In-Reply-To: <9o2vct$889$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010917003422Z16197-2757+375@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 16, 2001 09:43 pm, Linus Torvalds wrote:
> The fact that the "use-once" logic didn't kick in is the problem. It's
> hard to tell _why_ it didn't kick in, possibly because the MP3 player
> read small chunks of the pages (touching them multiple times). 

Can we confirm that the mp3 player is making subpage accesses? (strace)

The 'partially read/written' state isn't handled properly now.  The 
transition to the 'used-once' state should only occur if the transfer ends at 
the exact end of the page.  Right now it always takes place after the *first* 
transfer on the page which is correct only for full-page transfers.

It's still best to start all pages unreferenced, because otherwise we don't 
have a means of distinguishing between the first and subsequent page cache 
lookups.  The check_used_once logic should set the page referenced if the IO 
transfer ends in the interior of the page or unreferenced if it ends at the 
end of the page.

This straightforward to fix, I'll have a tested patch by Tuesday if nobody 
beats me to it.  I don't think this is the whole problem though, it's just 
exposing a balancing problem.  Even if I did go and randomly access a huge 
file so that all cache pages have high age (the effect we're simulating by 
accident here) I still shouldn't be able to drive all my swap pages out of 
memory.

--
Daniel
  

  

  
