Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264688AbTE1Lc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbTE1Lc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:32:58 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:8151 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264688AbTE1Lc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:32:57 -0400
Subject: Console & FBDev vs. locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054122360.602.197.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 May 2003 13:46:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

While working on various power management issues with fbdev, I noticed
that there's an almost complete lack of locking in there and I've
spotted several races. Some of them seem to be present at the vt
subsystem level as well. Unless I've missed something, what we have
today is:

All printk originated console call should done with the console
semaphore held. The console-sem is the de-facto locking mecanism for the
console today, while not fine-grained, it's probably plenty enough for
what we need in 2.5 and unless previous implementations which ran with
irqs off, the console drivers can actually block and rely on HW
interrupts.

However, the following (at least), break the rule and call the console
driver in a racy way:

 - Most of vt_ioctl.c userland calls. Things like KDSETMODE for example
can end up into a call to unblank_screen() -> redraw_screen()

 - Console blanking/unblanking: worst, that one is called at interrupt
time from a timer

 - In fbcon: all of the cursor handling (fortunately, _at least_, it's
no longer calling the driver at interrupt time).

 - Any userland access to fbcon via ioctls, that is mode change for
example, which can be a tricky task and leave the card in some unuseable
state until the mode change is complete, do race with anything else.

I can produce a patch fixing as much of these as I can find if you agree
that is the correct way, that is adding acquire_console_sem() in places
where it belongs, that is almost every of the above, except for the
blanking timer which has to be deferred to process context.

Any comments ?

Regards,
Ben.

