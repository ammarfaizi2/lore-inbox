Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSFCULf>; Mon, 3 Jun 2002 16:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315476AbSFCULe>; Mon, 3 Jun 2002 16:11:34 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:7628 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S315463AbSFCULe>; Mon, 3 Jun 2002 16:11:34 -0400
Date: Mon, 3 Jun 2002 22:11:33 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Pavel Machek <pavel@suse.cz>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: do_mmap
In-Reply-To: <20020603121943.A37@toy.ucw.cz>
Message-ID: <Pine.GSO.4.05.10206032153260.7433-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel,

--snip/snip

> While you are at it... fs/binfmt_elf does mmaps but does not check for errors.
> And errors actually do happen there :-(

ok, had a second look.
it does check for errors, using BAD_ADDR which is: if (addr > TASK_SIZE)
and TASK_SIZE on the other hand is PAGE_OFFSET == 0xC0000000 (for x86)

hmm, which means even if we correctly map an area > PAGE_OFFSET, we will 
never free the area (well another question is, if we ever try to map
an area > PAGE_OFFSET) - but nevertheless, the check should be before
trying to mmap, and checking for IS_ERR after mmap.

nyone explain what to do if we cannot map the page for MMAP_PAGE_ZERO?
- we just ignore it for now ...

also another instance: if (addr != req_address) - which means if we have
	some alignment with mmap - load_elf_library just bails out.
	guess we need to munmap also (if no error occured during mmap)

do_brk() is _never_ checked for return (at least in binfm_elf) ... oh
well ...

any comments?

	tm

-- 
in some way i do, and in some way i don't.

