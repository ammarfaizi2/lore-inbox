Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVBPBxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVBPBxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVBPBxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:53:55 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.68]:47315 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261964AbVBPBxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:53:49 -0500
Date: Tue, 15 Feb 2005 20:53:23 -0500
From: Vincent C Jones <vcjones@networkingunlimited.com>
Subject: Re: Radeon FB troubles with recent kernels
In-reply-to: <1108504921.13376.21.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Message-id: <20050216015323.GA7223@NetworkingUnlimited.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.6i
References: <3y1SR-5K6-1@gated-at.bofh.it>
 <20050215150713.EE7721DE4A@X31.nui.nul> <1108504921.13376.21.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 09:02:01AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2005-02-15 at 10:07 -0500, Vincent C Jones wrote:
> 
> > .../...
> >
> > radeonfb: panel ID string: 1024x768                
> > radeonfb: detected LVDS panel size from BIOS: 1024x768
> > BIOS provided panel power delay: 1000
> > radeondb: BIOS provided dividers will be used
> > ref_divider = 8
> > post_divider = 2
> > fbk_divider = 4d
> > Scanning BIOS table ...
> >  320 x 350
> >  320 x 400
> >  320 x 400
> >  320 x 480
> >  400 x 600
> >  512 x 384
> >  640 x 350
> >  640 x 400
> >  640 x 475
> >  640 x 480
> >  720 x 480
> >  720 x 576
> >  800 x 600
> >  848 x 480
> >  1024 x 768
> > Found panel in BIOS table:
> >   hblank: 320
> >   hOver_plus: 16
> >   hSync_width: 136
> >   vblank: 38
> >   vOver_plus: 2
> >   vSync_width: 6
> >   clock: 6500
> > Setting up default mode based on panel info
> 
> So far, things look good. At this point, the driver should have obtained
> the 1024x768 mode that matches your panel...
> 
> Can you look at radeon_monitor.c, function radeon_check_modes(). This
> function calls radeon_get_panel_info_BIOS() which is the above. Then, it
> gets into the if () block that follow that comment:
> 
> 	/*
> 	 * If we have some valid panel infos, we setup the default mode based on
> 	 * those
> 	 */
> 
> Could you add some more printk's in there to see what's going on ? It should
> setup a 1024x768 mode at this point...
> 
> Also, it should not get into any of the other if () statements of this function,
> except the last bit, in if (1) which adds the panel mode to the list for the
> driver. Can you check that happens ? (Especially, check that mode_option is NULL
> and thus the driver isn't trying to override the panel mode from the command
> line arguments).

This appears to be the challenge... the mode_option is being set from
the command line. 

> 
> If all of that looks good, then maybe look at what's going on in the function
> radeon_match_mode()... Maybe it's not matching the mode properly.
> 
> > radeonfb: Dynamic Clock Power Management enabled
> > hStart = 656, hEnd = 792, hTotal = 960
> > vStart = 402, vEnd = 408, vTotal = 438
> > h_total_disp = 0x4f0077	   hsync_strt_wid = 0x11028a
> > v_total_disp = 0x18f01b5	   vsync_strt_wid = 0x60191
> > pixclock = 15384
> > freq = 6500
> > Console: switching to colour frame buffer device 53x18
> > radeonfb (0000:01:00.0): ATI Radeon LY 
> > radeonfb_pci_register END
> > ACPI: AC Adapter [AC] (off-line)


. . .

Setting up default mode based on panel info
vcj: var->xres = 1024, yres = 768
vcj: var->xres_virtual = 1024, yres_virtual = 768
vcj: var->hsync_len = 136, vsync_len = 6
vcj: var->sync = 0x3
vcj: Inside if (mode_option)
vcj: Inside if (fb_find_mode(xxx)) with fb_find_mode = 3
vcj: Inside if (1)
vcj: Leaving radeon_check_modes
radeonfb: Dynamic Clock Power Management enabled
. . .

Duhhh... Going back to the beginning, guess what I find...

Kernel command line: auto BOOT_IMAGE=Test_9.2 ro root=306 pci=usepirqmask desktop idebus=66 video=radeonfb:1024x768-24@60

Note the "video=radeonfb:1024x768-24@60" which used to be required to
get the console into 1024x768 mode but is documented in "modefb.txt"
as an invalid combination of mode specifications (and also states
that radeonfb does not support mode specification...). So other
than the loss of temporary working of backlight controls, I just
see undocumented progress :-)

Thanks again, and keep up the great work!

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
