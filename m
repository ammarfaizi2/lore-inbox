Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSGXNkS>; Wed, 24 Jul 2002 09:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317283AbSGXNkR>; Wed, 24 Jul 2002 09:40:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17349 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317280AbSGXNkE>;
	Wed, 24 Jul 2002 09:40:04 -0400
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0,  mode:0x0
To: Andrew Morton <akpm@zip.com.au>
Cc: akpm@e4.ny.us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF58871EFC.4272F3EB-ON85256C00.004B3677@pok.ibm.com>
From: "David F Barrera" <dbarrera@us.ibm.com>
Date: Wed, 24 Jul 2002 08:42:55 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/24/2002 09:43:03 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

I tried the change to ptrace.c, but it did not work.  I cannot boot the
machine.  It gives an oops upon boot.

Unable to handle kernel paging request at virtual address 20203444
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01a19db>]    Not tainted
EFLAGS: 00010002
eax: f7942000   ebx: f7942000   ecx: 0000f209   edx: 20203320
esi: 0000f209   edi: 00000046   ebp: c6a574c0   esp: c6aedebc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, threadinfo=c6aec000 task=c6aea040)
Stack: 00000002 c01b81f6 f7942000 c01b8476 c6a574c0 c01b8ddd c6a574c0
00000009
       00000000 c03ee9a0 46460000 00000000 00000046 0000270f 00000001
c01b920b
       00000046 00000001 c6aedf15 c0112d70 c039ee40 00000001 00000000
c039ee40
Call Trace: [<c01b81f6>] [<c01b8476>] [<c01b8ddd>] [<c01b920b>]
[<c0112d70>]
   [<c01b927c>] [<c01092de>] [<c01094e4>] [<c01052f0>] [<c0107957>]
[<c01052f0>]
   [<c01052f0>] [<c010531a>] [<c01053c2>] [<c0117058>]

Code: f6 82 24 01 00 00 08 74 26 0f b6 83 25 01 00 00 b9 01 00 00
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Regards,

David F Barrera
Linux Technology Center, IBM
T/L 678-1375   External 838-1375
dbarrera@us.ibm.com


                                                                                                                                       
                      Andrew Morton                                                                                                    
                      <akpm@zip.com.au>        To:       Andrea Arcangeli <andrea@suse.de>                                             
                      Sent by:                 cc:       David F Barrera/Austin/IBM@IBMUS, linux-kernel@vger.kernel.org                
                      akpm@e4.ny.us.ibm        Subject:  Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0,        
                      .com                      mode:0x0                                                                               
                                                                                                                                       
                                                                                                                                       
                      07/23/2002 04:16                                                                                                 
                      PM                                                                                                               
                                                                                                                                       
                                                                                                                                       



Andrea Arcangeli wrote:
>
> On Tue, Jul 23, 2002 at 01:47:28PM -0700, Andrew Morton wrote:
> > Andrea Arcangeli wrote:
> > >
> > > On Tue, Jul 23, 2002 at 12:24:04PM -0700, Andrew Morton wrote:
> > > > David F Barrera wrote:
> > > > >
> > > > > I have experienced the following errors while running a test
suite (LTP
> > > > > test suite)  on the 2.4.26 kernel.  Has anybody seen this
problem, and, if
> > > > > so, is there a patch for it?  Thanks.
> > > > >
> > > > > kernel BUG at page_alloc.c:92!
> > > >
> > > > Could you please replace the put_page(page) in
> > > > kernel/ptrace.c:access_process_vm() with page_cache_release(page)
> > > > and retest?
> > >
> > > I prefer to drop page_cache_release and to have __free_pages_ok to
deal
> > > with the lru pages like it's been fixed in 2.4.
> >
> > That would fix it too.  But a __free_pages_ok call from interrupt
> > context can deadlock the box.
>
> I guess you mean it can corrupt the lru list, not necessairly deadlock
> the box.

Take the lock from interrupt context and it'll deadlock.

> That's not the case either though, see the in_interrupt() check
> in my tree in free_pages_ok, only normal context is allowed to play with
> pagecache. (async-io isn't in my tree)

Yes, I'm adding the same check to 2.5.  It's anon pages as well
as pagecache pages.  And unless we have a

             BUG_ON(PageLRU(page) && in_interrupt())

in put_page_testzero() then I'm not sure how we can be sure that
aio is the only problem area.

> >
> > The removal of pages from the LRU is rather a mess.  It's getting
> > better, and we can fix up some more of this if/when pagemap_lru_lock
> > becomes an interrupt-safe lock.
>
> that will allow irq to manage pagecahce but the fact it's not interrupt
> safe it's really a irq latency feature,

Not sure what you mean by this?

> the fact disabling irqs during
> the critical section decreases contention on the lock is kind of hack,
> that is true for all spinlocks out there, by that argument all spinlocks
> should be irq safe.

Sure.  If the lock is heavily used, performance critical and you've
done the work to ensure that maximum hold time is small, it is
well worth doing.  Plus we need it for free-from-interrupt-context,
and we may need it for performing LRU list motion within IO completion,
although that's looking a bit remote at present.


-





