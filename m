Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286914AbRL1ObA>; Fri, 28 Dec 2001 09:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286919AbRL1Oav>; Fri, 28 Dec 2001 09:30:51 -0500
Received: from fepB.post.tele.dk ([195.41.46.145]:33248 "EHLO
	fepB.post.tele.dk") by vger.kernel.org with ESMTP
	id <S286914AbRL1Oae>; Fri, 28 Dec 2001 09:30:34 -0500
Date: Fri, 28 Dec 2001 15:30:22 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011228153022.D1248@suse.de>
In-Reply-To: <20011221091104.A120@earthlink.net> <20011221154654.E811@suse.de> <20011221185538.A131@earthlink.net> <20011224150337.A593@suse.de> <20011224115953.A118@earthlink.net> <20011224180244.C1241@suse.de> <20011227140723.A4713@earthlink.net> <20011228124037.K2973@suse.de> <20011228091401.A15569@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011228091401.A15569@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28 2001, rwhron@earthlink.net wrote:
> On Fri, Dec 28, 2001 at 12:40:37PM +0100, Jens Axboe wrote:
> > > I rebuilt the reiserfs that dbench writes to.
> > > Here is ps -eo cmd,wchan on the k6-2 running 2.5.2-pre2:
> > 
> > Ah this is interesting, all stuck in get_request_wait. I cannot
> > reproduce your problem here whatever I do, no reiser though.
> > 
> > -- 
> > Jens Axboe
> 
> That's good news.  It's probably something with my configuration
> or hardware.  I saw the livelock on both ext2 and reiserfs.

Thanks for an excellent report. I can't quite see what the problem
should be yet, especially since the problems seem to start with
2.5.2-pre1 which doesn't really have a lot of interesting changes. I'll
keep looking, though. Could you do sysrq-t for a livelocked system?

The livelocks in this mail appear different than the previous ones.
Could you try running without swap?

> With the stripped config, I built 2.5.2-pre3.  It panic'd
> with the stripped config.  2.5.2-pre3 panic'd yesterday
> on this machine's normal config too.
> 
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> 8139too Fast Ethernet driver 0.9.22
> PCI: Found IRQ 11 for device 00:13.0
> IRQ routing conflict for 00:13.0, have irq 9, want irq 11
> eth0: RealTek RTL8139 Fast Ethernet at 0xd8800000, 00:50:bf:25:68:f3, IRQ 9
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Kernel panic: Out of memory and no killable processes...
> 
> I haven't noticed any reports of this panic on 2.5.2-pre3.

Someone else did report a similar case. Very strange, doesn't look bio
related at all. WHat's the entire boot message for a 2.5.2-pre3 boot
attempt like the above?

> I re-ran dbench 32, 128 with 2.4.17rc2aa2 on this machine and 
> it worked fine.  I'll try 2.5.1 on this machine (2.5.1 was 
> okay on another machine).  

2.5.1 vs 2.5.2-preX is much more interesting.

(btw, attached patch should fix your highmem oops)

--- /opt/kernel/linux-2.5.2-pre3/include/linux/blkdev.h	Fri Dec 28 11:43:04 2001
+++ include/linux/blkdev.h	Fri Dec 28 15:25:36 2001
@@ -228,8 +228,8 @@
  * BLK_BOUNCE_ANY	: don't bounce anything
  * BLK_BOUNCE_ISA	: bounce pages above ISA DMA boundary
  */
-#define BLK_BOUNCE_HIGH		((blk_max_low_pfn + 1) << PAGE_SHIFT)
-#define BLK_BOUNCE_ANY		((blk_max_pfn + 1) << PAGE_SHIFT)
+#define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_ANY		(blk_max_pfn << PAGE_SHIFT)
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
 extern int init_emergency_isa_pool(void);

-- 
Jens Axboe

