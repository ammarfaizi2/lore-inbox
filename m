Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268193AbUIKPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268193AbUIKPhe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268186AbUIKPgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:36:43 -0400
Received: from the-village.bc.nu ([81.2.110.252]:23219 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268179AbUIKPgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:36:07 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409110600120.26651@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094913222.21157.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 15:33:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 06:19, Dave Airlie wrote:
> 1. It doesn't matter where the code lives, fbdev/DRM need to start talking
> about things

It matters immensely what the divison is because people talking doesn't
scale ..

> I'm interested in seeing what Alan comes up with, even in a non-working
> form .. I much prefer the evolution of these things than complete new
> solutions... but I also think linking the fb and drm code together will
> remove alot of the headaches and result in a more maintainable system
> longterm, even if shortterm there are some ugly hacks..

What I'm trying to end up with is this

	drv.type = TYPE_FB0;	/* Head 0 */
	/* Rest much like PCI */
	vga_register_driver(&drv)

	drv.type = TYPE_DRI;
	vga_register_driver(&drv)

all working like the PCI API, so you get add/remove notifications, you
also don't need to modify the video and DRI drivers much. Unlike the
pci_register it allows multiple claims for each device (one memory
manager, one dri driver, up to four "heads" for now - multihead needs
more pondering perhaps)

Each of these gets notified when the others are added/removed and can
veto such an add or remove. They can also provide whatever methods it
turns out are appropriate to each other for co-ordination.

For example I can see the radeon DRM driver providing

	->queue_commands()
	->quiesce()

to the 2D driver. And the 2D driver providing

	->define_fb_layout()  for DRI to provide to X

That way it is only these calls between drivers you and the fb authors
have to argue about the functionality and interfaces between. (eg who
saves registers, which registers)

Alan



