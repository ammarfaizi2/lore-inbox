Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278302AbRJWVTK>; Tue, 23 Oct 2001 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278305AbRJWVTB>; Tue, 23 Oct 2001 17:19:01 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:21611 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S278302AbRJWVSy>; Tue, 23 Oct 2001 17:18:54 -0400
Message-ID: <71714C04806CD5119352009027289217022C3E11@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, kaos@ocs.com.au
Subject: RE: crc32 cleanups
Date: Tue, 23 Oct 2001 16:19:21 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another try...

Changes since last time:
* Do away with modules calling init/cleanup_crc32().  This now happens using
module_init().  This avoids refcounting (though I finally got it right with
assistance) and unnecessary pain associated with knowing exactly when in
each module to call init/cleanup_crc32, how many times, etc.

* Each driver that uses crc32 functions now calls request_module("crc32") in
their init or probe function.  This way if crc32.o is a module it gets
loaded and initialized prior to use.  If it's static, no harm.

I'm concerned by Keith's comment:
> __initcall entries are executed in the order that they are linked
> into the kernel.  The linkage order is controlled by the order that
> Makefiles are processed during kbuild and by line order within each
> Makefile.  There is definitely a priority order for __initcall code.

Top-level Makefile has:
SUBDIRS = kernel drivers mm fs net ipc lib

And indeed, drivers and fs get built before lib.  Therefore, drivers that
use any of the crc32 functions as part of their probe or module_init will be
broken.  So, I've moved lib before drivers, both there and in the link
(where it really matters).  Now library __init functions are called after
the file system drivers (which I think is OK, as no file systems, even
initrds, are used before the crc32 functions), and before static drivers are
loaded, which is critical.  Any objections?

Patches at:
http://domsch.com/linux/patches/linux-2.4.13-pre6-crc32-lib-20011023.patch
http://domsch.com/linux/patches/linux-2.4.13-pre6-crc32-drivers-20011023.pat
ch
http://domsch.com/linux/patches/linux-2.4.13-pre6-gpt-20011023.patch
http://domsch.com/linux/patches/linux-2.4.13-pre6-efivars-20011023.patch


Feedback welcome.  I'm hoping to wrap this up soon... :-)

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
