Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTKUWpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 17:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTKUWpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 17:45:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:7593 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261522AbTKUWpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 17:45:39 -0500
Date: Fri, 21 Nov 2003 14:45:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io
 priorities (fwd)]
In-Reply-To: <20031121153900.GA193@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0311211439120.13789-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Nov 2003, Pavel Machek wrote:
> 
> Well, did that, run it on vanilla kernel, and it kills the
> machine. Can someone reproduce it?

Ok, looks like a binutils bug to me.

"nr_syscalls" is mis-assembled at least on x86. The code says

	nr_syscalls=(.-sys_call_table)/4

but if you actually look at the disassembly of entry.S, you'll notice that 
the constant used in the object file is the one without the division.

Just do "gdb vmlinux" and do "disassemble system_call" to see this. It 
says something like

	cmp    $0x448,%eax
	jae    syscall_badsys

and it _should_ use just 274 (0x112 rather than 0x448) on x86.

Now, I wonder if this has ever worked, of which binutils version broke 
it..

		Linus

