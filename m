Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288223AbSACGiY>; Thu, 3 Jan 2002 01:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288224AbSACGiO>; Thu, 3 Jan 2002 01:38:14 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:35283 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288223AbSACGiA>; Thu, 3 Jan 2002 01:38:00 -0500
Date: Wed, 2 Jan 2002 23:37:59 -0700
Message-Id: <200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C33E0D3.B6E932D6@zip.com.au>
In-Reply-To: <3C33BCF3.20BE9E92@cyclades.com>
	<3C33E0D3.B6E932D6@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Ivan Passos wrote:
> > 
> > (Please CC your answer to me, as I'm not a subscriber of this list.)

And when sending a message to the list about devfs, I wish people
would Cc: me.

> > Hello,
> > 
> > By looking at tty_io.c:_tty_make_name(), it seems that the TTY
> > subsystem in the Linux 2.4.x kernel series expects driver.name to be
> > in the form "ttyX%d", even if you're not using devfs. I say that
> > because as of now the definition in serial.c for this variable is:
> > 
> > #if defined(CONFIG_DEVFS_FS)
> >         serial_driver.name = "tts/%d";
> > #else
> >         serial_driver.name = "ttyS";
> > #endif
> > 
> > , when it seems it should be:
> > 
> > #if defined(CONFIG_DEVFS_FS)
> >         serial_driver.name = "tts/%d";
> > #else
> >         serial_driver.name = "ttyS%d";
> > #endif
> 
> I don't think so.  Some quick grepping indicates that _all_
> tty drivers currently use the "ttyS" equivalent if !CONFIG_DEVFS.
> 
> Instead, it appears that someone broke tty_name().  Here's the
> 2.2 kernel's version:

That "someone" was me, and I changed it from broken to fixed.

> char *tty_name(struct tty_struct *tty, char *buf)
> {
>         if (tty)
>                 sprintf(buf, "%s%d", tty->driver.name, TTY_NUMBER(tty));
>         else
>                 strcpy(buf, "NULL tty");
>         return buf;
> }
> 
> And that's much more sensible.  The tty has a name associated with
> what it is (eg "ttyS") - correlates with major number, probably.
> And it has an instance number.
> 
> Which is cleaner, IMO, than embedding printf control strings
> in the driver name.

No, originally tty_name() did it, and then I shifted it to the
drivers. I don't recall the reason, but it was necessary. So I don't
want this changed.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
