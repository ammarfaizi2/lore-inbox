Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268661AbTBZG17>; Wed, 26 Feb 2003 01:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268662AbTBZG17>; Wed, 26 Feb 2003 01:27:59 -0500
Received: from holomorphy.com ([66.224.33.161]:55737 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268661AbTBZG15>;
	Wed, 26 Feb 2003 01:27:57 -0500
Date: Tue, 25 Feb 2003 22:37:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.63-1
Message-ID: <20030226063716.GJ10396@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*****      if you don't hack the kernel, stop reading now      *****

pgcl is a forward port and/or 2.5.x (re)implementation of page
clustering, originally implemented by Hugh Dickins for 2.4.7.
Don't blame Hugh -- all the bugs are mine and his code worked.

This patch is currently in a WIP phase of programming with various
relatively severe bugs getting worked out, though I've yet to encounter
non-fsck-recoverable filesystem corruption with remotely current sources.
Don't bother trying if you aren't prepared to debug.

The patch is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/

The patches are incremental and "unpackaged". You will have to fetch
the incremental pgcl-2.5.62-1A, pgcl-2.5.62-1B, etc. diffs to apply
on top of pgcl-2.5.62-1 etc. Well, pgcl-2.5.63-1 is current, but you
get the idea.

If you change PAGE_SIZE back to MMUPAGE_SIZE, you shouldn't be able
to observe any difference in behavior. If you do, send me either a
patch or a comprehensible(!) bug report. This is _not_ for naive users.

Known issues:
(0) This code is currently x86-32 only. Dropping something to say
	PAGE_SIZE == MMUPAGE_SIZE into other arches's code is trivial
	but largely meaningless.
(1) aio is 100% untested, and probably broken.
(2) Unusual corner cases appear to show binary compatibility breakage.
	This varies by distro; by and large /bin/sh should run, and
	most of the apps needed for initscripts run. Worse comes to
	worse init=/bin/sash or some other static executable should run,
	though if there's a bug in initial user stack setup that could
	defeat even static executables used for init=...
(3) SCSI ioctl's are probably broken, but 100% untested.
(4) Various drivers attempt to vmalloc() and/or ioremap() excessively
	large regions now that PAGE_SIZE has changed. They may fail
	during registration, but nothing interesting at runtime.
(5) Some machines stopped booting probably because of either arch code
	missed during the audits or flat out bugs.
(6) I saw some spontaneous reboots ca. 2.5.59 on a stinkpad. The
	source of the stuff was never tracked down, and no recent boots.
(7) L3 pagetables aren't fixed up to prevent internal fragmentation.
	This means PAGE_SIZE will get allocated for every 4KB of
	L3 pagetables required for a given workload.
(8) Anonymous pagefault handling hasn't been fixed up to prevent
	internal fragmentation. This means that most of the time,
	PAGE_SIZE will get allocated for every 4KB of anonymous
	memory faulted in. Easily fixable, but not merged due to
	the fact it provokes bugs more easily with some of the
	get_user_pages() users.
(9) Various pagetable indexing algorithms were "sort of needlessly"
	swizzled around to deal with non-contiguous pagetables set
	up by page_table_init() and friends. The arch code should
	be eventually fixed up to make the rest of the world happy
	and the changes to core/whatever code made for it reverted.


-- wli
