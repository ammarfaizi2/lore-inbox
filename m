Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935090AbWKXWKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935090AbWKXWKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 17:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935095AbWKXWKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 17:10:15 -0500
Received: from smtp.ono.com ([62.42.230.12]:56461 "EHLO resmaa04.ono.com")
	by vger.kernel.org with ESMTP id S935090AbWKXWKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 17:10:13 -0500
Date: Fri, 24 Nov 2006 23:10:03 +0100
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Martin A. Fink" <fink@mpe.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA Performance with Intel ICH6
Message-ID: <20061124231003.1d46f279@werewolf-wl>
In-Reply-To: <200611241407.01210.fink@mpe.mpg.de>
References: <200611241407.01210.fink@mpe.mpg.de>
X-Mailer: Claws Mail 2.6.0cvs57 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 14:07:01 +0100, "Martin A. Fink" <fink@mpe.mpg.de> wrote:

> Dear all,
> 
> I found out, that writing to a SATA harddisk costs around 20% of the
> computers cpu time. I write blocks of 1MB size to a file. Write performance
> is around 51MB/s what I think is really good. My computer has an Intel ICH6
> chipset and a 3.2GHz Pentium 4 processor.
> If I understand the design of this chipset correctly, then I would have
> expected, that the CPU needs to do only few work, instead I found out, that
> writing to disk seems to be really hard work for the CPU.
> 
> Can I do anything to optimize writing from memory to disk?
> 
> My final aim is to get around 140MB/s of data from 3 different Gigabit
> Ethernet cards and store it on 3 harddisk drives that perform 50MB/s.
> From the SATA bus side there should be no problem. Each of the 4 SATAs on
> this ICH6 chipset are capable of 150MB/s.
> 

Theoretically for when CPUs and disks are capable of giving those speeds...

> So what makes my CPU that slow? Is it a hardware problem or a problem of
> SATA driver of my operating system?
> 
> time dd if=/dev/zero of=test.zero bs=1M count=1000
> results in
> 
> real 0m52.561s
> user 0m0.003s
> sys  0m7.407s
> 

Guess first what are your busses limit. Get a try with hdparm.
I have this:

00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
scsi 2:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5

/dev/sdc:
 Timing cached reads:   1432 MB in  2.00 seconds = 715.90 MB/sec
 Timing buffered disk reads:  162 MB in  3.02 seconds =  53.70 MB/sec

That gives you the max speed limit of the kernel transfers+pci speed+disk cache speed
combo. Then you should add the real disk speed, but that's for a real benchmark
for iozone.

Also try to run several in parallel, one on each disk.

And something is really strange in your box:

werewolf:~> time -p dd if=/dev/zero of=test.zero bs=1M count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB) copied, 8.64253 seconds, 121 MB/s
real 8.64
user 0.00
sys 4.70

(dual xeon 2.4GHz)

CPU usage was 100% at the start but dropped to about 2-3-4%. 
Be sure to remove manually test.zero before running each test, if not
you will account the time the system spends cleaning the page cache when
dd unlinks or truncates test.zero:

werewolf:~> rm -f test.zero
werewolf:~> time -p dd if=/dev/zero of=test.zero bs=1M count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB) copied, 8.29974 seconds, 126 MB/s
real 8.30
user 0.00
sys 4.53
werewolf:~> time -p dd if=/dev/zero of=test.zero bs=1M count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB) copied, 8.30443 seconds, 126 MB/s
real 31.86
user 0.00
sys 5.52
werewolf:~> rm -f test.zero; time -p dd if=/dev/zero of=test.zero bs=1M count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB) copied, 7.98103 seconds, 131 MB/s
real 8.07
user 0.00
sys 4.61


> and strace dd... gives among other information
> 6.84s 1004calls syscall: write
> 
> So I spend 45s of 52s within the kernel. Why so long?
> 

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.18-jam13 (gcc 4.1.2 20061110 (prerelease) (4.1.2-0.20061110.1mdv2007.1)) #1 SMP PREEMPT
