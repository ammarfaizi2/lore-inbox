Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTBTULm>; Thu, 20 Feb 2003 15:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbTBTULm>; Thu, 20 Feb 2003 15:11:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37127 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265987AbTBTULl>; Thu, 20 Feb 2003 15:11:41 -0500
Date: Thu, 20 Feb 2003 12:17:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302202057020.2262-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302201207320.12127-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Ingo Molnar wrote:
> 
> ie. something like:

Well, please remove the double test for task inequality.

I like the patch conceptually, HOWEVER, I'm not sure it's correct. The 
thing is, moving the wait_task_inactive() to __put_task_struct() means 
that we will be doing the "release_task()" teardown while the task is 
still potentially active on another CPU.

In particular, we'll be freeing the security stuff and the signals while 
the process may still be active in the scheduler on another CPU. This can 
be dangerous, ie doing things like calling "free_uid()" on a process that 
is still running means that suddenly you have issues like not being able 
to trust "current->user" from interrupts. We may not care right now, but 
it's still wrong (imagine us doing per-user time accounting - which makes 
a _lot_ of sense).

		Linus

