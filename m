Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263299AbVGAK1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbVGAK1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 06:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbVGAK1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 06:27:47 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:34322 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263299AbVGAK1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 06:27:43 -0400
To: frankvm@frankvm.com
CC: miklos@szeredi.hu, frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk,
       arjan@infradead.org, linux-kernel@vger.kernel.org
In-reply-to: <20050701092444.GA4317@janus> (message from Frank van Maarseveen
	on Fri, 1 Jul 2005 11:24:44 +0200)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu> <20050701092444.GA4317@janus>
Message-Id: <E1DoIjd-0002bM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 12:27:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Perfectly valid argument.  My question: is it not a security problem
> > to allow signals to reach a suid program?
> 
> That's what I though too so I asked it first on the security mailing list.
> Apparently this signal behavior is normal.

Well, I think it's a fertile ground for hole hunters out there.  Just
needs a little publicity ;)

Is it considered DoS for example if I prevent other users from sending
email?  SIGSTOP on sendmail at the right moment (when the database is
locked) should do it fine.

> Stopping is a special case. But it is effectively the same as being
> indefinately slowed down by, say, 10000+ malicious processes and from
> that angle I don't see a fundamental difference w.r.t. security.

On a well protected multiuser system there will be ulimits in place to
prevent that.

> Killing the malicous processes should solve the problem. And killing
> one FUSE process looks easier to me than killing 10000+ ones.

Killing always works, if the sysadmin happens to be around.  If not
then there's not a lot other users can do.

> I think this is not true. Every pathname passed to a setuid program
> by the user is basically "tainted". Standard I/O is tainted as well.

You mean suid programs are never to touch paths passed to them?

If that would be true, then fuse_allow_task() would not be needed, but
would do no harm either, since it would never be invoked by a suid
program.

> > They can't even check if a file is in fact on a FUSE mount
> 
> They shouldn't. The pathname is not to be trusted anyway.
> 
> I think FUSE has shown to be conservative enough w.r.t. security to be
> merged. But it may be interesting to consider:
> 
> -	replace ptraceability test by a kill()ability test.

You didn't consider the information leak aspect (point B in fuse.txt).

> -	some sort of "intr" mount option for most signals on by default.

KILL will always interrupt a request.  So getting rid of a malicious
mount should present no problems.

> -	Forbid hiding data by mounting a FUSE filesystem on top of it (does
> 	FUSE check for this already?)

Yes.  It checks for writablilty on the mountpoing (excluding limited
writablilty as /tmp for example).

> -	/proc isn't a problem: most root processes tend to avoid it because
> 	it is synthetic and thus uninteresting. Maybe we should extend
> 	the idea of "synthetic file-systems being uninteresting" to any
> 	process which cannot receive signals from the FUSE mount owner. When
> 	one cannot hide data by a FUSE mount and its synthetic anyway so not
> 	interesting then just show the original empty mount point.

Been there.  People (like Al Viro) didn't like it.

Miklos
