Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVCODMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVCODMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVCODMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:12:18 -0500
Received: from waste.org ([216.27.176.166]:43404 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262217AbVCODLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:11:23 -0500
Date: Mon, 14 Mar 2005 19:11:14 -0800
From: Matt Mackall <mpm@selenic.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serious problems with HFS+
Message-ID: <20050315031114.GL32638@waste.org>
References: <20050313203604.GF3163@waste.org> <Pine.LNX.4.61.0503141103210.25131@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503141103210.25131@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:18:49AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 13 Mar 2005, Matt Mackall wrote:
> 
> > I've noticed a few problems with HFS+ support in recent kernels on
> > another user's machine running Ubuntu (Warty) running
> > 2.6.8.1-3-powerpc. I'm not in a position to extensively test or fix
> > either of these problem because of the fs tools situation so I'm just
> > passing this on.
> > 
> > First, it reports inappropriate blocks to stat(2). It uses 4096 byte
> > blocks rather than 512 byte blocks which stat callers are expecting.
> > This seriously confuses du(1) (and me, for a bit). Looks like it may
> > be forgetting to set s_blocksize_bits.
> 
> This should be fixed since 2.6.10.
> 
> > Second, if an HFS+ filesystem mounted via Firewire or USB becomes
> > detached, the filesystem appears to continue working just fine. I can
> > find on the entire tree, despite memory pressure. I can even create
> > new files that continue to appear in directory listings! Writes to
> > such files succeed (they're async, of course) and the typical app is
> > none the wiser. It's only when apps attempt to read later that they
> > encounter problems. It turns out that various apps including scp
> > ignore IO errors on read and silently copy zero-filled files to the
> > destination. So I got this report as "why aren't the pictures I took
> > off my camera visible on my website?"
> 
> HFS+ metadata is also in the page cache, so as long as everything is 
> cached, HFS+ won't notice a problem.

It's failing to notice errors at sync time or when such pages get
flushed due to memory pressure.

> > This is obviously a really nasty failure mode. At the very least, open
> > of new files should fail with -EIO. Preferably the fs should force a
> > read-only remount on IO errors. Given that the vast majority of HFS+
> > filesystems Linux is likely to be used with are on hotpluggable media,
> > I think this FS should be marked EXPERIMENTAL until such integrity
> > problems are addressed.
> 
> Currently nobody tells fs about such events, so even if I check for 
> write errors, it can still take a while until the error is detected.

It should catch up within the flush interval or at the next sync, at
least. And then fail all further writes. Consider the scenario of a
user sitting at their laptop when a power glitch offlines their
external drive. They can copy files onto it for the next hour, delete
the originals and be completely unaware that anything is wrong unless
they happen to check dmesg.

> It would be nice if the fs would be tould about plug/unplug events, e.g. 
> HFS+ could check the mount count to see if it was connected to a different 
> host in the meantime and react appropriately.

An FS-level callback when the underlying block device went for a walk
would be a nice hook just about everywhere. And at least a start on
the problem.

-- 
Mathematics is the supreme nostalgia of our time.
