Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267875AbUHPSxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267875AbUHPSxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUHPSvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:51:01 -0400
Received: from av3-1-sn3.vrr.skanova.net ([81.228.9.109]:33208 "EHLO
	av3-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S267883AbUHPSue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:50:34 -0400
To: Frediano Ziglio <freddyz77@tin.it>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Packet writing problems
References: <1092669361.4254.24.camel@freddy>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Aug 2004 20:50:15 +0200
In-Reply-To: <1092669361.4254.24.camel@freddy>
Message-ID: <m3acwuq5nc.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frediano Ziglio <freddyz77@tin.it> writes:

> I'm trying to do packet writing with my new DVD writer.
> 
> # cat /proc/ide/hdc/model
> PIONEER DVD-RW DVR-107D
> 
> dma enabled.
> After some tests with 2.4 I decided to switch to 2.6.
> I used Fedora Core 2 with a vanilla kernel 2.6.8.1 + patch from
> http://w1.894.telia.com/~u89404340/patches/packet/2.6/, udftools with
> Petero patch (http://w1.894.telia.com/~u89404340/patches/packet/, same
> site and author).
> 
> However I get a lot of problems mount/unmounting devices...
> 
> DVD+RW
> mkudffs /dev/hdc does not works... doing a strace opening /dev/hdc for
> read/write open returns EROFS (or similar). I tried with blockdev
> --setrw but still same errors...

I see two problems. The first problem is that the Mt Rainier detection
can succeed when it shouldn't, because it forgets to check that the
"GET CONFIGURATION" command returns the MRW feature number. On one of
my drives, the command returns feature 0x2a which is DVD+RW.

This bug has nothing to do with the packet writing driver, and the
patch below fixes it.

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/drivers/cdrom/cdrom.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/cdrom/cdrom.c~mrw-fix drivers/cdrom/cdrom.c
--- linux/drivers/cdrom/cdrom.c~mrw-fix	2004-08-16 20:35:45.332325832 +0200
+++ linux-petero/drivers/cdrom/cdrom.c	2004-08-16 20:38:32.513910368 +0200
@@ -521,6 +521,8 @@ int cdrom_is_mrw(struct cdrom_device_inf
 		return ret;
 
 	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];
+	if (be16_to_cpu(mfd->feature_code) != CDF_MRW)
+		return 1;
 	*write = mfd->write;
 
 	if ((ret = cdrom_mrw_probe_pc(cdi))) {
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
