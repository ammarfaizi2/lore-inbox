Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVCIIJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVCIIJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 03:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVCIIJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 03:09:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:15803 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261383AbVCIIIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 03:08:45 -0500
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Egbert Eich <eich@freedesktop.org>, Jon Smirl <jonsmirl@yahoo.com>,
       xorg@freedesktop.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1110348041.32524.60.camel@gaston>
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
	 <9e47339105030815477d0c7688@mail.gmail.com>
	 <1110326565.32556.7.camel@gaston>
	 <9e47339105030819172eecc324@mail.gmail.com>
	 <1110340398.32557.36.camel@gaston>
	 <9e4733910503082035318e9d23@mail.gmail.com>
	 <1110346634.32556.54.camel@gaston>
	 <9e4733910503082158c95c904@mail.gmail.com>
	 <1110348041.32524.60.camel@gaston>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 19:04:01 +1100
Message-Id: <1110355442.32524.97.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's today status. I posted the patch at
http://gate.crashing.org/~benh/vga-arbiter.diff. I fixed some issues &
added support for nesting locks, I added comments/documentation to
kernel interface. It's not tested yet. It's not complete neither, the
userland interface is partially implemented (via a /dev char device),
and I may still change things here or there before I'm happy with the
result. Constructive comments appreciated.

What need to be done also is to adapt vgacon.

The problems here are multiple. vgacon itself has all the consw
callbacks that need to be dealt with. A bunch of them can't schedule,
so they would have to use vga_tryget(). What to do if that fails ?
Another problem is that the VT code will directly access the
text/attribute buffer (VGA memory). Playing tricks here promises to
be difficult. Some bits of that code even keep pointers to video
memory as local statics (look at complement_pos(), that stuff is
probably interestingly broken during the vgacon->fbcon transition)

So I suspect here a minimum of rework is needed, in a rather disgusting
area of the code.

I suppose the easiest way for now is to move the vga_trylock() as much
up as possible in the call chain. The stuff in vc_screen() (userland
context, can schedule) would use vga_get(), same with the tty operations
(they acquire the console sem, so they are a big no-no at interrupt
time, but we need to do runtime checks since weird things may happen in
tty land).

The problem is how to have that code "know" that it needs to lock VGA
resources. It will be different between vgacon, fbcon, or whatever other
low level console. Some hacks may be needed here, at least until we have
a "sane" console subsystem if we ever have ... I'll have a deeper look
tomorrow.

Ben.


