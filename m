Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267775AbTAXQnn>; Fri, 24 Jan 2003 11:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267774AbTAXQnm>; Fri, 24 Jan 2003 11:43:42 -0500
Received: from web80311.mail.yahoo.com ([66.218.79.27]:43564 "HELO
	web80311.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267775AbTAXQnj>; Fri, 24 Jan 2003 11:43:39 -0500
Message-ID: <20030124165246.59003.qmail@web80311.mail.yahoo.com>
Date: Fri, 24 Jan 2003 08:52:46 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030124154647.GA20371@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Pavel Machek <pavel@ucw.cz> wrote:

> Can you explain a bit more about plex86? I thought plex86 aims to be
> complete machine emulation, capable of running winNT (for example). I
> don't think M$ will accept such a patch from you...

I gutted the old plex86 code, eliminated all the fancy stuff
and it now does nothing except provide a VM container to
run user-privilege code only.  X86 is reasonably VM'able
at user priviliege, but not so at kernel privilege.

Plex86 is a kernel module which runs on the host OS.  It
provides a separate set of page tables, segment registers
and other stuff so that there is no interference with the
host structures, nor dependence on them whatsover.

The thrust behind these simple mods is to be able to "push"
Linux kernel code (when running as a guest OS) down to user
level.  In this case, it can also be run in what is now
an extremely light-weight VM.  To do this, proper maintenance
of the interrupt flag (x86) is necessary, since behaviour of
this flag in the eflags register is different at user-level.
The x86 architecture provides a mechanism for this, called PVI
(protected mode virtual interrupts), although the logic for
this was not carried over to 2 instructions (PUSHF/POPF).
Thus my patches...

Other than that, plex86 "shadows" the guest page tables and
discovers the guest page tables on-demand.  So nothing special
needs to be done.  Access to system registers trap from user code,
so the VM monitor can handle those properly.

About 99% of the work of a full x86 VM is on handling less
than 1% of the cases.  So the new plex86 angle is, forget doing
all the fancy work for 1%.  If you're running a VM friendly OS
(like Linux with my small patches), you end up with a potentially high
performance and Open Source VM, with very little work.

As well, plex86 can bolt on to bochs for accelerating user code,
reverting back to bochs for emulation of kernel code - perhaps
good for running non-Linux, and for debugging Linux kernels.

But for the normal case of running Linux VMs, plex86 will be a standalone.
Because the non-essential IO stuff can be configured out of Linux,
and the remaining essential IO can be monitored very lightweight style
in plex86 - even right in the VM monitor for high performance.

-Kevin

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
