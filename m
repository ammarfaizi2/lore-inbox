Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265631AbSJSRMQ>; Sat, 19 Oct 2002 13:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265632AbSJSRMQ>; Sat, 19 Oct 2002 13:12:16 -0400
Received: from almesberger.net ([63.105.73.239]:6662 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265631AbSJSRMO>; Sat, 19 Oct 2002 13:12:14 -0400
Date: Sat, 19 Oct 2002 14:18:06 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] kexec syscall for 2.5.43 (linux booting linux)
Message-ID: <20021019141806.E7951@almesberger.net>
References: <m1k7kfzffk.fsf@frodo.biederman.org> <20021018173248.E14894@almesberger.net> <m1bs5rz1d6.fsf@frodo.biederman.org> <20021018231540.C7951@almesberger.net> <20021019025309.A24579@almesberger.net> <m17kgfyltc.fsf@frodo.biederman.org> <20021019040600.D7951@almesberger.net> <m13cr2zs99.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13cr2zs99.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Oct 19, 2002 at 03:34:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Cool.  What fails with X11.  Fixing it might be as simple as calling
> int 0x10 early in the new image.

The graphic engine (i810) simply doesn't switch back to text mode.
Yes, 0x10 helps. I've attached a little patch that does this in a
relatively safe way. (Alternative, one could also use set_80x25,
but I think always forcing mode 3 is slightly more reliable.
Except for MGA users, of course :-)

If you get a new boot loader type code from Peter Anvin, this
should even be good enough for inclusion into the mainstream
kernel. Alternatively, we could also pick a new loader flag to
indicate that the firmware didn't initialize the system.

> [vmlinux] specifies incorrect physical
> addresses, and it expects to be passed a whole host of strange values,
> in weird places.

I see. Perhaps you could say then that mkelfImage fixes flaws in
the vmlinux ELF image meta-data, or such:

| A kernel reformater is makes images that seem to boot more reliably is at:
| ftp://ftp.lnxi.com/pub/mkelfImage/mkelfImage-1.17.tar.gz

This sounds more like "if I kick it here, it usually works,
but I have no idea why" :-)

And yes, if it's not too intrusive, fixing the ELF meta-data
along with the addition of kexec might be a good idea.

- Werner

---------------------------------- cut here -----------------------------------

--- linux-2.5.44/arch/i386/boot/video.S.orig	Sat Oct 19 12:55:14 2002
+++ linux-2.5.44/arch/i386/boot/video.S	Sat Oct 19 13:51:19 2002
@@ -148,6 +148,13 @@
 	cmpb	$0x10, %bl			# No, it's a CGA/MDA/HGA card.
 	je	basret
 
+	cmpb	$0xff,type_of_loader		# are we using kexec ?
+	jne	novgareset
+
+	movw	$0x3, %ax			# reset EGA/VGA to 80x25 text
+	int	$0x10
+
+novgareset:
 	incb	adapter
 	movw	$0x1a00, %ax			# Check EGA or VGA?
 	int	$0x10

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
