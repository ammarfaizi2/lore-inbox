Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVARUkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVARUkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 15:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVARUkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 15:40:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9357 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261320AbVARUkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 15:40:13 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0 
In-reply-to: Your message of "Mon, 17 Jan 2005 09:30:17 -0000."
             <Pine.LNX.4.61.0501170909040.4593@ezer.homenet> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Jan 2005 07:38:26 +1100
Message-ID: <7152.1106080706@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005 09:30:17 +0000 (GMT), 
Tigran Aivazian <tigran@veritas.com> wrote:
>Hmmm, interesting, then -g compiled Linux kernel should also be useable, 
>with perhaps some tweaks to kdb to decode these frames correctly, right?

kdb on i386 uses heuristics to guess at what parameters have been
passed on stack.  When the parameters are passed by register, there is
not enough information in the code to work out which parameters have
been passed nor what gcc has done with them once the function has been
entered.

Why use heuristics and guess?  Because when kdb was started we were
still using a.out and stabs.  In those days there was no way for code
in the running kernel to access the kernel's debugging information to
track the parameter and register usage.

Since then the world has moved on.  The IA64 ABI mandates that the
information required to do backtrace is stored in the running kernel,
and kdb uses that unwind data, including tracking parameters passed in
registers.

Nobody has been concerned enough about the backtraces on i386 and
x86_64 to add the required unwind data to the kernel for those
platforms.  If you want to extract the dwarf data from a kernel
compiled with -g, include the dwarf data in the running kernel and add
a dwarf unwinder to the kernel then I will happily accept patches to
kdb.  Don't forget about support for adding and removing unwind data as
modules are loaded and unloaded.

To hpa: kdb is designed to run completely in kernel.  It is not (repeat
not) intended to be a remote client debugger.

BTW, even on IA64 which has unwind data, we still get problems because
the unwind data only says what parameters are passed in registers, it
says nothing about register reuse.  gcc can reuse a parameter register
if the parameter value is no longer required, for example :-

  void function foo(struct bar *b)
  {
    // On entry, ia64 r32 contains *b
    int i = b->i;
    // If b is not used after this point, gcc can reuse r32 for the value of i.
    // Debugging after this point will show a misleading value in r32 for b.
    ...
  }

