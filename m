Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTBSQyw>; Wed, 19 Feb 2003 11:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268470AbTBSQyw>; Wed, 19 Feb 2003 11:54:52 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:3033 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261368AbTBSQyw>;
	Wed, 19 Feb 2003 11:54:52 -0500
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302190853180.18995-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302190853180.18995-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045674387.12533.48.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Feb 2003 18:06:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 17:56, Linus Torvalds wrote:

> We've seen that before: try unplugging a PCMCIA IDE card unexpectedly. 
> 
> Guess what? It will start returning 0xff. And the machine dies, because 
> the PCMCIA interrupt happened due to the removal event will also be shared 
> by the IDE driver, so the IDE driver will react badly even before anybody 
> has had a chance to tell it that the hardware no longer exists.
> 
> So if you have code that doesn't work with 0xff, then that code is already 
> a-priori buggy. And getting it fixed would be a damn good idea.

Yup, you are right. Removing a disk from a controller shall return
anything with bit 7 at 0 per spec, but removing the controller
itself will return 0xff. Actually, in my "wait for BSY low" loop
I added to the probe code for pmac (should be made generic sooner
or later), I did special case 0xff.

So we should indeed fix the various bits in IDE. 0xff out of
status, I beleive, never means anything and can always be considered
as "this interface is gone".
 
Ben.

