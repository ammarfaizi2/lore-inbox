Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVCNKTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVCNKTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVCNKTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:19:20 -0500
Received: from [194.109.195.176] ([194.109.195.176]:47077 "EHLO
	scrub.xs4all.nl") by vger.kernel.org with ESMTP id S262104AbVCNKTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:19:10 -0500
Date: Mon, 14 Mar 2005 11:18:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serious problems with HFS+
In-Reply-To: <20050313203604.GF3163@waste.org>
Message-ID: <Pine.LNX.4.61.0503141103210.25131@scrub.home>
References: <20050313203604.GF3163@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 13 Mar 2005, Matt Mackall wrote:

> I've noticed a few problems with HFS+ support in recent kernels on
> another user's machine running Ubuntu (Warty) running
> 2.6.8.1-3-powerpc. I'm not in a position to extensively test or fix
> either of these problem because of the fs tools situation so I'm just
> passing this on.
> 
> First, it reports inappropriate blocks to stat(2). It uses 4096 byte
> blocks rather than 512 byte blocks which stat callers are expecting.
> This seriously confuses du(1) (and me, for a bit). Looks like it may
> be forgetting to set s_blocksize_bits.

This should be fixed since 2.6.10.

> Second, if an HFS+ filesystem mounted via Firewire or USB becomes
> detached, the filesystem appears to continue working just fine. I can
> find on the entire tree, despite memory pressure. I can even create
> new files that continue to appear in directory listings! Writes to
> such files succeed (they're async, of course) and the typical app is
> none the wiser. It's only when apps attempt to read later that they
> encounter problems. It turns out that various apps including scp
> ignore IO errors on read and silently copy zero-filled files to the
> destination. So I got this report as "why aren't the pictures I took
> off my camera visible on my website?"

HFS+ metadata is also in the page cache, so as long as everything is 
cached, HFS+ won't notice a problem.

> This is obviously a really nasty failure mode. At the very least, open
> of new files should fail with -EIO. Preferably the fs should force a
> read-only remount on IO errors. Given that the vast majority of HFS+
> filesystems Linux is likely to be used with are on hotpluggable media,
> I think this FS should be marked EXPERIMENTAL until such integrity
> problems are addressed.

Currently nobody tells fs about such events, so even if I check for 
write errors, it can still take a while until the error is detected.
I acknowledge that this is a problem, but I don't think it's a HFS+ 
specific problem, there is currently no standard procedure for fs what to 
do in such situations, so I didn't implement anything.
It would be nice if the fs would be tould about plug/unplug events, e.g. 
HFS+ could check the mount count to see if it was connected to a different 
host in the meantime and react appropriately.

> Having the whole directory tree seemingly pinned in memory is probably
> something that wants addressing as well.

This actually might be a real HFS+ problem :), I have to look into it.

bye, Roman
