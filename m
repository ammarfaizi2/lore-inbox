Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUDGGrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbUDGGrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:47:10 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:18357 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S264108AbUDGGqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:46:38 -0400
Date: Wed, 7 Apr 2004 08:46:37 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040407064637.GB28941@MAIL.13thfloor.at>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040406145544.GA19553@MAIL.13thfloor.at> <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:48:44PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Apr 06, 2004 at 04:55:44PM +0200, Herbert Poetzl wrote:
> > 
> > Hi Andrew!
> > 
> > according to todays vfs strategy (hope it hasn't changed
> > again), here is the first patch, which adds the mount 
> > flags propagation, fixes the /proc display, and implements
> > noatime and nodiratime per mountpoint ...
> > 
> > please consider for inclusion ...
> 
> noatime/nodiratime: OK, but we still have direct modifications of i_atime
> that need to be taken care of.

okay, will look at it ...

> massage of ->show(): more or less OK.  However, we don't need to keep
> MS_NOATIME and MS_NODIRATIME in flags at all - 
> > +	if (flags & MS_NOATIME)
> > +		mnt_flags |= MNT_NOATIME;
> > +	if (flags & MS_NODIRATIME)
> > +		mnt_flags |= MNT_NODIRATIME;
> >  	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
> 
> should remove them from flags in the last line, same way we do that for
> nosuid/noexec/nodev, with obvious consequences for ->show().
> 
> Note that we don't need to keep MS_NOATIME check in update_atime() - that
> animal is purely per-mountpoint now.

hmm, wasn't there a reason, for having them per inode
like for 'special' files, which I do not remember atm?

> > +	if (MNT_IS_NOATIME(mnt))
> > +		return;
> > +	if (S_ISDIR(inode->i_mode) && MNT_IS_NODIRATIME(mnt))
> > +		return;
> 
> Do we need those to be macros?  AFAICS, this is the only place where we
> do such checks and we shouldn't get new callers.  IOW, keeping them
> separate doesn't buy us anything and only obfuscates the code.

okay, no problem with that ...

> > -#define MNT_NOSUID	1
> > -#define MNT_NODEV	2
> > -#define MNT_NOEXEC	4
> > +#define MNT_RDONLY	1
> > +#define MNT_NOSUID	2
> > +#define MNT_NODEV	4
> > +#define MNT_NOEXEC	8
> > +#define MNT_NOATIME	16
> > +#define MNT_NODIRATIME	32
> 
> *ugh*
> 
> a) what's the point of reordering them (rdonly shifting the existing ones)?

simple, to match the MS_* counterparts, something which
actually confused me in the first place (in the code)

> b) since MNT_RDONLY doesn't do anything at that point, why introduce it
> (and associated confusion) now?  As it is, your /proc/mounts will pretend
> that per-mountpoint r/o works right now.  Since it doesn't...

no, they won't. the required MNT_RDONLY flag in the proc
function isn't set, so only MS_RDONLY will be reported
(from the superblock) which is equivalent to what is 
reported in the current version.

> > +#define	MNT_IS_RDONLY(m)	((m) && ((m)->mnt_flags & MNT_RDONLY))
> > +#define	MNT_IS_NOATIME(m)	((m) && ((m)->mnt_flags & MNT_NOATIME))
> > +#define	MNT_IS_NODIRATIME(m)	((m) && ((m)->mnt_flags & MNT_NODIRATIME))
> 
> See above.  Besides, are we ever planning to pass NULL to these guys?

originally there was a 'comment' which said, the
(m) check can be removed, when we are sure that this
isn't called with mnt == NULL ...

so maybe a BUGON(!m) might be useful? 

I'll add the 'updates' today ...

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
