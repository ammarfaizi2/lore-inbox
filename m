Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUBPVvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUBPVvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:51:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:21665 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265911AbUBPVvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:51:03 -0500
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
	 <1076904084.12300.189.camel@gaston>
	 <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076968236.3648.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 08:50:37 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-17 at 04:56, Linus Torvalds wrote:

> The console layer already always calls "unblank_screen()" on any switch to
> text mode, _regardless_ of whether it was switching from another console
> or not. That should be the place where this is done, and perhaps by
> changing the console layer to be a bit more helpful about things (mainly
> re-name the damn thing, since it has nothing to do with "unblank" any
> more).
> 
> "unblank_screen()" is really the same as "reset_screen" - it's also called
> on resume. While "do_blank_screen()" is basically "go away".

That's interesting... I didn't want to do a full mode + engine restore
in unblank_screen though as this can be called from interrupt time by
printk... But then, with the LVDS blanking, I already have to delay
up to 1 second in this function, so .... I think I'll have to find a
way to abstract a delay function that schedules in normal case _but_
when called from printk....

> So why don't you just reset the thing in "con_blank()" that gets called in 
> all the right cases?

Do we want to pay the cost (in time) of a full mode set + engine reset
on each unblank ? I could limit myself to restoring the accel engine,
that faster, but with X also not always restoring the console mode
properly, I'd have preferred re-setting the whole mode... 

Maybe we should go that way for now (engine only in unblank), then try
to fix X for the mode thing (if doable.... there is some VGA magic in
there that I don't understand)

Ben.


