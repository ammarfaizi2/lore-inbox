Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263273AbVGAJZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbVGAJZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 05:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbVGAJZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 05:25:12 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:47798 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S263273AbVGAJYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 05:24:46 -0400
Date: Fri, 1 Jul 2005 11:24:44 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050701092444.GA4317@janus>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus> <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 08:58:05AM +0200, Miklos Szeredi wrote:
> > > 
> > > - Frank points out that a user can send a sigstop to his own setuid(0)
> > >   task and he intimates that this could cause DoS problems with FUSE.  More
> > >   details needed please?
> > 
> > It's the other way around:
> > Apparently it is not a security problem to SIGSTOP or even SIGKILL a
> > setuid program. So why is it a security problem when such a program is
> > delayed by a supposedly malicious behaving FUSE mount?
> 
> Perfectly valid argument.  My question: is it not a security problem
> to allow signals to reach a suid program?

That's what I though too so I asked it first on the security mailing list.
Apparently this signal behavior is normal.

> There's a huge difference between slowing down, and stopping a
> process.  I wouldn't consider the first a true DoS. 

Stopping is a special case. But it is effectively the same as being
indefinately slowed down by, say, 10000+ malicious processes and from
that angle I don't see a fundamental difference w.r.t. security.

Killing the malicous processes should solve the problem. And killing
one FUSE process looks easier to me than killing 10000+ ones.

> Yes.  The extra problem with FUSE, is that they are not _able_ to be
> careful.

I think this is not true. Every pathname passed to a setuid program
by the user is basically "tainted". Standard I/O is tainted as well.

> They can't even check if a file is in fact on a FUSE mount

They shouldn't. The pathname is not to be trusted anyway.

I think FUSE has shown to be conservative enough w.r.t. security to be
merged. But it may be interesting to consider:

-	replace ptraceability test by a kill()ability test.
-	some sort of "intr" mount option for most signals on by default.
-	Forbid hiding data by mounting a FUSE filesystem on top of it (does
	FUSE check for this already?)
-	/proc isn't a problem: most root processes tend to avoid it because
	it is synthetic and thus uninteresting. Maybe we should extend
	the idea of "synthetic file-systems being uninteresting" to any
	process which cannot receive signals from the FUSE mount owner. When
	one cannot hide data by a FUSE mount and its synthetic anyway so not
	interesting then just show the original empty mount point.

-- 
Frank
