Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284677AbRLIXmb>; Sun, 9 Dec 2001 18:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284674AbRLIXmV>; Sun, 9 Dec 2001 18:42:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45330 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284671AbRLIXmL>; Sun, 9 Dec 2001 18:42:11 -0500
Subject: Re: [RFC][PATCH] 2.5.0 Multi-Queue Scheduler
To: kravetz@us.ibm.com (Mike Kravetz)
Date: Sun, 9 Dec 2001 23:51:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20011209143152.A1087@w-mikek2.sequent.com> from "Mike Kravetz" at Dec 09, 2001 02:31:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DDj6-0008H8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I assume the queue a task is assigned to is based on its priority?
> Or am I way off.  Are there 8 ranges of priorities for runnable tasks?
> Just curious how you came up with 8.  We also dabbled with a scheduler

8 queues makes it economical to compute the ffz by lookup. (Well
actually 9 queues including idle). To go to 32 queues means I have to
rely on hardware ffz or for other processors on a multiply, 26bit shift and
64 way lookup.

While 
	queue = queue_lookup[(0x0450FBAF*runnable)>>26];

makes for glorious obfuscating scheduling its not good for speed ;)

> that had queues based on task priority.  One issue was that we couldn't
> seem to come up with an optimal number of queues to represent all task
> priorities.

For now I'm ignoring real time. The priority is a combination of two things
->count, which is computed as before and means a higher priority task gets
a bit more time, and ->queue which when a task wakes is based on ->count.
Everyone who exceeds their quantum ends up in the lowest priority queue
next time around. 

Tasks with roughly the same priority will not neccessarily run in strict
priority order but they will get appropriate extra time and run before
anything measurably different in priority.

Incidentally you can test the "approximate order" behaviour simply by
hacking goodness. I couldn't tell the difference before or after so I feel
its probably acceptable.

Alan
