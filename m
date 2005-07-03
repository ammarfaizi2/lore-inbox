Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVGCLZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVGCLZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVGCLZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:25:56 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:52152 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261315AbVGCLZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:25:42 -0400
Date: Sun, 3 Jul 2005 13:25:41 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050703112541.GA32288@janus>
References: <20050701120028.GB5218@janus> <E1DoKko-0002ml-00@dorka.pomaz.szeredi.hu> <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 08:16:37AM +0200, Miklos Szeredi wrote:
> > After some thinking, the whole "not allowing namespace differences
> > based on user id" philosophy is unenforcable and not even true sometimes
> > nowadays. Think NFS: have a look at the unfsd server, you'll be surprised
> > what it can do. Think any other networked file system exported by a
> > machine with an unusual disk file-system underneath. IIRC ncpfs does
> > this on the server based on access and thus based on uid.
> 
> Hmm, do you mean returning different directory contents based on uid?

	http://clusternfs.sourceforge.net

Don't ask me how this plays with the dcache.

> > The thing is, root rules the _local_ part of the name space. So it should
> > make a _huge_ difference if FUSE can fiddle with that or only with what's
> > below the leaf nodes.
> 
> I don't really understand what you mean by "local".

The opposite of "local" is "remote", i.e. networked filesystems:

	mount foo:/bar /usr/src/bar

/, /usr and /usr/src are stored on a local disk. /usr/src/bar/* is not.
Namespace invariance can be guaranteed for the "/usr/src" part. Not for
anything below unless you control the peer.

> 
> The problem with this leaf node philosophy, is that it's not really
> consistent.  You can ensure that a mountpoint is a leaf node at mount
> time, but you cannot force it to remain a leaf node after the mount.  So
                   ^^^
                 inserted by me

ok, I just remembered that any process with an open directory handle
could still fchdir() underneath. I think the leaf node enforcing is
possible but it is indeed a bit more complicated.

(Hmm, it's a bit bizarre but could you mount FUSE on, for example, a
 named pipe and change it into a directory?)

> I don't see why this check at mount time would make _any_ difference.

It should be possible to do audits on local filesystems, e.g. by:

	find / /home /var -xdev ....

This can be done as root but sometimes you may want to do this with the
uid/gid of a specific user, for safety or for checking what the user
actually can access or damage. And that won't work as expected when the
user places a FUSE mount on top of his own login directory. But I don't
think leaf node enforcing is required from a security point of view. This
is the only thing I could come up with.

IMHO The namespace argument against FUSE is weak for multiple reasons. The
only variancy I see is when crossing the mount point. And that disappears
once EACCES is returned when non-ptraceable processes try to cross it.
But that's not really acceptable (see previous audit case) unless FUSE
refuses to mount on non-leaf dirs.

-- 
Frank
