Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267201AbSIRQJy>; Wed, 18 Sep 2002 12:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267232AbSIRQJy>; Wed, 18 Sep 2002 12:09:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51469 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267201AbSIRQJx>; Wed, 18 Sep 2002 12:09:53 -0400
Date: Wed, 18 Sep 2002 09:15:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Ingo Molnar <mingo@elte.hu>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918123206.GA14595@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0209180906460.1913-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Andries Brouwer wrote:
> 
> Please leave pid_max large.

I have to agree.

There is no goodness in making life complicated, and then putting a lot of 
effort in solving that complexity with other complexity.

I would suggest something like this:
 - make pid_max start out at 32k or whatever, to make "ps" look nice if 
   nothing else.
 - every time we have _any_ trouble at all with looking up a new pid, we 
   double pid_max.

And it's really easy to recognize trouble with something truly trivial
like the appended. 

Give me one reason for why these two added lines aren't better than all
the complexity we've discussed? I can pretty much _guarantee_ that it's
faster, and it sure as hell is simpler. And all traditional uses that has
less than a few thousand threads at most will never see the larger pids, 
so people can stare at "ps" output without going blind - the big pids 
start showing up only on boxes that might actually _need_ them.

		Linus

----
--- 1.77/kernel/fork.c	Sun Sep 15 11:01:39 2002
+++ edited/fork.c	Wed Sep 18 09:11:43 2002
@@ -175,6 +175,8 @@
 
 	if (last_pid >= next_safe) {
 inside:
+		if (nr_threads > pid_max >> 4)
+			pid_max <<= 1;
 		next_safe = pid_max;
 		read_lock(&tasklist_lock);
 	repeat:

