Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbUAKWut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUAKWut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:50:49 -0500
Received: from AGrenoble-101-1-2-83.w193-253.abo.wanadoo.fr ([193.253.227.83]:38825
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S266035AbUAKWui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:50:38 -0500
Subject: 2.6.0: blkdev_get() oopses on floppy
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1073861431.5014.85.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 23:50:32 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I writing a piece of code which piggybacks on a block_device (a bit like
dm/md). This particular piece of test code:

static void piggyback(dev_t dev)
{
        struct block_device *bdev;
        int err;
        bdev = bdget(dev);
        if(!bdev)
        {
                printk(KERN_ERR "no bdev ...\n");
                goto no_bdev;
        }
        err = blkdev_get(bdev, FMODE_READ, 0, BDEV_RAW);
        if(err)
        {
                printk(KERN_ERR "blkdev_get: error %d\n", -err);
                goto no_get;
        }
        printk(KERN_INFO "using device %s\n", dev->bd_disk->disk_name);
        blkdev_put(bdev, BDEV_RAW);
no_get:
        bdput(bdev);
no_bdev:
        return;
}

.. works fine on hda or ram0, but it oopses on fd0 or hdb (cdrom) in
blkdev_get(). As the raw devices seem to do something equivalent, I just
tried that:

raw /dev/raw/raw1 /dev/fd0
cat /dev/raw/raw1 >/dev/null

and got this oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000040
 printing eip:
d08a285a
*pde = 00000000
Oops: 0000 [#4]
CPU:    0
EIP:    0060:[<d08a285a>]    Not tainted
EFLAGS: 00000296
EIP is at floppy_open+0x1a/0x410 [floppy]
eax: 00000000   ebx: d08a2840   ecx: d08a9044   edx: d08a9584
esi: cfc9aac0   edi: cba1be6c   ebp: cfff108c   esp: cba1bd5c
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 16749, threadinfo=cba1a000 task=cc29f3a0)
Stack: c01fb800 00000000 cba1a000 00000001 cfff1040 cc2d9540 d08a2840 cfc9aac0
       cfff1040 d08a99c0 c015e964 cfff108c cba1be6c cffff8c8 c11d9b60 cba1a000
       00000246 cfff104c c0395420 00000000 cfff1040 00000001 cba1be6c cc2d9540
Call Trace:
 [<c01fb800>] exact_match+0x0/0x10
 [<d08a2840>] floppy_open+0x0/0x410 [floppy]
 [<c015e964>] do_open+0x134/0x410
 [<c015ecbe>] blkdev_get+0x7e/0xa0
 [<d08c9087>] raw_open+0x87/0x150 [raw]
 [<c015f932>] chrdev_open+0xf2/0x220
 [<c0165516>] open_namei+0xa6/0x400
 [<c0155630>] dentry_open+0x150/0x210
 [<c01554d8>] filp_open+0x68/0x70
 [<c015597b>] sys_open+0x5b/0x90
 [<c010b3d9>] sysenter_past_esp+0x52/0x71
 
Code: 8b 40 40 8b 70 28 b8 f0 ff ff ff 89 44 24 10 c7 47 74 00 00


Well now, why can't blkdev_get() be used on floppy ? And can someone
give me a pointer to understand the theory behind bdget(), blkdev_get(),
bd_claim() and friends ? I'm a bit lost when it comes to who does what,
especially do_open() in fs/block_dev.c

Thanks,
	Xav

