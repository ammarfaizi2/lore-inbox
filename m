Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWEODiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWEODiw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 23:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWEODiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 23:38:52 -0400
Received: from [198.99.130.12] ([198.99.130.12]:65451 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751387AbWEODiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 23:38:52 -0400
Date: Sun, 14 May 2006 23:39:19 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Alberto Bertogli <albertito@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060515033919.GD21383@ccure.user-mode-linux.org>
References: <20060514182541.GA4980@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514182541.GA4980@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 03:25:41PM -0300, Alberto Bertogli wrote:
> So I copied them from sysdeps/x86_64/jmpbuf-offsets.h, and building went
> on. Probably, the same happens under i386.

The current patch for this is http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf

I need to redo it, but that works for now.

> Then, it built fine, but at the end several errors showed up:
>   MODPOST
> WARNING: vmlinux - Section mismatch: reference to .init.text:do_mount_root from .bss between '__guard@@GLIBC_2.3.2' (at offset 0x603c5688) and 'stdout@@GLIBC_2.2.5'

I have no idea what these mean, but they seem not to affect the
viability of the resulting kernel.

> It begins to boot, but panics right after mounting root:
> 
> [42949373.800000] kjournald starting.  Commit interval 5 seconds
> [42949373.800000] EXT3-fs: mounted filesystem with ordered data mode.
> [42949373.800000] VFS: Mounted root (ext3 filesystem) readonly.
> [42949373.800000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943

This is a segfault happening when it shouldn't.

Can you disassemble stub_segv_handler and send me the output?  If
you're unfamiliar with gdb, it works like this:

	% gdb linux
	GNU gdb Red Hat Linux (6.3.0.0-1.122rh)
	Copyright 2004 Free Software Foundation, Inc.
	GDB is free software, covered by the GNU General Public License, and you are
	welcome to change it and/or distribute copies of it under certain conditions.
	Type "show copying" to see the conditions.
	`There is absolutely no warranty for GDB.  Type "show warranty" for details.
	This GDB was configured as "x86_64-redhat-linux-gnu"...Using host libthread_db library "/lib64/libthread_db.so.1".
	
	(gdb) disas stub_segv_handler
	Dump of assembler code for function stub_segv_handler:
	0x00000000601610c8 <stub_segv_handler+0>:       push   %rbp
	0x00000000601610c9 <stub_segv_handler+1>:       mov    %rsp,%rbp
	0x00000000601610cc <stub_segv_handler+4>:       mov    %rdx,%r8
	...

There was a bug like this a month or so ago, but it has been in
mainline for a while, so this should be something different.

				Jeff
