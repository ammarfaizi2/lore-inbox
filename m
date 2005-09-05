Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVIED6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVIED6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVIED6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:58:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25805 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932189AbVIED6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:58:49 -0400
Date: Mon, 5 Sep 2005 04:58:48 +0100
From: viro@ZenIV.linux.org.uk
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.13-git3-bird1
Message-ID: <20050905035848.GG5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	While waaaaay overdue, "fixes and sparse annotations" tree is finally
going public.  This version is basically a starting point - there will be
much more stuff to merge.

	Right now it builds with allmodconfig[1] on the following set:
alpha (UP and SMP), amd64 (UP and SMP), arm (RPC, versatile), i386, ia64,
m32r, m68k (sans sun3), ppc (6xx, 44x, chestnut), ppc64, sparc, sparc64,
s390 (31 and 64bit) and uml (i386 and amd64)[2].

	Amount of sparse and gcc4 warnings is moderate on all of the
above - there's no "drowns everything in noise" stuff left.  There _are_
nasty areas (drm, some of the sata, several mem* helpers with constant
arguments), but at least that's easy to isolate.  Tracking build log
changes for regressions had been fairly easy so far; quite a few chunks
in there (as well as already merged stuff) had been found that way,
so for now I'd say that it's usable.

	Current patchset is on ftp.linux.org.uk/pub/people/viro/ -
patch-2.6.13-git3-bird1.bz2 is combined patch, patchset/* is the splitup.
Long description of patches is in patchset/set*, short log is in the end of
this posting.  Current build and sparse logs are in logs/*/{log17b,S-log17b}.
Eventually I'll probably have to use rcs for them - they are large and change
slowly...

	Patchset will change pretty fast; for one thing, most of the stuff
in there is easily mergable, for another - sparse patches here are just
dealing with the most annoying noise sources.  There will be more and folks
are more than welcome to send sane annotation patches for merge.

	Have fun - it's just getting started...

[1] configs being tracked are of allmodconfig-with-fixed-subset variety; e.g.
alpha-UP is "set as much as possible to y or m, with CONFIG_SMP not set", etc.
See config/* for currently tracked ones.

[2] toolkit for cross-toolchains will be re-posted on anonftp pretty soon;
ditto for details on cross-build setups, etc.

Short log of the current patchset follows:
----------------------------------------------------------------------------
linus-delta	Changes in Linus' tree since -git3

Infrastructure:

I0-kconfig	Teaches allmodconfig to pin a set of options in given
		state [NB: rz has another variant; this is just a temporary]
I1-CHECKFLAGS	Allows to add stuff to CHECKFLAGS from command line
I2-disable-DI	disables CONFIG_DEBUG_INFO for test builds

Kconfig fixes:

B2-rio		rio is too broken to mess with; marked as such
B7-floppy	sanitized and fixed floppy dependencies
B12-broken-on-big-endian	new kconfig symbol: BROKEN_ON_BIG_ENDIAN.
B17-m32r-smc	combination of M32R, SMC91X and ISA is broken
B22-mtd-xip	MTD_XIP is there only for two subarchitectures of ARM - PXA
		and SA1100 [not for merge; cleaner variant needed]
B23-8390	8390 fixes - part 1 (generic and arm/etherh)
B33-m68k-8390	8390 fixes - part 2 (m68k ones)
B41-s390-phy	PHYLIB is broken on s390
B42-mga		drm/mga is broken if AGP is not enabled

Pure compile fixes:

C0-envctrl	envctrl fixes
C15-mv643xx_eth	mv643xx_eth ifdefs [not for merge; dwmw2 has objections]
C32-segment	missed gratitious includes of asm/segment.h
B40-mxser-sparc32 more sparc32 dependencies fallout
C33-mxser	another missed asm/segment.h, real fix for problem B40 marks
C34-uli526x	missing include in uli526x.c
C35-ipw2200	missing include (ipw2200)
C36-sunsu	sunsu compile fixes

Misc bug fixes:
F6-zatm		dereference of uninitialized pointer in zatm

Crap spotted by gcc and sparse:

O3-s2io-u64	s2io u64 use for uintptr_t
S0-chelsio	chelsio sparse annotations
S1-e1000	iomem annotations (e1000)
S2-s2io-iomem	iomem annotations (s2io)
S3-ipw2100	iomem annotations, NULL noise removal (ipw2100)
S4-scsi-ch	__user annotations (drivers/scsi/ch.c)
S5-ahci		iomem annotations (ahci)
S6-sata_nv	iomem annotations (sata_nv)
S7-sata_sx4	iomem annotations (sata_sx4)
S8-sata_qstor	enum safety (sata_qstor)
S9-aaci		iomem annotations (aaci)
S10-ethtool	__user annotations (ethtool)
S14-m32r-user	basic __user annotations (m32r)
S15-armv-iomem	basic iomem annotations (arm-versatile)
S16-m32r-iomem	missing basic iomem annotations (m32r)
S17-ia64-user	missing basic __user annotations (ia64)
S18-rpc-iomem	saner casts in arm-rpc IOMEM() 
S19-sparse-m32r	pass definition of __BIG_ENDIAN__ to sparse (m32r)

m68k patches:

C16-dmasound-lvalues	lvalues abuse in dmasound
C17-dmasound-extern	compile fixes for dmsound (static vs. extern)
C18-sun3ints	static vs. extern in sun3ints.h
C19-sun3_pgtable	bogus function argument types (sun3_pgtable.h)
C20-amigaints	static vs. extern in amigaints.h
C21-atyfb-typo	dumb typo in atyfb
C22-mac8390	lvalues abuse in mac8390
C23-lance	lvalues abuse in lance
C24-82596-apricot	wrong ifdefs in 82596
C25-scc		static vs. extern in scc
C26-m68k-reset	memory input should be an lvalue (mac/misc.c)
C27-m68k-mul	broken constraints on mulu.l
C28-isa_type	isa_{type,sex} should be exported (m68k)
B34-oktagon	oktagon makefile fix
B35-82596	Kconfig fix (82596)
B36-mac-fonts	Kconfig fix (mac vs. FONTS)
T0-task_thread_info	task_thread_info - part 1/5
T1-other-helpers	task_thread_info - part 2/5
T2-includes	task_thread_info - part 3/5
T3-m68k		task_thread_info - part 4/5
T4-m68k-flags	task_thread_info - part 5/5
m68k-adb.patch	ADBREQ_RAW missing declaration (from m68k CVS)
S11-m68k-iomem	basic iomem annotations (m68k)
S13-m68k-user	basic __user annotations (m68k)
C37-amigahw	gratitious namespace pollution in amigahw

UML patches:
jd1 -- jd9	Pending patches from jdike's 9-patch set
S12-uml-user	basic __user annotations (uml)
UM1-stubs	[UML] segv_stubs fixes
UM2-signal	[UML] copy_sc_..._user_tt() fixes
UM4-uml-checker	[UML] getting sparse to work for uml
