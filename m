Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132800AbRAVSIr>; Mon, 22 Jan 2001 13:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRAVSIh>; Mon, 22 Jan 2001 13:08:37 -0500
Received: from mail.t-intra.de ([62.156.146.210]:53384 "EHLO mail.t-intra.de")
	by vger.kernel.org with ESMTP id <S132379AbRAVSIY>;
	Mon, 22 Jan 2001 13:08:24 -0500
Message-Id: <200101221808.f0MI8UW03617@gate2.private.net>
From: "Otto Meier" <gf435@gmx.net>
To: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 22 Jan 2001 19:09:37 +0100
Reply-To: "otto meier" <gf435@gmx.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 98 (4.10.2222)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] - filesystem corruption on soft RAID5 in 2.4.0+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch I did rebuilt my raid5 from scratch. So far it still runs in degraded mode
to honor the father of invention. 
System is a SMP Dual Celeron with kernel 2.4.0. I copied 18 Gbyte of data from my 
backup  to it. So far i have not seen any corroption messages. 
Last time I did that I got a lot of them. Seams that the fix has improved things for me.
 
Otto

On Mon, 22 Jan 2001 07:47:42 +1100 (EST), Neil Brown wrote:

>
>There have been assorted reports of filesystem corruption on raid5 in
>2.4.0, and I have finally got a patch - see below.
>I don't know if it addresses everybody's problems, but it fixed a very
>really problem that is very reproducable.
>
>The problem is that parity can be calculated wrongly when doing a
>read-modify-write update cycle.  If you have a fully functional, you
>wont notice this problem as the parity block is never used to return
>data.  But if you have a degraded array, you will get corruption very
>quickly.
>So I think this will solve the reported corruption with ext2fs, as I
>think they were mostly on degradred arrays.  I have no idea whether it
>will address the reiserfs problems as I don't think anybody reporting
>those problems described their array.
>
>In any case, please apply, and let me know of any further problems.
>
>
>--- ./drivers/md/raid5.c	2001/01/21 04:01:57	1.1
>+++ ./drivers/md/raid5.c	2001/01/21 20:36:05	1.2
>@@ -714,6 +714,11 @@
> 		break;
> 	}
> 	spin_unlock_irq(&conf->device_lock);
>+	if (count>1) {
>+		xor_block(count, bh_ptr);
>+		count = 1;
>+	}
>+	
> 	for (i = disks; i--;)
> 		if (chosen[i]) {
> 			struct buffer_head *bh = sh->bh_cache[i];
>
>
> From my notes for this patch:
>
>   For the read-modify-write cycle, we need to calculate the xor of a
>   bunch of old blocks and bunch of new versions of those blocks.  The
>   old and new blocks occupy the same buffer space, and because xoring
>   is delayed until we have lots of buffers, it could get delayed too
>   much and parity doesn't get calculated until after data had been
>   over-written.
>
>   This patch flushes any pending xor's before copying over old buffers.
>
>
>Everybody running raid5 on 2.4.0 or 2.4.1-pre really should apply this
>patch, and then arrange the get parity checked and corrected on their
>array.
>There currently isn't a clean way to correct parity.
>One way would be to shut down to single user, remount all filesystems
>readonly, or un mount them, and the pull the plug.
>On reboot, raid will rebuild parity, but the filesystems should be
>clean.
>An alternate it so rerun mkraid giving exactly the write configuration.
>This doesn't require pulling the plug, but if you get the config file
>wrong, you could loose your data.
>
>NeilBrown
>






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
