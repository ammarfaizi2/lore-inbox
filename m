Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265503AbUABLTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 06:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUABLTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 06:19:43 -0500
Received: from [211.167.76.68] ([211.167.76.68]:26563 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265503AbUABLTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 06:19:41 -0500
Date: Fri, 2 Jan 2004 17:02:34 +0800
From: Hugang <hugang@soulinfo.com>
To: Jens Axboe <axboe@suse.de>
Cc: Bart Samwel <bart@samwel.tk>, Andrew Morton <akpm@osdl.org>,
       smackinlay@mail.com, Bartek Kania <mrbk@gnarf.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] laptop-mode-2.6.0 version 5
Message-Id: <20040102170234.66d6811d@localhost>
In-Reply-To: <20040101183545.GD5523@suse.de>
References: <20031231210756.315.qmail@mail.com>	<3FF3887C.90404@samwel.tk>	<20031231184830.1168b8ff.akpm@osdl.org>	<3FF43BAF.7040704@samwel.tk>
	<3FF457C0.2040303@samwel.tk>
	<20040101183545.GD5523@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Jan 2004 19:35:45 +0100
Jens Axboe <axboe@suse.de> wrote:

> Patch is obviously bogus, just look at the comm definition in sched.h:
> 
> 	char comm[16];
> 
> IO submission must happen in process context, so we also know that
> current is valid.

You are right. But why add this patch, My laptop not crash when I enable block dump, So I try to find where is the Bug. Final, The bug is in sector_t, I was enable CONFIG_LBD, So sector_t is u64, So We have to change the code when enable CONFIG_LBD.

I'd like the 2.4 style so add count number into printf.

Here is the patch fix it
+
+   if (unlikely(block_dump)) {
+       char b[BDEVNAME_SIZE];
+       printk("%s(%d): %s block %llu/%u on %s\n",
+           current->comm, current->pid,
+           (rw & WRITE) ? "WRITE" : (rw == READA ? "READA" : "READ"),
+           (u64)bio->bi_sector, count, bdevname(bio->bi_bdev,b));
+   }
+


I think, also have this bug in 2.4.23, here is the patch for it, Hope can helpful.
Index: linux-2.4.23/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.4.23/drivers/block/ll_rw_blk.c      (revision 4)
+++ linux-2.4.23/drivers/block/ll_rw_blk.c      (working copy)
@@ -1298,7 +1298,7 @@
                wake_up(&bh->b_wait);
 
        if (block_dump)
-               printk(KERN_DEBUG "%s: %s block %lu/%u on %s\n", current->comm, rw == WRITE ? "WRITE" : "READ", bh->b_rsector, count, kdevname(bh->b_rdev));
+               printk(KERN_DEBUG "%s: %s block %llu/%u on %s\n", current->comm, rw == WRITE ? "WRITE" : "READ", (u64)bh->b_rsector, count, kdevname(bh->b_rdev));
 
        put_bh(bh);
        switch (rw) {

-- 
Hu Gang / Steve
RLU#          : 204016 [1999] (Registered Linux user)
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
