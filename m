Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWHGNNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWHGNNs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWHGNNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:13:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:32648 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750814AbWHGNNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:13:48 -0400
Subject: Re: [PATCH] amd74xx: implement suspend-to-ram
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jason Lunz <lunz@falooley.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <1154116826.13509.160.camel@localhost.localdomain>
References: <200607281646.31207.rjw@sisk.pl>
	 <1154105517.13509.153.camel@localhost.localdomain>
	 <20060728171357.GB17549@knob.reflex>
	 <1154116826.13509.160.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 09:18:26 +0200
Message-Id: <1154416706.21801.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 21:00 +0100, Alan Cox wrote:
> Ar Gwe, 2006-07-28 am 13:13 -0400, ysgrifennodd Jason Lunz:
> > OK, I'll see about moving it there. Will this still be
> > controller-specific, or are you suggesting this is something ide ought
> > to do globally?
> 
> It should be done globally. In many cases the chips start up from power
> on configured for PIO 0 so that side happens to work, but not all chips
> do this as you've found out. Setting the PIO side correctly is a fix
> even if its not a bug people hit a lot.

It's actually incorrect to just "restore" the previous timings. In many
case, the disk will have been reset too. The safe thing is to force the
controller in PIO0 mode at resume, and the best place to do that is from
the controller's own resume(), as I do on pmac. It's the parent of the
hwif and thus will be resumed before the later.

Later on, the state machine will redo the tuning to get to a better
speed, including sending the right commands to also reconfigure the
drive.

Ben.


