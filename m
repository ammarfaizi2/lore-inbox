Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWHBO5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWHBO5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWHBO5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:57:05 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7808 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750998AbWHBO5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:57:04 -0400
Message-Id: <200608021456.k72EujBt007376@laptop13.inf.utfsm.cl>
To: Chase Venters <chase.venters@clientec.com>
cc: Amit Gud <agud@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] sysctl for the latecomers 
In-Reply-To: Message from Chase Venters <chase.venters@clientec.com> 
   of "Tue, 01 Aug 2006 12:22:22 EST." <Pine.LNX.4.64.0608011213190.12077@turbotaz.ourhouse> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Wed, 02 Aug 2006 10:56:45 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 02 Aug 2006 10:56:46 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters <chase.venters@clientec.com> wrote:
> On Tue, 1 Aug 2006, Chase Venters wrote:
> > On Tue, 1 Aug 2006, Amit Gud wrote:
> >>  /etc/sysctl.conf values are of no use to kernel modules that are inserted
> >>  after init scripts call sysctl for the values in /etc/sysctl.conf
> >>
> >>  For modules to use the values stored in the file /etc/sysctl.conf, sysctl
> >>  kernel code can keep record of 'limited' values, for sysctl entries which
> >>  haven't been registered yet. During registration, sysctl code can check
> >>  against the stored values and call the appropriate strategy and
> >>  proc_handler routines if a match is found.
> >>
> >> Attached patch does just that. This patch is NOT tested and is just to
> >> get opinions, if something like this is a right way of addressing this
> >> problem.

> > Do you anticipate any users that you could list? It seems like a
> > more appropriate approach would be to allow some kind of user-space
> > hook or event notification to run upon module insertion, which could
> > then apply the appropriate sysctl.

> Btw, wanted to add some comments on the specific approach:
> 
> 1. A ring hard-coded to 32 elements is IMO unuseable. While it may not
> be a real limit for what use case you have in mind, if it's in the
> kernel sooner or later someone else is going to use it and get
> bitten. Imagine if they wrote in 33 entries, and the first one was
> some critical security setting that ended up getting silently
> ignored...

Right.

> 2. On the other hand, allowing it to grow unbounded is equally
> unacceptable without a mechanism to list and clear the current
> "pending" sysctl values. Unfortunately, at this point, you're starting
> to violate "KISS".

Yep.

> Are the modules you refer to inserted during init at all? Because it
> seems like it would be a lot more appropriate to just move sysctl
> until after loading the modules, or perhaps running it again once they
> are loaded.

OK, lets step back a bit... sysctl(8) can be used to load other values, or
to change them, etc. Whatever is in sysctl.conf is just /default/ values,
/typically/ set on boot. You could let the initscripts set those, then
fiddle them by hand. If a module is now inserted, you can't just reset the
values to the ones in the file.

Perhaps module-specific values should be set in the configuration for the
module itself (i.e., arguments) or add to modprobe.conf something along
the lines:

  sysctl mymod kernel.mystuff=42

and have modprobe(8) run sysctl(8) as needed after loading the module? 
Sounds more KISSy to me...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
