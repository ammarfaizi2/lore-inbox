Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312265AbSCRJPv>; Mon, 18 Mar 2002 04:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312262AbSCRJPl>; Mon, 18 Mar 2002 04:15:41 -0500
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:3052 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S312268AbSCRJPa>; Mon, 18 Mar 2002 04:15:30 -0500
Date: Mon, 18 Mar 2002 10:18:06 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Andreas Dilger <adilger@clusterfs.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
In-Reply-To: <20020317020145.A20307@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.33.0203180938060.9609-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Jamie Lokier wrote:

> As long as __SLOW_DOWN_IO_PORT is a simple constant, you can just use
> this instead:
>
>     #define __SLOW_DOWN_IO_ASM	"\noutb %%al,$" #__SLOW_DOWN_IO_PORT

What cpp are you guys using? Mine does stringification (#s) only with
arguments of function-like macros. However

#define __SLOW_DOWN_IO_P(p) "\noutb %%al,%" #p
#define __SLOW_DOWN_IO __SLOW_DOWN_IO(__SLOW_DOWN_IO_PORT)

won't work, either, because cpp does not recursively substitute macros
for stringification, so in the above _SLOW_DOWN_IO wuold evaluate as
"\noutb %%al,$__SLOW_DOWN_IO_PORT" - bad.

I have tried a number of things to make this a single cpp line, but they
all don't work. The only way would be to change the way the inb_p ...
macros are coded.

It is possible to write
#define __SLOW_DOWN_IO __asm__ ("outb %%al, %0" : : "i" (__SLOW_DOWN_IO_PORT));

but only if one modifies the definitions of inb_p etc which are so complex
that I don't dare touch them now.

Please note that, as an intermediate solution, my patch reduces explicit
usage of the constant 0x80 from ~20 in 8 different source files to 2
immediately following each other in 1 source file.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





