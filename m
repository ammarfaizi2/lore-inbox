Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVK3LAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVK3LAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 06:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVK3LAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 06:00:06 -0500
Received: from petaflop.b.gz.ru ([217.67.124.5]:46752 "EHLO hq.sectorb.msk.ru")
	by vger.kernel.org with ESMTP id S1750997AbVK3LAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 06:00:04 -0500
Date: Wed, 30 Nov 2005 13:59:52 +0300
From: "Alexander V. Inyukhin" <shurick@sectorb.msk.ru>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.15-rc1, soft lockup detected while probing IDE devices on AMD7441
Message-ID: <20051130105952.GA14641@shurick.s2s.msu.ru>
References: <20051120204656.GA17242@shurick.s2s.msu.ru> <20051120172915.31754054.akpm@osdl.org> <1132605524.11842.38.camel@localhost.localdomain> <200511232017.52788.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511232017.52788.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 08:17:51PM +0100, Jesper Juhl wrote:
> On Monday 21 November 2005 21:38, Alan Cox wrote:
> > On Sul, 2005-11-20 at 17:29 -0800, Andrew Morton wrote:
> > > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > > Quite normal. The old IDE probe code takes a long time and it makes the
> > > > soft lockup code believe a lockup occurred - rememeber its a debugging
> > > > tool not a 100% reliable detector of failures.
> > > 
> > > We could put a touch_softlockup_watchdog() in there.
> > 
> > Would make sense. Spin up and probe can take over 30 seconds worst case
> > and is polled in the IDE world. The loop will eventually exit and a true
> > lockup caused by a stuck IORDY line will hang forever in an inb/outb so
> > neither softlockup or even nmi lockup would save you.
> 
> How about something like the patch below?
> 
> The  if (!(timeout % 128))  bit is a guess that since 
> touch_softlockup_watchdog() is a per_cpu thing it will be cheaper to do the
> modulo calculation than calling the function every time through the loop,
> especially as the nr of CPU's go up. But it's purely a guess, so I may very 
> well be wrong - also, 128 is an arbitrarily chosen value, it's just a nice 
> number that'll give us <10 function calls pr second.

It seems to work.
I have no BUG messages during boot with this patch.
