Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTBYEcx>; Mon, 24 Feb 2003 23:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTBYEcx>; Mon, 24 Feb 2003 23:32:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:12282 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266540AbTBYEcv>;
	Mon, 24 Feb 2003 23:32:51 -0500
Date: Mon, 24 Feb 2003 20:43:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62-mm2 slow file system writes across multiple disks
Message-Id: <20030224204321.5016ded6.akpm@digeo.com>
In-Reply-To: <20030224174731.A31454@beaverton.ibm.com>
References: <20030224120304.A29472@beaverton.ibm.com>
	<20030224135323.28bb2018.akpm@digeo.com>
	<20030224174731.A31454@beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2003 04:42:59.0570 (UTC) FILETIME=[5F804520:01C2DC88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield <patmans@us.ibm.com> wrote:
>
> On Mon, Feb 24, 2003 at 01:53:23PM -0800, Andrew Morton wrote:
> 
> > Could be that concurrent umount isn't a good way of getting scalable
> > writeout; I can't say that I've ever looked...
> > 
> > Could you try putting a `sync' in there somewhere?
> > 
> > Or even better, throw away dd and use write-and-fsync from ext3 CVS.  Give it
> > the -f flag to force an fsync against each file as it is closed.
> > 
> > http://www.zip.com.au/~akpm/linux/ext3/
> 
> Using fsync didn't seem to make any difference.

Something is up.

> I moved to 2.5.62-mm3 [I had to drop back to qlogicisp for my boot disk,
> and run the feral drver as a module in order to boot without hanging], and
> ran write-and-fsync with -f, with and without -o (O_DIRECT).

Is this using an enormous request queue or really deep TCQ or something?
I always turn TCQ off, stupid noxious thing it is.

> What keeps pdflush running when get_request_wait sleeps? I thought there
> was (past tense) some creation of multiple pdflushes to handle such cases.

When searching for pages to write out, pdflush will skip over superblocks which
are backed by queues which are currently under write congestion.  Once pdflush 
has walked all superblocks, it will take a little nap, waiting for some write
requests to be put back and then it will take another search of the dirty superblocks.

So pdflush can keep many queues busy, and should never wait in get_request_wait().

There are some little accident scenarios which could cause pdflush to get stuck,
usually in a read from disk.  But having more than just a single instance is
probably overkill.  I don't have enough disks to know, really. 17 in this box,
but not enough scsi/pci bandwidth to feed them all.

> Here are more details:

Something is really up.

When I do

	for i in sda5 sdb5 sdf5 sdg5 hde5 hdg5
	do
		time write-and-fsync -f -m 100 /mnt/$i/1 &
	done

I get:

write-and-fsync -f -m 100 /mnt/$i/1  0.00s user 1.98s system 59% cpu 3.344 total
write-and-fsync -f -m 100 /mnt/$i/1  0.00s user 2.12s system 60% cpu 3.519 total
write-and-fsync -f -m 100 /mnt/$i/1  0.00s user 1.51s system 20% cpu 7.430 total
write-and-fsync -f -m 100 /mnt/$i/1  0.00s user 1.67s system 20% cpu 7.975 total
write-and-fsync -f -m 100 /mnt/$i/1  0.00s user 1.38s system 15% cpu 8.785 total
write-and-fsync -f -m 100 /mnt/$i/1  0.00s user 1.44s system 12% cpu 11.611 total

and

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 7196732  10668   8580    0    0     6   446  257     8  0  1 96  2
 0  0      0 7196732  10668   8580    0    0     0     0 1160     6  0  0 100  0
 0  0      0 7196732  10668   8580    0    0     0     0 1026     4  0  0 100  0
 8  0      0 7089060  10796 115476    0    0     0     0 1044    57  0 34 65  0
10  0      0 6837660  11044 352880    0    0     0 39848 1250    32  0 100  0  0
 9  0      0 6692308  11168 482548    0    0     0 134964 1517    45  0 100  0  0
 0  7      0 6542812  11300 622980    0    0     8 294936 1560    89  0 79  0 21
 0  5      0 6572796  11300 622980    0    0     0 74708 1484   556  0  7  5 88
 0  5      0 6572860  11300 622980    0    0     0 38904 1170   101  0  1 25 74
 0  5      0 6572892  11300 622980    0    0     0 20968 1170   203  0  1 24 75
 0  4      0 6573324  11300 622980    0    0     0  7180 1178   277  0  1 24 74
 0  2      0 6573580  11300 622980    0    0     0  3544 1143   174  0  0 30 69
 0  1      0 6573948  11300 622980    0    0     0     4 1079    18  0  0 69 31
 0  1      0 6573996  11300 622980    0    0     0     0 1058     5  0  0 75 25

100M isn't a lot.  Using 1G lets things settle out better.


So sorry, don't know.  Badari had a setup like that happily sustaining 180 MB/sec
a while back.


