Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUFPORX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUFPORX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUFPORX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:17:23 -0400
Received: from barclay.balt.net ([195.14.162.78]:18675 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S263932AbUFPORU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:17:20 -0400
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
	or address)
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
Reply-To: zilvinas@gemtek.lt
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40D0432A.1080006@pobox.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040616095805.GC14936@gemtek.lt>  <40D0432A.1080006@pobox.com>
Content-Type: text/plain
Organization: Gemtek Baltic
Message-Id: <1087395424.5314.2.camel@swoop.gemtek.lt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 17:17:04 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've checked drivers/char/tty_io.c :

/*
 * Change # of rows and columns (0 means unchanged/the size of
fg_console)
 * [this is to be used together with some user program
 * like resize that changes the hardware videomode]
 */
int vc_resize(int currcons, unsigned int cols, unsigned int lines)
{
	unsigned long old_origin, new_origin, new_scr_end, rlth, rrem, err = 0;
	unsigned int old_cols, old_rows, old_row_size, old_screen_size;
	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
	unsigned short *newscreen;

	WARN_CONSOLE_UNLOCKED();

	if (!vc_cons_allocated(currcons))
		return -ENXIO;




there is only place that returns ENXIO ... and if you take a look into 
vc_cons_allocated() :

int vc_cons_allocated(unsigned int i)
{
	return (i < MAX_NR_CONSOLES && vc_cons[i].d);
}

it might be either i exceeds MAX_NR_CONSOLES or vc_cons[i].d is 0.

btw, get TIOCGWINSZ, works fine and returns correct values as shown in
strace. it is only SET part is failing ...

br 

On Wed, 2004-06-16 at 15:55, Jeff Garzik wrote:
> Zilvinas Valinskas wrote:
> > On Compaq N800 EVO notebook with a radeonfb enabled - stty failes to
> > adjust terminal size. strace log attached. Under 2.6.5/2.6.6 it used to
> > work. 
> > 
> > relevant part:
> > 
> > open("/dev/vc/1", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
> > fcntl64(3, F_GETFL)                     = 0x8800 (flags
> > O_RDONLY|O_NONBLOCK|O_LARGEFILE)
> > fcntl64(3, F_SETFL, O_RDONLY|O_LARGEFILE) = 0
> > ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo
> > ...}) = 0
> > ioctl(3, TIOCGWINSZ, {ws_row=65, ws_col=175, ws_xpixel=0, ws_ypixel=0})
> > = 0
> > ioctl(3, TIOCSWINSZ, {ws_row=50, ws_col=175, ws_xpixel=0, ws_ypixel=0})
> > = -1 ENXIO (No such device or address)
> > write(2, "/bin/stty: ", 11)             = 11
> > write(2, "/dev/vc/1", 9)                = 9
> > open("/usr/share/locale/locale.alias", O_RDONLY) = 4
> > 
> > 
> > it makes no difference when doing :
> > 
> > stty rows 50 columns 140 
> > or
> > stty rows 50 columns 140 -F /dev/vc/1 ... 
> > 
> > Exactly same error.
> 
> 
> huh, I wonder if this is why reset(1) doesn't fully reset the terminal, 
> like it used to ...
> 
> 	Jeff
> 
> 

