Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131534AbRC0UVK>; Tue, 27 Mar 2001 15:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbRC0UVB>; Tue, 27 Mar 2001 15:21:01 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:25735 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S131533AbRC0UUx>; Tue, 27 Mar 2001 15:20:53 -0500
Date: Tue, 27 Mar 2001 15:20:12 -0500
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Message-ID: <20010327152011.A1354@cs.cmu.edu>
Mail-Followup-To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200103271957.NAA13547@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200103271957.NAA13547@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Tue, Mar 27, 2001 at 01:57:42PM -0600
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2001 at 01:57:42PM -0600, Jesse Pollard wrote:
> > Using similar numbers as presented. If we are working our way through
> > every single block in a Pentabyte filesystem, and the blocksize is 512
> > bytes. Then the 1us in extra CPU cycles because of 64-bit operations
> > would add, according to by back of the envelope calculation, 2199023
> > seconds of CPU time a bit more than 25 days.
> 
> Ummm... I don't think it adds that much. You seem to be leaving out the
> overlap disk/IO and computation for read-ahead. This should eliminate the
> majority of the delay effect.

1024 TB should be around 2*10^12 512-byte blocks, divide by 10^6 (1us)
of "assumed" overhead per block operation is 2*10^6 seconds, no I
believe I'm pretty close there. I am considering everything being
"available in the cache", i.e. no waiting for disk access.

> > Seriously, there is a lot more that needs to be done than introducing a
> > 64-bit blocknumber. Effectively 512 byte blocks are far too small for
> > that kind of data, and going to pagesize blocks (and increasing pagesize
> > to 64KB or 2MB at the same time) is a solution that is far more likely
> > to give good results since it reduces both the total the number of
> > 'blocks' on the device as well as reducing the total amount of calls
> > throughout kernel space instead of increasing the cost per call.
> 
> Talk about adding overhead... How long do you think it takes to read a
> 2MB block (not to mention the time to update that page..) The additional
> contention on the fiberchannel I/O alone might kill it if the filesystem
> is busy.

The time to update the pagetables is identical to the time to update a
4KB page when the OS is using a 2MB pagesize. Ofcourse it will take more
time to load the data into the page, however it should be a consecutive
stretch of data on disk, which should give a more efficient transfer
than small blocks scattered around the disk.

> Granted, 512 bytes could be considered too small for some things, but
> once you pass 32K you start adding a lot of rotational delay problems.
> I've used file systems with 256K blocks - they are slow when compaired
> to the throughput using 32K. I wasn't the one running the benchmarks,
> but with a MaxStrat 400GB raid with 256K sized data transfer was much
> slower (around 3 times slower) than 32K. (The target application was
> a GIS server using Oracle).

But your subsystem (the disk) was probably still using 512 byte blocks,
possibly scattered. And the OS was still using 4KB pages, it takes more
time to reclaim and gather 64 pages per IO operation than one, that's
why I'm saying that the pagesize needs to scale along with the blocksize.

The application might have been assuming a small block size as well, and
the OS was told to do several read/modify/write cycles, perhaps even 512
times as much as necessary.

I'm not saying that the current system will perform well when working
with large blocks, but compared to increasing the size of block_t, a
larger blocksize has more potential to give improvements in the long
term without adding an unrecoverable performance hit.

Jan

