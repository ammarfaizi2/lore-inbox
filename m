Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267866AbUHPTJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267866AbUHPTJZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267879AbUHPTJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:09:25 -0400
Received: from av3-1-sn4.m-sp.skanova.net ([81.228.10.114]:27816 "EHLO
	av3-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S267866AbUHPTJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:09:22 -0400
To: Frediano Ziglio <freddyz77@tin.it>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Packet writing problems
References: <1092669361.4254.24.camel@freddy> <m3acwuq5nc.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Aug 2004 21:09:19 +0200
In-Reply-To: <m3acwuq5nc.fsf@telia.com>
Message-ID: <m3657iq4rk.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Frediano Ziglio <freddyz77@tin.it> writes:
> 
> > I'm trying to do packet writing with my new DVD writer.
> > 
> > # cat /proc/ide/hdc/model
> > PIONEER DVD-RW DVR-107D
> > 
> > dma enabled.
> > After some tests with 2.4 I decided to switch to 2.6.
> > I used Fedora Core 2 with a vanilla kernel 2.6.8.1 + patch from
> > http://w1.894.telia.com/~u89404340/patches/packet/2.6/, udftools with
> > Petero patch (http://w1.894.telia.com/~u89404340/patches/packet/, same
> > site and author).
> > 
> > However I get a lot of problems mount/unmounting devices...
> > 
> > DVD+RW
> > mkudffs /dev/hdc does not works... doing a strace opening /dev/hdc for
> > read/write open returns EROFS (or similar). I tried with blockdev
> > --setrw but still same errors...
> 
> I see two problems. The first problem is that the Mt Rainier detection
> can succeed when it shouldn't, because it forgets to check that the
> "GET CONFIGURATION" command returns the MRW feature number.

The second problem is in the dvdrw-support patch in the -mm kernel.
(This patch is also included in the patch you are using.)

The problem is that some drives fail the "GET CONFIGURATION" command
when asked to only return 8 bytes. This happens for example on my
drive, which is identified as:

        hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive

Since the cdrom_mmc3_profile() function already allocates 32 bytes for
the reply buffer, this patch is enough to make the command succeed on
my drive.

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/cdrom/cdrom.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/cdrom/cdrom.c~dvd+rw-get-configuration-fix drivers/cdrom/cdrom.c
--- linux/drivers/cdrom/cdrom.c~dvd+rw-get-configuration-fix	2004-08-16 20:54:49.710353928 +0200
+++ linux-petero/drivers/cdrom/cdrom.c	2004-08-16 20:55:41.514478504 +0200
@@ -834,7 +834,7 @@ static void cdrom_mmc3_profile(struct cd
 	cgc.cmd[0] = GPCMD_GET_CONFIGURATION;
 	cgc.cmd[1] = 0;
 	cgc.cmd[2] = cgc.cmd[3] = 0;		/* Starting Feature Number */
-	cgc.cmd[7] = 0; cgc.cmd [8] = 8;	/* Allocation Length */
+	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
 	cgc.quiet = 1;
 
 	if ((ret = cdi->ops->generic_packet(cdi, &cgc))) {
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
