Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRCLQmB>; Mon, 12 Mar 2001 11:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbRCLQlv>; Mon, 12 Mar 2001 11:41:51 -0500
Received: from harrier.prod.itd.earthlink.net ([207.217.121.12]:11503 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130253AbRCLQld>; Mon, 12 Mar 2001 11:41:33 -0500
Date: Mon, 12 Mar 2001 00:42:11 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev cursor management 
Message-ID: <Pine.LNX.4.31.0103120034300.1143-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Guys,
>
>I've been taking a look at the cursor flashing code,
>from the point of view of how it's affected by the
>recent enabling of interrupts across the console code.

I see the problems. I just pursposed a new cursor api soe we can have a
clean fbdev to fbcon abstraction. Also we really need to move the curent
cursor code in fbcon.c:fbcon_startup. They really belong in their
respected drivers.

>It all happens in timer handlers and interrupt handlers,
>with no protection against mainline code accessing the
>hardware simultaneously.

Many drivers use spinlocks to manage access.

>- Collapse all the various per-driver cursor flashing
>  routines into a single place - manage the timer from
>  drivers/video/fbcon.c and from there, call into the
>  driver layer if requested.

fbcon_cursor :-)

> The only way we have of doing this at present is to call
> schedule_task() from within the timer handler.  This works
> fine, but it complicates the device close and module unload
> problem somewhat.  del_timer_sync + flush_scheduled_tasks
> will be needed in the right places.

Yuck!!! I see this also a problem for VBL dependent drivers. Some
drivers to require you sync with the VBL to do things like change
the color map. Worst some of these drivers require you poll a bit
to see if the VBL occured.

[snip] rivafb problems. These will be fixed now they are pointed out.


MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

