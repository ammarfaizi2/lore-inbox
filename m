Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268484AbUHYHU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbUHYHU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbUHYHU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:20:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:21128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268484AbUHYHUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:20:53 -0400
Date: Wed, 25 Aug 2004 00:20:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
In-Reply-To: <1093417267.2170.47.camel@gaston>
Message-ID: <Pine.LNX.4.58.0408250015420.17766@ppc970.osdl.org>
References: <412AD123.8050605@jp.fujitsu.com>  <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org>
 <1093417267.2170.47.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Aug 2004, Benjamin Herrenschmidt wrote:
>
> Well, I'm not sure about all this... part of the problem is that drivers
> commonly need to also do IOs from interrupts. And another driver may
> "pollute" us too, depending on how the HW & bridge are designed. So we
> really also want to disable interrupts, we may need a "flags" around (could
> be burried into the cookie stuff though as an arch specific thing)

Good point. I believe you _do_ end up having to do that, like it or not.

Because if you don't lock the bridge (or whatever the entity is that keeps 
track of errors), the whole exercise is kind of pointless. If two drivers 
try to do error checking at the same time, and will potentially clear the 
errors of each other, causing the errors to get lost, the whole recovery 
infrastructure is clearly worthless.

> Most drivers already have such a low level lock though, so we may end
> up replacing it with a bridge-based lock... but depending on the architecture,
> that would end up sync'ing lots of drivers on the same lock, which may not
> be good especially if we have no checking to do... 

Some serialization will happen. Inevitable. See above.

The "good news" is that I doubt very many drivers will care enough to do
this. I suspect you'll only have a few very specific drivers used in 
fault-tolerant circumstances, where you care more about the errors than 
about the inevitable serialization.

> I don't know what is the best thing to do here... The arch is the one to
> know what is the granularity of the error management (per slot ? per segment
> or per domain ?) and so to know what kind of lock is needed...

It will have to depend on the bus setup. Not arch-specific per se, but 
clearly specific to the bus controllers in question. 

		Linus
