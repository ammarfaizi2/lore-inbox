Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318954AbSICVtq>; Tue, 3 Sep 2002 17:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318955AbSICVtq>; Tue, 3 Sep 2002 17:49:46 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:39571 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318954AbSICVtk>; Tue, 3 Sep 2002 17:49:40 -0400
Message-Id: <5.1.0.14.2.20020903221201.00ac5770@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 03 Sep 2002 22:54:06 +0100
To: ptb@it.uc3m.es
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [RFC] mount flag "direct" (fwd)
Cc: Lars Marowsky-Bree <lmb@suse.de>, "Peter T. Breuer" <ptb@it.uc3m.es>,
       root@chaos.analogic.com, Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200209032107.g83L71h10758@oboe.it.uc3m.es>
References: <20020903185344.GA7836@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:07 03/09/02, Peter T. Breuer wrote:
>"A month of sundays ago Lars Marowsky-Bree wrote:"
> > On 2002-09-03T18:29:02,
> >    "Peter T. Breuer" <ptb@it.uc3m.es> said:
> > > If that presently is not possible, then I would like to think about
> > > making it possible.
> >
> > Just please, tell us why.
>
>You don't really want the whole rationale. It concerns certain
>european (nay, world ..) scientific projects and the calculations of the
>technologists about the progress in hardware over the next few years.
>We/they foresee that we will have to move to multiple relatively small
>distributed disks per node in order to keep the bandwidth per unit of
>storage at the levels that they will have to be at to keep the farms
>fed.  We are talking petabytes of data storage in thousands of nodes
>moving over gigabit networks.
>
>The "big view" calculations indicate that we must have distributed
>shared writable data.
>
>These calculations affect us all. They show us what way computing
>will evolve under the price and technology pressures. The calculations
>are only looking to 2006, but that's what they show. For example
>if we think about a 5PB system made of 5000 disks of 1TB each in a GE
>net, we calculate the aggregate bandwidth available in the topology as
>50GB/s, which is less than we need in order to keep the nodes fed
>at the rates they could be fed at (yes, a few % loss translates into
>time and money).  To increase available bandwidth we must have more
>channels to the disks, and more disks, ... well, you catch my drift.
>
>So, start thinking about general mechanisms to do distributed storage.
>Not particular FS solutions.

Hm, I believe you are barking up the wrong tree. Either you are omitting 
too much information in your statement above or you are contradicting 
yourself.

What you are looking for is _exactly_ particular FS solution(s)! And in 
particular you are looking for a truly distributed file system.

I just get the impression you are not fully aware what a distributed FS 
(call it DFS for short) actually is.

In my understanding a DFS offers exactly what you need: each node has disks 
and all disks on all nodes are part of the very same file system. Of course 
each node maintains the local disks, i.e. the local part of the file system 
and certain operations require that the nodes communicates with the "DFS 
master node(s)" in order for example to reserve blocks of disks or to 
create/rename files (need to make sure no duplicate filenames are 
instantiated for example). -- Sound familiar so far? You wanted to do 
exactly the same things but at the block layer and the VFS layer levels 
instead of the FS layer...

The difference between a DFS and your proposal is that a DFS maintains all 
the caching benefits of a normal FS at the local node level, while your 
proposal completely and entirely disables caching, which is debatably 
impossible (due to need to load things into ram to read them and to modify 
them and then write them back) and certainly no FS author will accept their 
FS driver to be crippled in such a way. The performance loss incurred by 
removing caching completely is going to make sure you will only be dreaming 
of those 50GiB/sec. More likely you will be getting a few bytes/sec... (OK, 
I exaggerate a bit.) The seek times on the disks together with the 
read/write timings are going to completely annihilate performance. A DFS 
maintains caching at local node level, so you can still keep open inodes in 
memory for example (just don't allow any other node to open the same file 
at the same time or you need to do some juggling via the "Master DFS node").

To give you an analogy, you can think of a DFS like a NUMA machine, where 
you have different access speeds to different parts of memory (for DFS the 
"storage device", same thing really) and where decision on where to store 
things are decided depending on the resource/time cost involved. Simplest 
example: A file created on node A, will be allocated/written to a disk (or 
multiple disks) located on node A, because accessing the local disks has a 
lower time cost compared to going to a different node over the slower wire.

Your time would be much better spent in creating the _one_ true DFS, or 
helping improve one of the existing ones instead of trying to hack up the 
VFS/block layers to pieces. It almost certainly will be a hell of a lot 
less work to implement a decent DFS in comparison to changing the block 
layer, the VFS, _and_ every single FS driver out there to comply with the 
block layer and VFS changes. And at the same time you get exactly the same 
features you wanted to have but with hugely boosted performance.

I hope my ramblings made some kind of sense...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

