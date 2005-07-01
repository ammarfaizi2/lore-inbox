Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263257AbVGAHAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263257AbVGAHAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbVGAHAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:00:21 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:12042 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S263257AbVGAG6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 02:58:41 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
In-reply-to: <20050630222828.GA32357@janus> (message from Frank van Maarseveen
	on Fri, 1 Jul 2005 00:28:28 +0200)
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <20050630222828.GA32357@janus>
Message-Id: <E1DoFTR-0002NH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Jul 2005 08:58:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > - Frank points out that a user can send a sigstop to his own setuid(0)
> >   task and he intimates that this could cause DoS problems with FUSE.  More
> >   details needed please?
> 
> It's the other way around:
> Apparently it is not a security problem to SIGSTOP or even SIGKILL a
> setuid program. So why is it a security problem when such a program is
> delayed by a supposedly malicious behaving FUSE mount?

Perfectly valid argument.  My question: is it not a security problem
to allow signals to reach a suid program?

> I think that setuid programs take too many things for granted, especially
> "time". I also think the ptrace equivalence principle (item C2 in the
> FUSE doc) is too harsh for FUSE.

It's obviously not equivalence.  FUSE filesystem gets a subset of
ptrace's capabilities (and rather a small one).

> Suppose the process changes id to full root and we can no longer send
> signals to it. Are there any other ways we could affect its scheduling
> without FUSE? I think "yes", clearly not that easy as when it accesses a
> FUSE mount but "yes". Think about typing ^S (XOFF), or by letting it read
> from a pipe or from a file on a very very slow device. Or by renicing
> the parent in advance. Regarding the pipe: yes the setuid program could
> check that with fstat() but is such a check fundamentally the right
> approach? I have doubt because unified I/O is a good thing and there is
> no guarantee whatsoever about completion of any FS operation within a
> certain amount of time. Suppose another malicious process does a lookup
> in a huge directory without hashed names? What about a process consuming
> lots of memory, pushing everything else into swap? What about deleting
> a _huge_ file or do other things which might(?) take a considerable
> amount of kernel time? [id]notify might even help using this to delay
> a root process at a crucial point to exploit a race. So, I think there
> are many ways to affect the execution speed of [setuid] programs. I
> have never heard of a setuid root program which renices itself, such,
> that it successfully avoids a race or DoS exploit.

There's a huge difference between slowing down, and stopping a
process.  I wouldn't consider the first a true DoS. 

> And then the DoS thing using simulated endless files within FUSE. It is
> already possible to create terabyte sized [sparse] files. Can the fstat()
> size/blocks info be trusted from FUSE? no more than fstat() outside FUSE
> because the file may still be growing!
> 
> > - I don't recall seeing an exhaustive investigation of how an
> >   unprivileged user could use a FUSE mount to implement DoS attacks against
> >   other users or against root.
> 
> In general I think it is _hard_ to protect against a local DoS for many
> reasons and I don't see any new fundamental problem here with FUSE:
> it is just making it more obvious that it's hard to write secure setuid
> programs. Those programs should _know_ that input data and anything else
> from the user is "tainted" and that they must be _very_ careful with it,
> in every detail.

Yes.  The extra problem with FUSE, is that they are not _able_ to be
careful.  They can't even check if a file is in fact on a FUSE mount
or not without the FUSE daemon's intervention (lookup on a file will
be passed to userspace).

Thanks,
Miklos
