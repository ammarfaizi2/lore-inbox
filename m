Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVEHGKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVEHGKr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 02:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVEHGKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 02:10:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46557 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261397AbVEHGKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 02:10:40 -0400
Date: Sun, 8 May 2005 07:10:44 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Alexander Nyberg <alexn@telia.com>, Antoine Martin <antoine@nagafix.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050508061044.GB32143@parcelfarce.linux.theplanet.co.uk>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <1115481468.925.9.camel@localhost.localdomain> <20050507180356.GA10793@ccure.user-mode-linux.org> <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 01:18:32AM +0100, Al Viro wrote:
> 	a) stub.S handling breaks on O= builds.   Actually, your unprofile
> breaks there - it's bypassing the machinery that deals with include path.

Solved.

> 	p) TOP_ADDR in Kconfig_x86_64 got lost in transmission - your patchset
> has it, but same patch in Linus' tree does not.

	q) skas/mmu.c is calling pte_alloc_map() without ->page_table_lock.
Trivially fixed, needed if you want spinlock debugging to produce something
useful.
	r) when built static, kernel dies ugly death with
#0  0x00000000601e4178 in ptmalloc_init () at swab.h:134
#1  0x00000000601e4034 in malloc_hook_ini () at swab.h:134
#2  0x00000000601e1698 in malloc () at swab.h:134
#3  0x00000000602068ee in _dl_init_paths () at swab.h:134
#4  0x00000000601eba45 in _dl_non_dynamic_init () at swab.h:134
#5  0x00000000601ebc60 in __libc_init_first () at swab.h:134
#6  0x00000000601cfa4f in __libc_start_main () at swab.h:134
#7  0x000000006001202a in _start () at proc_fs.h:183
as stack trace.  Buggered offsets in uml.lds, perhaps?

Dynamically built it works; for i386 the same tree works both with both
static and dynamic.  It _might_ be libc difference, in theory (i386 libc
is 2.3.2.ds1-18, amd64 - 2.3.2.ds1-21, both from sarge), but I wouldn't
bet on it.  Anyway, I'm going down right now; carving the fixes into
sane patch series + experimenting with static/amd64 breakage will have
to wait until the morning...
