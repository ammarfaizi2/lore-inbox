Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTADLDV>; Sat, 4 Jan 2003 06:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTADLDV>; Sat, 4 Jan 2003 06:03:21 -0500
Received: from packet.digeo.com ([12.110.80.53]:34985 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266840AbTADLDU>;
	Sat, 4 Jan 2003 06:03:20 -0500
Message-ID: <3E16C171.BFEA45AE@digeo.com>
Date: Sat, 04 Jan 2003 03:11:45 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Korty <joe.korty@ccur.com>
CC: sct@redhat.com, adilger@clusterfs.com, rusty@rustcorp.com.au,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, hch@sgi.com
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
References: <3E15F2F5.356A933D@digeo.com> from "Andrew Morton" at Jan 03, 2003 12:30:45 PM <200301040111.BAA00401@rudolph.ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2003 11:11:46.0172 (UTC) FILETIME=[11C243C0:01C2B3E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> 
> > In the previous episode of "travails of a geriatric kernel jock",
> > Andrew Morton wrote:
> > >
> > >  Unpatched 2.4.20 does the same thing.
> > >
> >
> > No it doesn't.
> >
> > Good news is that 2.4.20 plus recent ext3 fixes doesn't lock up
> > either.
> 
> Hi Andrew,
> I have continued to play with the problem, and have gathered more evidence.
> 
> Everything works (kinda) when I back out the attached 2.4.20-pre1
> patches.  I am not sure how to uniquely identify patches in the BK
> tree, so I have enclosed the full text of each at the end of this
> letter.
> 
> A remaining problem are long stallouts not present in 2.4.20.  The
> stallouts are of uniform duration, 20 seconds, triggered aperiodically.

This is because of differences in how sync() is handled between 2.4.20's
ext3 and 2.4.21-pre2's.

2.4.20:

  sync() will _start_ a commit, but will not wait on it.  This was done
  to fix a throughput problem with kupdate periodic writeback, which
  used to use the same code as sync.

  Not waiting on the writeout is OK by the letter of the POSIX spec,
  but is not traditional Linux behaviour, and is undesirable IMO.

2.4.21-pre2:

  sync() will start the commit, and will wait on it.  So you know that
  when it returns, everything which was dirty is now tight on disk.

So yes, running a looping sync while someone else is writing stuff
will take much longer in 2.4.21-pre2, because that kernel actually
waits on the writeout.


With respect to the lockup problem: it is due to a non-atomic __set_bit()
in the new buffer_attached() implementation.

Sure, we don't need atomic semantics for the BH_Attached bit because
it is always read and modified under a global spinlock.  But *other*
users of buffer_head.b_state do not run under that lock so the nonatomic
RMW will stomp on their changes.   2.4.20 does not have this bug.

Here is a patch:


--- 24/include/linux/fs.h~buffer_attached-fix	Sat Jan  4 03:09:13 2003
+++ 24-akpm/include/linux/fs.h	Sat Jan  4 03:09:16 2003
@@ -1202,7 +1202,7 @@ static inline void mark_buffer_async(str
 
 static inline void set_buffer_attached(struct buffer_head *bh)
 {
-	__set_bit(BH_Attached, &bh->b_state);
+	set_bit(BH_Attached, &bh->b_state);
 }
 
 static inline void clear_buffer_attached(struct buffer_head *bh)

_
