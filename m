Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266088AbUFWDTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbUFWDTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 23:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFWDTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 23:19:25 -0400
Received: from havoc.gtf.org ([216.162.42.101]:5270 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266088AbUFWDTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 23:19:20 -0400
Date: Tue, 22 Jun 2004 23:19:18 -0400
From: David Eger <eger@havoc.gtf.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jeff Garzik <garzik@havoc.gtf.org>,
       jsimmons@infradead.org
Subject: Re: [PATCH] cirrusfb: it lives!
Message-ID: <20040623031918.GA24055@havoc.gtf.org>
References: <20040622202758.GA10135@havoc.gtf.org> <40D89865.3040606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D89865.3040606@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 04:36:53PM -0400, Jeff Garzik wrote:
> David Eger wrote:
> >Dear Andrew,
> >
> >This patch brings the cirrusfb driver up to date with 2.6.  cirrusfb
> >has suffered bit rot like you wouldn't believe (last updated... 2.3.x 
> >era?).
...

> >-
> >-#include "clgenfb.h"
> >-#include "vga.h"
> >+#include "video/vga.h"
> >+#include "video/cirrus.h"
> 
> should be <> not "", no?

My bad.  I keep thinking <> is for those system headers -- obviously not
the little project I'm working on ;-)

> > /* debugging assertions */
> >-#ifndef CLGEN_NDEBUG
> >+#ifndef CIRRUSFB_NDEBUG
> 
> IMO it would be nice to split up your patch into one that does all the 
> cosmetic renames, and one that does the "real stuff".  Makes it far 
> easier to review.

Porting the driver to 2.6 did involve a lot of search-and-replace.
Sorry that it makes checking the diff so hard. I'll try to explain what's
changed and why,  but splitting the patch into cosmetic+functional isn't
really something I want to do...  Read on for details.

C = Cosmetic change
L = Logical change
A = API change
W = register Writing change

(1-CA) fb_info and cirrusfb_info:
   - mostly cosmetic, but a lot less confusing, and no more nasty casting.

  It used to be stylish to embed struct fb_info_gen (now struct fb_info)
  as the first member of struct clgenfb_info (now struct cirrusfb_info), 
  and then you'd cast to the deisred struct.
  Now we pass the size of our data structure to framebuffer_alloc(), 
  and we make fb_info and cirrusfb_info reference each other with 
  pointers (as in radeonfb).

  In the old code, there two declarations were common:

  clgenfb_info *fb_info;
  clgenfb_info *info;

  since there's also a 'struct fb_info' now, I found this really confusing,
  and unified usage as:

  cirrusfb_info *cinfo;
  fb_info *info;

  This accounts for a lot of the search and replace cosmetic upgrade.

(2-A) All of the FB knowledge of FB internals is gone in 2.6

(3-LW) revised maxclock numbers (cirrusfb_board_info_rec.maxclock[5])

	In my quest to get fbset to work, I borrowed some maxclock data
	from the X.Org tree for various chipsets.  It didn't really seem 
	to help.  oh well.

(3-LA) upgraded PCI registration

	Instead of doing PCI walking from the driver, we hand off a
	pci_device_id table to the PCI subsystem and just get called when
	it finds a relevant board.

(4-L) striking lots of __init and __initdata specifiers

	I was running into some things not working when I moved the call to
	init_vgachip() from the driver registration to set_par().  I thought
	perhaps this was due to some things being marked __init accidentally
	so I axed said annotations.  Turns out it was something else.  See 5.

(5-LA) delayed chip initialization, nasty double-set_par() pseudo-bug
  
  Tony says that the fb drivers shouldn't do any chipset initialization
  until they get a set_par() call.  This way, fb modules can be safely
  unloaded if no one gets around to using them, and the vga_con -> fbcon
  hand off is smoother, as fbcon can still grab the back-scroll data from 
  vga_con...

  In any case, moving the calls to init_vgachip() and fbgen_do_set_var()
  from driver initialization to set_par() revealed that the cirrus 
  register-writing function needs to be called twice for a mode change to
  work.  I don't understand why.

(6-LA) split clgen_decode_var() into the bits that check the var and the
  bits that actually generate register information (par/regs) to write

  Adding modedb hooks here might actually fix fbset, i think...

(7-LW) No longer write the palette in init_vgachip() nor in set_par().
  Someone else (fbcon?) seems to be making its own calls to setcolreg()
  for us.

(8-LW) setcolreg() -- while removing all of the console cruft, I had
  to try to reconstitute the palette code. I think I got this right, 
  but I could be off -- the penguin boots in the correct colors at least ;-)

(9-L) pan_display() - we don't do wrap, silly. that's only on the amiga.

(10-L) pan+BLT - to make pan play nicely with copyarea()/fillrect() 
   I had to add a couple of calls to cirrusfb_WaitBLT() to make sure
	the engine is idle.

(11-LW) cirrusfb_blank() - I upgraded the switch here to use the new
  VESA_* blanking mode constants.  I think I translated the right
  logic for the right blanking levels.


-dte
