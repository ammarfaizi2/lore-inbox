Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282882AbRLLXi1>; Wed, 12 Dec 2001 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282890AbRLLXiR>; Wed, 12 Dec 2001 18:38:17 -0500
Received: from 12-234-19-19.client.attbi.com ([12.234.19.19]:50701 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S282882AbRLLXiI>;
	Wed, 12 Dec 2001 18:38:08 -0500
Date: Wed, 12 Dec 2001 15:38:06 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slow Disk I/O with QPS M3 80GB HD
Message-ID: <20011212153806.A22202@lucon.org>
In-Reply-To: <20011210203452.A3250@lucon.org> <20011210235708.A17743@lucon.org> <20011211154331.A32433@lucon.org> <20011212092954.N4801@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011212092954.N4801@athlon.random>; from andrea@suse.de on Wed, Dec 12, 2001 at 09:29:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 09:29:54AM +0100, Andrea Arcangeli wrote:
> On Tue, Dec 11, 2001 at 03:43:31PM -0800, H . J . Lu wrote:
> > On Mon, Dec 10, 2001 at 11:57:08PM -0800, H . J . Lu wrote:
> > > On Mon, Dec 10, 2001 at 08:34:52PM -0800, H . J . Lu wrote:
> > > > I have a very strange problem. The disk I/O of my QPS M3 80GB HD is
> > > > very slow under 2.4.10 and above. I got like 1.77 MB/s from hdparm.
> > > > But under 2.4.9, I got 14 MB/s on the same hardware. A 30GB HD has
> > > > consistent I/O performance under 2.4.9 and above on the same bus. Has
> > > > anyone else seen this? Does anyone have a large (>= 80GB) 1394 HD?
> > > > 
> > > 
> > > I did a binary search. 2.4.10-pre10 is the last good kernel. I got
> > > 
> > > # hdparm -t /dev/sda
> > > 
> > > /dev/sda:
> > >  Timing buffered disk reads:  64 MB in  4.40 seconds = 14.55 MB/sec
> > > 
> > > Even since 2.4.10-pre11 up to 2.4.16, I got about 1.77 MB/sec on the
> > > same hardware. However, I don't have problems with 80GB IDE HD. Has
> > > anyone seen I/O problems on large (>= 80GB) SCSI HD or HD with SCSI
> > > emulation?
> > 
> > I tracked own the problem to 40_blkdev-pagecache-17 in the 2.4.10
> > pre10aa1 patch. When it is applied, the disk I/O on some drives become
> > very slow. It not only happens to my 80GB 1394 HD, but also the second
> > IDE drive. Before the patch
> > 
> > # hdparm -t /dev/hdd
> > 
> > /dev/hdd:
> >  Timing buffered disk reads:  64 MB in  8.02 seconds =  7.98 MB/sec
> > 
> > After the patch
> > 
> > # hdparm -t /dev/hdd
> > 
> > /dev/hdd:
> >  Timing buffered disk reads:  64 MB in 21.09 seconds =  3.03 MB/sec
> > 
> > The slow down is not as bad as 1394. But it is still very significant.
> > I couldn't figure out why it only affects certain drives.
> 
> do you have a 4k filesystm mounted on /dev/hdd? if so then you will get
> the same performance with latest 2.4 (precisely after 2.4.1).
> 

Even Sony F707 digital camera is slowed because your change from
2.4.10-pre10 to 2.4.10-pre11. It is a USB memory stick. It is 10 times
slower than before. So far, we have some USB and 1394 storage devices
are slowed down very badly. Some IDE hds also suffer. It is very
strange.


H.J.
----
3 files on USB:

# ls -l
total 5984
-rwxr-xr-x    1 root     root      1991481 Dec  8 21:44 dsc00002.jpg
-rwxr-xr-x    1 root     root      2432127 Dec  8 23:54 dsc00005.jpg
-rwxr-xr-x    1 root     root      1675563 Dec  8 23:59 dsc00009.jpg

1. 2.4.10-pre10

# time /bin/cp * /tmp/
real    0m0.623s
user    0m0.000s
sys     0m0.100s

2. 2.4.10-pre10aa1

# time /bin/cp * /tmp/
real    0m8.952s
user    0m0.000s
sys     0m0.190s


3. 2.4.10-pre11

# time /bin/cp * /tmp/
real    0m8.851s
user    0m0.000s
sys     0m0.170s
