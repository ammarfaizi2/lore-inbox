Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSD3MiT>; Tue, 30 Apr 2002 08:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSD3MiT>; Tue, 30 Apr 2002 08:38:19 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:33274 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S313305AbSD3MiR>; Tue, 30 Apr 2002 08:38:17 -0400
Message-ID: <3CCE9038.F4C830B4@redhat.com>
Date: Tue, 30 Apr 2002 13:38:16 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-0.24smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jaime Medrano <overflow@eurielec.etsit.upm.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid1 performance
In-Reply-To: <Pine.LNX.4.33.0204301411210.4658-100000@cuatro.eurielec.etsit.upm.es>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaime Medrano wrote:
> 
> I have several raid arrays (level 0 and 1) in my machine and I have
> noticed that raid1 is much more slower than I expected.
> 
> The arrays are made from two equal hds (/dev/hde, /dev/hdg). And some
> numbers about the read performances are:
> 
> /dev/hde: 29 Mb/s
> /dev/hdg: 29 Mb/s
> /dev/md0: 27 Mb/s (raid1)
> /dev/md1: 56 Mb/s (raid0)
> /dev/md2: 27 Mb/s (raid1)
> 
> These numbers comes from hdparm -tT. I have noticed a very poor
> performance when reading sequentially a large file from raid1 (I suppose
> this is what hdparm does).
> 
> I have taken a look at the read balancing code at raid1.c and I have found
> that when a sequential read happens no balancing is done, and so all the
> reading is done from only one of the mirrors while the others are iddle.ç

Yes this is expected. Sequential reads from RAID1 with the 
current on disk format are as fast as the fastest disk.
The reason for this is simple: 

<ascii art of the on disk layout, each letter is a "block">

Disk 1:  ABCDEFGHIJK
Disk 2:  ABCDEFGHIJK

If you read block A from disk 1, to get more than the speed for just 1
disk
you would need to read block B from disk 2 *in parallel*, and so far so
good.
However then you need to read block C, and to do it in parallel you need
to
read it from Disk 1, but disk 1's diskhead was at block A -> so you get
a head seek.
or if the drive is trying to be intelligent it'll read block B into it's
own cache 
anyway and then block C after that (which is the more common case). Etc
etc.
This later case effectively means that Disk 1 will still read ALL blocks
from the platter
into the drive's cache, and of course Disk 2 will do likewise. In just
about all
cases you care about the platter transfer rate is the limiting facter
and not the 
"disk to host" rate. So both disk 1 and disk 2 are reading ALL the data
at platter speed,
which means the maximum speed at which you can get the data is at
platter speed.

Now if the disk wasn't smart and was doing seeks, it would suck much
much more due
to the high cost of seeks....

The only way to get the "1 thread sequential read" case faster is by
modifying the 
disk layout to be

Disk 1: ACEGIKBDFHJ
Disk 2: ACEGIKBDFHJ

where disk 1 again reads block A, and disk 2 reads block B.
To read block C, disk 1 doesn't have to move it's head or read a dummy
block away,
it can read block C sequention, and disk 2 can read block D that way.

That way the disks actually each only read the relevant blocks in a
sequential way
and you get (in theory) 2x the performance of 1 disk.

Greetings,
    Arjan van de Ven
