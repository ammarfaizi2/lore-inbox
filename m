Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264992AbUEVC3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbUEVC3X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUEVCVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:21:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:24286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264804AbUEVCTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:19:36 -0400
Date: Fri, 21 May 2004 19:19:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/buffer.c:1270! [TAINTED]
Message-Id: <20040521191904.68544946.akpm@osdl.org>
In-Reply-To: <40AE4AAB.60008@g-house.de>
References: <40AE4AAB.60008@g-house.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:
>
> kernel BUG at fs/buffer.c:1270!
>  invalid operand: 0000 [#1]
>  PREEMPT
>  Modules linked in: snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi
>  snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd soundcore ide_cd
>  cdrom isofs zlib_inflate nls_utf8 ntfs nls_iso8859_15 vfat fat nls_base
>  xfs agpgart autofs4 ipv6 8250 serial_core nvidia rtc
>  CPU:    0
>  EIP:    0060:[<c0151806>]    Tainted: P
>  EFLAGS: 00010286   (2.6.6)
>  EIP is at __getblk_slow+0x66/0xf0
>  eax: fffffe00   ebx: 00000000   ecx: 0000d200   edx: 0000d200
>  esi: 00000000   edi: dffe0740   ebp: 00008000   esp: c0d25dc8
>  ds: 007b   es: 007b   ss: 0068
>  Process mount (pid: 4585, threadinfo=c0d24000 task=dd3682b0)
>  Stack: dffe0740 00008000 00000000 00000000 00000000 00008000 dffe0740
>  00000000
>  ~       c0151bff dffe0740 00008000 00000000 00000010 00008000 df718eb8
>  c0151c8f
>  ~       dffe0740 00008000 00000000 e0ca3e79 dffe0740 00008000 00000000
>  00000000
>  Call Trace:
>  ~ [<c0151bff>] __getblk+0x4f/0x60
>  ~ [<c0151c8f>] __bread+0x1f/0x40
>  ~ [<e0ca3e79>] isofs_fill_super+0x159/0x700 [isofs]
>  ~ [<c0156235>] sb_set_blocksize+0x25/0x60
>  ~ [<c0155c3d>] get_sb_bdev+0x11d/0x150
>  ~ [<e0ca50ef>] isofs_get_sb+0x2f/0x40 [isofs]
>  ~ [<e0ca3d20>] isofs_fill_super+0x0/0x700 [isofs]
>  ~ [<c0155e8f>] do_kern_mount+0x5f/0xe0
>  ~ [<c016b0c8>] do_add_mount+0x78/0x170
>  ~ [<c016b3c4>] do_mount+0x144/0x190

This is isofs passing sinful block sizes to bread().  There's a patch in
Linus's current tree which should allow the system to survive this.  It
won't fix the root problem though, which is presumably related to those I/O
errors.


diff -puN fs/buffer.c~getblk-BUG-removal fs/buffer.c
--- 25/fs/buffer.c~getblk-BUG-removal	2004-05-21 00:50:13.353550904 -0700
+++ 25-akpm/fs/buffer.c	2004-05-21 00:50:13.359549992 -0700
@@ -1263,12 +1263,6 @@ grow_buffers(struct block_device *bdev, 
 	pgoff_t index;
 	int sizebits;
 
-	/* Size must be multiple of hard sectorsize */
-	if (size & (bdev_hardsect_size(bdev)-1))
-		BUG();
-	if (size < 512 || size > PAGE_SIZE)
-		BUG();
-
 	sizebits = -1;
 	do {
 		sizebits++;
@@ -1289,6 +1283,18 @@ grow_buffers(struct block_device *bdev, 
 struct buffer_head *
 __getblk_slow(struct block_device *bdev, sector_t block, int size)
 {
+	/* Size must be multiple of hard sectorsize */
+	if (unlikely(size & (bdev_hardsect_size(bdev)-1) ||
+			(size < 512 || size > PAGE_SIZE))) {
+		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
+					size);
+		printk(KERN_ERR "hardsect size: %d\n",
+					bdev_hardsect_size(bdev));
+
+		dump_stack();
+		return NULL;
+	}
+
 	for (;;) {
 		struct buffer_head * bh;
 

_


