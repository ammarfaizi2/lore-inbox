Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUCRHQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 02:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbUCRHQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 02:16:51 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:52353 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262442AbUCRHQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 02:16:42 -0500
Date: Thu, 18 Mar 2004 08:17:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <1@pervalidus.net>
Cc: Peter Williams <peterw@aurema.com>, linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong thing
Message-ID: <20040318071754.GA499@ucw.cz>
References: <40593015.9090507@aurema.com> <Pine.LNX.4.58.0403180346000.1276@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0403180346000.1276@pervalidus.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 03:56:35AM -0300, Frédéric L. W. Meunier wrote:

> Wrongly ? I don't think so, as it has presumably been fixed in
> XFree86 after 4.4.0.
> 
> http://www.xfree86.org/cvs/changes.html:
> 
> 6. Do the Linux KDKBDREP ioctl on the correct fd.  This
> prevents the fallback that tries to directly program the
> keyboard repeat rate, and the related warning messages that
> recent Linux kernels generate (David Dawes).
> 
> I'm attaching the patch I extracted from CVS.
> 
> Vojtech, what about adding such information to your HOWTO ? And
> better, adding the URL to atkbd.c, so people stop reporting it.

I'll add the info and the URL into the HOWTO and kill the message.

> On Thu, 18 Mar 2004, Peter Williams wrote:
> 
> > With 2.6.4 I'm getting the following messages very early in the boot
> > long before XFree86 is started:
> >
> > Mar 18 16:05:31 mudlark kernel: atkbd.c: Unknown key released
> > (translated set 2, code 0x7a on isa0060/serio0).
> > Mar 18 16:05:31 mudlark kernel: atkbd.c: This is an XFree86 bug. It
> > shouldn't access hardware directly.
> >
> > They are repeated 6 times and are NOT the result of any keys being
> > pressed or released.
> 
> -- 
> http://www.pervalidus.net/contact.html
> Index: xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c
> diff -u xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c:3.26 xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c:3.27
> --- xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c:3.26	Mon Nov 17 22:20:41 2003
> +++ xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c	Wed Mar  3 18:53:41 2004
> @@ -1,4 +1,4 @@
> -/* $XFree86: xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c,v 3.26 2003/11/17 22:20:41 dawes Exp $ */
> +/* $XFree86: xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c,v 3.27 2004/03/03 18:53:41 dawes Exp $ */
>  /*
>   * Copyright 1992 by Orest Zborowski <obz@Kodak.com>
>   * Copyright 1993 by David Dawes <dawes@xfree86.org>
> @@ -81,7 +81,7 @@
>  #endif
>  
>  static int
> -KDKBDREP_ioctl_ok(int rate, int delay) {
> +KDKBDREP_ioctl_ok(int fd, int rate, int delay) {
>  #if defined(KDKBDREP) && !defined(__sparc__)
>       /* This ioctl is defined in <linux/kd.h> but is not
>  	implemented anywhere - must be in some m68k patches. */
> @@ -90,7 +90,7 @@
>     /* don't change, just test */
>     kbdrep_s.rate = -1;
>     kbdrep_s.delay = -1;
> -   if (ioctl( 0, KDKBDREP, &kbdrep_s )) {
> +   if (ioctl( fd, KDKBDREP, &kbdrep_s )) {
>         return 0;
>     }
>  
> @@ -105,7 +105,7 @@
>     if (kbdrep_s.delay < 1)
>       kbdrep_s.delay = 1;
>     
> -   if (ioctl( 0, KDKBDREP, &kbdrep_s )) {
> +   if (ioctl( fd, KDKBDREP, &kbdrep_s )) {
>       return 0;
>     }
>  
> @@ -174,7 +174,7 @@
>      delay = xf86Info.kbdDelay;
>  
>  
> -  if(KDKBDREP_ioctl_ok(rate, delay)) 	/* m68k? */
> +  if(KDKBDREP_ioctl_ok(xf86Info.consoleFd, rate, delay)) 	/* m68k? */
>      return;
>  
>    if(KIOCSRATE_ioctl_ok(rate, delay))	/* sparc? */
> Index: xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_kbd.c
> diff -u xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_kbd.c:1.5 xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_kbd.c:1.6
> --- xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_kbd.c:1.5	Tue Nov  4 03:14:39 2003
> +++ xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_kbd.c	Wed Mar  3 18:53:41 2004
> @@ -1,4 +1,4 @@
> -/* $XFree86: xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_kbd.c,v 1.5 2003/11/04 03:14:39 tsi Exp $ */
> +/* $XFree86: xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_kbd.c,v 1.6 2004/03/03 18:53:41 dawes Exp $ */
>  
>  /*
>   * Copyright (c) 2002 by The XFree86 Project, Inc.
> @@ -108,7 +108,7 @@
>  #endif
>  
>  static int
> -KDKBDREP_ioctl_ok(int rate, int delay) {
> +KDKBDREP_ioctl_ok(int fd, int rate, int delay) {
>  #if defined(KDKBDREP) && !defined(__sparc__)
>       /* This ioctl is defined in <linux/kd.h> but is not
>  	implemented anywhere - must be in some m68k patches. */
> @@ -117,7 +117,7 @@
>     /* don't change, just test */
>     kbdrep_s.rate = -1;
>     kbdrep_s.delay = -1;
> -   if (ioctl( 0, KDKBDREP, &kbdrep_s )) {
> +   if (ioctl( fd, KDKBDREP, &kbdrep_s )) {
>         return 0;
>     }
>  
> @@ -132,7 +132,7 @@
>     if (kbdrep_s.delay < 1)
>       kbdrep_s.delay = 1;
>     
> -   if (ioctl( 0, KDKBDREP, &kbdrep_s )) {
> +   if (ioctl( fd, KDKBDREP, &kbdrep_s )) {
>       return 0;
>     }
>  
> @@ -200,7 +200,7 @@
>    if (pKbd->delay >= 0)
>      delay = pKbd->delay;
>  
> -  if(KDKBDREP_ioctl_ok(rate, delay)) 	/* m68k? */
> +  if(KDKBDREP_ioctl_ok(pInfo->fd, rate, delay)) 	/* m68k? */
>      return;
>  
>    if(KIOCSRATE_ioctl_ok(rate, delay))	/* sparc? */


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
