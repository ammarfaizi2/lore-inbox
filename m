Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSGCJlL>; Wed, 3 Jul 2002 05:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSGCJlK>; Wed, 3 Jul 2002 05:41:10 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:25101 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S315413AbSGCJlK>; Wed, 3 Jul 2002 05:41:10 -0400
Message-ID: <3D22C735.7A5F299A@aitel.hist.no>
Date: Wed, 03 Jul 2002 11:43:17 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.24-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
References: <Pine.LNX.4.44.0207011758180.3104-100000@netfinity.realnet.co.sz> <3D216157.FC60B17E@aitel.hist.no> <200207021333.36435.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

> I've seen it. 1GB of swap for caching heavy downloads (se earlier thread 'VM
> fsckup' or somehting)
> 
> What is the reason of using swap for cache buffers?????

To be precise - swap is never used _for_ cache buffers - you'll
never see file contents in the swap partition, perhaps with
the exception of tmpfs stuff.

But aggressive caching may indeed push other stuff into swap,
typically little-used program memory.

The balance is probably off, but the feature is a good one.
The point is to minimize disk waiting by ensuring that
often-used stuff is in memory, possibly pushing seldom-used
stuff into swap.

Some workload results in some files being accessed a lot,
such as the homepage files for a webserver.  Caching them
makes sense then, even if some little-used sleeping
program is pushed into swap.  It is used less than those
often-used files, so recovering it from swap when it
eventually is needed results in less total waiting
than what you get if every web server access hits the disk.

The balance being off have several explanations:
1. People don't _expect_ to wait for paging activity, while
   they expect having to wait for the disk.
2. Selecting wich pages to keep and which to swap (or
   not cache if it is a data file) is hard.
   The reverse mapping VM will limit the unnecessary swapping,
   making the best decision is sometimes impossible without
   it, or at least much harder.  
3. The problem is still hard, even with rmap.  That's because
   we don't know how files and executables will be used in
   the future.  All we have to make the decision is statistics
   about previous use.  
   Allowing applications to give the kernel hints may help,
   but giving good hints may be hard, and the potential
   for abuse is there.  (App gives unrealistic hints - 
   and seems more snappy than the competition.  And lots
   of other processes suffer.)  This is avoidable by only
   allowing negative hints, i.e. "Don't bother caching this"

You probably agree that it makes sense to swap out
program initialization code that won't be used
again once the program is up and running.  The problem is
that the VM system can't identify such code other than
by the fact that it is a long time since the last use.

Helge Hafting
