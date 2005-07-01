Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263310AbVGAMAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbVGAMAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 08:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbVGAMAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 08:00:40 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:56246 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263310AbVGAMAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 08:00:30 -0400
Date: Fri, 1 Jul 2005 14:00:28 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050701120028.GB5218@janus>
References: <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus> <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 12:27:01PM +0200, Miklos Szeredi wrote:
> 
> You mean suid programs are never to touch paths passed to them?

never when euid==root.
The pathname could even point into /proc or anything else yet unknown,
e.g. by putting some symlinks at the right places. The mere act of
opening the file as root could have unwanted side effects already.

> 
> If that would be true, then fuse_allow_task() would not be needed, but
> would do no harm either, since it would never be invoked by a suid
> program.

In theory it should not be necessary. But on a practical side: we need
to provide security for daemons with elevated privileges which need to
traverse all local disks.

> You didn't consider the information leak aspect (point B in fuse.txt).

Correct. I have no answer to that other than: is it a real problem or
yet something else a setuid program should take into consideration?
And what info can we extract already using inotify/dnotify? There are
several ways to monitor activity and it is all information. /proc (ps)
gives information too.

> > -	Forbid hiding data by mounting a FUSE filesystem on top of it (does
> > 	FUSE check for this already?)
> 
> Yes.  It checks for writablilty on the mountpoing (excluding limited
> writablilty as /tmp for example).

But can you mount FUSE on top of a populated tree, a non-leaf dir?

> > -	/proc isn't a problem: most root processes tend to avoid it because
> > 	it is synthetic and thus uninteresting. Maybe we should extend
> > 	the idea of "synthetic file-systems being uninteresting" to any
> > 	process which cannot receive signals from the FUSE mount owner. When
> > 	one cannot hide data by a FUSE mount and its synthetic anyway so not
> > 	interesting then just show the original empty mount point.
> 
> Been there.  People (like Al Viro) didn't like it.

including changing the ptraceability test by a signal test and including
the (IMHO) required emptyness of the mount stub?

Traversing a FUSE mountpoint is almost equivalent to talking with a
userspace program. Why should that be interesting when one simply wants
to traverse the FS? root isn't going to execute all user programs to
see what they do either.

-- 
Frank
