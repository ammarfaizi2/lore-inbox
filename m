Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbSLDWGh>; Wed, 4 Dec 2002 17:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbSLDWGh>; Wed, 4 Dec 2002 17:06:37 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:10255 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267129AbSLDWGD>; Wed, 4 Dec 2002 17:06:03 -0500
Subject: Re: [PATCH 1/3: FBDEV: VGA State Save/Restore module
From: Antonino Daplas <adaplas@pol.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <962842B4859@vcnet.vc.cvut.cz>
References: <962842B4859@vcnet.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039050187.1086.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 06:05:36 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 23:41, Petr Vandrovec wrote:
> On  4 Dec 02 at 22:26, Antonino Daplas wrote:
> > +static void vga_cleanup(struct fb_vgastate *state)
> > +{
> > +   if (state->fbbase)
> > +       iounmap(state->fbbase);
> > +}
> 
> Nobody is setting state->fbbase to NULL, so 
Oops, yes I missed setting fbbase to NULL at the start.

> "save_vga(SAVE_FONT); restore_vga(); save_vga(0); restore_vga();"
> will badly die. I think that you should change save prototype to
> int fb_save_vga(int whattosave, struct fb_vgastate* state);, and at
> the beginning of save you should do "memset(state, 0, sizeof(*state));"
> 
> And fbbase should not be in state variable, as this value is valid
> only during duration of save or restore, not outside of them. Pass it
> to function which needs it as an explicit argument.
>
The field fbbase is kind of temporary at the moment, fixed for the
0xa0000 window.  I'm currently thinking of having the offset and the
size of the window optionally set by the calling process.
 
> It looks easier to me to make fb_vgastate larger structure with
> crt/seq/cmap fields embeded, instead of kmallocing these portions.
> Or at least allocate them together depending on 'whattosave' flag,
> doing four kmalloc() to allocate about 64 bytes is waste of resources.

I hate hardwiring fixed numbers :)  It's also possible that some drivers
may find it sufficient to use the module to save the standard and its
own set of extended registers. 

But you're correct, 4 kmallocs is wasteful, I wasn't thinking straight
:-).  I'll just do one and adjust the offsets for each field.

[...]
> And if my VGA documentation is correct, you are saving random
> data into vga_text: first 8192 chars interleaved with
> 8192 bytes of garbage, plus attributes from chars 8192-16383 interleaved
> with 8192 bytes of garbage. 
>
Right, I'm not sure about this part too.  The docs say that this is true
for EGA compatible hardware.  How about non-compliant hardware?  
 
> When you program hardware to get access to planes (vga 16 color 
> graphics mode), every second byte from plane 0 contains character, 
> and every second byte from plane 1 contains character attribute 
> (it is that way because of bit A0 selects plane, while A15-A1.0 
> selects memory address, so odd in memory addresses are unreachable 
> in vga text mode).
> 
> And if you are using standard hardware, then font data live only in
> plane 2, plane 3 is unused on VGA hardware in text mode. I think that
> you should either save whole 256KB of memory, without deeper understanding,
> or you should just save FONT 0 (first 32*256 bytes from plane 2) if you
Only if saving the first character map in plane 2.  Hardware can have as
much as 8 character maps per plane, each 8K in size for 64K.  The same
setup is true for plane 3 fonts.
 
> want to save memory and you know that console was driven by vgacon in
> text mode.
To save memory, apps can explicitly choose what to save, but I don't
want to go finer than that, ie. save character maps 2,3,5  of plane 2
and 1,2,3 of plane 3.  The current way of saving the text mode map may
be a bit wasteful, but better than being bitten by hardware that's
non-EGA compliant.  

Tony
 


