Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSACQ37>; Thu, 3 Jan 2002 11:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSACQ3u>; Thu, 3 Jan 2002 11:29:50 -0500
Received: from intra.cyclades.com ([209.81.55.6]:12306 "HELO
	intra.cyclades.com") by vger.kernel.org with SMTP
	id <S287386AbSACQ3b>; Thu, 3 Jan 2002 11:29:31 -0500
Message-ID: <3C3487B3.38AACAF6@cyclades.com>
Date: Thu, 03 Jan 2002 08:32:51 -0800
From: Ivan Passos <ivan@cyclades.com>
Organization: Cyclades Corporation
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C33BCF3.20BE9E92@cyclades.com> <3C33E0D3.B6E932D6@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> 
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
> 
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
> 
> --- linux-2.4.18-pre1/drivers/char/tty_io.c     Wed Dec 26 11:47:40 2001
> +++ linux-akpm/drivers/char/tty_io.c    Wed Jan  2 20:39:53 2002
> @@ -194,7 +194,7 @@ _tty_make_name(struct tty_struct *tty, c
>         if (!tty) /* Hmm.  NULL pointer.  That's fun. */
>                 strcpy(buf, "NULL tty");
>         else
> -               sprintf(buf, name,
> +               sprintf(buf, "%s%d", name,
>                         idx + tty->driver.name_base);
> 
>         return buf;
> 
> Does this look (and work) OK to you?

No, because with this implementation you'll break the devfs printk.

We have two options, I guess:

1) Change the drivers to have "ttx/%d" (devfs) and "ttyX%d" 
   (non-devfs), and leave _tty_make_name() untouched (my original 
   suggestion).

2) Change the drivers to have "ttx/" (devfs) and "ttyX" (non-devfs) 
   and change _tty_make_name() as suggested above by Andrew. I don't 
   know how this would affect devfs though ...

I really don't care which solution is used (although I do prefer 
option 2, if possible), but I'm sure that it can't stay as it is 
now, because right now it's broken.

So ... Which one is more appropriate?? Any other suggestions??

Later,
-- 
Ivan Passos							 -o)
Integration Manager, Cyclades	- http://www.cyclades.com	 /\\
Project Leader, NetLinOS	- http://www.netlinos.org	_\_V
--------------------------------------------------------------------
