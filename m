Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279556AbRJXTNm>; Wed, 24 Oct 2001 15:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279574AbRJXTNd>; Wed, 24 Oct 2001 15:13:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26116 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279556AbRJXTNM>; Wed, 24 Oct 2001 15:13:12 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: linux-2.4.13 high SWAP
Date: Wed, 24 Oct 2001 19:11:59 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9r73pv$8h1$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0110241509250.885-100000@freak.distro.conectiva> <200110241936.RAA04632@inter.lojasrenner.com.br>
X-Trace: palladium.transmeta.com 1003950802 24140 127.0.0.1 (24 Oct 2001 19:13:22 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 Oct 2001 19:13:22 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110241936.RAA04632@inter.lojasrenner.com.br>,
Andre Margis  <andre@sam.com.br> wrote:
>
>Without use the tmpfs, appears to be OK!!!!!!!!!!

Ok, the problem appears to be that tmpfs stuff just stays on the
inactive list, and because it cannot be written out it eventually
totally clogs the system.

Suggested fix appended (from Andrea),

		Linus

-----
diff -u --recursive --new-file v2.4.13/linux/drivers/block/rd.c linux/drivers/block/rd.c
--- v2.4.13/linux/drivers/block/rd.c	Tue Oct 23 22:48:50 2001
+++ linux/drivers/block/rd.c	Wed Oct 24 08:59:21 2001
@@ -209,6 +209,7 @@
  */
 static int ramdisk_writepage(struct page *page)
 {
+	activate_page(page);
 	SetPageDirty(page);
 	UnlockPage(page);
 	return 0;
diff -u --recursive --new-file v2.4.13/linux/fs/ramfs/inode.c linux/fs/ramfs/inode.c
--- v2.4.13/linux/fs/ramfs/inode.c	Tue Oct  9 17:06:53 2001
+++ linux/fs/ramfs/inode.c	Wed Oct 24 08:59:21 2001
@@ -81,6 +81,7 @@
  */
 static int ramfs_writepage(struct page *page)
 {
+	activate_page(page);
 	SetPageDirty(page);
 	UnlockPage(page);
 	return 0;

