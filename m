Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266854AbSKHRvD>; Fri, 8 Nov 2002 12:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266855AbSKHRvD>; Fri, 8 Nov 2002 12:51:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19974 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266854AbSKHRvB>; Fri, 8 Nov 2002 12:51:01 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Linux-ia64] reader-writer livelock problem
Date: Fri, 8 Nov 2002 17:57:13 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aqgttp$2qf$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0211080918220.4298-100000@home.transmeta.com> <1036777105.13021.13.camel@ixodes.goop.org>
X-Trace: palladium.transmeta.com 1036778245 10209 127.0.0.1 (8 Nov 2002 17:57:25 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Nov 2002 17:57:25 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1036777105.13021.13.camel@ixodes.goop.org>,
Jeremy Fitzhardinge  <jeremy@goop.org> wrote:
>
>Even without interrupts that would be a bug.  It isn't ever safe to
>attempt to retake a read lock if you already hold it, because you may
>deadlock with a pending writer.  Fair multi-reader locks aren't
>recursive locks.

.. but I don't think we have any real users who use them for recursion,
so the only "recursion" right now is through interrupts that use this
feature.

(At least that was true a long time time ago, maybe we've added truly
recursive users since)

>> Actually, giving this som emore thought, I really suspect that the
>> simplest solution is to alloc a separate "fair_read_lock()", and paths
>> that need to care about fairness (and know they don't have the irq
>> issue)  
>> can use that, slowly porting users over one by one...
>
>Do you mean have a separate lock type, or have two different read_lock
>operations on the current type?

That depends on whether it is even sanely implementable to share the
same lock. It may not be. 

>From a migration standpoint it would be easiest (by far) to be able to
share the lock type and to mix operations (ie an interrupt - or
recursive user - could just use the non-fair version, while others could
use the fair version on the same lock).  However, I have this nagging
suspicion that it might be a total nightmare to implement efficiently in
practice. 

I've not looked at it. Any ideas?

		Linus
