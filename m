Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUJKE0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUJKE0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 00:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUJKE0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 00:26:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:46292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268683AbUJKE0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 00:26:03 -0400
Date: Sun, 10 Oct 2004 21:25:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <16746.299.189583.506818@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
 <16746.299.189583.506818@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Paul Mackerras wrote:
> 
> Maybe the real problem is that we are trying to use the device suspend
> functions for suspend-to-disk, when we don't really want to change the
> device's power state at all.

An acceptable solution is certainly to instead of passing down "go to D3",
just not do anything at all. HOWEVER, I doubt that is actually all that 
good a solution either: devices quite possibly do want to save state 
and/or set wake-on-events. 

But I don't know. Somebody would need to go through the drivers and verify 
that.

NOTE! I don't mind passing down "D3cold" (aka 4 - same as PM_SUSPEND_DISK)  
in theory. The problem is that the very first machine I ever tested it on
clearly didn't like it and refused to suspend. Maybe I was unlucky, but
the point is, the real solution again requires people to _verify_ that.

See the pattern?

Which is why I suggested making it a separate type that is _not_ a normal 
number. Exactly so that you cannot think it's a PCI state by mistake, when 
clearly drivers _do_ think that. And force people to verify it.

You could do it with "sparse" and "bitwise" types too. Sparse will
complain if you use the type in an inappropriate manner. But the basic
issue remains: there are PCI power states, and there are "suspend" power
states, and they are different. And right now people _are_ confused about
them.

Arguing against that is futile. It's a fact.

I'm more than happy to learn that there are other alternatives to solving
the confusion problem. But quite frankly, arguing for undoing the
translation is just stupid. It's putting your head in the sand and saying
"la-la-laa-I-can't-hear-you".

And until something actually tries to sort _out_ the confusion, the state 
translation stays. Does it put devices into sleep modes when you shouldn't 
need to? Sure. But at least it's not confused about things. 

		Linus
