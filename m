Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWJBHgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWJBHgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 03:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWJBHgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 03:36:10 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:23322 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750774AbWJBHgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 03:36:07 -0400
Subject: Re: [RFC][PATCH 0/2] Swap token re-tuned
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: ashwin.chaugule@celunite.com, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20061001155608.0a464d4c.akpm@osdl.org>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 09:35:52 +0200
Message-Id: <1159774552.13651.80.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 15:56 -0700, Andrew Morton wrote:
> On Sat, 30 Sep 2006 00:11:51 +0530
> Ashwin Chaugule <ashwin.chaugule@celunite.com> wrote:

> > PATCH 2: 
> > 
> > Instead of using TIMEOUT as a parameter to transfer the token, I think a
> > better solution is to hand it over to a process that proves its
> > eligibilty. 
> > 
> > What my scheme does, is to find out how frequently a process is calling
> > these functions. The processes that call these more frequently get a
> > higher priority. 
> > The idea is to guarantee that a high priority process gets the token.
> > The priority of a process is determined by the number of consecutive
> > calls to swap-in and no-page. I mean "consecutive" not from the
> > scheduler point of view, but from the process point of view. In other
> > words, if the task called these functions every time it was scheduled,
> > it means it is not getting any further with its execution. 
> > 
> > This way, its a matter of simple comparison of task priorities, to
> > decide whether to transfer the token or not. 
> 
> Does this introduce the possibility of starvation?  Where the
> fast-allocating process hogs the system and everything else makes no
> progress?

I tinkered with this a bit yesterday, and didn't get good results for:
mem=64M ; make -j5

-vanilla: 2h32:55
-swap-token: 2h41:48

various other attempts at tweaking the code only made it worse. (will
have to rerun these test, but a ~3h test is well, a 3h test ;-)

Being frustrated with these results - I mean the idea made sense, so
what is going on - I came up with this answer:

Tasks owning the swap token will retain their pages and will hence swap
less, other (contending) tasks will get less pages and will fault more
frequent. This prio mechanism will favour exactly those tasks not
holding the token. Which makes for token bouncing.

The current mechanism seemingly assigns the token randomly (whomever
asks while not held gets it - and the hold time is fixed), however this
change in paging behaviour (holder less, contenders more) shifts the
odds in favour of one of the contenders. Also the fixed holding time
will make sure the token doesn't get released too soon and can make some
progress.

So while I agree it would be nice to get rid of all magic variables
(holding time in the current impl) this proposed solution hasn't
convinced me (for one it introduces another).

(for the interrested, the various attempts I tried are available here:
  http://programming.kicks-ass.net/kernel-patches/swap_token/ )


