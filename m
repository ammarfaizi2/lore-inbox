Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319136AbSIDL3a>; Wed, 4 Sep 2002 07:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319139AbSIDL3a>; Wed, 4 Sep 2002 07:29:30 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:28176 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319136AbSIDL33>; Wed, 4 Sep 2002 07:29:29 -0400
Message-ID: <3D75EFBC.77F51F5A@aitel.hist.no>
Date: Wed, 04 Sep 2002 13:34:20 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] mount flag "direct"
References: <200209040915.g849Ftf29959@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:

> There is no problem locking and serializing groups of
> read/write accesses.  Please stop harping on about THAT at
> least :-). What is a problem is marking the groups of accesses.

Sorry, I now see you dealt with that in other threads.
> 
> That's fine. And I don't see what needs to be reread. You had this
> problem once with smp, and you beat it with locks.
> 
Consider that taking a lock on a SMP machine is a fairly fast
operation.  Taking a lock shared over a network probably
takes about 100-1000 times as long.

People submit patches for shaving a single instruction
off the SMP locks, for performance.  The locking is removed
on UP, because it makes a difference even though the
lock never is busy in the UP case.  A much slower lock will
either hurt performance a lot, or force a coarse granularity.
The time spent on locking had better be a small fraction
of total time, or you won't get your high performance.
A coarse granularity will limit your software so the
different machines mostly use different parts of the 
shared disks, or you'll loose the parallellism.
I guess that is fine with you then.


> > it is useless for everything, although it certainly is useless
> > for the purposes I can come up with.  The only uses *I* find
> > for a shared writeable (but uncachable) disk is so special that
> > I wouldn't bother putting a fs like ext2 on it.  
> 
> It's far too inconvenient to be totally without a FS. What we
> want is a normal FS, but slower at some things, and faster at others,
> but correct and shared. It's an approach. The caclulations show
> clearly that r/w  (once!) to existing files are the only performance
> issues. The rest is decor. But decor that is very nice to have around.

Ok.  If r/w _once_ is what matters, then surely you don't
need cache.  I consider that a rather unusual case though,
which is why you'll have a hard time getting this into
the standard kernel.  But maybe you don't need that?

Still, you should consider writing a fs of your own.
It is a _small_ job compared to implementing your locking
system in existing filesystems.  Remember that those
filesystems are optimized for a common case of a few
cpu's, where you may take and release hundreds or 
thousands of locks per second, and where data transfers
often are small and repetitive.  Caching is so
useful for this case that current fs code is designed
around it.

With a fs of your own you won't have to worry about
maintainers changing the rest of the fs
code.  That sort of thing is hard to keep up with
with the massive changes you'll need for your sort
of distributed fs.  A single-purpose fs isn't such a
big job, you can leave out design considerations
that don't apply to your case.  

Helge Hafting
