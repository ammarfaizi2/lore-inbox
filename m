Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbTBWV5l>; Sun, 23 Feb 2003 16:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268964AbTBWV5l>; Sun, 23 Feb 2003 16:57:41 -0500
Received: from franka.aracnet.com ([216.99.193.44]:1491 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268954AbTBWV5k>; Sun, 23 Feb 2003 16:57:40 -0500
Date: Sun, 23 Feb 2003 14:07:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pte-highmem vs UKVA (was: object-based rmap and pte-highmem)
Message-ID: <22420000.1046038049@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302231335090.1534-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302231335090.1534-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > The thing is, you _cannot_ have a per-thread area, since all threads
>> > share the same TLB.  And if it isn't per-thread, you still need all the
>> > locking and all the scalability stuff that the _current_ pte_highmem
>> > code needs, since there are people with thousands of threads in the
>> > same process. 
>> 
>> I don't see why that's an issue - the pagetables are per-process, not
>> per-thread.
> 
> Exactly. Which means that UKVA has all the same problems as the current 
> global map.
> 
> There are _NO_ differences. Any problems you have with the current global 
> map you would have with UKVA in threads. So I don't see what you expect
> to  win from UKVA.

This just just for PTEs ... for which at the moment we have two choices:
1. Stick them in lowmem (fills up the global space too much).
2. Stick them in highmem - too much overhead doing k(un)map_atomic
   as measured by both myself and Andrew.

Using UKVA for PTEs seems to be a better way to implement pte-highmem to me.
If you're walking another processes' pagetables, you just kmap them as now,
but I think this will avoid most of the kmap'ing (if we have space for two
sets of pagetables so we can do a little bit of trickery at fork time).
 
>> Yes, that was a stalling point for sticking kmap in there, which was
>> amongst my original plotting for it, but the stuff that's per-process
>> still works. 
> 
> Exactly what _is_ "per-process"? The only thing that is per-process is 
> stuff that is totally local to the VM, by the linux definition.

The pagetables.

> And the rmap stuff certainly isn't "local to the VM". Yes, it is torn
> down  and built up by the VM, but it needs to be traversed by global code.

Sorry, subject was probably misleading ... I'm just talking about the
PTEs here, not sticking anything to do with rmap into UKVA. 

Partially object-based rmap is cool for other reasons, that have little to
do with this. ;-)

M.
