Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbUKBSFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUKBSFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUKBSFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:05:32 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:53766 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261251AbUKBSE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:04:57 -0500
Date: Tue, 2 Nov 2004 18:03:56 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: adaplas@pol.net
cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
In-Reply-To: <200411020746.27871.adaplas@hotpop.com>
Message-ID: <Pine.LNX.4.10.10411021743001.4822-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have identified what is going on. My CG3 console uses the same font and
exactly overlaps prom console. [I have re-inserted the console margin code
for my CG3 driver]. The timing is such that the prom overwrites the
console text (using colour 255) a fraction later than the fbcon code.

The two problems to be solved are (apart from seting the red,green and
blue structures up for the cg series fb cards):

1) The prom write (from -p) needs to be disabled as soon as an alternative
console becomes active (either prom console, fbcon console or serial
console). This has probably been the major cause of hassel.

2) The restore pallet function (see cgsix.c in the 2.2.x or 2.4.x kernels)
needs to be re-introduced in some form and called when exiting fbcon so
that the prom does not end up as black on black. My prom uses fg=255,
bg=0. Does any one know if this is standard for all sparc boot proms.

I need to tidy up my code before I start work on the first of these two
problems. The second one should not catch me out as I am using colour
255 as my margin colour and it is set to "Dark Slate Grey" so I do not 
have a black on black prom console.

If any one wants a linux 2.6.10 CG3 driver with software margins then let
me know and I will post an appropriate patch.

Regards
	Mark Fortescue.

On Tue, 2 Nov 2004, Antonino A. Daplas wrote:

> On Tuesday 02 November 2004 01:32, Mark Fortescue wrote:
> > Hi all,
> >
> > Thanks for the info Antonino. I see you spotted my typing error. Yes it is
> > the 2.6.10-rc1-bk6 kernel. The oter error is the 2.2.8.1. It should be
> > 2.6.8.1.
> >
> > The cgthree driver does not currently set up the all->info.var.red,
> > all->info.var.green or all->info.var.blue structures. Putting a value of 8
> > in the length field of these structures (correct for the cgthree) does get
> > me my logo back but I am still getting black on black text. It makes it
> > very difficult to read. It is begining to look like there is something
> > werid going on with the colour pallet stuf for PSEUDO_COLOUR.
> >
> 
> I doubt that the problem is at the driver layer since you were able to
> see the logo. It's probably higher up.
> 
> Try this mod, hardwire the foreground color to 0x07.
> 
> Edit drivers/video/console/bitblit.c:bit_putcs() and change this line:
> 
> image.fg_color = fg;
> image.bg_color = bg;
> 
> to
> 
> image.fg_color = 0x07070707;
> image.bg_color = 0x0;
> 
> You can also try the reverse:
> 
> image.fg_color = 0x0;
> image.bg_color = 0x07070707
> 
> If you get visible text, the problem is either in fbcon.c or vt.c.
> 
> Tony
> 
> 

