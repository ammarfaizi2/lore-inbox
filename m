Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUB2N6v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 08:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbUB2N6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 08:58:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9412 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262051AbUB2N6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 08:58:50 -0500
Date: Sun, 29 Feb 2004 13:58:49 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maurice van der Stee <stee@planet.nl>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.4-rc1 oops on HPFS filesystem file rename
Message-ID: <20040229135849.GI16357@parcelfarce.linux.theplanet.co.uk>
References: <20040228171259.GA587@maurice.stee.nl> <20040228190649.GF16357@parcelfarce.linux.theplanet.co.uk> <20040229113130.GA577@maurice.stee.nl> <20040229131425.GH16357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229131425.GH16357@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 01:14:25PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Unless there are complaints and bug reports, it will go to Linus in a couple
> of days.

Oh, lovely - there's a deadlock (both in new and old code) too.  The trouble
being, we can get ->write_inode() *triggered* in the middle of btree
rebalancing.  Which leads to deadlock, since we really need the exclusion
there (and would be very unhappy if search for directory entry would happen
in the middle of that fun).

Fix is to switch the allocations done in that area to GFP_NOFS.  However,
there's an extra PITA caused by inode allocations - we'll need to take
the inode allocation in hpfs_create() et.al. outside of lock on parent.

Potential inode allocation in ->write_inode() (done if parent inode is
not in core - that can happen, unfortunately) is not a problem if we
replace the "parent can change" semaphore to rwsem and hold it for
read here.  There's no risk of down_read()/somebody does down_write()/the
first task gets recursive down_read() deadlock in that case, since all
down_write() can happen only if parent inode is already in-core.

Sigh...  Gotta love that code - deadlocks had been there since _way_ back...

Additional patch later today...
