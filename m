Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVFTVFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVFTVFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVFTU5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:57:42 -0400
Received: from CPE00095b3131a0-CM0011ae8cd564.cpe.net.cable.rogers.com ([70.28.191.58]:58240
	"EHLO kenichi") by vger.kernel.org with ESMTP id S261820AbVFTUoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:44:22 -0400
From: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [PATCH] Fix Reiser4 Dependencies
Date: Mon, 20 Jun 2005 16:44:10 -0400
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Edward Shishkin <edward@namesys.com>
References: <20050619233029.45dd66b8.akpm@osdl.org> <200506200832.22260.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> <42B70A6D.7030308@namesys.com>
In-Reply-To: <42B70A6D.7030308@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201644.10429.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew James Wade wrote:
> 
> >*    ZLIB_INFLATE is not visible in menuconfig. Reiser4 should probably
> >     just select it like the other filesystems do.
The issue I had here was that Reiser4 wasn't appearing in menuconfig for
me as I did not have ZLIB_INFLATE set, and the ZLIB_INFLATE option wasn't
appearing either (I think it's because it doesn't have a prompt). I just
followed the pattern for all other filesystems referencing ZLIB_INFLATE,
and the comment in lib/Kbuild suggests this is the proper approach:

| #
| # compression support is select'ed if needed
| #

> >
> >*    Reiser4 also depends on ZLIB_DEFLATE.
I was getting linker errors:

| fs/built-in.o(.text+0x8f465): In function `gzip1_alloc':
| fs/reiser4/plugin/compress/compress.c:59: undefined reference to `zlib_deflate_workspacesize'
| fs/built-in.o(.text+0x8f475): In function `gzip1_alloc':
| include/asm/string.h:361: undefined reference to `zlib_deflate_workspacesize'
| fs/built-in.o(.text+0x8f64e): In function `gzip1_compress':
| fs/reiser4/plugin/compress/compress.c:167: undefined reference to `zlib_deflateInit2_'
| fs/built-in.o(.text+0x8f661):fs/reiser4/plugin/compress/compress.c:174: undefined reference to `zlib_deflateReset'
| fs/built-in.o(.text+0x8f697):fs/reiser4/plugin/compress/compress.c:184: undefined reference to `zlib_deflate'

select'ing ZLIB_DEFLATE fixed them.

Reiser4 is working for me after the two changes.

HTH,
Andrew


> >
> >signed-off-by: Andrew Wade <ajwade@alumni.uwaterloo.ca>
> >
> >--- 2.6.12-mm1/fs/reiser4/Kconfig	2005-06-20 07:38:22.087653000 -0400
> >+++ linux/fs/reiser4/Kconfig	2005-06-20 08:01:28.914324250 -0400
> >@@ -1,6 +1,8 @@
> > config REISER4_FS
> > 	tristate "Reiser4 (EXPERIMENTAL)"
> >-	depends on EXPERIMENTAL && !4KSTACKS && ZLIB_INFLATE
> >+	depends on EXPERIMENTAL && !4KSTACKS
> >+	select ZLIB_INFLATE
> >+	select ZLIB_DEFLATE
> > 	help
> > 	  Reiser4 is a filesystem that performs all filesystem operations
> > 	  as atomic transactions, which means that it either performs a
