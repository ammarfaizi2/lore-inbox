Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264974AbTIJOx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTIJOx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:53:27 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:36542 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264974AbTIJOxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:53:24 -0400
Date: Wed, 10 Sep 2003 07:53:17 -0700
From: Larry McVoy <lm@bitmover.com>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: uek32z@phoenix.hadiko.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910145317.GA32321@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Luca Veraldi <luca.veraldi@katamail.com>, uek32z@phoenix.hadiko.de,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <E19x3el-0002Fc-Rj@phoenix.hadiko.de> <03ca01c37795$6497ac80$5aaf7450@wssupremo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ca01c37795$6497ac80$5aaf7450@wssupremo>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 02:16:40PM +0200, Luca Veraldi wrote:
> > I've read your posting on the lkml and also the answers
> > concerning IPC mechanisms on Linux.
> > You speak English very well - why don't you translate your
> > page into english, I think many people would be very interested
> > in it... at least I am ;) Unfortunately not many kernel hackers
> > are able to understand Italian, I think...
> 
> Page is now in English since last night (Italian time).
> Please, refresh your browser.
> 
> http://web.tiscali.it/lucavera/www/root/ecbm/index.htm
> for English users and

I read it and I must be missing something, which is possible, I need more
coffee.

I question the measurement methodology.  Why didn't you grab the sources
to LMbench and use them to measure this?  It may well be that you disagree
with how it measures things, which may be fine, but I think you'd benefit
from understanding it and thinking about it.  It's also trivial to add
another test to the system, you can do it in a few lines of code.

I also question the results.  I modified lat_pipe.c from LMbench to measure
a range of sizes, code is included below.  The results don't match yours at
all.  This is on a 466Mhz Celeron running RedHat 7.1, Linux 2.4.2.  The 
time reported is the time to send and receive the data between two processes,
i.e., 

	Process A		Process B
	write
		 <context switch>
				read
				write
		 <context switch>
	read

In other words, the time printed is for a round trip.  Your numbers
appear to be off by a factor of two, they look pretty similar to mine
but as far as I can tell you are saying that it costs 4 usecs for a send
and 4 for a recv and that's not true, the real numbers are 2 sends and
2 receives and 2 context switches.

     1 bytes: Pipe latency: 8.0272 microseconds
     8 bytes: Pipe latency: 7.8736 microseconds
    64 bytes: Pipe latency: 8.0279 microseconds
   512 bytes: Pipe latency: 10.0920 microseconds
  4096 bytes: Pipe latency: 19.6434 microseconds
 40960 bytes: Pipe latency: 313.3328 microseconds
 81920 bytes: Pipe latency: 1267.7174 microseconds
163840 bytes: Pipe latency: 3052.1020 microseconds

I want to stick some other numbers in here from LMbench, the signal
handler cost and the select cost.  On this machine it is about 5 usecs
to handle the signal and about 4 for select on 10 file descriptors.

If I were faced with the problem of moving data between processes at very
low cost the path I choose would depend on whether it was a lot of data
or just an event notification.  It would also depend on whether the 
receiving process is doing anything else.  Let's walk a couple of those
paths:

If all I want to do is let another process know that something has happened
then a signal is darn close to as cheap as I can get.  That's what SIGUSR1
and SIGUSR2 are for.  

If I wanted to move large quantities of data I'd combine signals with 
mmap and mutexes.  This is easier than it sounds.  Map a scratch file,
truncate it up to the size you need, start writing into it and when you
have enough signal the other side.  It's a lot like the I/O loop in 
many device drivers.  

So I guess I'm not seeing why there needs to be a new interface here.
This looks to me like you combine cheap messaging (signals, select,
or even pipes) with shared data (mmap).  I don't know why you didn't
measure that, it's the obvious thing to measure and you are going to be
running at memory speeds.

The only justification I can see for a different mechanism is if the 
signaling really hurt but it doesn't.  What am I missing?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
