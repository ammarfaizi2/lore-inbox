Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUIKQsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUIKQsl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUIKQsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:48:40 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:59093 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268207AbUIKQqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:46:17 -0400
Message-ID: <9e47339104091109463694ffd3@mail.gmail.com>
Date: Sat, 11 Sep 2004 12:46:13 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Cc: Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1094913222.21157.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
	 <1094913222.21157.61.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 15:33:43 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> For example I can see the radeon DRM driver providing
> 
>         ->queue_commands()
>         ->quiesce()
> 
> to the 2D driver. And the 2D driver providing
> 
>         ->define_fb_layout()  for DRI to provide to X
> 
> That way it is only these calls between drivers you and the fb authors
> have to argue about the functionality and interfaces between. (eg who
> saves registers, which registers)
> 

Take a system with two simultaneous users on two heads of a dual head
card. The kernel will be process swapping between these two users as
needed.

User 1 is playing a 3D game. 
User 2 is editing with emacs on fbdev

User 1's game queues up 20ms of 3D drawing commands.
Process swap to user 2.  ->quiesce() is going to take 20ms. 
User 2's timeslice expires and we go back to user 1.
User 1 queues up another 20ms.

User 2's editor is never going to function.

The correct solution is to leave the chip in 3D mode and merge DMA
command streams. User 2 wouldn't have problems if it's console driver
queued 3D commands instead of stopping the 3D coprocessor, changing
the chip mode, executing a host based 2D command, and then restarting
the coprocessor.

-- 
Jon Smirl
jonsmirl@gmail.com
