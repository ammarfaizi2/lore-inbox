Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261714AbSJQRJ0>; Thu, 17 Oct 2002 13:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSJQRJ0>; Thu, 17 Oct 2002 13:09:26 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:19906 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261714AbSJQRJZ>; Thu, 17 Oct 2002 13:09:25 -0400
Date: Thu, 17 Oct 2002 15:15:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Pathological case identified from contest
In-Reply-To: <3DAE6826.72C345EE@digeo.com>
Message-ID: <Pine.LNX.4.44L.0210171506260.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, Andrew Morton wrote:

> No, it's a bug in either the pipe code or the CPU scheduler I'd say.

The scheduler definately seems to have a big error here.

Say we're doing a pipe test with 3 processes.  On an idle
system this would result in each process getting 33% of
the CPU and using the other 66% of the time sleeping.
Of course, this makes all 3 processes "interactive", since
they sleep twice as much as they run.

Now introduce 1 CPU hog in competition to this load, this
CPU hog never sleeps so it is quickly marked as cpu hog and
will end up on the expired array after one timeslice (150 ms?).

The pipe processes will have the CPU all to themselves until
STARVATION_LIMIT (2 seconds) time has passed.

This means that the CPU hog will get 7.5% of the CPU, while
the pipe processes get the other 92.5% of the CPU, or 30.8%
each, almost 4 times as much as the CPU hog.

This could either mean the sleep average isn't a useful way
to measure CPU priority or the way we measure the sleep
average needs to be changed somewhat...

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

