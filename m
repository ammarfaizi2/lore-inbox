Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273909AbTHKT1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273906AbTHKT0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:26:06 -0400
Received: from [66.212.224.118] ([66.212.224.118]:30226 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S273909AbTHKTZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:25:01 -0400
Date: Mon, 11 Aug 2003 15:13:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: test3 oops on Compaq 8500R
In-Reply-To: <Pine.LNX.4.44.0308111552350.1734-100000@logos.cnet>
Message-ID: <Pine.LNX.4.53.0308111509160.26153@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0308111552350.1734-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Marcelo Tosatti wrote:

> EIP is at DAC960_open+0x15/0x80
> eax: 00000000   ebx: 00000000   ecx: f668d004   edx: f6a2c004
> esi: 00000000   edi: f668e6a0   ebp: f6a2c004   esp: cc1fbd1c
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=cc1fa000 task=f7f97000)
> Stack: 00000000 f668d004 c016884c f668d004 cc1fbe08 00000000 00000000 
> c195a03c
>        00000246 c195a03c 00000000 f668d004 00000000 cc1fbe08 f668e6a0 
> c0168bf9
>        f668e6a0 f668d004 cc1fbe08 00000000 00000000 00000000 00000000 
> f668d004
> Call Trace:
>  [<c016884c>] do_open+0x12c/0x470
>  [<c0168bf9>] blkdev_get+0x69/0x80
>  [<c0198081>] register_disk+0xa1/0x130
>  [<c023b2bf>] blk_register_region+0x2f/0x40
>  [<c023b35a>] add_disk+0x3a/0x50
>  [<c023b2f0>] exact_match+0x0/0x10
>  [<c023b300>] exact_lock+0x0/0x20
>  [<c024e004>] DAC960_Probe+0x84/0xa0
>  [<c01f14bc>] pci_device_probe_static+0x2c/0x50
>  [<c01f1671>] __pci_device_probe+0x21/0x40
>  [<c01f16af>] pci_device_probe+0x1f/0x40
>  [<c02347f4>] bus_match+0x34/0x60
>  [<c02348d4>] driver_attach+0x44/0x60
>  [<c0234b41>] bus_add_driver+0x71/0x90
>  [<c01f1968>] pci_register_driver+0x88/0xb0
>  [<c025407e>] DAC960_init_module+0xe/0x30
>  [<c041889b>] do_initcalls+0x3b/0x90
>  [<c01050fb>] init+0x7b/0x210
>  [<c0105080>] init+0x0/0x210
>  [<c0108ba5>] kernel_thread_helper+0x5/0x10
>                                             
> Code: 8b 98 48 01 00 00 80 7b 1c 00 75 12 85 f6 75 0e 8b 44 24 10
>  <0>Kernel panic: Attempted to kill init!

NULL disk->queue->queuedata, what does the following (possibly 
fundamentally flawed) patch do?

Index: linux-2.6.0-test3-huge_kpage/drivers/block/DAC960.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/drivers/block/DAC960.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 DAC960.c
--- linux-2.6.0-test3-huge_kpage/drivers/block/DAC960.c	10 Aug 2003 08:42:16 -0000	1.1.1.1
+++ linux-2.6.0-test3-huge_kpage/drivers/block/DAC960.c	11 Aug 2003 19:08:29 -0000
@@ -71,6 +71,9 @@ static int DAC960_open(struct inode *ino
 	DAC960_Controller_T *p = disk->queue->queuedata;
 	int drive_nr = (int)disk->private_data;
 
+	if (!p)
+		return -ENXIO;
+
 	/* bad hack for the "user" ioctls */
 	if (!p->ControllerNumber && !drive_nr && (file->f_flags & O_NONBLOCK))
 		return 0;
