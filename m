Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSEQNdK>; Fri, 17 May 2002 09:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316215AbSEQNdJ>; Fri, 17 May 2002 09:33:09 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:64642 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315423AbSEQNdI>; Fri, 17 May 2002 09:33:08 -0400
Date: Fri, 17 May 2002 08:32:03 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205171332.IAA93516@tomcat.admin.navo.hpc.mil>
To: phillips@bonn-fries.net, Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <E178VRs-0008Va-00@starship>
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Peter Chubb <peter@chubb.wattle.id.au>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de, akpm@zip.com.au, martin@dalecki.de,
        neilb@cse.unsw.edu.au
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net>:
> On Friday 17 May 2002 02:04, Peter Chubb wrote:
> > >>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
> > 
> > Daniel> On Tuesday 14 May 2002 03:36, Anton Altaparmakov wrote:
> > >> ...And yes at the moment the pagecache limit is also a problem
> > >> which we just ignore in the hope that the kernel will have gone to
> > >> 64 bits by the time devices grow that large as to start using > 32
> > >> bits of blocks/pages...
> > 
> > Daniel> PAGE_CACHE_SIZE can also grow, so 32 bit architectures are
> > Daniel> further away from the page cache limit on than it seems.
> > 
> > Check out the table on page 2 of
> > http://www.scsita.org/statech/01s005r1.pdf 
> > 
> > The SCSI trade association is predicting 200TB in a high-end server
> > within 10 years --- and  2TB in a high-end desktop by 2004.  I'd take
> > some of their predictions with a grain of salt, however.
> 
> The server definitely won't be running a 32 bit processor, and the high
> end desktop probably won't.  In any event, the current 44 bit limitation
> (32 bit arch) on the page cache takes us up to 16 TB, and going to a 16 KB 
> PAGE_CACHE_SIZE takes us to 64 TB, so I don't think we have to start
> slicing and dicing that part of the kernel just now.  Anybody who expects
> to run into this limitation should of course raise their hand.
> 
> Incidently, the 200 TB high-end servers are a lot closer than you think.

A lot closer - though ours is really 10TB online, with 300+ TB nearline.

Note - most these really large filesystems allow the inode tables and
bitmaps to be stored on disks with a relatively small blocksize (raid 5),
and the data on different drives (striped) with a large block size (I believe
ours is 64K to 128K sized data blocks, inode/bitmaps are 16K-32K.) This is
done for two reasons:

1. the data blocks are temporary until the the file migrates to tape and
   is striped. If we loose a disk out of the stripe, the filesystem is
   sort of dead. Replace the disk and all is well since the metadata IS
   protected. Files that were physically damanged are recalled from tape.
   New files not yet migrated are destroyed, but since the tape archive
   is created as near the file creation date (close time), it doesn't really
   happen that often. Not many files will be damaged.
2. The inode/bitmap metadata is raid5 for maximum protection. Backup of
   just the metadata can also be done much faster (about 3 hours in our
   case).

The division allows for high integrity of the meta data (which is also
backed up daily (incremental) - but without the corresponding datablocks),
along with maximum capacity for data. 1/5 of 200TB is about 40TB if raid5
were used with everything.

And for the curious, the filesystems are SAMFS and SAMQFS on Sun E10000s.
We migrated the data from Cray NC1 filesystems with DMF - Cray data
migration facility (this took over 4 months. Would have taken only a month
or two, but we also had to accept new data at the same time).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
