Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUCQTDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 14:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUCQTDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 14:03:19 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:25105 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261939AbUCQTDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 14:03:15 -0500
Date: Wed, 17 Mar 2004 19:03:06 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Ian Campbell <icampbell@arcom.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PXA255 LCD Driver
In-Reply-To: <1079525185.13373.143.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.44.0403171723330.15898-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I was trying too (I mostly copied the i810 driver). How wrong did I get
> > > it? I'm willing to rework it to make it the same as the standard.
> > 
> > Take a look at drivers/video/modedb.c and fb_find_mode().
> 
> Ah, I had seen that, but it doesn't seem to be very appropriate for an
> LCD controller in an embedded environment. TFT and STN (STN in
> particular) displays don't often fit into any of the standard mode
> definitions. There's also several settings which aren't in the DB, such
> as pixel clock polarity, dual vs. single panel STN etc.

    The way to handle different types of displays, LCD, CRT etc has 
improved greatly in the latest 2.6.X kernels. You don't need to lock yourself 
into the standard modedb database. Also  modedb is used only for selecting a 
particular resolution. The structure used to define the display panels 
behavior is struct fb_monspecs. Take a look at it in fb.h. I'm interested 
if I got all the needed data from the EDID about a display panel.
 
    Here is basically what you have to do to handle mode setting:

1) Does the displaying hardware tell you data about itself? You have to 
   ask yourself can I get display hardware information. If it does 
   what format is it in. In most hardware today you can get data about the
   display hardware in a EDID block format. Usually that data is retrieved
   via i2c. Fbdev driver writers must write the code handling getting the  
   display hardware's data. Once you have the EDID data block you can use 
   already written functions to parse the EDID block. 
      If you display hardware does not use EDID format then the driver 
   writer must parse the data himself. What data needs to get generated?
   This is covered next. 

2) Attempt to generate the struct fb_monspecs data. Now it is not a 
   absolute requirement but it sure does help. There is one per physical 
   display. This means for cases like laptops you can have one framebuffer's
   data being displayed on two physical displays (attached CRT and the LCD 
   panel). In this case you would have two struct fb_monspecs per struct 
   fb_info. When you are going to change the video mode you would have to 
   valid the new mode against BOTH physical displays. In fact you can get 
   a bunch of crazy combo's. The important part is that use generate a 
   fb_monospec if possible. 
	Note that fb_monospec has a mode database in its data structure.
   Sometimes the display hardware will tell use what the "best" video 
   modes are for it. Also some display hardware is limited in what it can
   be allow to display. SO those modes are the only ones that actually 
   work.
        Now back to the EDID case. There is a global function that will get
   the monitor limits for you. This function will also build you your 
   modedb for you!!! 

   fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs) 

   Again what if we don't use EDID. Well if you can get the display 
   hardware information in some way it is in your best interest to create
   a struct fb_monspec and also the modedb attached to it. What if you 
   can't get supported modes to build a database but you can get the monitor 
   limits? Here are your options.

      I.  Build your own modedb from stratch.
     II.  Use the standard vesa database if hooking up to a standard vesa 
          display.
     III. Don't use a database. We have a function, fb_get_mode in fbmon.c, 
	  that generates modes on the fly based on GTF formulas. Note this
          function can generate modes without fb_monspecs but it will be 
          severally handicapped modes. 
     
  Now if you can't get neither fb_monspecs or modedb data you still can
  use the above options.       

3) Okay now we "might" have our monitor data and our modedb. If we have to 
   ask ourselves does the hardware allow the change of the resolution? If 
   it doesn't then why do we generate a fb_monospec or a modedb. Because 
   that data can be very useful to userland :-) If this is the case you 
   can call fb_find_mode on your modedb if you have one and return the 
   default struct fb_var_screeninfo that we need. If you don't have a 
   modedb you still need to supply a default struct fb_var_screeninfo that
   represents the display resolution. Also you could have the case where 
   you swap about the display. In this case you might want to create a new
   fb_monospec and update your var data even if you don't change your 
   resolution. Now we are done. If you hardware can change modes then 
   continue on.

3) Now what to do for when we want to set the graphics display. Before we 
   consider the monitor we have to see if the new resolution request is 
   complete. Not every fb_var_screeninfo request is complete. Often the user 
   only is concern with xres, yres and bpp. That is it. Alot of data is 
   missing. This is bug in many drivers that they don't fill in that data 
   thus often when the user tried to change the resolution they ended up 
   with a blank screen. So how do we deal with it?

4) First we can use a modedb we have to find the best fit. If not use the 
   function fb_get_mode in fbmon.c. 

5) Now that we have the purposed mode we call the function 

   fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
  
   This tells us if the requested video mode is to much for our display 
   hardware to handle. 

6) If the monitor can handle it we call the drivers xxxfb_check_var 
   function to see if the graphics chip can handle the mode.
 
I hope that answers your question. Now that I wrote this I'm going to make 
it apart of the documenation in the kernel for a driver how to.



