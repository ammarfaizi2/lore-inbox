Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbTH0T5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 15:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTH0T5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 15:57:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:62625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262122AbTH0T5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 15:57:40 -0400
Date: Wed, 27 Aug 2003 12:41:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Okrain Genady <mafteah@mafteah.co.il>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Some errors with 2.6.0-test4-mm2
Message-Id: <20030827124120.2f93c976.akpm@osdl.org>
In-Reply-To: <200308271047.47794.mafteah@mafteah.co.il>
References: <200308271047.47794.mafteah@mafteah.co.il>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okrain Genady <mafteah@mafteah.co.il> wrote:
>
> This error started with -mm2:
> 
> # lilo
> <1>Unable to handle kernel NULL pointer dereference at virtual address 
> 00000000
>  printing eip:
> c029f9b2
> *pde = 00000000
> Oops: 0000 [#4]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c029f9b2>]    Tainted: PF  VLI
> EFLAGS: 00010246
> EIP is at generic_ide_ioctl+0x352/0x8b0
> eax: 00000000   ebx: bfffec70   ecx: 0000e7a2   edx: 00000000
> esi: bfffec68   edi: c87ca000   ebp: c87cbf68   esp: c87cbf2c
> ds: 007b   es: 007b   ss: 0068
> Process lilo (pid: 5503, threadinfo=c87ca000 task=c8eac080)
> Stack: c03c76db 0000064e c7853200 fffffff2 00000000 00000000 e7a20003 c04ccb8c
>        cfa7e000 c87cbf9c c0153b66 cf5ae6c0 cfd33e40 c02a3a60 cf619680 c87cbf90
>        c0268235 cfd33e40 00000301 bfffec68 bfffec68 00000001 00000301 c7853200
> Call Trace:
>  [<c0153b66>] filp_open+0x66/0x70
>  [<c02a3a60>] idedisk_ioctl+0x0/0x30

Al has sent through a fix for this.


diff -puN include/linux/genhd.h~large-dev_t-12-fix include/linux/genhd.h
--- 25/include/linux/genhd.h~large-dev_t-12-fix	2003-08-27 10:36:32.000000000 -0700
+++ 25-akpm/include/linux/genhd.h	2003-08-27 10:36:32.000000000 -0700
@@ -197,7 +197,7 @@ extern void rand_initialize_disk(struct 
 
 static inline sector_t get_start_sect(struct block_device *bdev)
 {
-	return bdev->bd_part->start_sect;
+	return bdev->bd_contains == bdev ? 0 : bdev->bd_part->start_sect;
 }
 static inline sector_t get_capacity(struct gendisk *disk)
 {

_

