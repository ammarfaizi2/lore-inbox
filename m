Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288449AbSAHV7g>; Tue, 8 Jan 2002 16:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288460AbSAHV7c>; Tue, 8 Jan 2002 16:59:32 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:2284 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S288449AbSAHV7T>; Tue, 8 Jan 2002 16:59:19 -0500
Date: Tue, 8 Jan 2002 16:58:51 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: David Weinehall <tao@acc.umu.se>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
Message-ID: <20020108165851.B26294@alcove.wittsend.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	David Weinehall <tao@acc.umu.se>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Ivan Passos <ivan@cyclades.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C33E0D3.B6E932D6@zip.com.au> <3C33BCF3.20BE9E92@cyclades.com> <200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca> <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca> <3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca> <3C3A7DA7.381D033D@zip.com.au>, <3C3A7DA7.381D033D@zip.com.au>; <20020108071548.J5235@khan.acc.umu.se> <3C3A9048.CB80061A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3A9048.CB80061A@zip.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 10:23:04PM -0800, Andrew Morton wrote:
> David Weinehall wrote:
> > 
> > On Mon, Jan 07, 2002 at 09:03:35PM -0800, Andrew Morton wrote:
> > > [ tty driver name breakage ]
> > >
> > > Richard, can we please get this wrapped up?
> > >
> > > My preferred approach is to change the driver naming scheme
> > > so that we don't have to put printf control-strings everywhere.
> > > We can remove a number of ifdefs that way.
> > 
> > Wouldn't it be cleaner to have:
> > 
> > #ifdef CONFIG_DEVFS_FS
> >         serial_driver.name = "tts/";
> > #else
> >         serial_driver.name = "tts";
> > #endif
> > 
> > and
> > 
> >         sprintf("buf, "%s%d", name, idx + tty->driver.name_base);
> > 
> > respectively?!
> > 

> Well, with the scheme I proposed most drivers won't need the
> ifdef.  It'll just be:

> 	serial_driver.name = "cua";

> With devfs enabled that expands to cua/42.  Without devfs it expands
> to cua42.

	No.

	We've been over this in several lists and there are more
issues here.  The Computone driver is ttyF%d / tts/F%d cuf%d / cua/F%d.
If I understand your convention (and maybe I do not) then the cuf
driver would be what?  Expanded to cuf/42 with devfs and cuf42 without?
That's what it use to be and that created a problem in userland.  The
trouble there is the problem with conventional lock files under
/var/lock which only use the base name of the device name so cua/42
and cuf/42 both have the same lock file of /var/lock/LCK..42 and
would collide.  Yes we could ALSO change ALL the user space applications
using locks, but I just got done changing the Computone driver to conform
to the non-conflicting convention that had been agreed to.  This also
impacts the USB ACM driver and it's devices and lock files.

	Unfortunately, the basenames need to be non-conflicting in flat
name space due the the indeterminant pile of applications which are going
to require non-conflicing lock files under a convention that days back to
before Linux or even Taylor UUCP (HDB UUCP used a similar locking scheme).
That includes pppd, slip, uucp, minicom, cu, ecu, tip, mgetty, etc, etc...

> Seems that some drivers have had their name changed when used under
> devfs (tts/%d versus ttyS%d).  But a lot have not.

	Other drivers which are not under ttyS%d don't make to tts/%d.
As things stand right now, ttyF%d maps to tts/F%d.  It use to be mapped
under ttf/%d but this created a lock file conflict with the tts/%d and
usb/acm/%d devices and had to be changed.

> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
