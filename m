Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319441AbSIGSXq>; Sat, 7 Sep 2002 14:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319500AbSIGSXq>; Sat, 7 Sep 2002 14:23:46 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:63899 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S319441AbSIGSXp>; Sat, 7 Sep 2002 14:23:45 -0400
Date: Sat, 7 Sep 2002 19:27:36 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
Message-ID: <20020907192736.A22492@kushida.apsleyroad.org>
References: <E17neGi-0006Sv-00@starship> <Pine.GSO.4.21.0209070858380.21690-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0209070858380.21690-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Sep 07, 2002 at 09:36:26AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> If your rules are "it's pinned as long as there are opened files created
> by foo()" - very well, there are two variants.  The basic idea is the same
> - have sum of ->mnt_count for all vfsmounts of our type bumped whenever we
> call foo() and drop whenever final fput() is done on a file created by foo().

Thanks -- that's what I implemented, except I used a semaphore instead
of a spinlock.

I wanted to check that it's safe to call `mntput' from `->release()',
which seems like quite a dubious thing to depend on.  But if you say it
is safe, that's cool.

> > It's a good example of why the module interface is stupidly wrong, and
> > __exit needs to be called by the module unloader, returning 0 if it's
> > ok to unload.  Then your __exit can whatever condition it's interested
> > in and, if all is well, do the kern_umount.
> 
> BS.  Instead of playing silly buggers with "oh, we will start exiting
> and maybe we'll bail out, let's just hope we won't find that we want
> to do that after we'd destroyed something" you need to decide what kind
> of rules you really want for the module lifetime.  The rest is trivial.
> Again, variant (a) (which is absolutely straightforward - add one line
> in foo(), modify one line in foo(), delete one line in init) is enough
> to give the desired rules.  Optimizing it if needed is not too hard -
> see (b) for one possible variant...

Unfortunately, your suggestion, which I ended up implementing, is not
safe from race conditions.

The problem comes during the call to `->release()'.  If that's really
the last reference to the module, than as soon as I call `mntput' the
module might be unloaded.  In practice this doesn't happen, but if there
were a long scheduling delay... (see CONFIG_PREEMPT), it could.

-- Jamie
