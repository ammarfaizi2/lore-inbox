Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUJEB1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUJEB1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 21:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUJEB1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 21:27:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:35034 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267916AbUJEB13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 21:27:29 -0400
X-Authenticated: #4399952
Date: Tue, 5 Oct 2004 03:42:23 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       thewade <pdman@aproximation.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
Message-ID: <20041005034223.70ae4af7@mango.fruits.de>
In-Reply-To: <20041004215315.GA17707@elte.hu>
References: <20040919122618.GA24982@elte.hu>
	<414F8CFB.3030901@cybsft.com>
	<20040921071854.GA7604@elte.hu>
	<20040921074426.GA10477@elte.hu>
	<20040922103340.GA9683@elte.hu>
	<20040923122838.GA9252@elte.hu>
	<20040923211206.GA2366@elte.hu>
	<20040924074416.GA17924@elte.hu>
	<20040928000516.GA3096@elte.hu>
	<20041003210926.GA1267@elte.hu>
	<20041004215315.GA17707@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004 23:53:15 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> i've released the -S9 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9
> 

Something is fishy for me from S8 on. I justbooted into S9 and i see
many many xruns under load in jackd [as i saw in S8]. Since all my ll
settings are enabled as usual, something else must be wrong. 

I find the following very interesting:

mango:~# ps aux|grep IRQ
root        12  0.0  0.0     0    0 ?        S<   04:28   0:00 [IRQ 8]
root        14  0.0  0.0     0    0 ?        S<   04:28   0:00 [IRQ 12]
root        15  0.0  0.0     0    0 ?        S<   04:28   0:00 [IRQ 14]
root        16  0.0  0.0     0    0 ?        S<   03:17   0:00 [IRQ 15]
root        17  0.0  0.0     0    0 ?        S<   03:17   0:00 [IRQ 1]
root       314  0.0  0.0     0    0 ?        S<   03:17   0:00 [IRQ 10]
root      7983  0.6  0.0     0    0 ?        S<   03:26   0:03 [IRQ 5]
root     14617  0.0  0.0  1576  464 pts/2    R+   03:35   0:00 grep IRQ
mango:~# chrt -p 7938
sched_getscheduler: No such process
failed to get pid 7938's policy

For other irq threads i get normal values [SCHED_OTHER].

Here's the usual tweakables. I find it interesting that the preempt
timing stuff is seemingly non working, either [see bottom]. Will boot
into S8 to see if i see similar things:

-----------
-----------
Linux mango.fruits.de 2.6.9-rc3-mm2-VP-S9LT #1 Tue Oct 5 03:07:49 CEST
2004 i686 GNU/Linux-----------
/proc/interrupts:
           CPU0       
  0:    1233290          XT-PIC  timer  0/33290
  1:       4810          XT-PIC  i8042  0/4810
  2:          0          XT-PIC  cascade  0/0
  5:     863776          XT-PIC  CS46XX  0/63776
  8:          4          XT-PIC  rtc  0/4
 10:       1008          XT-PIC  eth0  0/1008
 12:      34888          XT-PIC  i8042  0/34888
 14:        927          XT-PIC  ide0  0/927
 15:      33585          XT-PIC  ide1  0/33585
NMI:          0 
ERR:          0
-----------
/proc/irq/1/i8042/threaded:1
/proc/irq/10/eth0/threaded:1
/proc/irq/12/i8042/threaded:1
/proc/irq/14/ide0/threaded:1
/proc/irq/15/ide1/threaded:1
/proc/irq/5/CS46XX/threaded:0
/proc/irq/8/rtc/threaded:0
-----------
/sys/block/hda/queue/max_sectors_kb:16
/sys/block/hdc/queue/max_sectors_kb:16
/sys/block/hdd/queue/max_sectors_kb:16
-----------
voluntary_preemption
1
kernel_preemption
1
softirq redirect
1
hardirq redirect
1
-----------
preempt_thresh
0
-----------
preempt_max_thresh
0
-----------
trace enabled
0
-----------


I also see some of these "Wait for ready failed before probe !" [in
dmesg] which have popped up somewhere along the line when VP was based
on mm [definetly in S8 and S9, dunno about earlier for sure]:

[snip]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L060AVER07-0, ATA DISK drive
requesting new irq thread for IRQ14...
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST340823A, ATA DISK drive
hdd: TDK CDRW121032, ATAPI CD/DVD-ROM drive
requesting new irq thread for IRQ15...
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
IRQ#14 thread started up.
hda: 120103200 sectors (61492 MB) w/1916KiB Cache, CHS=65535/16/63,
UDMA(100) hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: max request size: 128KiB
IRQ#15 thread started up.
hdc: Host Protected Area detected.
	current capacity is 78165360 sectors (40020 MB)
	native  capacity is 78165361 sectors (40020 MB)
hdc: Host Protected Area disabled.
hdc: 78165361 sectors (40020 MB) w/1024KiB Cache, CHS=65535/16/63,
UDMA(33) hdc: cache flushes not supported
 hdc: hdc1 hdc2
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
[snip]
