Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbUDGMqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 08:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUDGMqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 08:46:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263191AbUDGMqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 08:46:42 -0400
Date: Wed, 7 Apr 2004 13:46:41 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040407124641.GR31500@parcelfarce.linux.theplanet.co.uk>
References: <20040406145544.GA19553@MAIL.13thfloor.at> <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk> <20040407064637.GB28941@MAIL.13thfloor.at> <20040407084722.GQ31500@parcelfarce.linux.theplanet.co.uk> <20040407101912.GA29900@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407101912.GA29900@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 12:19:12PM +0200, Herbert Poetzl wrote:

> > Yes, but that's S_NOATIME in inode->i_flags, not MS_NOATIME in sb->s_flags.
> > Actually, I've been wrong here - we *do* need that check, since there are
> > filesystems that force noatime or nodiratime.
> 
> so we keep them?

yes.

> > it on remount.  Most of those are my fault - I've missed the remount side of
> > things in readdir patch.  They should have nodiratime always on to match
> > the original behaviour.  IMO, both (a) and (b) should be handled by a new
> > field - sb->s_forced_flags.  do_remount_sb() would set those in flags before
> > doing anything else.  Note that assignment to ->s_flags in do_remount_sb()
> > is not safe - e.g. ext[23] can get forced r/o by fs error and if that
> > happens after return from ->remount_sb() but before assignement, we are
> > screwed.  IOW, do_remount_sb() will need more work.
> 
> are you going to do this?

Yes - for now I'll do a fix that doesn't change API (IOW, add/update
->remount_fs() to filesystems with forced flags, forced r/o has the
same problems); we'll see what should be done in the long run when
the things clean up a bit.  I'd rather avoid struct super_block changes
that would have to be reverted soon.
 
> >> simple, to match the MS_* counterparts, something which
> >> actually confused me in the first place (in the code)
> 
> so is this okay? actually I'd prefer to use the same
> values for the MNT_NOATIME and MNT_NODIRATIME too ...
> (as in the previous version I did)

Hmm...  Potentially we are breaking ABI for no good reason, since these
defines are visible to out-of-tree code.  I don't think that we should
care about matching MS_... stuff, simply because MS_... encoding is ugly
as hell and there's no reason to use MNT_... and MS_... in the same
context.
