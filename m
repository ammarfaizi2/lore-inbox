Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUA0N4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 08:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUA0N4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 08:56:43 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:15878 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263598AbUA0N4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 08:56:42 -0500
Date: Tue, 27 Jan 2004 14:56:06 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       stern@rowland.harvard.edu, greg@kroah.com, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <20040127175104.48bd8664.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.58.0401271142510.7855@serv>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>
 <Pine.LNX.4.58.0401251054340.18932@home.osdl.org>
 <20040125202136.GR21151@parcelfarce.linux.theplanet.co.uk>
 <20040127175104.48bd8664.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Jan 2004, Rusty Russell wrote:

> viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> > Basically, "protect the module" is wrong - it should be "protect specific
> > object" and we need that anyway.
>
> Agreed.  You're oversimplifying a little, though.
>
> In this model, the object here is the function text.  So if you hand out
> a pointer to the function text, you need to hold a refcount.
>
> BUT since the module itself is the only one which can hand these out,
> and it unregisters everything it has registered, and all those references
> fall to zero, it's trivial to prove that there are no more references to
> the module functions.

There is a very simple rule: If two or more objects have the same
lifetime, they all only need to be protected once.
So if you have two static objects (e.g. a static structure with a
reference to a function), the module count is indeed enough to protect
both objects. The problem starts when you mix dynamic and static objects,
then the module count is not enough anymore and you have to use proper
refcounts, but the generic module code currently has no decent way to get
to that information, so we have to maintain the module count additionally
to the refcount. Now we only have to find a way to utilize the object
protection to also protect the module it refers to and you can get rid of
the module count.
Rusty, you need to get away from this idea, that every single function
pointer must be protected by itself, it can also be protected via another
object, the real problem is that the generic module code doesn't know
anything about this. Fixing this requires changing every single module,
but in the end it would be worth it, as it avoids the duplicated
protection and we had decent module unload semantics.

bye, Roman
