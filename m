Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUDTXVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUDTXVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbUDTWKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:10:13 -0400
Received: from havoc.gtf.org ([216.162.42.101]:41436 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264530AbUDTVJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:09:16 -0400
Date: Tue, 20 Apr 2004 17:09:11 -0400
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Subject: Re: radeonfb broken
Message-ID: <20040420210911.GA9936@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Apr 19, 2004 at 10:31:27AM -0400, Timothy Miller wrote:
>Ah, so you are the one who wrote the Radeon driver?  Thanks for the fix.

Originally it was Ani Joshi's driver.  Now BenH maintains it.
I just wrote the acceleration code for radeon for 2.6 ;-)

>One question I have is how to turn on acceleration in the 2.6 kernel. 

Funny you should ask. We're discussing over on the fbdev list
( http://linux-fbdev.sourceforge.net/ ) why it's so slow and how to fix it.
It turns out that the fbcon layer has some heuristics to decide how
best to accelerate text rendering (i.e., redraw, call driver accel routines,
or do a screen-to-screen bitblt).  These heuristics are just plain *bad*.
At the moment, I just comment out the logic and hard-wire the choice
to "use the driver accel routines, dumbass" as in the excerpt below.

We ought to fix this logic so the video cards indicate which method
is best.  The current fields in fb_fix_screeninfo don't really
convey the message well, as you can see in the logic below..


Excerpt from linux/drivers/video/console/fbcon.c:

#define divides(a, b)   ((!(a) || (b)%(a)) ? 0 : 1)

/* ... */

static __inline__ void updatescrollmode(struct display *p, struct 
vc_data *vc)
{
        struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];

        int m;
        /*if (p->scrollmode & __SCROLL_YFIXED)
                return;
        if (divides(info->fix.ywrapstep, vc->vc_font.height) &&
            divides(vc->vc_font.height, info->var.yres_virtual))
                m = __SCROLL_YWRAP;
        else if (divides(info->fix.ypanstep, vc->vc_font.height) &&
                 info->var.yres_virtual >= info->var.yres + 
vc->vc_font.height)
                m = __SCROLL_YPAN;
        else if (p->scrollmode & __SCROLL_YNOMOVE)
                m = __SCROLL_YREDRAW;
        else*/
                m = __SCROLL_YMOVE;
        p->scrollmode = (p->scrollmode & ~__SCROLL_YMASK) | m;
}

- end Excerpt

So the new driver will work once we patch it to tell fbcon not to be
stupid ;-)

sorry, i'm not sure about setting initial resolution with kernel arguments..

-dte



----- End forwarded message -----
