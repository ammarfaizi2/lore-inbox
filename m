Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVCMUgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVCMUgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVCMUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:36:15 -0500
Received: from waste.org ([216.27.176.166]:34750 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261447AbVCMUgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:36:08 -0500
Date: Sun, 13 Mar 2005 12:36:04 -0800
From: Matt Mackall <mpm@selenic.com>
To: zippel@linux-m68k.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Serious problems with HFS+
Message-ID: <20050313203604.GF3163@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed a few problems with HFS+ support in recent kernels on
another user's machine running Ubuntu (Warty) running
2.6.8.1-3-powerpc. I'm not in a position to extensively test or fix
either of these problem because of the fs tools situation so I'm just
passing this on.

First, it reports inappropriate blocks to stat(2). It uses 4096 byte
blocks rather than 512 byte blocks which stat callers are expecting.
This seriously confuses du(1) (and me, for a bit). Looks like it may
be forgetting to set s_blocksize_bits.

Second, if an HFS+ filesystem mounted via Firewire or USB becomes
detached, the filesystem appears to continue working just fine. I can
find on the entire tree, despite memory pressure. I can even create
new files that continue to appear in directory listings! Writes to
such files succeed (they're async, of course) and the typical app is
none the wiser. It's only when apps attempt to read later that they
encounter problems. It turns out that various apps including scp
ignore IO errors on read and silently copy zero-filled files to the
destination. So I got this report as "why aren't the pictures I took
off my camera visible on my website?"

This is obviously a really nasty failure mode. At the very least, open
of new files should fail with -EIO. Preferably the fs should force a
read-only remount on IO errors. Given that the vast majority of HFS+
filesystems Linux is likely to be used with are on hotpluggable media,
I think this FS should be marked EXPERIMENTAL until such integrity
problems are addressed.

Having the whole directory tree seemingly pinned in memory is probably
something that wants addressing as well.

-- 
Mathematics is the supreme nostalgia of our time.
