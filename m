Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEXcf>; Tue, 5 Dec 2000 18:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLEXcZ>; Tue, 5 Dec 2000 18:32:25 -0500
Received: from Cantor.suse.de ([194.112.123.193]:58384 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129210AbQLEXcL>;
	Tue, 5 Dec 2000 18:32:11 -0500
Date: Wed, 6 Dec 2000 00:01:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livelock in elevator scheduling
Message-ID: <20001206000108.F747@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp> <20001121112836.B10007@suse.de> <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp> <20001121123608.F10007@suse.de> <3A2840AB.EE085CAA@thebarn.com> <20001202164234.B31217@suse.de> <3A2C472B.DBEA9E9@thebarn.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <3A2C472B.DBEA9E9@thebarn.com>; from cattelan@thebarn.com on Mon, Dec 04, 2000 at 07:38:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04 2000, Russell Cattelan wrote:
> I'm going to take a closer look at the scsi_back_merge_fn.
> This may  have more to due with our/Chait's kiobuf modifications than
> anything else.
> 
> 
> 
> XFS (dev: 8/20) mounting with KIOBUFIO
> Start mounting filesystem: sd(8,20)
> Ending clean XFS mount for filesystem: sd(8,20)
> kmem_alloc doing a vmalloc 262144 size & PAGE_SIZE 0 rval=0xe0a10000
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000008
>  printing eip:
> c019f8b5
> *pde = 00000000
> 
> Entering kdb (current=0xc1910000, pid 5) on processor 1 Panic: Oops
> due to panic @ 0xc019f8b5
> eax = 0x00000002 ebx = 0x00000001 ecx = 0x00081478 edx = 0x00000000
> esi = 0xc1957da0 edi = 0xc1923ac8 esp = 0xc1911e94 eip = 0xc019f8b5
> ebp = 0xc1911e9c xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010046
> xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc1911e60
> [1]kdb> bt
>     EBP       EIP         Function(args)
> 0xc1911e9c 0x00000000c019f8b5 scsi_back_merge_fn_c+0x15 (0xc1923a98,
> 0xc1957da0, 0xcfb05780, 0x80)
>                                kernel .text 0xc0100000 0xc019f8a0

Ah, I see what it is now. The elevator is attempting to merge a buffer
head into a kio based request, poof. The attached diff should take
care of that in your tree.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xfs-elv-1

--- drivers/block/elevator.c~	Tue Dec  5 23:59:01 2000
+++ drivers/block/elevator.c	Tue Dec  5 23:59:41 2000
@@ -39,6 +39,9 @@
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
 
+		if (req->kiobuf)
+			continue;
+
 		/*
 		 * simply "aging" of requests in queue
 		 */
@@ -105,6 +108,8 @@
 	while ((entry = entry->prev) != head) {
 		struct request *__rq = blkdev_entry_to_request(entry);
 
+		if (req->kiobuf)
+			continue;
 		if (__rq->cmd != rw)
 			continue;
 		if (__rq->rq_dev != bh->b_rdev)

--bg08WKrSYDhXBjb5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
