Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVARXPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVARXPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 18:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVARXPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 18:15:34 -0500
Received: from one.firstfloor.org ([213.235.205.2]:45513 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261473AbVARXPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 18:15:18 -0500
To: Keith Owens <kaos@sgi.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
References: <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
	<7152.1106080706@kao2.melbourne.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 19 Jan 2005 00:15:15 +0100
In-Reply-To: <7152.1106080706@kao2.melbourne.sgi.com> (Keith Owens's message
 of "Wed, 19 Jan 2005 07:38:26 +1100")
Message-ID: <m1acr649do.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> writes:

> Nobody has been concerned enough about the backtraces on i386 and
> x86_64 to add the required unwind data to the kernel for those
> platforms.  If you want to extract the dwarf data from a kernel
> compiled with -g, include the dwarf data in the running kernel and add
> a dwarf unwinder to the kernel then I will happily accept patches to
> kdb.  Don't forget about support for adding and removing unwind data as

It would be pretty easy to do.

The x86-64 ABI actually includes unwind data (without other dwarf
data) by default in all executables. However it wasn't needed in the
kernel so far so I turned it off to save some disk space:

If you want it without -g just remove the 

ifneq ($(CONFIG_DEBUG_INFO),y)
CFLAGS += -fno-asynchronous-unwind-tables
endif

in arch/x86_64/Makefile. Then to actually use it in the running kernel
you would need to change the unwind segment in the vmlinux.lds.S
to be loaded instead of discarded at link time (one liner change too)

And something to map it for modules (i haven't looked at that, but 
I suppose if ia64 has the infrastructure it shouldn't be hard to port)

I wouldn't be opposed to a new CONFIG_RUNTIME_UNWIND that does all
this. However without an working unwinder in kernel it's not very useful.

>
> BTW, even on IA64 which has unwind data, we still get problems because
> the unwind data only says what parameters are passed in registers, it
> says nothing about register reuse.  gcc can reuse a parameter register
> if the parameter value is no longer required, for example :-

This is no different from stack based parameters where the stack slot
of the parameter can be overwritten by the callee too.
You just will have to live with that.

-Andi
