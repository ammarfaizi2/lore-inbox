Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUGBVwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUGBVwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUGBVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:52:50 -0400
Received: from av2-1-sn3.vrr.skanova.net ([81.228.9.107]:41867 "EHLO
	av2-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S264937AbUGBVwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:52:33 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
References: <m2lli36ec9.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jul 2004 23:52:22 +0200
In-Reply-To: <m2lli36ec9.fsf@telia.com>
Message-ID: <m2u0wqqdpl.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> This patch implements CDRW packet writing as a kernel block device.
> Usage instructions are in the packet-writing.txt file.
...
> +static int pkt_proc_device(struct pktcdvd_device *pd, char *buf)
> +{
> +	char *b = buf, *msg;
> +	char bdev_buf[BDEVNAME_SIZE];
> +	int states[PACKET_NUM_STATES];
> +
> +	b += sprintf(b, "\nWriter %s mapped to %s:\n", pd->name,
> +		     __bdevname(pd->dev, bdev_buf));

This code leaks a module reference. The patch below fixes it. I'm not
sure it's correct, but do_open() also does module_put() after
put_disk().

Signed-off-by: Peter Osterlund <petero2@telia.com>

---

 linux-petero/fs/partitions/check.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/partitions/check.c~packet-refcnt fs/partitions/check.c
--- linux/fs/partitions/check.c~packet-refcnt	2004-07-02 23:18:22.000000000 +0200
+++ linux-petero/fs/partitions/check.c	2004-07-02 23:18:23.000000000 +0200
@@ -151,6 +151,7 @@ const char *__bdevname(dev_t dev, char *
 	if (disk) {
 		buffer = disk_name(disk, part, buffer);
 		put_disk(disk);
+		module_put(disk->fops->owner);
 	} else {
 		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 				MAJOR(dev), MINOR(dev));
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
