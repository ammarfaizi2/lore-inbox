Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbSLEWjA>; Thu, 5 Dec 2002 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbSLEWjA>; Thu, 5 Dec 2002 17:39:00 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:46340 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267568AbSLEWi6>; Thu, 5 Dec 2002 17:38:58 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
From: Antonino Daplas <adaplas@pol.net>
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021205204442.GA1103@iliana>
References: <20021205180314.GA860@iliana>
	<Pine.LNX.4.44.0212052035330.31967-100000@phoenix.infradead.org> 
	<20021205204442.GA1103@iliana>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039138551.1024.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 06:36:31 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 01:44, Sven Luther wrote: 
> On Thu, Dec 05, 2002 at 08:37:08PM +0000, James Simmons wrote:
> > 
> > > > Not really. When X closes /dev/fb then fb_release is called which if the 
> > > 
> > > That supposes X is fbdev aware (either using the fbdev driver or the
> > > UseFBDev option), right ? What if X knows nothing about fbdev, it will
> > > try restoring stuff as if it was in text mode.
> > 
> > That is what X will try. 
> 
> Mmm, is it enough for X to just save/restore the registers it modifies ?
> 
Life will be easy if native X does that always.  However, it does not
always restore all the registers it modifies. Common example, the cursor
registers.  If fbdev is also using a hardware cursor, you will see X's
cursor replacing your console's block cursor when switching from X to
the console.

Some ATI cards freezes the system when native X and fbdev are running
concurrently.

James,

Without the set_var hook 2.5 as is in 2.4, this will become more of a
problem. Most drivers in 2.4 refreshes their registers during set_var.

> Also, i suppose if i am comming from fbdev, what X saves or restores
> does not really count, since fbdev knows what relevant thing to save.

Yes, the same thing too if the X driver supports Option "Usefbdev". Instead
of restoring the hardware registers, X (or XFBdev) will call fb_set_var 
to restore fbcon's state.

> 
> Still i sense that there may be some issues involved here, especially
> if you switch from text mode to fbdev or between fbdevs while not in X.
> 

State saves and restores are pertinent only for state changes within a single card.
Ie, the state of the vga core and the graphics state. Thus, this is relevant to
vgacon, vga16fb, the native fbdev driver, and of course X since all can coexist 
in one card. I have already run vgacon, vga16fb and native fbdev simultaneously
already.  Fortunately, the X driver was nice too, so I was able to run X also.  

In multiple fbdev's with each on it's own hardware, this does not matter since 
the state of the other hopefully does not affect the other. The only problem I can think
of is that one card is the primary (thus with an active vga core) and the others are
non primary (thus with an inactive vga core).  If the non-primary drivers are not
careful, they may attempt to save/restore the VGA state that they have no business of
knowing.  There can be several solutions to this:

1.  There is probably a flag somewhere that says that the hardware's vga core is 
inactive, and if so, do not attempt to save/restore the state..

2.  Most hardware with a vga core most probably has the VGA registers memory mapped. 
If this is the case, all it needs to do is fill up fb_vgastate.vgabase, and the 
save/restore module will instead do mmio instead of pio, leaving the actual VGA registers
untouched.

Tony


