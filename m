Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263337AbVGANXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbVGANXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbVGANXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:23:05 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:59655 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263337AbVGANWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:22:41 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050701130510.GA5805@janus> (message from Frank van Maarseveen
	on Fri, 1 Jul 2005 15:05:10 +0200)
Subject: Re: FUSE merging?
References: <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu> <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus>
Message-Id: <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 15:21:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > OK, open is out.  However other operations (stat, unlink, chmod etc)
> > are always without side effects on "normal" filesystems.  However on
> > FUSE they are very much unsafe (can block, not do what was instructed
> > and return success, etc).
> 
> What about tricking a setuid program to stat into /auto (/mnt/auto,
> /misc, whatever it is called)? then the automounter will act upon a root
> request with again possibly unwanted side effects. See how careful a
> setuid/full-root program must be in handling userdata including pathnames?

I don't see why /auto is special.  It's basically a userspace
filesystem too, but that's not what is specaial about FUSE.  It's the
fact the it's a userspace filesystem controlled by an _ordinary user_.

> FUSE suddenly makes this more obvious but it is not new.

I believe it _is_ something new.  If it were not, then your arguments
would be bulletproof.  As it is, I think you miss the point that the
side effect is actually in the hands of the user invoking the suid
program, instead of something external.

> > > including changing the ptraceability test by a signal test and including
> > > the (IMHO) required emptyness of the mount stub?
> > 
> > It's been thrown out for the reason, that it's unacceptable if suid
> > programs see a different namespace as non-suid.
> 
> You mean root versus non-root. or user versus other user I assume. Because
> the euid (fsuid) is what matters.

Yes.

> But then: this _is_ already the case for NFS when squash_root is in effect
> (what about kerberos et.al?). So there are several reasons to consider
> FUSE a nonlocal fs instead of a local one so nothing new there. FUSE could
> be used to implement a usable (not perfect) userspace NFS/ftp client.

Yes.  In fact even if the check were left out of the kernel, the
userspace filesystem could still return different data/error based on
fsuid/fsgid/pid.

So what's so controversial about it?  I really fail to understand...

> To require an empty stub to mount FUSE upon makes the whole picture
> cleaner: users are only able to extend the namespace _leaf_ nodes for
> themselves and processes they can send signals to: setuid programs
> which do not fully become root. The existing namespace [nodes] remains
> unchanged for everyone.

It's not as simple.  A filesystem can be mounted many times (either
with mount --bind, or just by mounting the same device on multiple
mountpoints).  In this case you can't ensure, that a mountpoint will
remain a leaf node after being mounted on.

Miklos
