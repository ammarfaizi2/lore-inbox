Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRC0V6h>; Tue, 27 Mar 2001 16:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbRC0V62>; Tue, 27 Mar 2001 16:58:28 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:53583 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131627AbRC0V6V>; Tue, 27 Mar 2001 16:58:21 -0500
Message-ID: <3AC10C64.108BCFD3@sgi.com>
Date: Tue, 27 Mar 2001 13:55:48 -0800
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <200103271957.NAA13547@tomcat.admin.navo.hpc.mil> <20010327152011.A1354@cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
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
---
	If everything being used is only used from the cache, then
the application probably doesn't need 64-bit block support.  

	I submit that your argument may be flawed in the assumption that
if an application needs multi-terabyte files and devices, that most
of the data will be in the in-memory cache. 
 

> The time to update the pagetables is identical to the time to update a
> 4KB page when the OS is using a 2MB pagesize. Ofcourse it will take more
> time to load the data into the page, however it should be a consecutive
> stretch of data on disk, which should give a more efficient transfer
> than small blocks scattered around the disk.
---
	Not if you were doing alot of random reads where you only
needd 1-2K of data.  The read-time of the extra 2M-1K would seem
to eat into any performance boot gained by the large pagesize.

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
> 
> The application might have been assuming a small block size as well, and
> the OS was told to do several read/modify/write cycles, perhaps even 512
> times as much as necessary.
> 
> I'm not saying that the current system will perform well when working
> with large blocks, but compared to increasing the size of block_t, a
> larger blocksize has more potential to give improvements in the long
> term without adding an unrecoverable performance hit.
---
	That's totally application dependent.  Database applications
might tend to skip around in the data and do short/reads/writes over
a very large file.  Large block sizes will degrade their performance.

	This was the idea of making it a *configurable* option.  If
you need it, configure it.  Same with block size -- that should
likely have a wider range for configuration as well.  But
configuration (and ideally auto-configuration where possible)
seems the ultimate win-win situation.

-l
-- 
The above thoughts are my own and do not necessarily represent those
		of my employer.
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
