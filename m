Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSHHVqL>; Thu, 8 Aug 2002 17:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318036AbSHHVqL>; Thu, 8 Aug 2002 17:46:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7371 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318033AbSHHVqI>;
	Thu, 8 Aug 2002 17:46:08 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, andrea@suse.de, davej@suse.de,
       lkml <linux-kernel@vger.kernel.org>, Paul Larson <plars@austin.ibm.com>
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OFC67607F7.46F76DF9-ON85256C0F.007764F2-85256C0F.0077F591@us.ibm.com>
From: Hubertus Franke <frankeh@us.ibm.com>
Date: Thu, 8 Aug 2002 17:50:16 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Build V60_M14_08012002 Release
 Candidate|August 01, 2002) at 08/08/2002 17:48:41
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


Agreed ....
The mark-and-sweep is the correct method for 16-bits ! For 32-bits its not
possible !
Two level is over-engineered (as I told Paul).

If you want I can post the data that I collected comparing
(a) stock kernel
(b) my mark and sweep
(c) my double mark and sweep (try looking forward and then scan task list)
?

Let me know if you are interested.
That should clear up the issue quickly giving you some average allocation
times etc.....
as a function of random used pids.



Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003




                                                                                                                                     
                      Linus Torvalds                                                                                                 
                      <torvalds@transme        To:       Andrew Morton <akpm@zip.com.au>                                             
                      ta.com>                  cc:       Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>,    
                                                <davej@suse.de>, Hubertus Franke/Watson/IBM@IBMUS, <andrea@suse.de>                  
                      08/08/2002 04:24         Subject:  Re: [PATCH] Linux-2.5 fix/improve get_pid()                                 
                      PM                                                                                                             
                                                                                                                                     
                                                                                                                                     




On Wed, 7 Aug 2002, Andrew Morton wrote:
>
> Has this been evaluated against Bill Irwin's constant-time
> allocator?  Bill says it has slightly worse normal-case and
> vastly improved worst-case performance over the stock allocator.
> Not sure how it stacks up against this one.   Plus it's much nicer
> looking code.

Guys, this discussion is getting ridiculous.

Doing a bit allocator should be trivial, but it's hard to know when a bit
is to be free'd. You can't just do it at "exit()" time, because even if
pid X exits, that doesn't mean that X can be re-used: it may still be used
as a pgid or a tid by some other process Y.

So if you really want to take this approach, you need to count the uses of
"pid X", and free the bitmap entry only when that count goes to zero. I
see no such logic in Bill Irwin's code, only a comment about last use
(which doesn't explain how to notice that last use).

Without that per-pid-count thing clarified, I don't think the (otherwise
fairly straightforward) approach of Bills really flies.

For that reason I think the mark-and-sweep thing is the right thing to do,
but I think the two-level algorithm is just over-engineering and not worth
it. And I do hate that getpid_mutex thing. Having a blocking lock for
something as simple as pid allocation just smells horribly wrong to me.

Moving the pid allocation to later (so that it doesn't need to handle
operations that block in between allocation and "we're done" and the pid
allocation can be a spinlock) sounds like a fairly obvious thing to do.

I don't see why we would need the "pid" until the very last moment, at
which point we already have the tasklist lock, in fact.

And I hate overengineering.

                         Linus




