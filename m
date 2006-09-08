Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWIHWmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWIHWmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWIHWmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:42:20 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:33035 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S1751225AbWIHWmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:42:18 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Subject: Re: TG3 data corruption (TSO ?)
From: "Michael Chan" <mchan@broadcom.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       "Segher Boessenkool" <segher@kernel.crashing.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Paul Mackerras" <paulus@samba.org>,
       "Anton Blanchard" <anton@samba.org>
In-Reply-To: <1157754326.31071.115.camel@localhost.localdomain>
References: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
 <1157751689.31071.97.camel@localhost.localdomain>
 <1157753242.9584.4.camel@rh4>
 <1157754326.31071.115.camel@localhost.localdomain>
Date: Fri, 08 Sep 2006 15:40:20 -0700
Message-ID: <1157755220.9584.21.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006090808; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230342E34353031463033332E303033412D422D306A7671374D75736C6841666147687761704E7344673D3D;
 ENG=IBF; TS=20060908224211; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006090808_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 691F2E483CC5772810-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 08:25 +1000, Benjamin Herrenschmidt wrote:
> Ok. I'm trying to figure out what's the best way with fixing that. I can
> see the flamewar coming on wether stores to memory vs. writel shall be
> ordered or not :)
> 
> I'm very reluctant to add another sync instruction to our writel though.
> It needs one already after the stores to prevent leaking out of
> spinlocks (and thus possible mmio vs. mmio order issues on SMP with
> stores from different CPUs being re-ordered). Fixing the above would
> require one before the store as well. We already pay a pretty high price
> for that sync, having 2 would be a real shame.
> 
> (Unfortunately, there is no cheap barrier available for ordering
> cacheable vs. non cacheable storage on PowerPC, they are completely
> separate domains).
> 
> One option I was discussing with others would be to drop that sync after
> the store, and instead start requiring drivers to use mmiowb() (as
> defined by the ia64 folks) to provide ordering of writel's vs. locks.
> But that probably means breaking and then having to fix a while bunch of
> drivers in the tree who haven't been updated to use it...
> 
> I'd rather not have to do that, or even if I go that way, not have to
> add that sync at all before the store and thus get back the few percent
> of perfs lost due to those sync's on some heavy IO benchmarks.
> 
Another way to fix this without requiring drivers to add all kinds of
barriers in the driver code is to add a writel_sync() variant.  So on
powerpc, writel_sync() will have a sync before and after the write.  On
most other architectures, writel_sync() is the same as writel() if the
ordering is guaranteed.  We'll then convert tg3 and other drivers to use
writel_sync() in places where they're needed.

