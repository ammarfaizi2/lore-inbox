Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRF0OWp>; Wed, 27 Jun 2001 10:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRF0OWf>; Wed, 27 Jun 2001 10:22:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:18135 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262288AbRF0OWY>;
	Wed, 27 Jun 2001 10:22:24 -0400
Date: Wed, 27 Jun 2001 10:22:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Ben Ford <ben@kalifornia.com>, Marty Leisner <leisner@rochester.rr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mounting a fs in two places at once?
In-Reply-To: <20010628004854.B7331@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0106271005340.19655-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jun 2001, Chris Wedgwood wrote:

> On Mon, Jun 25, 2001 at 02:20:16AM -0700, Ben Ford wrote:
> 
> > Feature.  It actually makes it quite nice when you want to allow
> > chrooted user(s) access to a common directory, you just mount a
> > partition in all the users home dirs.
> 
> For security, this can be a bad idea.
> 
> Potentially, chrooted user can mess with another, by messing with
> libraries and such like. In most cases not terribly easy, but in some
> cases possible.

If chrooted user had gained root - he can do much more damage than that.
If your libraries are world-writable - you had asked for that, hadn't
you?

> No, if the fs was mounted RO, then I assume you would have less to
> worry about. Its a pity the VFS code doesn't allow you to fix RO & RW
> of the same fs.

<shrug> 2.5 stuff. Requires extra argument on getattr/setattr/permission -
prototype change on 3 methods for something that is a feature and not a
fix for any specific bug...

If you want root-proof analog of chroot - fine, but that will require
at least taking away the ability to mount/umount anything. Otherwise
attacker will simply be able to remount everything he want r/w once he
had gained root. That can be done (e.g. by adding "can modify" flag
to namespace and doing something along the lines

	pid = clone(CLONE_NAMESPACE, NULL);
	if (!pid) {
		/* do all needed mount/umount work */
		pid = clone(CLONE_FREEZE_NAMESPACE, NULL);
		if (!pid) {
			/* we are set */
		}
		exit(0);
	}

which would give grandchild a namespace we want it to see and prohibit
any changes in said namespace, root or not)

