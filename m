Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318124AbSIFIMU>; Fri, 6 Sep 2002 04:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSIFIMU>; Fri, 6 Sep 2002 04:12:20 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:23506 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S318124AbSIFIMS>; Fri, 6 Sep 2002 04:12:18 -0400
Date: Fri, 6 Sep 2002 10:14:38 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Message-ID: <20020906101438.P781@nightmaster.csn.tu-chemnitz.de>
References: <3D771613.783E3B15@aitel.hist.no> <200209051424.g85EOx105274@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200209051424.g85EOx105274@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Sep 05, 2002 at 04:24:59PM +0200
X-Spam-Score: -3.4 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *17nEIR-0006bN-00*ocoONjxITkA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

after following this discussion I have some ideas which might
help you, but have to ask some more questions to find out clearly
what you are trying to do and express it in terms known to this
audience (which has failed so far, it seems).

1. You want to stream lots of data from a external source (which
   might be the network) to a bunch of machines which are
   connected to the same file system, where file system is a file
   system designed to be a local one (like FAT, NTFS, EXT2FS and
   so on). 
   
   
2. This filesystem is on a single device, which is attached to
   multiple machines, right?

3. You problem is, that your data arrives at some hundred MB/s
   right?

4. You want to solve it by force with using multiple machines to
   accept the data but sharing one super fast persistent device
   between them, ok?

5. To archieve 4. you cannot trust the caches and want to disable
   them?

6. Do you have a "master" machine or do you want each machine
   only peering each other?

7. Is fast bidirectional communication between the machines over
   some kind of wire/network possible?

I would suggest not to disable caches, but to use timed leases on
them to not penalize read only metadata operations (which are
~100% in your case).

If you read in some cache item, then you tell all your machines,
that you did so and want to use it read only for a time of X.
That is called a "lease", because other machines can tell you, that
you cannot use your cache anymore, because they need to
invalidate it. Leases can be broken by the grantor as opposed to
locks, which can only be released by the holder.

You can make the cache items very big and chunk them together to
reduce communication overhead, so performance should not be that
bad.

The writing case happens not that often you say, so you can make
it as easy as:

   1) Disallow new leases on the related items (if you cannot
      find out relations, than disallow ALL new leases).

   2) Breaking all related leases while telling them
      waiting for the lease clients to ACK the breakage.

   3) Do you update, flush it to disk.

   4) Reallow leases.

One of your problems are file extension and mtime updates.

This could be solved by restricting both to only one machine and
propagating the changes to the other machines. It's like an
allocator thread, if you are familiar with this concept.

These mechanisms are basically some kind of cache coherency
protocol. A special network between these machines just for that
might be worthwhile. 

You don't need to change ANY on-disk format.
You need to change the locks of kernel meta data caching into
leases.

Now you have sth. to work with, which is well known, is
performant in your use case and acceptable in OS terms.

But please answer my questions and doubts first, because I might
be way off, if my assumptions are wrong.

Hope this helps.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
