Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283314AbRLOSkx>; Sat, 15 Dec 2001 13:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283430AbRLOSkm>; Sat, 15 Dec 2001 13:40:42 -0500
Received: from pop.gmx.de ([213.165.64.20]:1454 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283314AbRLOSkj>;
	Sat, 15 Dec 2001 13:40:39 -0500
Date: Sat, 15 Dec 2001 19:40:32 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20265 IDE controller trouble
Message-Id: <20011215194032.59752d93.rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.33.0112151309350.19022-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <20011215185643.252d5547.rene.rebe@gmx.net>
	<Pine.LNX.4.33.0112151309350.19022-100000@coffee.psychology.mcmaster.ca>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Thanks for the reply!

I'm sorry tht I can not do many other benchmarks - since the server is
in production ...

On Sat, 15 Dec 2001 13:15:57 -0500 (EST)
Mark Hahn <hahn@physics.mcmaster.ca> wrote:

> > Single transfer to one disk:
> > server1:~ # hdparm -tT /dev/ide/host2/bus0/target0/lun0/disc
> 
> is any of this different if you use non-devfs?

This might make a difference? Maybe the open() call but read/write on
a open fd ??

> >  Timing buffered disk reads:  64 MB in  2.86 seconds = 22.38 MB/sec
> >  Timing buffered disk reads:  64 MB in  4.66 seconds = 13.73 MB/sec
> 
> that's somewhat surprising; I wonder if there's some extra
> synchronization in the pdc driver.  otoh, I didn't notice
> this sort of thing at all with a recent raid box I built
> (6x100G, 2xpdc, 1 via, athlonxp/1600, pc2100).

Did you tryed ReiserFS on a software raid device?

> can you replicate this with benchmarks more sane than hdparm
> (like build a raid0, and run bonnie or iozone on an ext2 on it?)

There is a Raid5 on top of 3 discs running ReiserFS (the performance is
bad ...)

But here are the results of a dd if=/bla bla/disc

A single disk:
server1:~ # time dd if=/dev/ide/host2/bus0/target0/lun0/part1 of=/dev/zero bs=1000000 count=200
200+0 records in
200+0 records out

real    0m7.106s
user    0m0.030s
sys     0m3.640s
=>28.1 MB/s

And parallel read from two mastess:
server1:~ # time dd if=/dev/ide/host2/bus0/target0/lun0/part1 of=/dev/zero bs=1000000 count=200
200+0 records in
200+0 records out

real    0m12.797s
user    0m0.010s
sys     0m4.210s
=>15.6 MB/s

And parallel read from master/slave:
server1:~ # time dd if=/dev/ide/host2/bus0/target0/lun0/part1 of=/dev/zero bs=1000000 count=200
200+0 records in
200+0 records out

real    0m18.427s
user    0m0.000s
sys     0m2.690s
=>10.85 MB/s

> >  Timing buffered disk reads:  64 MB in  8.36 seconds =  7.66 MB/sec
> 
> that's not particularly surprising, since there's no concurrency
> among disks in an ide chain.

I do not understand? No concurrency? The two reads are fighting for the
same IDE channel the whole time ... ?

> > Is this an general IDE issue or is some queueing code in the kernel
> > rather bad/slow for this task???
> 
> hdparm is a fairly horrible benchmark; running two at once is nonsense.
> and hdparm's use of block devices probably interacts with things like 
> the blocksize (1k unless you build a 4k FS), and the fact that blkdev
> moved into the pagecache.

OK. Above are some raw-read numbers. Currently the disc are in a RAID5
setup with ReiserFS on top - running in production ...

The ReiserFS is realy realy realy slow (reported in another thread).
We might add a 4th disc an reconfigure it leaving some Gigs on each
disc for tests - but not in this year ...

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
