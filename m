Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSHHTCW>; Thu, 8 Aug 2002 15:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317799AbSHHTCW>; Thu, 8 Aug 2002 15:02:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37791 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317743AbSHHTCU>;
	Thu, 8 Aug 2002 15:02:20 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@zip.com.au>, andrea@suse.de, davej@suse.de,
       lkml <linux-kernel@vger.kernel.org>, Paul Larson <plars@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OF107F9BDE.0B57DFBC-ON85256C0F.00669FD0-85256C0F.00681292@us.ibm.com>
From: Hubertus Franke <frankeh@us.ibm.com>
Date: Thu, 8 Aug 2002 14:56:44 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Build V60_M14_08012002 Release
 Candidate|August 01, 2002) at 08/08/2002 15:05:43
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


Which one sounds like the best one ?

Assuming that for now we have to stick to 16-bit pid_t ....
There are the following patches out there ....:

(a) Vanilla version which breaks down after 22K pids and really sucks above
32.5K
(b) Bill Irwin's, which keeps track of which PID is free and which one is
not ?
(c) Andrea's patch which searches in the bitmap when we are running out
(d) Paul's patch, which I believe was based on one of my earlier submission
(03/02) that
                                 essentially switches between (a)+(c) at
the break even point.

Assuming that Paul's patch still resembles somewhat my earlier intentions:
My observation of (d) back in february was that the current approach with
using next_pid = ++last_pid in the general case is pretty good and that
only the determination of a guaranteed free range sucks due to O(N**2)
algorithm sucks and using a bitmap to determine the next safe range
through a O(N) algorithm is good. I determined the breakeven point with
random pid deletion to be ~22K where the current algorithm worked darn
well.
One difference to Andrea's patch (c) is  (if I remember his code correctly)
that
I used was that I always look forward in the bitmap for the next safe range
in the
bitmap when I exhausted the previous one without having to traverse the
task list.
Only if non is found I traverse the task list and try the bit search one
more time.

I feel (c) or (d) is a better solution over (a) and (b)...   Open for
discussion.
I have a test program that does the random pid deletion and pid allocation
in user space. All what's required is to copy the get_pid() code from the
kernel into there... Can make that available ...

I don't know what Paul has done to the patch since then ....

-- Hubertus Franke  (frankeh@watson.ibm.com)





                                                                                                                                     
                      Andries Brouwer                                                                                                
                      <aebr@win.tue.nl>        To:       Andrew Morton <akpm@zip.com.au>                                             
                                               cc:       Paul Larson <plars@austin.ibm.com>, Linus Torvalds <torvalds@transmeta.     
                      08/07/2002 08:24          com>, lkml <linux-kernel@vger.kernel.org>, davej@suse.de, Hubertus                   
                      PM                        Franke/Watson/IBM@IBMUS, andrea@suse.de                                              
                                               Subject:  Re: [PATCH] Linux-2.5 fix/improve get_pid()                                 
                                                                                                                                     
                                                                                                                                     
                                                                                                                                     



On Wed, Aug 07, 2002 at 04:06:05PM -0700, Andrew Morton wrote:

> Has this been evaluated against Bill Irwin's constant-time
> allocator?  Bill says it has slightly worse normal-case and
> vastly improved worst-case performance over the stock allocator.
> Not sure how it stacks up against this one.   Plus it's much nicer
> looking code.

> #define PID_MAX                    0x8000
> #define RESERVED_PIDS        300
>
> #define MAP0_SIZE            (PID_MAX   >> BITS_PER_LONG_SHIFT)
> #define MAP1_SIZE            (MAP0_SIZE >> BITS_PER_LONG_SHIFT)
> #define MAP2_SIZE            (MAP1_SIZE >> BITS_PER_LONG_SHIFT)
>
> static unsigned long pid_map0[MAP0_SIZE];
> static unsigned long pid_map1[MAP1_SIZE];
> static unsigned long pid_map2[MAP2_SIZE];

Here it is of interest how large a pid is.
With a 64-bit pid_t it is just

  static pid_t last_pid;

  pid_t get_next_pid() {
             return ++last_pid;
  }

since 2^64 is a really large number.
Unfortunately glibc does not support this (on x86).

With a 32-bit pid_t wraparounds will occur, but very infrequently.
Thus, finding the next pid will be very fast on average, much faster
than the above algorithm, and no arrays are required.
One only loses the guaranteed constant time property.
Unless hard real time is required, this sounds like the best version.

Andries



