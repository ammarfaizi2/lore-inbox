Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSFRAhm>; Mon, 17 Jun 2002 20:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSFRAhl>; Mon, 17 Jun 2002 20:37:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5637 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313638AbSFRAhl>;
	Mon, 17 Jun 2002 20:37:41 -0400
Message-ID: <3D0E807C.5D50C17E@zip.com.au>
Date: Mon, 17 Jun 2002 17:36:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3x slower file reading oddity
References: <3D0E7041.860710CA@zip.com.au> <Pine.LNX.4.44.0206171649270.18507-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> 
> ...
> > You'll get best throughput with a single read thread.
> 
> what if you have a disk array with lots of spindles?  it seems at some
> point that you need to give the array or some lower level driver a lot of
> i/os to choose from so that it can get better parallelism out of the
> hardware.

mm.  For that particular test, you'd get nice speedups from striping
the blockgroups across disks, so each `cat' is probably talking to
a different disk.  I don't think I've seen anything like that proposed
though.

But regardless of the disk topology, the sanest way to get good IO
scheduling is to throw a lot of requests at the block layer.  That's
simple for writes.  But for reads, it's harder.

You could fork one `cat' per file ;)  (Not so silly, really.  But if
you took this approach, you'd need "many" more threads than blockgroups).

Or teach `cat' to perform asynchronous (aio) reads.  You'd need async
opens, too.   But generally we get a good cache hit rate against the
data which is needed to open a small file.

hmm.  What else?  Physical readahead - read metadata into the block
device's pagecache and flip pages from there into directories and
files on-demand.  Fat chance of that happening.

Or change ext2/3 to not place directories in different block groups
at all.  That's super-effective, but does cause somewhat worse long-term
fragmentation.

You can probably lessen the seek-rate by accessing the files in the correct
order.  Read all the files from a directory before descending into any of
its subdirectories.  Can find(1) do that?  You should be able to pretty
much achieve disk bandwidth this way - it depends on how bad the inter-
and intra-file fragmentation has become.

-
