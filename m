Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131678AbRC0WYr>; Tue, 27 Mar 2001 17:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRC0WYi>; Tue, 27 Mar 2001 17:24:38 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:50497 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131661AbRC0WYT>; Tue, 27 Mar 2001 17:24:19 -0500
Date: Tue, 27 Mar 2001 16:23:32 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103272223.QAA37189@tomcat.admin.navo.hpc.mil>
To: jaharkes@cs.cmu.edu, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: 64-bit block sizes on 32-bit systems
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes <jaharkes@cs.cmu.edu>:
> 
> On Tue, Mar 27, 2001 at 01:57:42PM -0600, Jesse Pollard wrote:
> > > Using similar numbers as presented. If we are working our way through
> > > every single block in a Pentabyte filesystem, and the blocksize is 512
> > > bytes. Then the 1us in extra CPU cycles because of 64-bit operations
> > > would add, according to by back of the envelope calculation, 2199023
> > > seconds of CPU time a bit more than 25 days.
> > 
> > Ummm... I don't think it adds that much. You seem to be leaving out the
> > overlap disk/IO and computation for read-ahead. This should eliminate the
> > majority of the delay effect.
> 
> 1024 TB should be around 2*10^12 512-byte blocks, divide by 10^6 (1us)
> of "assumed" overhead per block operation is 2*10^6 seconds, no I
> believe I'm pretty close there. I am considering everything being
> "available in the cache", i.e. no waiting for disk access.

That would be true for small files (< 5GB). I have to deal with files that
may be 20-100 GB. Except for the largest systems (200GB of main memory)
the data will NOT be in the cache except for ~50% of the time. (assuming
only one user....)

> > > Seriously, there is a lot more that needs to be done than introducing a
> > > 64-bit blocknumber. Effectively 512 byte blocks are far too small for
> > > that kind of data, and going to pagesize blocks (and increasing pagesize
> > > to 64KB or 2MB at the same time) is a solution that is far more likely
> > > to give good results since it reduces both the total the number of
> > > 'blocks' on the device as well as reducing the total amount of calls
> > > throughout kernel space instead of increasing the cost per call.
> > 
> > Talk about adding overhead... How long do you think it takes to read a
> > 2MB block (not to mention the time to update that page..) The additional
> > contention on the fiberchannel I/O alone might kill it if the filesystem
> > is busy.
> 
> The time to update the pagetables is identical to the time to update a
> 4KB page when the OS is using a 2MB pagesize. Ofcourse it will take more
> time to load the data into the page, however it should be a consecutive
> stretch of data on disk, which should give a more efficient transfer
> than small blocks scattered around the disk.

You assume the file is accessed sequentially. The wether models don't do
that. They do have some locality, but only in a 3D sense. When you include
time it becomes closer to a random disk block reference when everything has to
be linearized.

> 
> > Granted, 512 bytes could be considered too small for some things, but
> > once you pass 32K you start adding a lot of rotational delay problems.
> > I've used file systems with 256K blocks - they are slow when compaired
> > to the throughput using 32K. I wasn't the one running the benchmarks,
> > but with a MaxStrat 400GB raid with 256K sized data transfer was much
> > slower (around 3 times slower) than 32K. (The target application was
> > a GIS server using Oracle).
> 
> But your subsystem (the disk) was probably still using 512 byte blocks,
> possibly scattered. And the OS was still using 4KB pages, it takes more
> time to reclaim and gather 64 pages per IO operation than one, that's
> why I'm saying that the pagesize needs to scale along with the blocksize.

It wasn't - the "disks" were composed of groups of 5 drives in a raid striped
for speed and spread across 5 SCSI III controlers. Each raid attached had
16MB internal cache. I think the controlers were using an entire sector
read (32K).

> The application might have been assuming a small block size as well, and
> the OS was told to do several read/modify/write cycles, perhaps even 512
> times as much as necessary.

There was some of that, but not much. Oracle (as I recall) allows for the
specification of transfer size. 

This also brings up the problem of small files. Allocating 2MB per file
would, waist quite a bit of disk space (assuming 5 - 10 million files
with only 15% having 25GB or more).

> I'm not saying that the current system will perform well when working
> with large blocks, but compared to increasing the size of block_t, a
> larger blocksize has more potential to give improvements in the long
> term without adding an unrecoverable performance hit.

Not when the filesystem is required for general use. It only makes it
simpler to actually have a large filesystem. It doesn't help when it
must be used.

Now you are saying that the throughput WILL go down, but only if you use
large block sizes.

I can go along with making block sizes up to 8K. Even 32K for special
circumstances (even 64K for dedicated use). But not larger. NFS overhead on
file I/O becomes way too excessive (...worst example now is having to read
a 2MB block to update 512 bytes, then write it back... :-) 

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
