Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264328AbTCZFXn>; Wed, 26 Mar 2003 00:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264531AbTCZFXn>; Wed, 26 Mar 2003 00:23:43 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:29713 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264328AbTCZFXm>; Wed, 26 Mar 2003 00:23:42 -0500
Date: Wed, 26 Mar 2003 05:34:44 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [BK FBDEV] A few more updates.
In-Reply-To: <1048649746.998.28.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303260519380.12718-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1.  The following lines are missing from softcursor.c, but is present in
> fb_show_logo() where it shoudn't be:
> 
> 	atomic_dec(&info->pixmap.count);
> 	smp_mb__after_atomic_dec();
> 
> In both cases, the reference counting will be incorrect which can cause
> irregular cursor flashing and unnecessary "syncing".  Only functions
> that call fb_get_buffer_offset() need to decrement the reference count
> afterwards.

Fixed. Applied. I missed it when I was applying your patches by hand. My 
tree was way to different to accept your patches. 
 
> 2.  I applied your workqueue patch and changed locking from spinlocks to
> semaphores in fb_get_buffer_offset().

Cool. Needed really bad. Applied.

> 3.  BTW, there are too many kmalloc's/kfree's in accel_cursor() and
> softcursor().  Personally, I would rather have 2 64-byte buffers for the
> mask and the data in the info->cursor structure than allocating/freeing
> memory each time the cursor flashes.  However, if you prefer doing it
> this way, the patch also includes changes so kmallocs are only done when
> necessary.  Still, accel_cursor() has unnecessary work being done, such
> as always creating the mask bitmap, when a simple flag to monitor cursor
> shape changes could prevent all this.

I agree. The problem is the upper layer of the console system is to brain 
dead. Its either erase the cursor or redraw it again. There is no way to 
just say cursor just moved. There is a CM_MOVE but the upper layer doesn't 
even use it :-( If you look at vgacon and friends you will see they 
recreate the cursor every time the cursor blinks. Yes even vgacon.c does 
this. It is stupid and brain dead but that is the way the upper layers of 
the console work. The correct solution would be to use actually use 
CM_MOVE in the upper layers.

> 5.  softcursor should not concern itself with memory bookkeeping, and
> must be able to function with just the parameter passed to it in order
> to keep it as simple as possible.  These tasks are moved to
> accel_cursor.

We do if we make a ioctl for cursors. I'm trying to avoid reprogramming 
the hardware over and over again if the properties of the cursor don't 
change. The idea is similar to passing in var and comparing it to the var 
in struct fb_info. 

> 6.  The patch should also fix the "irregularly dashed" cursor.

Okay.

> PS:  What happened to the logo?  I just get a white square in the uppper left corner.

Strange. It should work. I reworked the logo code anyways. I did this 
because if we have more than one framebuffer in the system, say vesafb and 
vga16fb. We need to select the 16 color logo and a 224 color logo. The 
right logo needs to be draw on the right screen.

