Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTLXJYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 04:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTLXJYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 04:24:32 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:54314 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S263486AbTLXJY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 04:24:29 -0500
Date: Wed, 24 Dec 2003 10:27:04 +0100
From: Bram Stolk <bram@sara.nl>
To: linux-kernel@vger.kernel.org
Subject: fix for tridentfb.c usage on CRTs.
Message-Id: <20031224102704.72c00a87.bram@sara.nl>
Organization: SARA
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


tridentfb.c is broken for non-FP (CRT) users, and it is not being maintained.
I believe that all kernels since 2.4.19 are affected, including 2.6.0

I mailed the maintainer in June 2003, and in October 2003, but
he does not respond.

What happens is this:
All modes that exceed the native resolution of a flatpanel
are discarded. However, a CRT has native resolution set to 0, and
therefore, tridentfb.c cannot be used with a CRT.

The patch to make it work:

$ diff -c tridentfb.c tridentfb.orig 
*** tridentfb.c Wed Dec 24 10:08:44 2003
--- tridentfb.orig      Wed Dec 24 09:55:39 2003
***************
*** 723,729 ****
        if (bpp == 24 )
                bpp = var->bits_per_pixel = 32;
        /* check whether resolution fits on panel and in memory*/
!       if (flatpanel && nativex && var->xres > nativex)
                return -EINVAL;
        if (var->xres * var->yres_virtual * bpp/8 > info->fix.smem_len)
                return -EINVAL;
--- 723,729 ----
        if (bpp == 24 )
                bpp = var->bits_per_pixel = 32;
        /* check whether resolution fits on panel and in memory*/
!       if (var->xres > nativex)
                return -EINVAL;
        if (var->xres * var->yres_virtual * bpp/8 > info->fix.smem_len)
                return -EINVAL;


Also, the Documents/fb/ docs are out of date, with regard
to option passing.

And the comment in tridentfb.c
 * Parse user specified options (`video=trident:')
...is wrong.
Only 'video=tridentfb:' will work.

modedb.txt should include the 'tridentfb' target for video=
tridentfb.txt should be updated on how to pass parameters.

And last:
video=tridentfb:mode=800x600 does not work, as mode= is
not recognized. I think it should. Currently, you are forced to
skip the mode=, thus: video=tridentfb:800x600


  Bram Stolk

PS: Maintainers I tried to contact to fix this:
jani at iv.ro,
geert at linux-m68k.org
salvestrini at users.sourceforge.net
janim at users.sourceforge.net
Only salvestrini responded that jani is probably busy.

-- 
"For the costs of subsidized agriculture in the EU, we can have all 56 million
 European cows fly around the world. First Class." - J. Norberg
