Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTJYVte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTJYVte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:49:34 -0400
Received: from griffin-can-au.getin2net.com ([203.43.225.34]:19716 "EHLO
	griffin-can-au.getin2net.com") by vger.kernel.org with ESMTP
	id S263056AbTJYVtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:49:31 -0400
Subject: Re: [PATCH][2.6-mm] radeonfb as module
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: James Simmons <jsimmons@infradead.org>
Cc: Svetoslav Slavtchev <svetljo@gmx.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310211828021.32738-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0310211828021.32738-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067118401.3576.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 25 Oct 2003 23:49:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 19:28, James Simmons wrote:
> > acquire_console_sem is exported, 
> > but release_console_sem is not
> > 
> > this seems like a bug for me,
> > as if one acquire console_sem, he should be able to relase it
> 
> 
> True that release_console_sem should be exported as well. But that lock 
> shouldn't be in a driver. In fbcon.c yes but not the driver. My next pacth 
> will fix that.

Well... please leave it the way I did it for now. There are subtle
races if you don't do. In a more general manner, there are a lot of
races in fbdev regarding lack of console_sem. For example, we should
take it on any mode change ioctl etc...

The problem is that, except for eventual local spinlocks, the console
sem is the only way to protect the low level drivers against concurrent
accesses, and those _do_ need some protection or you can have
accelerated printk racing against a mode change for example, etc...

It's even worse if mode change can sleep. Some updates to fbdev I'm
currently working on will require the ability to sleep from the
set_par() function. I would even to sleep in blank(), but that's
not possible, I think, at the moment (isn't it called by a timer
in the console code ?) so I'm doing something more complicated
using timers.

So almost all calls to the fbdev should be done with the console
sem held (even blank imho, if you can't get it using a trylock,
delay it by firing the timer).

Regarding the fb_client callbacks, to avoid lock nesting, I decided
the only sane way is to have the _caller_ take the console sem.
That's important as those can be called from things like set_par()
which will (if the above is fixed properly) be called with the
console sem already held. So the act of taking the console sem should
be moved up the chain as much as possible. In the case of calls issued
from outside the fbdev world, like PM callbacks, the driver can only
take the console sem itself to protect against concurrent set_par
among others.

Now, if you want to "hide" the console sem, maybe export an fbdev_lock/
unlock API whose implementation takes the console sem... That would
allow maybe to move to a per-fbdev locking in the future provided we
can deal with the "printk" problem (that is deferring actual display
while still letting fbcon draw into the console buffer).

Ben.

