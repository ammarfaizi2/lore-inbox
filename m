Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSG3MzA>; Tue, 30 Jul 2002 08:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSG3MzA>; Tue, 30 Jul 2002 08:55:00 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:60932 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S318252AbSG3My7>; Tue, 30 Jul 2002 08:54:59 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200207301257.OAA02813@green.mif.pg.gda.pl>
Subject: Re: Patch for xconfig
To: zaitcev@redhat.com
Date: Tue, 30 Jul 2002 14:57:30 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list), gnb@alphalink.com.au,
       mec@shout.net
In-Reply-To: <200207301001.g6UA1hN14567@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Jul 30, 2002 12:02:31 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BTW, what I sent was a low hanged fruit that I picked.
> The main bug is worse, and I have no idea how to fix it.
> This is what we have in configuration:
> 
> tristate 'ISO ...' CONFIG_ISO9660_FS
> dep_bool ' Tranparent ...' CONFIG_ZISOFS $CONFIG_ISO9660_FS
> if [ "$CONFIG_ZISOFS" = "y" ]; then
>    define_tristate CONFIG_ZISOFS_FS $CONFIG_ISO9660_FS
> else
>    define_tristate CONFIG_ZISOFS_FS n
> fi
> 
> if [ "$CONFIG_CRAMFS" = "y" -o \
>      "$CONFIG_PPP_DEFLATE" = "y" -o \
>      "$CONFIG_JFFS2_FS" = "y" -o \
>      "$CONFIG_ZISOFS_FS" = "y" ]; then
>    define_tristate CONFIG_ZLIB_INFLATE y
> else
>   if [ "$CONFIG_CRAMFS" = "m" -o \
>        "$CONFIG_PPP_DEFLATE" = "m" -o \
>        "$CONFIG_JFFS2_FS" = "m" -o \
>        "$CONFIG_ZISOFS_FS" = "m" ]; then
>      define_tristate CONFIG_ZLIB_INFLATE m
>   else
>      tristate 'zlib decompression support' CONFIG_ZLIB_INFLATE
>   fi
> fi

IMO, the simpliest fix is to make change like replacing:
      tristate 'zlib decompression support' CONFIG_ZLIB_INFLATE
with:
      tristate 'zlib decompression support' CONFIG_ZLIB_INFLATE_X
      define_tristate CONFIG_ZLIB_INFLATE $CONFIG_ZLIB_INFLATE_X
+ rename the option in a help file (if it exist)

(not tested, but should work)

> As far as I can tell, tkgen.c does an acceptable job on the
> second part; though it refuses to generate "else" and uses
> de Morgan transformation instead. However, it seems that tkparse
> chokes on the very innocently looking first part. The result
> is that xconfig insist on zlib to be a module when it should
> be compiled into the kernel; it all ends with undefined symbols.
> Naturally, "make oldconfig" works correctly.

No. The problem is that variales associated with eg. "tristate" clauses
are always modified (even if its condition is false) during configuration 
refreshment - to store the previous value for the option.
Not good, but it is just bad project. Nobody wanted to rewrite xconfig
as CML2 was assumed to come soon...

> The code in the menu part of kconfig.tk fixes the problem.
> In other words, the bug is only visible if someone does "make xconfig",
> loads a canned configuration which we ship, then does "save
> and exit" immediately. If he visits any menus, everything is ok.

I'm not sure it is so simple...

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
