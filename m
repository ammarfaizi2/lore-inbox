Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSHBPOd>; Fri, 2 Aug 2002 11:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSHBPOd>; Fri, 2 Aug 2002 11:14:33 -0400
Received: from reload.namesys.com ([212.16.7.75]:30084 "EHLO
	reload.namesys.com") by vger.kernel.org with ESMTP
	id <S315279AbSHBPOc>; Fri, 2 Aug 2002 11:14:32 -0400
Date: Fri, 2 Aug 2002 19:17:58 +0400
From: Joshua MacDonald <jmacd@namesys.com>
To: linux-kernel@vger.kernel.org
Cc: oxymoron@waste.com, jbarnes@sgi.com, reiser@namesys.com
Subject: Re: [PATCH] lock assertion macros for 2.5.28
Message-ID: <20020802151758.GD5469@reload.namesys.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, oxymoron@waste.com,
	jbarnes@sgi.com, reiser@namesys.com
References: <20020725233047.GA782991@sgi.com> <20020726120918.GA22049@reload.namesys.com> <20020726174258.GC793866@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726174258.GC793866@sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 10:42:58AM -0700, Jesse Barnes wrote:
> On Fri, Jul 26, 2002 at 04:09:18PM +0400, Joshua MacDonald wrote:
> > In reiser4 we are looking forward to having a MUST_NOT_HOLD (i.e.,
> > spin_is_not_locked) assertion for kernel spinlocks.  Do you know if any
> > progress has been made in that direction?
> 
> Well, I had that in one version of the patch, but people didn't think
> it would be useful.  Maybe you'd like to check out Oliver's comments
> at http://marc.theaimsgroup.com/?l=linux-kernel&m=102644431806734&w=2
> and respond?  If there's demand for MUST_NOT_HOLD, I'd be happy to add
> it since it should be easy.  But if you're using it to enforce lock
> ordering as Oliver suggests, then there are probably more robust
> solutions.
> 

I read Oliver's comments and I do not fully agree.  It is true that often the
MUST_NOT_HOLD macro is used to assert that you are not about to attempt a
recursive lock, which a debugging spinlock implementation would catch as soon
as the recursive attempt is made.  However, it is difficult to make a case
against adding support for this kind of assertion since it has many possible
uses.

It may be useful to catch a recursive spinlock attempt several stack frames
before it actually happens, or to assert that an unusual calling convention
such as "This function is called with the spinlock held and if it returns 0
the spinlock remains held, but if the function returns non-zero the spinlock
is released".  We have such a function in reiser4.

As for preventing deadlock, it is true that (as Oliver says) "Locking order is
larger than functions and should be documented at the point of declaration of
the locks."  We have a mechanism in reiser4 which is not quite the same as
Oliver outlined for making assertions about lock ordering.  We maintain
per-thread counts of each spinlock class and use those counts in a locking
predicate that is applied before a lock of each class is taken.

So I agree that recursive locking should be checked as part of the debugging
spin_lock() routine and that deadlock detection requires more general work,
but the MUST_NOT_HOLD assertion is still useful in some contexts.

-josh
