Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVCOP7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVCOP7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVCOP7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:59:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:27010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261353AbVCOP73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:59:29 -0500
Date: Tue, 15 Mar 2005 08:00:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] blockdev: fix for racing mount/umount
In-Reply-To: <20050315141449.GA13653@locomotive.unixthugs.org>
Message-ID: <Pine.LNX.4.58.0503150746320.6119@ppc970.osdl.org>
References: <20050315141449.GA13653@locomotive.unixthugs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Mar 2005, Jeff Mahoney wrote:
>
> This patch is another take at fixing the race between mount and umount
> resetting the blocksize and causing buffer errors, infinite loops in
> __getblk_slow, and possibly other undiscovered effects.

Ok. I had to go back and look up the original problem, and having looked 
at this a bit more, I wonder whether the real problem is not that we do 
that silly "set blocksize back to the original one" at umount time in the 
first place.

(It happens very indirectly, though the "->kill_sb()" fn pointer, which 
ends up doing kill_block_super on a regular block device).

Maybe we should just get rid of it entirely? There's really no point to 
it.

Instead, to make things repeatable, we'd always just set the blocksize to
its default value at the first open. We already do that anyway, don't we?

Wouldn't that approach also just fix things? And then the fix would 
literally be to just remove the set_blocksize() call in kill_block_super. 
At that point, we know that the only people who set the block size are 
either
 - a first opener
 - somebody who got exclusive access (ie a filesystem that sets it at 
   mount-time)

(Yeah, it's a bit more complex than that one-liner, since somebody would 
need to back me up on not being totally tripping on some 'shrooms. But Al 
can probably do that trivially)

Or maybe I misunderstood the problem. Jeff?

		Linus
