Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVGCNZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVGCNZH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 09:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVGCNZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 09:25:07 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:6668 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261439AbVGCNYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 09:24:47 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050703112541.GA32288@janus> (message from Frank van Maarseveen
	on Sun, 3 Jul 2005 13:25:41 +0200)
Subject: Re: FUSE merging?
References: <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus>
Message-Id: <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 03 Jul 2005 15:24:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmm, do you mean returning different directory contents based on uid?
> 
> 	http://clusternfs.sourceforge.net
> 
> Don't ask me how this plays with the dcache.

But here the decision on what to return is in the _server_.  There's
nothing magic about that.  It's as if it was N different servers for N
different clients, only more effective.

> The opposite of "local" is "remote", i.e. networked filesystems:
> 
> 	mount foo:/bar /usr/src/bar
> 
> /, /usr and /usr/src are stored on a local disk. /usr/src/bar/* is not.
> Namespace invariance can be guaranteed for the "/usr/src" part. Not for
> anything below unless you control the peer.

I think what you call namespace invariance is basically true for all
existing filesystems.  There could be a filesystem which returns
different directory contents based on whatever it wants, but it can't
return a different "dentry" for the same name.

So file/directory _content_ can be made to vary, but the namespace
itself can't.

> > 
> > The problem with this leaf node philosophy, is that it's not really
> > consistent.  You can ensure that a mountpoint is a leaf node at mount
> > time, but you cannot force it to remain a leaf node after the mount.  So
>                    ^^^
>                  inserted by me

[well corrected :)]

> 
> ok, I just remembered that any process with an open directory handle
> could still fchdir() underneath. I think the leaf node enforcing is
> possible but it is indeed a bit more complicated.
> 
> (Hmm, it's a bit bizarre but could you mount FUSE on, for example, a
>  named pipe and change it into a directory?)

No.  Fusermount checks file type and refuses the mount if there's a
mismatch (and it protects against races by mounting on '.' for
directories, and on '/proc/self/fd/X' for regular files).

> > I don't see why this check at mount time would make _any_ difference.
> 
> It should be possible to do audits on local filesystems, e.g. by:
> 
> 	find / /home /var -xdev ....
> 
> This can be done as root but sometimes you may want to do this with the
> uid/gid of a specific user, for safety or for checking what the user
> actually can access or damage.

But note, that running with the uid/gid of the user exposes the
auditing script to manipulation (kill, ptrace) by the user.  Running
with changed fsuid/fsgid is OK though.

> And that won't work as expected when the user places a FUSE mount on
> top of his own login directory. But I don't think leaf node
> enforcing is required from a security point of view. This is the
> only thing I could come up with.

OK, from the auditing POV, there's a slight hole in unprivileged
mounts.  But I don't think this is grave, since it's not so hard to
hide any sensitive data from such scripts anyway (keeping data in
memory, or keeping a file descriptor to an unlinked file, etc).

> IMHO The namespace argument against FUSE is weak for multiple reasons. The
> only variancy I see is when crossing the mount point. And that disappears
> once EACCES is returned when non-ptraceable processes try to cross it.

Yes, but still this is just a difference in permission, and not a
difference in namespace.

> But that's not really acceptable (see previous audit case) unless FUSE
> refuses to mount on non-leaf dirs.

I don't think the audit case is important.  It's easy to work around
it manually by the sysadmin, and for the automatic case it doesn't
really matter (as detailed above).

Miklos
