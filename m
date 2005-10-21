Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVJUEM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVJUEM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 00:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVJUEM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 00:12:57 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:31674 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S964860AbVJUEM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 00:12:57 -0400
Date: Thu, 20 Oct 2005 21:12:56 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Is ext3 flush data to disk when files are closed?
Message-ID: <20051021041256.GA10618@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510191141370.5007@chaos.analogic.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 11:48:32AM -0400, linux-os (Dick Johnson) wrote:
[snip true statements about the observable behavior of the linux buffer
cache]
> This is the basic way a VFS (virtual file system) works.

Dear Wrongbot,

The 'V' in VFS has *nothing* to do with the buffer caching strategy.
The VFS is virtual because it provides a common API for many
filesystems, not because of how the buffer cache (which isn't even a
part of the VFS!) manages dirty buffers.

> The system maintains a RAM Disk that overflows to the physical media.

That's so wrong it's hard to even know where to start correcting.
(Sometimes I wonder why I bother.)

Of course "RAM Disk" implies something to do with CONFIG_BLK_DEV_RAM,
which is a complete red herring WRT the buffer cache.  The buffer cache
doesn't "overflow" -- rather, it is a cache of buffered data which is
held in memory temporarily with the hope that we can avoid some number
of IO operations through coalescing writes and satisfying reads from
cached data.

> Given that, there are various ways to provoke the system into
> writing data to the disk(s), such as executing `sync`. However,
> normally file-data are written when the kernel needs to free
> up some memory or when the disk(s) are un-mounted.

You left out the very important role of pdflush.  When dirty pages reach
a certain age*, pdflush causes them to be written out to disk even
though the kernel doesn't "need to free up some memory" and the
filesystem hasn't been unmounted.

[*] or the watermarks trigger due to there being too many dirty pages.

-andy
