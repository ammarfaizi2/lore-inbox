Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWDLRSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWDLRSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWDLRSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:18:51 -0400
Received: from ns1.idleaire.net ([65.220.16.2]:63172 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S932259AbWDLRSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:18:50 -0400
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
From: Dave Dillow <dave@thedillows.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <200604121155.55561.vda@ilport.com.ua>
References: <200604071628.30486.vda@ilport.com.ua>
	 <200604111028.54813.vda@ilport.com.ua>
	 <1144763984.16193.9.camel@dillow.idleaire.com>
	 <200604121155.55561.vda@ilport.com.ua>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 13:18:45 -0400
Message-Id: <1144862325.18319.32.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2006 17:18:12.0822 (UTC) FILETIME=[140C4F60:01C65E55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 11:55 +0300, Denis Vlasenko wrote:
> On Tuesday 11 April 2006 16:59, Dave Dillow wrote:
> > DaveM beat me to it, but as he said, it saves 5K only if you have all
> > the drivers built in
> 
> I have most of network drivers built in.
> I want network card to work right away in early boot,
> and I prefer to not regenerate initrd with new nic modules for
> each new kernel which I build for diskless stations.

Do you really intend to say that you are the common case, and that this
5K really matters? I'm all for removing bloat, but not without looking
at the real savings vs the cost.

> > or loaded. And even if it saves 200 bytes in one 
> > module, unless that module text was already less than 200 bytes into a
> > page, you've saved no memory -- a 4300 byte module takes 2 pages on x86,
> > as does a 4100 byte module.
> 
> Sometimes, those 200 bytes can bring module size just under 4096.
> Thus on the average, on many modules you get the same size savings
> as on built-in code. (Not that we have THAT many network modules...)

You're making a bogus leap from "sometimes" to "average".

Assuming an even distribution of lengths mod 4096, less than 5% of the
time will 200 bytes save any memory on a module.

Since we're both making big assumptions, only real numbers from built
modules would be convincing.

> > NAK. The #ifdefs are ugly, for no significant gain.
> > 
> > And you introduced a race condition when you moved the spin_locks. The
> > test for tp->vlgrp is no longer protected.
> 
> See attached. Much less #ifdefs (most of the time I test for compile time
> constant VLAN_ENABLED in the if()s instead), the race is fixed.

Testing for VLAN_ENABLED in an if statement is better than the ifdefs, I
agree, but I still find it ugly. Probably not ugly enough to argue about
it any more.

I don't like "VLAN_ENABLED" as a global define -- it looks too much like
something local. The CONFIG_VLAN... defines were more descriptive.

I didn't think about this before, but I'm pretty sure you're taking away
functionality. When I wrote the typhoon driver, ISTR that I looked
through the vlan implantation, and determined that all the #ifdefs on
CONFIG_VLAN_8021Q were not really needed, since all the hooks were
there. You could just load the 8021q module (even perhaps building it at
a later date), and it would work if you had filled in the hooks in
struct net_device. So I didn't #ifdef out code in my driver to let the
user have the option.

You're taking that away in the name of a total of 5K, which most users
won't actually get back?
-- 
Dave Dillow <dave@thedillows.org>

