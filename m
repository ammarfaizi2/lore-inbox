Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUCWXCO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUCWXCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:02:14 -0500
Received: from havoc.gtf.org ([216.162.42.101]:10396 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262896AbUCWXCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:02:10 -0500
Date: Tue, 23 Mar 2004 18:02:09 -0500
From: David Eger <eger@havoc.gtf.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] UTF-8ifying the kernel sources
Message-ID: <20040323230209.GA25510@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following are four patches against Linux 2.6.4 for charset clean-up.
That is, converting the sources to be UTF-8 text.  Please consider.

Thankfully, the vast majority of the kernel sources (some 15860 files)
are 7-bit clean ASCII.  The rest (274 files) are mostly ISO Latin-1.
However, there are spots of pure junk (userland output in the docs and
some corruption that's creeped in over time), box-drawing characters,
EUC-JP, and ISO-2022-JP.

The only controversial patch here is patch 4, which changes the 
output of the kernel to userspace (via /proc, mostly).  It sets the
policy that the kernel should output UTF-8 instead of ISO Latin-1 
when printing things that are not 7-bit ASCII.  Details below.

-dte

Patch 1: linux-2.6.4-utf8-cleanup-auto.diff.bz2
===============================================
237 ISO Latin-1 files auto-converted to UTF-8.
All changes are to documentation or to the comments of code.

Patch 2: linux-2.6.4-utf8-cleanup-jp.diff
=========================================
arch/v850/kernel/as85ep1.ld
arch/v850/kernel/as85ep1.c

Two files containing Japanese comments - in two different charsets!
Unfortunately, emacs doesn't understand CJK pages in UTF-8.  
cat, less, and vim do. (though vim gets confused when you look 
at the diff, since it is a mix of two charsets...)

Patch 3: linux-2.6.4-utf8-cleanup-wrong.diff
============================================
drivers/video/amifb.c   - +- sign (NOTE: X's .ttf files just don't have it)
Documentation/i2c/i2c-protocol  - NBSP, but why? (made regular space)
arch/i386/kernel/cpu/cyrix.c    - NBSP, but why? (made regular space)
include/linux/802_11.h - why the non-standard dash? (made regular dash)
scripts/docproc.c       - why the bizarre spelling for specific? (fixed)
fs/ext2/xattr.c - bad ASCII art (made regular pipe - fixed)
fs/ext3/xattr.c - bad ASCII art (made regular pipe - fixed)
arch/arm/nwfpe/fpopcode.h       - line-drawing characters (fixed)
include/asm-m68k/atarihw.h      - 0x94? no, it's an ö, for Björn
include/asm-m68k/atariints.h    - 0x94? no, it's an ö, for Björn

Patch 4: linux-2.6.4-utf8-cleanup-cstrings2utf8.diff
====================================================
arch/ppc/platforms/proc_rtas.c  -  a C string w/"degrees": exports to proc
arch/ppc64/kernel/rtas-proc.c   -  a C string w/"degrees": exports to proc
drivers/macintosh/therm_adt7467.c       - temperature reporting (degrees sign)
        - several printk's, output to a devfs interface, MODULE_PARAM_DESC(), 
drivers/mtd/chips/cfi_probe.c   - time reporting (micro sign) 
        - printk's in the DEBUG code
drivers/net/wireless/netwave_cs.c       - module version string 
    (author's name - but it doesn't seem to be *used* for anything...)
