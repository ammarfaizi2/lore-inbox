Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTBPJT4>; Sun, 16 Feb 2003 04:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTBPJT4>; Sun, 16 Feb 2003 04:19:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:49608 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266064AbTBPJTz>;
	Sun, 16 Feb 2003 04:19:55 -0500
Date: Sun, 16 Feb 2003 01:30:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, zwane@holomorphy.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: tbench as a load - DDOS attack?
Message-Id: <20030216013029.0aa71376.akpm@digeo.com>
In-Reply-To: <200302161007.25149.kernel@kolivas.org>
References: <200302161007.25149.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2003 09:29:44.0240 (UTC) FILETIME=[F090D300:01C2D59D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> 
> Zwane M suggested using tbench as a load to test one of his recent patches and 
> gave me the idea to try using tbench_load in contest. Here are the first set 
> of results I got while running tbench 4 continuously (uniprocessor machine):
> 
> tbench_load:
> Kernel         [runs]   Time    CPU%    
> test2420            1   180     38.9    
> test2561            1   970     7.7   
> 
> This is a massive difference. Sure tbench was giving better numbers on 2.5.61 
> but it caused a massive slowdown. I wondered whether this translates into 
> being more susceptible to ping floods or DDOS attacks? You should have seen 
> tbench 16 - 3546 seconds!
> 

Yes, something is wrong with the CPU scheduler.  Simple test case:

	./tbench_srv &
	while true
	do
		./tbench 4
	done &
	cd /usr/src/util-linux
	time make -j4

The tbench activity takes the time to compile util-linux from 13 second to
133 seconds.

But that is not the whole story.  The compilation appeared to make no
progress at all while tbench was running - it was only in the gaps between
ending one tbench run and starting another that the compilation did anything.

When I changed the load to one instance of

	while true
	do
		./tbench 2
	done

	and one instance of

	while true
	do
		./tbench 3
	done

the compilation made no progress except for those rare instances when the two
shell scripts were restarting the tbench run at the same time.  After a while
the scripts fell itno synchronism, and the compilation took 260 seconds.

Conclusion: tbench completely starves the `make'.

It mainly seems to affect uniprocessor builds.  SMP was much better behaved.

Adding the sched-f3 patch basicaly fixed it all up.  The 133 second build
came down to 55 seconds, and the compilation was visibly making progress
during the tbench runs.

