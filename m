Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSL0XT0>; Fri, 27 Dec 2002 18:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSL0XTZ>; Fri, 27 Dec 2002 18:19:25 -0500
Received: from p060.as-l031.contactel.cz ([212.65.234.252]:27008 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S261561AbSL0XTX>;
	Fri, 27 Dec 2002 18:19:23 -0500
Date: Sat, 28 Dec 2002 00:24:25 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: two 2.5 modules bugs
Message-ID: <20021227232425.GD1403@ppc.vc.cvut.cz>
References: <200212271616.RAA03356@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212271616.RAA03356@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2002 at 05:16:35PM +0100, Mikael Pettersson wrote:
> 1. With kernel 2.5.53 and module-init-tools-0.9.6, "modprobe tulip"
>    fails and goes into an infinite CPU-consuming loop. The problem
>    appears to be related to the dependency from tulip to crc32. If I
>    manually modprobe crc32 before modprobe tulip, it works. If crc32
>    isn't loaded, modprobe tulip first loads crc32 and then loops.
> 
>    module-init-tools-0.9.5 did not have this problem.

Load modprobe with MALLOC_CHECK_=1. It will reveal that it tries to
free() some non-mallocated area. 

Try patch below, insmod() can realloc/free its second argument, so
we can doublefree it, and glibc's malloc goes wild. It fixes problems
I had with modprobe ipx (which depends on psnap/p8022 which depends
on llc).
 
--- 0.9.6-1/modprobe.c.dist	2002-12-26 10:32:22.000000000 +0100
+++ 0.9.6-1/modprobe.c	2002-12-28 00:12:16.000000000 +0100
@@ -582,7 +582,7 @@
 		char *baseopts = NOFAIL(strdup(""));
 		insmod(list, baseopts, NULL, 0, dry_run, verbose, options,
 		       commands, 0);
-		free(baseopts);
+//		free(baseopts);
 	}
 
 	/* Did config file override command or add options? */

							Petr Vandrovec
							vandrove@vc.cvut.cz
