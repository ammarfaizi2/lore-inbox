Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVCID6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVCID6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVCID6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:58:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:39863 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261476AbVCID5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:57:50 -0500
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: xorg@freedesktop.org, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105030819172eecc324@mail.gmail.com>
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
	 <9e47339105030815477d0c7688@mail.gmail.com>
	 <1110326565.32556.7.camel@gaston>
	 <9e47339105030819172eecc324@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 14:53:18 +1100
Message-Id: <1110340398.32557.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 22:17 -0500, Jon Smirl wrote:
> How do I do the 'disable all, post, renable last active' sequence in
> this scheme?

You don't do it that way. You vga_get(IO|MEM) the card you want to
POST, do the POST, then vga_put().

Subsequent user will get back ownership when it does vga_get(something)
again.

BTW. I have a draft of the userland API. It will be a /dev entry (so
other OSes can implement the same API, also, it's just doing too much
for sysfs, I debated it with a few kernel folks and we decided it should
be that way) :

 *  open	: open user instance of the arbitrer. by default, it's
 *                attached to the default VGA device of the system.
 *
 *  close	: close user instance, release locks
 *
 *  read	: return a string indicating the status of the target.
 *                an IO state string is of the form {mem,io,mem+io,none},
 *                mc and ic are respectively mem and io lock counts (for
 *                debugging/diagnostic only). "decodes" indicate what the
 *                card currently decodes, "owns" indicates what is currently
 *                enabled on it, and "locks" indicates what is locked by this
 *                card.
 *
 *   "<card_ID>:decodes=<io_state>,owns=<io_state>,locks=<io_state> (mc,ic)"
 *
 * write	: write a command to the arbiter. List of commands is:
 *
 *   target <card_ID>   : switch target to card <card_ID> (see below)
 *   lock <io_state>    : acquires locks on target ("none" is invalid io_state)
 *   trylock <io_state> : non-blocking acquire locks on target
 *   unlock <io_state>  : release locks on target
 *   decodes <io_state> : set the legacy decoding attributes for the card
 * 
 * poll         : event if something change on any card (not just the target)


I also added nesting counters (mostly to make things safer, though it could
be useful for scenarios where IRQ stuffs are doing a tryget kind of thing
as described in a previous message).

Ben.


