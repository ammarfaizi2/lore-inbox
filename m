Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUF3Gac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUF3Gac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266573AbUF3Gac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:30:32 -0400
Received: from burro.logi-track.com ([213.239.193.212]:23695 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S266572AbUF3GaN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:30:13 -0400
Date: Wed, 30 Jun 2004 08:30:09 +0200
From: Markus Schaber <schabios@logi-track.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Block Device Caching
Message-Id: <20040630083009.18c5e216@kingfisher.intern.logi-track.com>
In-Reply-To: <20040629224622.GQ15166@schnapps.adilger.int>
References: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
	<20040629224622.GQ15166@schnapps.adilger.int>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Jun 2004 16:46:22 -0600
Andreas Dilger <adilger@clusterfs.com> wrote:

>>[block device caching problems]
> When you close the block device it flushes the cache for that device
> (inode). If you kept the device open in some way (e.g. "sleep 10000000
> < /dev/hda5") then it should start caching the data between dd runs.

This sounds reasonable, and it works using hda5 on my developer machine:

root@kingfisher:~# dd if=/dev/hda5 of=/dev/null bs=1M count=100
100+0 Datensätze ein
100+0 Datensätze aus
104857600 bytes transferred in 4,644529 seconds (22576584 bytes/sec)
root@kingfisher:~# dd if=/dev/hda5 of=/dev/null bs=1M count=100
100+0 Datensätze ein
100+0 Datensätze aus
104857600 bytes transferred in 4,688006 seconds (22367207 bytes/sec)
root@kingfisher:~# sleep 1000000 </dev/hda5 &
[1] 17321
root@kingfisher:~# dd if=/dev/hda5 of=/dev/null bs=1M count=100
100+0 Datensätze ein
100+0 Datensätze aus
104857600 bytes transferred in 4,662113 seconds (22491433 bytes/sec)
root@kingfisher:~# dd if=/dev/hda5 of=/dev/null bs=1M count=100
100+0 Datensätze ein
100+0 Datensätze aus
104857600 bytes transferred in 0,271807 seconds (385779610 bytes/sec)

And it works on my USB memory stick:

root@kingfisher:~# dd if=/dev/sda of=/dev/null bs=1M count=100
31+1 Datensätze ein
31+1 Datensätze aus
32768000 bytes transferred in 36,011661 seconds (909927 bytes/sec)
root@kingfisher:~# dd if=/dev/sda of=/dev/null bs=1M count=100
31+1 Datensätze ein
31+1 Datensätze aus
32768000 bytes transferred in 37,133379 seconds (882441 bytes/sec)
root@kingfisher:~# sleep 1000000 </dev/sda &
[1] 17375
root@kingfisher:~# dd if=/dev/sda of=/dev/null bs=1M count=100
31+1 Datensätze ein
31+1 Datensätze aus
32768000 bytes transferred in 36,004170 seconds (910117 bytes/sec)
root@kingfisher:~# dd if=/dev/sda of=/dev/null bs=1M count=100
31+1 Datensätze ein
31+1 Datensätze aus
32768000 bytes transferred in 0,088144 seconds (371755027 bytes/sec)

But it seems to fail on our production machine LVM volume:

bear:~# dd if=/dev/daten/testing of=/dev/null bs=1M count=1000 
1000+0 records in
1000+0 records out
1048576000 bytes transferred in 10.779081 seconds (97278793 bytes/sec)
bear:~# dd if=/dev/daten/testing of=/dev/null bs=1M count=1000 
1000+0 records in
1000+0 records out
1048576000 bytes transferred in 10.773274 seconds (97331229 bytes/sec)
bear:~# sleep 1000000 </dev/daten/testing &
[1] 23588
bear:~# dd if=/dev/daten/testing of=/dev/null bs=1M count=1000 
1000+0 records in
1000+0 records out
1048576000 bytes transferred in 11.030774 seconds (95059149 bytes/sec)
bear:~# dd if=/dev/daten/testing of=/dev/null bs=1M count=1000 
1000+0 records in
1000+0 records out
1048576000 bytes transferred in 11.027699 seconds (95085656 bytes/sec)


top on bear displays:
top - 08:23:31 up 68 days,  5:14,  8 users,  load average: 0.08, 0.08, 0.03
Tasks:  81 total,   1 running,  79 sleeping,   0 stopped,   1 zombie
 Cpu0 :  0.0% us,  0.0% sy,  0.0% ni, 99.4% id,  0.0% wa,  0.6% hi,  0.0% si
 Cpu1 :  0.0% us,  0.3% sy,  0.0% ni, 99.7% id,  0.0% wa,  0.0% hi,  0.0% si
 Cpu2 :  0.0% us,  0.0% sy,  0.0% ni, 100.0% id,  0.0% wa,  0.0% hi,  0.0% si
 Cpu3 :  0.0% us,  0.0% sy,  0.0% ni, 100.0% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:   3953624k total,  1120508k used,  2833116k free,   800248k buffers
Swap:  1048568k total,        0k used,  1048568k free,    24932k cached

So there clearly is enough free RAM to buffer 1 Gig of data (which, as I
said, works for a file when mounting /dev/daten/testing with ext3).

Did we do something wrong in our LVM setup? Do you need more info (such
as the output of some lv tools or the kernel config)?

Thanks for your efforts,
Markus Schaber

-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com
