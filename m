Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUIKJVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUIKJVu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 05:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUIKJUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 05:20:53 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:42683 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268000AbUIKJUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 05:20:47 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Dave Airlie <airlied@linux.ie>,
       Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: radeon-pre-2
Date: Sat, 11 Sep 2004 17:20:38 +0800
User-Agent: KMail/1.5.4
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?iso-8859-1?q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> <1094873412.4838.49.camel@admin.tel.thor.asgaard.local> <Pine.LNX.4.58.0409110600120.26651@skynet>
In-Reply-To: <Pine.LNX.4.58.0409110600120.26651@skynet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111720.38477.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 September 2004 13:19, Dave Airlie wrote:
> The other thing I think some people are confusing is 2.4 fbdev and 2.6...
> there is no console support in 2.6 fbdev drivers, it is all in the fbcon
> stuff, so the fbdev drivers are only doing 2d mode setting and monitor
> detection, some points I've considered are:

Correct.  fbdev is almost completely separate from fbcon. And you can
actually rip out fbdev and place it anywhere you want. As long as fbcon has
access to a pointer to framebuffer memory, and the characteristics of the
display such as depth, pitch, etc, then the framebuffer console will work.
Throw in a few functions, such as for buffer flipping, and fbcon will be happy. 

Hardware acceleration is entirely optional, and most drivers except for a few
(such as vga16fb or amiga) can use the cfb_* drawing functions.

There's also a recent change in the latest bk tree that changes the
intialization order of the framebuffer system. Previously, fbcon triggers
fbmem, then fbmem triggers each individual drivers.  This method requires
that a working fbdev is present, otherwise fbcon will fail (although you can
do a con2fbmap later, or modprobe a driver). With the change, the
order is reversed, driver->fbmem->fbcon.  This change is probably
significant because fbcon can wait until an active framebuffer activates.

In theory, one can have a process (kernel or userland) change the video
mode, then provide the in-kernel driver with the necessary information
about the layout of the framebuffer.  When this in-kernel driver gets the
necessary information, it can trigger fbcon. This in-kernel driver need not
know anything about the hardware (unless 2D acceleration is needed).

Tony


