Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbTICNb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTICNb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:31:28 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:55263 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262167AbTICNbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:31:25 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@suse.cz>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <1062594137.19058.23.camel@dhcp23.swansea.linux.org.uk>
References: <20030831232812.GA129@elf.ucw.cz>
	 <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org>
	 <20030901211220.GD342@elf.ucw.cz>
	 <20030901225243.D22682@flint.arm.linux.org.uk>
	 <20030901221920.GE342@elf.ucw.cz>
	 <20030901233023.F22682@flint.arm.linux.org.uk>
	 <1062498096.757.45.camel@gaston>
	 <1062594137.19058.23.camel@dhcp23.swansea.linux.org.uk>
Message-Id: <1062595873.1785.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 15:31:14 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Fix up power managment in 2.6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 15:02, Alan Cox wrote:
> On Maw, 2003-09-02 at 11:21, Benjamin Herrenschmidt wrote:
> > The whole point was to get rid of the old 2 step save_state, then
> > suspend model which didn't make sense. A saved state is only meaningful
> > as long as that state doesn't get modified afterward, so saving state
> > and suspending are an atomic operation.
> 
> Very old myth. In fact just about every scheduler on the planet exploits
> the fact this is untrue.
> 
> 		save state
> 		continue running doing scheduler stuff
> 		restore other state losing the state in the middle we dont need
> 
> Ditto with a lot of I/O devices. My audio save state and suspend can be
> seperated - I might play a little bit of a song twice but is that a bug

It is in lots of case with IO. Especially if your state don't match
between different devices that rely on each other (parent/child
typically), or if some of that state information matches something
persistent on the HW (devices don't necessarily get fully powered
off during suspend).

Note that in most case, there isn't really a notion of "state" to
store or save anyway, that is "state" is just whatever is in your
net_device structure for a network driver, or whatever private
structure in your whatever-other driver, so you just have to restore
a couple of things on wakeup, but really nothing to save on suspend.

The single callback is much simpler, and will avoid lots of mistakes
imho.

Ben.


