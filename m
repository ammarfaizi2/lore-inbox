Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288788AbSBDIuG>; Mon, 4 Feb 2002 03:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSBDItp>; Mon, 4 Feb 2002 03:49:45 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:36626 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288788AbSBDItW>; Mon, 4 Feb 2002 03:49:22 -0500
Message-Id: <200202040847.g148lVt09789@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 include file shakeup.
Date: Mon, 4 Feb 2002 10:47:32 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020202002532.A7782@suse.de>
In-Reply-To: <20020202002532.A7782@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 February 2002 22:25, Dave Jones wrote:
> sensible.  We also gain a little speed increase on the compile..
>
> make dep bzImage on a 866MHz Cyrix3 with a fast disk..
>                 real       user      sys
> 2.5.3           12m37.110s 11m8.580s 0m47.590s
> 2.5.3+cleanup   12m8.053s  11m0.670s 0m47.450s
>
> make dep on a quad ppro with a _slow_ disk.
>                 real       user       sys
> 2.5.3           2m50.229s  1m51.370s  0m12.640s
> 2.5.3+cleanup   1m44.634s  1m32.580s  0m10.200s
>
> make -j4 bzImage on the same quad
> 2.5.3           9m11.167s  31m8.060s  2m20.950s
> 2.5.3+cleanup   9m8.546s   30m33.020s 2m18.710s
>
> Further compile time decreases should be possible by looking a little
> harder at various places that are including sched.h, and also when we
> get to the aforementioned fs.h cleanup.  Currently some of the compile
> fixes introduced in this patch are taking the easy way out, and including
> fs.h, but this is after all, the first phase of this cleanup.

Given amount of (trivially fixable) breakage we _regularly_ see in the form 
of missing #includes, I want to find a way to stop it once and for all time.

What about generating one rather big include file out of .config first, and 
including it in each .c file? Aha, device drivers... Ok, what about this:

foo.c (core kernel source)
=====
/* All kernel infrastructure structs, funcs, global vars, macros... */
include <kernel_common.h>
...

ide_viaxxx.c (device driver)
============
/* All kernel infrastructure structs, funcs, global vars, macros... */
include <kernel_common.h>
/* Device specific bits not belonging to kernel infrastructure */
include <driver_ide.h>
...

This can slow down compilation on a box with fast disk and slow CPU, but can 
_speed up_ comilation if disk is slow and CPU is fast.
Why? Parsing .h file contents (declarations, almost no code) is much faster 
than .c, feeding unneeded declarations is cheaper that it seems to be.

Note that in future CPU/disk speed gap will only increase.

Surely I can miss a reason why this won't work at all (messed up 
dependencies?), feel free to enlighten me.
--
vda
