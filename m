Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVB1UgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVB1UgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVB1UgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:36:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:29201 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261726AbVB1Ufm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:35:42 -0500
Date: Mon, 28 Feb 2005 21:35:36 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Donald Duckie <schipperke2000@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ethertap.c compilation problem
Message-ID: <20050228203536.GG1850@alpha.home.local>
References: <20050228110439.86144.qmail@web53605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228110439.86144.qmail@web53605.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 28, 2005 at 03:04:39AM -0800, Donald Duckie wrote:
(...)
> In file included from /usr/include/asm/atomic.h:17,
>                  from /usr/include/linux/module.h:25,
>                  from auto_irq.c:33:
> /usr/include/asm/system.h: In function `tas':
> /usr/include/asm/system.h:81: unknown register name
> `t' in `asm'
> In file included from /usr/include/linux/sched.h:14,
>                  from auto_irq.c:34:
> /usr/include/linux/timex.h: At top level:
> /usr/include/linux/timex.h:173: field `time' has
> incomplete type
> In file included from /usr/include/linux/sched.h:82,
>                  from auto_irq.c:34:
> /usr/include/linux/timer.h:17: field `list' has
> incomplete type
> auto_irq.c: In function `autoirq_report':
> auto_irq.c:51: `jiffies' undeclared (first use in this
> function)
> auto_irq.c:51: (Each undeclared identifier is reported
> only once
> auto_irq.c:51: for each function it appears in.)

Missing or bad includes. Is your 'include/asm' link pointing
to the valid arch ? Have you got any reports that this arch
compiles without any tweaking ?

> auto_irq.c: At top level:
> auto_irq.c:56: syntax error before
> "this_object_must_be_defined_as_export_objs_in_the_Makefile"

it means that you must append the name of the resulting ".o" file to
the "export_objs" list in the makefile located in the same directory.

(...)

 
> basing on this compile log, i am expecting that: 
> (for example)
> /usr/include/asm/system.h
> to be
> /usr/src/linux-sh-2.4.18/include/asm/system.h

This should not be true. /usr/include/asm should reflect the includes for
YOUR architecture, not the one your are currently cross-compiling for. But
at most it may prevent you from compiling user-space progs (eg: lxdialog),
but should not cause any trouble to other parts of the kernel.

> I know that there is no need to touch the Makefiles,
> Rules.make for this, but I also tried replacing all
> $(TOPDIR) to /usr/src/linux-sh-2.4.18.
> The result was still the same.

No need to play with this. Oh, and BTW, are you sure that your GCC version
is compatible with 2.4.18 ? You should use 2.95 or even 2.91 for this, but
I don't think that any 3.X will work.

> I already ran make dep, make clean, and still got the
> same result.

Out of curiosity, have you done 'make oldconfig' ?
And also, have you set ARCH=sh4 ?

> And also to my surprise, 
> /usr/src/linux -> linux-sh-2.4.18

you don't need /usr/src/linux at all, and I even suggest that you remove
this link which seems to confuse you.

> /usr/src/linux-sh-2.4.18
> doing a : 
> cd linux
> would result to:
> /usr/src/linux   instead of   /usr/src/linux-sh-2.4.18
> has anyone experienced this?

This is a configurable 'cd' behaviour. Use 'cd -P' to follow the Physical
path. Man bash for more info.

> if so, can this be explained as to why this is the
> result?

absolutely not related.

> hoping for some insights on how to proceed with my
> compilation problem.

Well, at least clean up the few points above to leverage confusion, ensure
that your GCC is able to compile this tree and that you have set every
variable correctly, and if it still does not work, follow the includes and
try to find what breaks by hand.

You should be compiling this way :

$ cd /usr/src/linux-sh-2.4.18
$ cp .config ../.config.saved
$ make ARCH=sh4 distclean
$ mv ../.config.saved .config
$ make ARCH=sh4 CROSS_COMPILE=sh4-linux- oldconfig
$ make ARCH=sh4 CROSS_COMPILE=sh4-linux- dep
$ make ARCH=sh4 CROSS_COMPILE=sh4-linux- vmlinux modules

If you think you have no reason to encounter such problems, try to get in
touch with the arch maintainer.

Regards,
Willy

