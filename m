Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135817AbRDZSSp>; Thu, 26 Apr 2001 14:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135822AbRDZSSf>; Thu, 26 Apr 2001 14:18:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31282 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135817AbRDZSSY>; Thu, 26 Apr 2001 14:18:24 -0400
Date: Thu, 26 Apr 2001 20:12:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010426201236.W819@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0104261137410.15385-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0104261137410.15385-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 26, 2001 at 11:45:47AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 11:45:47AM -0400, Alexander Viro wrote:
> 	Ext2 does getblk+wait_on_buffer for new metadata blocks before
> filling them with zeroes. While that is enough for single-processor,
> on SMP we have the following race:
> 
> getblk gives us unlocked, non-uptodate bh
> wait_on_buffer() does nothing
> 					read from device locks it and starts IO
> we zero it out.
> 					on-disk data overwrites our zeroes.
> we mark it dirty
> bdflush writes the old data (_not_ zeroes) back to disk.
> 
> Result: crap in metadata block. Proposed fix: lock_buffer()/unlock_buffer()
> around memset()/mark_buffer_uptodate() instead of wait_on_buffer() before
> them.
> 
> Patch against 2.4.4-pre7 follows. Please, apply.

correct. I bet other fs are affected as well btw.

Andrea
