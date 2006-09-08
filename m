Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWIHWZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWIHWZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWIHWZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:25:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:52361 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751172AbWIHWZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:25:46 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Chan <mchan@broadcom.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
In-Reply-To: <1157753242.9584.4.camel@rh4>
References: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
	 <1157751689.31071.97.camel@localhost.localdomain>
	 <1157753242.9584.4.camel@rh4>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 08:25:26 +1000
Message-Id: <1157754326.31071.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 15:07 -0700, Michael Chan wrote:
> On Sat, 2006-09-09 at 07:41 +1000, Benjamin Herrenschmidt wrote:
> 
> > As for the tcpdump output, well, I have a 3Gb file for now :) I need to do a bit of surgery on it to
> > get only the interesting part. I'll try to do that later today (but it may have to wait for monday).
> > 
> Ben, We probably don't need the tcpdump anymore now that we know it's a
> memory ordering issue.

Ok. I'm trying to figure out what's the best way with fixing that. I can
see the flamewar coming on wether stores to memory vs. writel shall be
ordered or not :)

I'm very reluctant to add another sync instruction to our writel though.
It needs one already after the stores to prevent leaking out of
spinlocks (and thus possible mmio vs. mmio order issues on SMP with
stores from different CPUs being re-ordered). Fixing the above would
require one before the store as well. We already pay a pretty high price
for that sync, having 2 would be a real shame.

(Unfortunately, there is no cheap barrier available for ordering
cacheable vs. non cacheable storage on PowerPC, they are completely
separate domains).

One option I was discussing with others would be to drop that sync after
the store, and instead start requiring drivers to use mmiowb() (as
defined by the ia64 folks) to provide ordering of writel's vs. locks.
But that probably means breaking and then having to fix a while bunch of
drivers in the tree who haven't been updated to use it...

I'd rather not have to do that, or even if I go that way, not have to
add that sync at all before the store and thus get back the few percent
of perfs lost due to those sync's on some heavy IO benchmarks.

Ben.


