Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWC0GKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWC0GKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 01:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWC0GKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 01:10:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:65218 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750713AbWC0GKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 01:10:12 -0500
Date: Mon, 27 Mar 2006 17:10:21 +1100
From: David Chinner <dgc@sgi.com>
To: Peter Palfrader <peter@palfrader.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16: Oops - null ptr in blk_recount_segments?
Message-ID: <20060327061021.GT1173973@melbourne.sgi.com>
References: <20060327022814.GV25288@asteria.noreply.org> <20060327043601.GE27189130@melbourne.sgi.com> <20060327045823.GW25288@asteria.noreply.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327045823.GW25288@asteria.noreply.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 06:58:23AM +0200, Peter Palfrader wrote:
> On Mon, 27 Mar 2006, David Chinner wrote:
> 
> > > I've seen a few of these since upgrading to 2.6.16 on my x86_64 system:
> > 
> > What did you upgrade from?
> 
> 2.6.14.2.
> 
> 
> > > [14513.189101] Call Trace: <ffffffff80288e8d>{blk_recount_segments+125}
> > > [14513.189113]        <ffffffff8045ab19>{schedule_timeout+153} <ffffffff8017df90>{__bio_clone+128}
> > > [14513.189134]        <ffffffff8017dfed>{bio_clone+61} <ffffffff80144a70>{autoremove_wake_function+0}
> > > [14513.189143]        <ffffffff882576c1>{:dm_crypt:crypt_alloc_buffer+65}
> > > [14513.189157]        <ffffffff8825813e>{:dm_crypt:crypt_map+174} <ffffffff8823b463>{:dm_mod:__map_bio+83}
> > > [14513.189190]        <ffffffff8823b6a8>{:dm_mod:__clone_and_map+168} <ffffffff8823b8de>{:dm_mod:__split_bio+174}
> > > [14513.189223]        <ffffffff8823b9dc>{:dm_mod:dm_request+204} <ffffffff8028b532>{generic_make_request+258}
> > > [14513.189243]        <ffffffff8028b628>{submit_bio+216} <ffffffff8017e20f>{__bio_add_page+463}
> > > [14513.189256]        <ffffffff8026bd3e>{xfs_submit_ioend_bio+30} <ffffffff8026bec0>{xfs_submit_ioend+144}
> > > [14513.189269]        <ffffffff8026cd03>{xfs_page_state_convert+1379} <ffffffff8026d2e0>{linvfs_writepage+176}
> > 
> > This area of XFS changed in 2.6.16; it might be doing something wrong
> > with bios that is blowing up later. Then again, it might be something in dm
> > that is wrong. Does this happen on non-dmcrypt XFS filesystems you have?
> 
> All the Oopses so far had dm_crypt in their backtrace, but then the
> non-crypted XFSs don't see that much action.  Also, I recently added a
> new XFS filesytem to the system.  Is there a way to tell which of them
> causes the Oops?

The only way I know involves prodding the decomposing corpse with a long,
pointy stick (i.e. kdb).  That probably doesn't help you, though.

> > I understand that the recognised way to find introduced a reproducable problem
> > like this is to do a git bisect to find the mod that introduced the problem.
> > Is it possible for you to do this?
> 
> I can certainly try but it usually takes several hours or a at least a
> few days to manifest here on my desktop.

Well, you can try ruling out the XFS changes - on this page:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;h=9eeff2395e3cfd05c9b2e6074ff943a34b0c5c21;f=fs/xfs/linux-2.6/xfs_aops.c

These diffs:

2006-01-18
[XFS] Fix a race in xfs_submit_ioend() where we can ...
2006-01-11
[XFS] fix writeback control handling fix a reversed ...
[XFS] cluster rewrites We can cluster mapped pages ...
[XFS] pass full 64bit offsets to xfs_add_to_ioend
[XFS] consolidate some code in xfs_page_state_convert ...
[XFS] various fixes for xfs_convert_page fix various ...
[XFS] clean up the xfs_offset_to_map interface Currently ...
[XFS] use pagevec lookups This reduces the time spend ...
[XFS] Initial pass at going directly-to-bio on the ...

Are the ones that change the XFS I/O path from what is in 2.6.14.  Try
reverting them and see if the problem goes away....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
