Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUIKQe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUIKQe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUIKQe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:34:57 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:13959 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268191AbUIKQex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:34:53 -0400
Message-ID: <9e473391040911093432781819@mail.gmail.com>
Date: Sat, 11 Sep 2004 12:34:52 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: adaplas@pol.net
Subject: Re: radeon-pre-2
Cc: Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200409111720.38477.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
	 <200409111720.38477.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 17:20:38 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> On Saturday 11 September 2004 13:19, Dave Airlie wrote:
> > The other thing I think some people are confusing is 2.4 fbdev and 2.6...
> > there is no console support in 2.6 fbdev drivers, it is all in the fbcon
> > stuff, so the fbdev drivers are only doing 2d mode setting and monitor
> > detection, some points I've considered are:
> 
> Correct.  fbdev is almost completely separate from fbcon. And you can
> actually rip out fbdev and place it anywhere you want. As long as fbcon has
> access to a pointer to framebuffer memory, and the characteristics of the
> display such as depth, pitch, etc, then the framebuffer console will work.
> Throw in a few functions, such as for buffer flipping, and fbcon will be happy.

The intention of the DRM work is to reuse fbcon without change if
possible or minimize the changes needed.

> Hardware acceleration is entirely optional, and most drivers except for a few
> (such as vga16fb or amiga) can use the cfb_* drawing functions.

No code has been written for this, but part of the plan is to split
the console function into two pieces: boot and user. The boot console
would be non-accelerated and use fbcon for drawing. It's goal is to be
as reliable as possible and to work in all environments including
interrupt time. Booting in single user mode would use boot console. So
would OOPs and initial boot.

Another major console use is for normal users doing things like
editing and command line stuff. This console would be implemented in
user space. User space console can call into DRM and achieve full
acceleration. This would also allow consoles in Asian and Indic
languages.

> There's also a recent change in the latest bk tree that changes the
> intialization order of the framebuffer system. Previously, fbcon triggers
> fbmem, then fbmem triggers each individual drivers.  This method requires
> that a working fbdev is present, otherwise fbcon will fail (although you can
> do a con2fbmap later, or modprobe a driver). With the change, the
> order is reversed, driver->fbmem->fbcon.  This change is probably
> significant because fbcon can wait until an active framebuffer activates.
> 
> In theory, one can have a process (kernel or userland) change the video
> mode, then provide the in-kernel driver with the necessary information
> about the layout of the framebuffer.  When this in-kernel driver gets the
> necessary information, it can trigger fbcon. This in-kernel driver need not
> know anything about the hardware (unless 2D acceleration is needed).

The plan for mode setting is to move as much as possible of it to user
space via a hotplug event. The driver would then be informed of the
information it needs like framebuffer location, dimensions, mode
register values, etc.

> 
> Tony
> 
> 



-- 
Jon Smirl
jonsmirl@gmail.com
