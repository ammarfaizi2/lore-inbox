Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUCPB6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbUCPB4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:56:09 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52656 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263414AbUCPByu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:54:50 -0500
Date: Tue, 16 Mar 2004 02:54:45 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: 2.6.4 ext3fs half order of magnitude slower than xfs - bulk write
Message-ID: <20040316015445.GA17564@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040315214741.GA5042@merlin.emma.line.org> <20040315152355.32a1b054.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315152355.32a1b054.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton:

> It should be possible to generate a simple testcase which demonstrates this
> problem on that machine.  Is that something you can do?
> 
> From your description, write-and-fsync.c from
> 
> 	http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
> 
> would be a good starting point.

I've run "write-and-fsync -m SIZE -f SOMEFILE" where size is given in
each section and SOMEFILE was chosen for some real-life but idle file
system. I hope this is what you meant. I did one run per test.

Benchmarks from three different machines below (1/2 from the same
machine). Times as per "GNU time", user time always below timer resolution.

I am aware that bulk write performance is just one of the possible load
profiles and there are many others involving seeks.

I am also aware that most of the Linux kernel developers run their ATA
data tombs with write caches turned on. Given that there is no proper
documentation on write barrier/ordered tag behaviour of file systems and
block device drivers, I feel uncomfortable with that for production
systems. (No UPS, we don't have difficulties with power outages... yet.)

The 2.6.4 kernel was taken from BK rather than the tarball but short
after the announcement with the TAG being the most recent change. test
#3 and #4 are just to give some other figures from Linux 2.4, they may
be irrelevant to the case but I was curious and thought I'd share the
figures.

========================================================================
Test set #1: file size 512 MB
AMD XP 2500+ Kernel 2.6.4 Maxtor 4K060H3 (5400/min ATA UDMA/100 2 MB cache)
VIA 8237   256 MB RAM  hdparm -tT 586 MB/s buffer 32.24 MB/s disk
               sys/s real/s   throughput/(MB/s)
WC=1 -------------------
XFS              1.8  24.18   21.2
ext3 writeback   2.6  74.21    6.9
ext3 ordered     2.4  74.70    6.9
ext3 journal     2.6  58.65    8.7
WC=0 -------------------
XFS              1.8  67.11    7.6
ext3 writeback   2.4 115.21    4.4
ext3 ordered     2.3 114.55    4.5
ext3 journal     2.8 323.30    1.6
               sys/s real/s   throughput/(MB/s)

========================================================================
Test set #2: file size 512 MB for ext3, 400 MB for reiserfs
(same motherboard as in test #1)
AMD XP 2500+ Kernel 2.6.4 Fujitsu MAH3182MP (7200/min Ultra 160 SCSI 4 MB cache)
SYM53C875   256 MB RAM  hdparm -tT 580 MB/s buffer 29.18 MB/s disk
The drive likely saturates the SCSI host bus.

/sys/block/sda/queue/iosched/antic_expire was set to 0
as the anticipatory scheduler documentation recommends so for data base
workload and drives with tagged command queueing (which mine is)

               sys/s real/s   throughput/(MB/s)
ext3 ordered     1.4  55.27    9.3   512 MB file
reiserfs 400 MB  1.4  52.74    7.6   400 MB file
reiserfs NO TCQ  1.4  74.64    5.4   tagged command queueing off, 400 MB
========================================================================
Test set #3: file size 1024 MB
Xeon 2.8 GHz  Kernel 2.4.20 (SuSE 9.0) RAID5 of 3 pcs Fujitsu MAP3367NC
512 MB RAM                       (10,025/min Ultra 320 SCSI 8 MB Cache)
LSI MegaRAID 320-1 w/ 64 MB Cache, write-through cache
This is server-class hardware with PCI-X hotplug, ServerWorks chips,
monitoring, remote management and such.
hdparm -tT 1331 MB/s buffer 135 MB/s "disk"

ext3 ordered         116.37s elapsed  8.8 MB/s (sys unknown)

This looks unbelievably low but may be a tribute to RAID5 and
write-through caching - the system is set for reliability.

========================================================================
Test set #4: file size 1024 MB
AMD XP 1700+ Kernel 2.4.21 (SuSE 8.2)
SCSI: Fujitsu MAP3367NP Adaptec 2940UW (10,025/min Ultra320 8 MB Cache)
ATA:  IBM IC35L060AVV207-0 VIA 8233    ( 7,200/min UDMA100  2 MB Cache)
write caches off on all drives
hdparm -tT ATA: buffer 320/disk 47.76, SCSI: buffer 328/disk 28.57
The SCSI drive definitely saturates the SCSI BUS.

times in s     sys  real  throughput MB/s
SCSI reiserfs 6.7  43.44  23.6
ATA ext3fs    6.7 162.53   6.3
ATA jfs       3.6 171.15   6.0
========================================================================

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
