Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUCEXY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUCEXY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:24:29 -0500
Received: from havoc.gtf.org ([216.162.42.101]:38075 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261449AbUCEXY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:24:26 -0500
Date: Fri, 5 Mar 2004 18:24:25 -0500
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UTF-8ifying the kernel source
Message-ID: <20040305232425.GA6239@havoc.gtf.org>
References: <20040304100503.GA13970@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040304100503.GA13970@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are now three patches available, and some work left to go.

The first patch hasn't changed, still the trivial ISO Latin-1 => UTF-8.

The second patch takes care of a lot of wrong and/or unneeded non-ASCII.

The third patch concerns 8-bit characters embedded in C strings.
These are almost always output to devfs or proc.  The characters used are
the degrees symbol (for ppc temp. sensors) and mu (for micro-seconds).
I do not want to make a value judgement on what the kernel outputs
to userspace, so I leave the strings the same.  However, C99 makes it
implementation defined how the source character set is translated to
the character set in the compiled binary...  Therefore, I've taken the
raw octets and converted them in the source file to octal constants in
the strings, just to make sure cc doesn't mangle things if you set your
locale differently...

http://www.yak.net/random/linux-2.6.3-utf8-cleanup-auto.diff.bz2
http://www.yak.net/random/linux-2.6.3-utf8-cleanup-wrong.diff
http://www.yak.net/random/linux-2.6.3-utf8-cleanup-cstrings.diff

-dte


Un-needed/wrong non-ASCII characters (patch 2)
==============================================
drivers/video/amifb.c	- +- sign (NOTE: X's .ttf files just don't have it)
Documentation/i2c/i2c-protocol	- NBSP, but why? (made regular space)
arch/i386/kernel/cpu/cyrix.c	- NBSP, but why? (made regular space)
include/linux/802_11.h - why the non-standard dash? (made regular dash)
scripts/docproc.c	- why the bizarre spelling for specific? (fixed)
fs/ext2/xattr.c	- bad ASCII art (made regular pipe - fixed)
fs/ext3/xattr.c	- bad ASCII art (made regular pipe - fixed)
arch/arm/nwfpe/fpopcode.h	- line-drawing characters (fixed)
include/asm-m68k/atarihw.h	- 0x94? no, it's an ö, for Björn
include/asm-m68k/atariints.h	- 0x94? no, it's an ö, for Björn

C strings - (patch 3)
=====================
arch/ppc/platforms/proc_rtas.c	-  a C string w/"degrees": exports to proc
arch/ppc64/kernel/rtas-proc.c	-  a C string w/"degrees": exports to proc
drivers/macintosh/therm_adt7467.c	- temperature reporting (degrees sign)
	- several printk's, output to a devfs interface, MODULE_PARAM_DESC(), 
drivers/mtd/chips/cfi_probe.c	- time reporting (micro sign) 
	- printk's in the DEBUG code
drivers/net/wireless/netwave_cs.c	- module version string 
   (author's name - but it doesn't seem to be *used* for anything...)

BELOW HERE not fixed...

(was going to be fixed w/ patch, but, umm, huh?)
==================================================
arch/v850/kernel/as85ep1.ld	- according to Miles Bader, 
	it's EUC-JP in the comments, and e.g. as85ep1.c uses ISO-2022-JP...
drivers/char/ftape/lowlevel/fdc-isr.c	- WTF? shit in the comments
fs/afs/vlclient.h	- a degrees sign, but why? (author says he'll get it)
drivers/scsi/dc395x.c	- C debug strings... is this chinese traditional?
Documentation/networking/tms380tr.txt	- DOS-style ASCII art 

Other - (i'd convert it, but...)
================================
drivers/pci/pci.ids	- I don't know what program processes this...
drivers/ieee1394/oui.db	- I don't know what program processes this...

Machine / charset specific shite - (does anything need to be done?)
===================================================================
arch/m68k/hp300/hp300map.map	- maps to "char"s.. grr
drivers/char/defkeymap.map	- a map file... maps to "char"s.. grr
drivers/char/qtronixmap.c_shipped	- maps to "char"s.. grr
drivers/char/qtronixmap.map	- maps to "char"s.. grr
drivers/tc/lk201-map.c_shipped	- maps to "char"s.. grr
drivers/tc/lk201-map.map	- maps to "char"s.. grr
drivers/acorn/char/defkeymap-l7200.c	- maps to "char"s.. grr
arch/s390/kernel/ebcdic.c	- comments on a keymap table
drivers/video/console/font_8x16.c	- comments on a keymap table 
drivers/video/console/font_8x8.c	- comments on a keymap table 
drivers/video/console/font_pearl_8x8.c	- comments on a keymap table 
drivers/s390/ebcdic.c	- comments on a keymap table

Noise from userland (this I won't be touching)
==============================================
Documentation/networking/ethertap.txt	- random crap cat'd from /dev/tap0
Documentation/s390/Debugging390.txt	- weird gdb output

