Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291022AbSBGBLL>; Wed, 6 Feb 2002 20:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291019AbSBGBLE>; Wed, 6 Feb 2002 20:11:04 -0500
Received: from ua0d5hel.dial.kolumbus.fi ([62.248.132.0]:62732 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S291022AbSBGBKu>; Wed, 6 Feb 2002 20:10:50 -0500
Message-ID: <3C61D409.1B9B5895@kolumbus.fi>
Date: Thu, 07 Feb 2002 03:10:33 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <Pine.LNX.4.33.0202061329370.4542-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> since there is lots of idle CPU time left, the only thing that could make
> a difference is timeslice length.
> to 'fix' this (temporarily), renice all the non-SCHED_FIFO processes to
> nice +19, that will give them the minimum timeslice length.

That caused a "choke" effect of about 10 seconds and then returned back to
normal without visible change.

> again, what does it need to cause the 'bad' situation - too much latency
> in the sound delivery path causing the audio buffers to starve? (or audio
> buffers to be dropped?)

If processes doing read()/write() on socket are not scheduled fast enough it
will cause sender thread in distributor process (SCHED_FIFO) to loose
pthread_cond_*() event for new block of data. This is non-waiting datablock
posting mechanism is made to prevent one hung or otherwise nonresponding
process from affecting other processes dataflow, esp. in SMP systems. So all
the output threads must be back from write() on pthread_cond_wait() before
input thread finishes it's read() and issues pthread_cond_broadcast() for
new datablock. If one of those output threads is not on pthread_cond_wait()
it will of course loose it's datablock.


I made even more testing and found situation where the old scheduler also
does same thing. It seems to be related to processes frequency(/size) of
issuing read()/write() calls on socket. Below _and_ above this frequency
everything works fine. This frequency is a bit lower on old scheduler. So
there is some kind of grey frequency region.


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

