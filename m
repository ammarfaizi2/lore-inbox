Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbTCIWTU>; Sun, 9 Mar 2003 17:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262647AbTCIWTU>; Sun, 9 Mar 2003 17:19:20 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:48671 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S262646AbTCIWTS>; Sun, 9 Mar 2003 17:19:18 -0500
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
From: Antonino Daplas <adaplas@pol.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20030309212903.GC16578@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
	<20030220150201.GD13507@codemonkey.org.uk>
	<20030220182941.GK14445@vana.vc.cvut.cz>
	<1045787031.2051.9.camel@localhost.localdomain>
	<20030303203500.GA2916@vana.vc.cvut.cz>
	<20030304212906.GA1115@middle.of.nowhere> 
	<20030309212903.GC16578@vana.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1047248782.1208.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Mar 2003 06:27:14 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 05:29, Petr Vandrovec wrote:
> Hi James,
>   I tried to use fb_cursor and I have quite a lot problems with
> it:
> (1) it uses global variables for storing last cursor value -
>     - but there is no global hardware, so after switching from
>     one fbdev to another you can have cursor with wrong shape,
>     wrong color and so on...
> (2) callback from timer for cursor blinking may set almost any
>     FB_CUR_* bits. But in this case fb_cursor callback may be
>     called from interrupt context, while accelerator is busy
>     and so on... Did I miss some synchronization? Best for me
>     would be disabling blinking code in fbcon completely:
>     in VGA mode cursor blinks automatically, and in graphics mode
>     more lightweight only 'flash' callback is more appropriate
>     for me. But then there is problem with

I've also noticed problems with 1 and 2, and I submitted a patch to
James that allocates resources on a per device basis instead of being
global and statically allocated.  This includes the cursor data
structures, cursor timer/vbl interrupt service, putcs buffer, and
optionally the softback buffer.  The last is probably not very important
for the present setup but may become useful later on (ie, multiple
active consoles).

As for synchronization, I was meaning to ask some pointers on that.  The
setup currently works like this:

                        (blink)
fbcon_cursor         fbcon_vbl_handler (interrupt or timer)   
     |                     |
     -----------------------
               |
           accel_cursor
               |
     -----------------------
     |                      |
  hardware              soft_cursor    accel_putcs    accel_putc
                            |              |               |
                            -------------- -----------------
                                           | 
                                   fb_get_buffer_offset
                                           |
                                     xxxfb_imageblit
                                           |
                                  -------------------
                                  |                  |
                              hardware           software


I was thinking of placing locks in accel_cursor and
fb_get_buffer_offset, but I'm not sure.
  
> (3) cursor_undrawn... I have no idea how is this supposed to work

In the present cursor api, the driver just needs to draw/undraw the
cursor whether by software or hardware.  So the problem here is with
cursors that does it's own blinking, such as text modes.

>     if fbdev provides hardware cursor... And HZ/50 delay after
>     putcs makes orientation on screen very complicated, as there
>     is no cursor while new characters are appearing on screen.

The delay is only for the blinking.  After drawing a character/stream of
characters, an explicit "draw cursor" command immediately follows (I
think) via fbcon_cursor.

Tony



