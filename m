Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSI0BXK>; Thu, 26 Sep 2002 21:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbSI0BXK>; Thu, 26 Sep 2002 21:23:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261596AbSI0BXK>; Thu, 26 Sep 2002 21:23:10 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [patch 4/4] increase traffic on linux-kernel
Date: Fri, 27 Sep 2002 01:31:17 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <an0cd5$262$1@penguin.transmeta.com>
References: <3D928864.23666D93@digeo.com>
X-Trace: palladium.transmeta.com 1033090106 18894 127.0.0.1 (27 Sep 2002 01:28:26 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Sep 2002 01:28:26 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D928864.23666D93@digeo.com>,
Andrew Morton  <akpm@digeo.com> wrote:
>
>Infrastructure to detect sleep-inside-spinlock bugs.  Really only
>useful if compiled with CONFIG_PREEMPT=y.  It prints out a whiny
>message and a stack backtrace if someone calls a function which might
>sleep from within an atomic region.

This is in my BK tree now, along with Ingo's symbolic backtraces, which
makes it possibly less tedious to read the output. 

I would suggest that all developers for a while run with 

	CONFIG_PREEMPT=y
	CONFIG_DEBUG_KERNEL=y
	CONFIG_KALLSYMS=y

and see if something shows up in their subsystem (but be careful about
the backtraces, since they often contain old crud, especially since gcc
does a horrible job at keeping the stack together and thus leaves unused
"holes" in the stack frame which then show old and stale info). 

It shows clearly that at least the sound PCM code does locking
completely the wrong way around, apparently at least partly because of
bad abstraction macros that hide the fact that some locks are semaphores
and others are spinlocks.

[ Rant: abstraction like this is _bad_, for christ sake! Don't hide what
  locks you're using just to make the code look simpler.  Hint: trying
  to do a "down()" within a spinlock is stupid and not produtive. ]

Thanks,

		Linus
