Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTBJDd0>; Sun, 9 Feb 2003 22:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTBJDd0>; Sun, 9 Feb 2003 22:33:26 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:46720 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261448AbTBJDdY>; Sun, 9 Feb 2003 22:33:24 -0500
Date: Mon, 10 Feb 2003 01:42:28 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Con Kolivas <ckolivas@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <20030209144622.GB31401@dualathlon.random>
Message-ID: <Pine.LNX.4.50L.0302100127250.12742-100000@imladris.surriel.com>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com>
 <20030209144622.GB31401@dualathlon.random>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Andrea Arcangeli wrote:

> The only way to get the minimal possible latency and maximal fariness is
> my new stochastic fair queueing idea.

"The only way" ?   That sounds like a lack of fantasy ;))

Having said that, I like the idea of using SFQ for fairness,
since it seems to work really well for networking...
I'll definately try such a patch.

> The only other possible fix would be to reduce the I/O queue to say
> 512kbytes and to take advantage of the FIFO behaviour of the queue
> wakeups, I tried that, it works so well, you can trivially test it with
> my elevator-lowlatency by just changing a line, but the problem is 512k
> is a too small I/O pipeline, i.e. it is not enough to guarantee the
> maximal throughput during contigous I/O.

Maybe you want to count the I/O pipeline size in disk seeks
and not in disk blocks ?

In the time of one disk seek plus half rotational latency
(12 ms) you can do a pretty large amount of reading (>400kB).
This means that for near and medium disk seeks you don't care
all that much about how large the submitted IO is. Track buffers
further reduce this importance.

OTOH, if you're seeking to the track next-door, or have mixed
read and write operations on the same track, the seek time
goes to near-zero and only the rotational latency counts. In
that case the size of the IO does have an influence on the
speed the request can be handled.

> the stochastic fair queueing will also make the anticipatory scheduling
> a very low priority to have. Stochasting fair queueing will be an order
> of magnitude more important than anticipatory scheduling IMHO.

On the contrary, once we have SFQ to fix the biggest elevator
problems the difference made by the anticipatory scheduler should
be much more visible.

Think of a disk with 6 track buffers for reading and a system with
10 active reader processes. Without the anticipatory scheduler you'd
need to go to the platter for almost every OS read (because each
process flushes out the track buffer for the others), while with the
anticipatory scheduler you've got a bigger chance of having the data
you want in one of the drive's track buffers, meaning that you don't
need to go to the platter but can just do a silicon to silicon copy.

If you look at the academic papers of an anticipatory scheduler, you'll
find that it gives as much as a 73% increase in throughput.
On real-world tasks, not even on specially contrived benchmarks.

The only aspect of the anticipatory scheduler that is no longer needed
with your SFQ idea is the distinction between reads and writes, since
your idea already makes the (better, I guess) distinction between
synchronous and asynchronous requests.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
