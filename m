Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276641AbRJPTFi>; Tue, 16 Oct 2001 15:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276640AbRJPTF2>; Tue, 16 Oct 2001 15:05:28 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:23049 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S276641AbRJPTFR>; Tue, 16 Oct 2001 15:05:17 -0400
Message-ID: <71714C04806CD51193520090272892178BD725@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: crc32 cleanups
Date: Tue, 16 Oct 2001 14:05:29 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since last time:
* A lot more drivers were updated.  These had in-lined the CRC32 code
(either BE or LE).  I think I got them all except natsemi, which I was
afraid I'd screw up.
* Incorporated the new crc32 library routines.  Both BE and LE now use a
table.  LE is faster, BE uses less space.  It's trivial to make this
tradeoff now.

> * Still need init_crc32:
>   8139too, au1000_eth, fealnx, smc91c92_cs, xircom_tulip_cb, smc9194,
>   via-rhine, winbond-840

Now that the BE functions use a table, yes.

> * lib/uuid.o needs to be in lib/Makefile's export-objs

Oops, good catch.  I meant to submit uuid as a separate patch, but I'll
include it in the crc32-lib + efivars patches (it's small).

> * in init/cleanup_crc32, don't hold spinlock during kmalloc/kfree.
>   Check out other refcounting schemes in the various fs/*.c files.

OK, hope this is better.

> * Add a Config.in entry, so that people can manually select to compile
>   crc32.o as a module.  This takes care of the 3rd party module case,
>   the module that might for example have been built some time
>   after the kernel itself was built.

OK.  Turns out this then needs to change arch/$arch/config.in to add
lib/Config.in to the menus too. :-(

Here's today's pass at all this.
http://domsch.com/linux/patches/linux-2.4.13-pre3-crc32-lib-20011016.patch
http://domsch.com/linux/patches/linux-2.4.13-pre3-crc32-drivers-20011016.pat
ch
http://domsch.com/linux/patches/linux-2.4.13-pre3-gpt-20011016.patch
http://domsch.com/linux/patches/linux-2.4.13-pre3-efivars-20011016.patch


This is working on my x86 system with CONFIG_EFI_PARTITION enabled, so I
feel pretty good about at least the LE crc32 function.  All the drivers that
could be built on x86 were, but I don't have hardware to test any of them,
nor any non-x86 platforms.

I'm not sure I got the init/cleanup right in all the modules.  I tried to
call init_crc32() once only if/when we know the driver's init routine
actually found one or more cards.  For the hassle of getting this right, I'm
tempted to make crc32.c have module_init/cleanup() that allocates the memory
unconditionally...  It's only 2*1KB at most.

Feedback appreciated.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!

