Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTFKAio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFKAin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:38:43 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51337
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262429AbTFKAij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:38:39 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: cachefs on linux
Date: Tue, 10 Jun 2003 20:51:34 -0400
User-Agent: KMail/1.5
Cc: Sean Hunter <sean@uncarved.com>, Shawn <core@enodev.com>,
       Matthias Schniedermeyer <ms@citd.de>,
       "Leonardo H. Machado" <leoh@dcc.ufmg.br>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.SOL.3.96.1030610213326.23899A-100000@virgo.cus.cam.ac.uk>
In-Reply-To: <Pine.SOL.3.96.1030610213326.23899A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306102051.34837.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 June 2003 16:39, Anton Altaparmakov wrote:
> On Tue, 10 Jun 2003, Rob Landley wrote:

> > Technically cachefs is just a union mount with tmpfs or ramfs as the
> > overlay on the underlying filesystem.  Doing a seperate cachefs is kind
> > of pointless in Linux.
>
> That is not correct (unless there is something about tmpfs/ramfs that I
> have missed).
>
> cachefs is very powerfull because it caches to both ram AND to local disk
> storage. Thus for example you can use cachefs to mount cdroms and then the
> first time some blocks are read they will come from the cdrom disk and
> subsequent reads of the same blocks will come out of the local hard drive
> and/or the local ram which is of course a lot faster. And you can do the
> same for nfs or any other slow and/or non-local file system in order to
> implement a faster cache.

Linux automatically caches files in ram, although mount hints that "this 
underlying data isn't going to change, so don't worry about coherence" would 
be nice.  (Maybe there are some already, I dunno quite what the semantics of 
read-only NFS mounts are...)

When cache is evicted due to memory pressure, the general assumption is that 
there are no pathologically slow connections in the system, so flushing NFS 
or CDROM data to swap would probably be a loss.

Maybe this is a bad assumption.  I know OS/2 used to prefault in DLL's and 
then swap them out immediately to avoid duplicating the linking overhead.  
(You may barf now.  But it bought them some interesting benchmark numbers at 
the time...)

> Also the cache is intelligent in that the LRU blocks are discarded when
> the cache is full (or to be precise above a certain adjustable threshold)
> and is replaced by data that is fetched from the slow/remote fs.
>
> AFAIK union mounting with tmpfs/ramfs could never give you such caching
> behaviour as cachefs on Solaris...

We've never really needed it.  What kind of setup causes a demand for it?  
(800 machines mounting their root partition off of a single NFS server, type 
thing?  Booting all of them after a power failure doesn't bring the setup to 
its knees anyway?)  These days ram is pretty cheap.  I admit that's a 
cop-out...

It doesn't so much sound like there's a need for another filesystem as a need 
for mount hints to the existing cacheing behavior.  (I.E. how expensive is a 
read from this device vs a read from that device if they are, indeed, 
seriously out of whack.)  Then again, if it's only used for a bogged down 
read-only NFS server on a machine with a fast local swap device (which, for 
some reason, doesn't want root to live on that writeable partition...)

How about extracting a tarball into tmpfs and using that to hold the data in 
question?  (Sounds like it'd work fine on boot, for example.)  If the data 
changes while it's mounted, your cacheing sounds dangerous.  If the data 
doesn't change while it's mounted, you effectively prefault the whole thing 
across the wire in compressed form exactly once and fling a much as is needed 
out to swap, with no CPU drain on the server (and CPU on the client's 
generally pretty cheap) and no kernel modification.

This may not be what you want, but I don't really know what you're trying to 
do.  It seems you want a filesystem that:

A) Is designed for read-only remote mounts that don't change.
B) On a slow or heavily used server,
C) Contains a dataset that's too big to store locally.

I get it.  You're doing 3D render farm clusters with Honking Big Datasets(tm), 
aren't you?

If the tarball->tmpfs idea isn't helpful, then no, Linux doesn't have a 
clusterfs I'm aware of.  Try thumping the Filesystem in Userspace guys.  
http://sourceforge.net/forum/forum.php?forum_id=254100

> Best regards,
>
> 	Anton

Rob
