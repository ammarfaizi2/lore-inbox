Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319135AbSHTBXY>; Mon, 19 Aug 2002 21:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319136AbSHTBXY>; Mon, 19 Aug 2002 21:23:24 -0400
Received: from p042.as-l031.contactel.cz ([212.65.234.234]:16768 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S319135AbSHTBXX>;
	Mon, 19 Aug 2002 21:23:23 -0400
Date: Tue, 20 Aug 2002 03:25:08 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       jsimmons@infradead.org
Subject: Re: Little console problem in 2.5.30
Message-ID: <20020820012508.GE6988@ppc.vc.cvut.cz>
References: <20020819023731.C316@devserv.devel.redhat.com> <Pine.GSO.4.21.0208191433430.23654-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208191433430.23654-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 02:36:25PM +0200, Geert Uytterhoeven wrote:
> On Mon, 19 Aug 2002, Pete Zaitcev wrote:
> > I would appreciate if someone would explain me if the attached patch
> > does the right thing. The problem is that I do not use the framebuffer,
> > and use a serial console. Whenever a legacy /sbin/init tries to
> > open /dev/tty0, the system oopses dereferencing conswitchp in
> > visual_init().
> 
> And this worked before?

I was simillary surprised when it happened (between 2.5.25 and 2.5.26 if
my memory serves correctly).
 
> conswitchp must never be NULL, say `conswitchp = &dummy_con;' in your setup.c
> if you have a serial console.

No, it does not work that way for very loooong... Just remove VGA device from
your box, VGA con_startup will fail and conswitchp will become NULL... And
in 2.5.26 more than 50% of archs (including i386) does not use dummy_con, it
leaves conswitchp uninitialized (== NULL).
 
> > diff -ur -X dontdiff linux-2.5.30-sp_pbk/drivers/char/console.c linux-2.5.30-sparc/drivers/char/console.c
> > --- linux-2.5.30-sp_pbk/drivers/char/console.c	Thu Aug  1 14:16:34 2002
> > +++ linux-2.5.30-sparc/drivers/char/console.c	Sun Aug 18 23:14:20 2002
> > @@ -652,7 +652,7 @@
> >  
> >  int vc_allocate(unsigned int currcons)	/* return 0 on success */
> >  {
> > -	if (currcons >= MAX_NR_CONSOLES)
> > +	if (currcons >= MAX_NR_CONSOLES || conswitchp == NULL)
> >  		return -ENXIO;
> >  	if (!vc_cons[currcons].d) {
> >  	    long p, q;

In 2.5.25 con_init and vty_init was one function, which checked conswitchp == NULL
at beginning. In 2.5.26 it was spilt down, and vty_init does no conswitchp checking,
it blindly registers console tty driver. Proper fix is putting

if (!conswitchp) return;

at the beginning of vty_init(), unless we support hotplug tty. If we support hotplug tty,
then your fix is probably correct, but it needs deeper inspection, as no tty code
ever expected conswitchp == NULL.
								Petr Vandrovec
								vandrove@vc.cvut.cz
