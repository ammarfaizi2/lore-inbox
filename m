Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTJUU2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTJUU2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:28:47 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17655 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263359AbTJUU2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:28:39 -0400
Date: Tue, 21 Oct 2003 21:28:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "B. D. Elliott" <bde@nwlink.com>
cc: David Woodhouse <dwmw2@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Slram doesn't work
In-Reply-To: <20031021050245.9083A6F661@smtp1.pacifier.net>
Message-ID: <Pine.LNX.4.44.0310212102300.1445-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003, B. D. Elliott wrote:
> I have an old (x86) machine that does not cache the upper half of memory.
> Under 2.4.x, I used "slram=slr0,64M,+64M" to reserve that half, and then
> used it as a swap device.
> 
> This fails on 2.6.0-test8, with an "ioremap failed" message during booting.
> The boot messages plus capturing the page flags in ioremap() shows the
> following:
> 
> ...
> slram: devname = slr0
> slram: devstart = 64M
> slram: devlength = +64M
> slram: devname=slr0, devstart=0x4000000, devlength=0x4000000
> .. ioremap failed: line 145 (approximately)
> .. phys_addr: 04000000 t_addr: c4000000 t_end: c7ffffff page0: c10a0000 page: c10a0000
> .. page-1 flags: 01000000
> .. page   flags: 01000080
> .. page+1 flags: 01000080
> .. page+2 flags: 01000080
> .. page+3 flags: 01000080
> .. PageReserved(page): 0
> slram: ioremap failed
> ...
> 
> The failure occurs where "PageReserved" is checked.  "page0" is the address
> of the first page entry for the region, which is also where it failed.
> ("PageReserved" is bit 11.)  Apparently, "PageReserved" is no longer set
> when slram initialization occurs.

The ioremap failure occurs because the 2.6 "mem=" bootparam currently
behaves slightly differently from the 2.4 one, and your slram ends up
overlapping memory used by the kernel.  That was noticed a few days
ago, and a fix to setup.c is already queued up in 2.6.0-test8-mm1.

But when you fix that, you'll find mkswap (and any other write to it)
fails: a small change to mtdblock_writesect seems to work fine for me,
but it might not be the right fix - MTD handles a lot more than just
slram, I've never delved in there before, David is the maintainer,
and sure to grasp the issues.

Many thanks for leading me to drivers/mtd/devices/slram.c: I'd long
thought such a driver should exist, but never discovered that it does
already exist.  Looks like just what's needed to eliminate one of my
betes noirs, arch/m68k/atari/stram.c.  (Though something else I'd like
to try with it, is using i386 mem above 4GB for swap: but it's not at
present suitable for that, since it's using permanent ioremap space.)

Hugh

--- 2.6.0-test8/arch/i386/kernel/setup.c	2003-10-08 20:24:56.000000000 +0100
+++ linux/arch/i386/kernel/setup.c	2003-10-21 18:10:02.000000000 +0100
@@ -141,14 +141,14 @@ static void __init probe_roms(void)
 
 static void __init limit_regions (unsigned long long size)
 {
+	unsigned long long current_addr = 0;
 	int i;
-	unsigned long long current_size = 0;
 
 	for (i = 0; i < e820.nr_map; i++) {
 		if (e820.map[i].type == E820_RAM) {
-			current_size += e820.map[i].size;
-			if (current_size >= size) {
-				e820.map[i].size -= current_size-size;
+			current_addr = e820.map[i].addr + e820.map[i].size;
+			if (current_addr >= size) {
+				e820.map[i].size -= current_addr-size;
 				e820.nr_map = i + 1;
 				return;
 			}
--- 2.6.0-test8/drivers/mtd/mtdblock.c	2003-07-02 21:59:59.000000000 +0100
+++ linux/drivers/mtd/mtdblock.c	2003-10-21 20:44:43.000000000 +0100
@@ -248,7 +248,7 @@ static int mtdblock_writesect(struct mtd
 			      unsigned long block, char *buf)
 {
 	struct mtdblk_dev *mtdblk = mtdblks[dev->devnum];
-	if (unlikely(!mtdblk->cache_data)) {
+	if (unlikely(!mtdblk->cache_data && mtdblk->mtd->erasesize)) {
 		mtdblk->cache_data = vmalloc(mtdblk->mtd->erasesize);
 		if (!mtdblk->cache_data)
 			return -EINTR;

