Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSFUXNV>; Fri, 21 Jun 2002 19:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSFUXNU>; Fri, 21 Jun 2002 19:13:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16400 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316182AbSFUXNS>;
	Fri, 21 Jun 2002 19:13:18 -0400
Message-ID: <3D13B2B4.CC2A83B8@zip.com.au>
Date: Fri, 21 Jun 2002 16:11:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Duc Vianney <dvianney@us.ibm.com>
CC: mgross <mgross@unix-os.sc.intel.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles 
 gets large
References: <3D13A2B4.236E55DD@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duc Vianney wrote:
> 
> Andrew Morton wrote:
> >If you have time, please test ext2 and/or reiserfs and/or ext3
> >in writeback mode.
> I ran IOzone on ext2fs, ext3fs, JFS, and Reiserfs on an SMP 4-way
> 500MHz, 2.5GB RAM, two 9.1GB SCSI drives. The test partition is 1GB,
> test file size is 128MB, test block size is 4KB, and IO threads varies
> from 1 to 6. When comparing with other file system for this test
> environment, the results on a 2.5.19 SMP kernel show ext3fs is having
> performance problem with Writes and in particularly, with Random Write.
> I think the BKL contention patch would help ext3fs, but I need to verify
> it first.
> 
> The following data are throughput in MB/sec obtained from IOzone
> benchmark running on all file systems installed with default options.
> 
> Kernels           2519smp4   2519smp4   2519smp4   2519smp4
> No of threads=1   ext2-1t    jfs-1t     ext3-1t    reiserfs-1t
> 
> Initial write     138010     111023      29808      48170
> Rewrite           205736     204538     119543     142765
> Read              236500     237235     231860     236959
> Re-read           242927     243577     240284     242776
> Random read       204292     206010     201664     207219
> Random write      180144     180461       1090     121676

ext3 only allows dirty data to remain in memory for five seconds,
whereas the other filesystems allow it for thirty.  This is
a reasonable thing to do, but it hurts badly in benchmarks.

If you run a benchmark which takes ext2 ten seconds to
complete, ext2 will do it all in-RAM.  But after five
seconds, ext3 will go to disk and the test takes vastly longer.
I suspect that is what is happening here - we're seeing the
difference between disk bandwidth and memory bandwidth.

If you choose a larger file, a shorter file or a longer-running
test then the difference will not be so gross.

You can confirm this by trying a one-gigabyte file instead.

The "Initial write" is fishy.  I wonder if the same thing
is happening here - there may have been lots of dirty memory
left in-core (and unaccounted for) after the test completed.
iozone has a `-e' option which causes it to include the fsync()
time in the timing  calculations.   Using that would give a
better comparison, unless you are specifically trying to test
in-memory performance.  And we're not doing that here.

-
