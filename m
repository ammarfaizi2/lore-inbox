Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUKABmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUKABmD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 20:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUKABls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 20:41:48 -0500
Received: from cantor.suse.de ([195.135.220.2]:31104 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261723AbUKABlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 20:41:20 -0500
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, pluto@pld-linux.org
Subject: Re: unit-at-a-time...
References: <200410311541.i9VFf0ah023857@harpo.it.uu.se.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Nov 2004 02:39:41 +0100
In-Reply-To: <200410311541.i9VFf0ah023857@harpo.it.uu.se.suse.lists.linux.kernel>
Message-ID: <p73hdoaibz6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> On Sun, 31 Oct 2004 15:57:00 +0100, pluto@pld-linux.org wrote:
> >/i386/Makefile:# Disable unit-at-a-time mode, it makes gcc use a lot morestack
> >/i386/Makefile:CFLAGS += $(call cc-option,-fno-unit-at-a-time)
> >
> >/x86_64/Makefile:# -funit-at-a-time shrinks the kernel .text considerably
> >/x86_64/Makefile:CFLAGS += $(call cc-option,-funit-at-a-time)
> >
> >Which solution is correct?

It shrinks the .text on i386 considerably too. One reason
is that it automatically enables regparms for static functions.
With global CONFIG_REGPARM the shrink is a bit less, but still
noticeable.

One drawback is that oopses are harder to read because
of the more aggressive inlining, but it's not too bad.

> 
> Disabling unit-at-a-time for i386 is definitely correct.
> I've personally observed horrible runtime corruption bugs
> in early 2.6 kernels when they were compiled with gcc-3.4
> without the -fno-unit-at-a-time fix.

Maybe you got a buggy gcc version. The 2.6.5 based SLES9/i386
kernel is shipping with -funit-at-a-time compiled with a 3.3-hammer
compiler and I am not aware of any reports of stack overflow
(and that kernel is extremly well tested) 

IMHO it should be enabled on i386 in mainline, and if some gcc version
is determined to break it then it should be only explicitely 
disabled for that version. With the commonly used 3.3-hammer
compiler it seems to work fine.

> 
> x86-64 is a different architecture. It's possible its larger
> number of registers reduces spills enough that gcc's failure
> to merge stack slots doesn't matter.

The only reports of stack overflows on x86-64 were clear programmer
bugs (too large arrays/structures on the stack).

-Andi
