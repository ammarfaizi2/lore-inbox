Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbTHaWeG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbTHaWeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:34:06 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:23193 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262937AbTHaWeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:34:03 -0400
Message-ID: <3F527C63.7090805@kegel.com>
Date: Sun, 31 Aug 2003 15:53:23 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: staelin@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: LMbench as gcc performance regression test?
References: <3F51A201.8090108@kegel.com> <20030831140037.GA16620@work.bitmover.com> <3F520773.1070907@kegel.com> <20030831145956.GE23783@work.bitmover.com>
In-Reply-To: <20030831145956.GE23783@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Here is some background, pick a benchmark and play with it and see if
> you can convince yourself of anything.  The basic idea is to run the
> benchmark TRIES times for $ENOUGH milliseconds.  TRIES is set to an odd
> number in bench.h because we sort the results and take the midpoint and
> print that as the result. 

It seems lat_pipe never does any median smoothing; it always sets TRIES to 1.
However, at least on the fairly quiet embedded system I'm testing on,
smoothing samples taken within a single run wouldn't make
a huge difference.  Any smoothing you get with that would be swamped by
the fact that lat_pipe's result has a bimodal distribution only one of whose
peaks shows up in any one run.
This sure sounds like the kind of thing page coloring is
supposed to solve; has anyone observed page coloring improving
the repeatability of the lat_pipe benchmark?

(There's no median smoothing in lat_pipe.c, I think, because it passes
a value >= 1000000 as the 2nd arg of BENCH:
                 BENCH(doit(p2[0], p1[1]), SHORT);
BENCH computes the number of samples to take the median of as
         __N = (get_enough(1000000) <= 100000) ? TRIES : 1;
get_enough() will always return at least what it is passed,
thus __N will always be 1.  It sure was whenever I printed it out, too.
This seems to be the case for the following tests:
bw_pipe  bw_tcp  bw_unix
lat_fcntl lat_fifo lat_pipe lat_rpc lat_tcp lat_udp lat_unix)
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

