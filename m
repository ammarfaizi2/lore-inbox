Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263320AbVGAMh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbVGAMh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 08:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbVGAMh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 08:37:56 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:43785 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263320AbVGAMhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 08:37:05 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050701120028.GB5218@janus> (message from Frank van Maarseveen
	on Fri, 1 Jul 2005 14:00:28 +0200)
Subject: Re: FUSE merging?
References: <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus>
Message-Id: <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 14:36:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You mean suid programs are never to touch paths passed to them?
> 
> never when euid==root.
> The pathname could even point into /proc or anything else yet unknown,
> e.g. by putting some symlinks at the right places. The mere act of
> opening the file as root could have unwanted side effects already.

OK, open is out.  However other operations (stat, unlink, chmod etc)
are always without side effects on "normal" filesystems.  However on
FUSE they are very much unsafe (can block, not do what was instructed
and return success, etc).

> > If that would be true, then fuse_allow_task() would not be needed, but
> > would do no harm either, since it would never be invoked by a suid
> > program.
> 
> In theory it should not be necessary. But on a practical side: we need
> to provide security for daemons with elevated privileges which need to
> traverse all local disks.

I agree wholeheartedly.  However, I'm not arguing this point, because
it has been (rightly) pointed out, that private namespaces can be used
to solve this.  While the suid issue is not solvable with private
namespaces.

> > You didn't consider the information leak aspect (point B in fuse.txt).
> 
> Correct. I have no answer to that other than: is it a real problem or
> yet something else a setuid program should take into consideration?
> And what info can we extract already using inotify/dnotify?

Probably not file access patterns.  But yes I don't consider this a
very grave problem.

> There are several ways to monitor activity and it is all
> information. /proc (ps) gives information too.
> 
> > > -	Forbid hiding data by mounting a FUSE filesystem on top of it (does
> > > 	FUSE check for this already?)
> > 
> > Yes.  It checks for writablilty on the mountpoing (excluding limited
> > writablilty as /tmp for example).
> 
> But can you mount FUSE on top of a populated tree, a non-leaf dir?

Yes, but I think that's OK, because if the directory is writable on
which you mount, than you can hide the data already (unlinking it, but
keeping a reference though a file descriptor).  And it's not very
effective hiding, since a bind mount of the mountpoint's filesystem
will reveal what's underneeth the FUSE mount.

> > > -	/proc isn't a problem: most root processes tend to avoid it because
> > > 	it is synthetic and thus uninteresting. Maybe we should extend
> > > 	the idea of "synthetic file-systems being uninteresting" to any
> > > 	process which cannot receive signals from the FUSE mount owner. When
> > > 	one cannot hide data by a FUSE mount and its synthetic anyway so not
> > > 	interesting then just show the original empty mount point.
> > 
> > Been there.  People (like Al Viro) didn't like it.
> 
> including changing the ptraceability test by a signal test and including
> the (IMHO) required emptyness of the mount stub?

It's been thrown out for the reason, that it's unacceptable if suid
programs see a different namespace as non-suid.

> Traversing a FUSE mountpoint is almost equivalent to talking with a
> userspace program. Why should that be interesting when one simply wants
> to traverse the FS? root isn't going to execute all user programs to
> see what they do either.

Yes.  Please explain that to Al Viro, Christoph Hellwig et. al.
Believe me it's not something that's easy to get across, and I'm very
happy that you see it this way too :).

Miklos

