Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUGLMBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUGLMBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 08:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUGLMBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 08:01:38 -0400
Received: from witte.sonytel.be ([80.88.33.193]:36844 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266725AbUGLMB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 08:01:29 -0400
Date: Mon, 12 Jul 2004 14:01:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc1
In-Reply-To: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0407121356510.17199@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Linus Torvalds wrote:
> Hirofumi Ogawa:
>   o FAT: don't use "utf8" charset and NLS_DEFAULT

This patch breaks compilation if both MSDOS_FS and VFAT_FS are not set, due to
CONFIG_FAT_DEFAULT_CODEPAGE being undefined.

Suggested fix: either make FAT_DEFAULT_CODEPAGE depend on FAT_FS only
(compilation of fs/fat/inode.c depends on FAT_FS), or add a test for
CONFIG_FAT_DEFAULT_CODEPAGE being undefined, cfr. the test for
CONFIG_FAT_DEFAULT_IOCHARSET in fs/fat/inode.c.

| --- a/fs/Kconfig	2004-06-20 11:08:01 -07:00
| +++ b/fs/Kconfig	2004-06-20 11:08:01 -07:00
| @@ -672,6 +672,25 @@
|  	  To compile this as a module, choose M here: the module will be called
|  	  vfat.
|
| +config FAT_DEFAULT_CODEPAGE
| +	int "Default codepage for FAT"
| +	depends on MSDOS_FS || VFAT_FS
| +	default 437
| +	help
| +	  This option should be set to the codepage of your FAT filesystems.
| +	  It can be overridden with the 'codepage' mount option.
| +
| +config FAT_DEFAULT_IOCHARSET
| +	string "Default iocharset for FAT"
| +	depends on VFAT_FS
| +	default "iso8859-1"
| +	help
| +	  Set this to the default I/O character set you'd like FAT to use.
| +	  It should probably match the character set that most of your
| +	  FAT filesystems use, and can be overridded with the 'iocharset'
| +	  mount option for FAT filesystems.  Note that UTF8 is *not* a
| +	  supported charset for FAT filesystems.
| +
|  config UMSDOS_FS
|  #dep_tristate '    UMSDOS: Unix-like file system on top of standard MSDOS fs' CONFIG_UMSDOS_FS $CONFIG_MSDOS_FS
|  # UMSDOS is temprory broken
| diff -Nru a/fs/fat/inode.c b/fs/fat/inode.c
| --- a/fs/fat/inode.c	2004-06-20 11:08:01 -07:00
| +++ b/fs/fat/inode.c	2004-06-20 11:08:01 -07:00
| @@ -23,6 +23,14 @@
|  #include <linux/parser.h>
|  #include <asm/unaligned.h>
|
| +#ifndef CONFIG_FAT_DEFAULT_IOCHARSET
| +/* if user don't select VFAT, this is undefined. */
| +#define CONFIG_FAT_DEFAULT_IOCHARSET	""
| +#endif
| +
| +static int fat_default_codepage = CONFIG_FAT_DEFAULT_CODEPAGE;
| +static char fat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
| +
|  /*
|   * New FAT inode stuff. We do the following:
|   *	a) i_ino is constant and has nothing with on-disk location.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
