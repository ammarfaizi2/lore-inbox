Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269594AbRHCUpn>; Fri, 3 Aug 2001 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269596AbRHCUpe>; Fri, 3 Aug 2001 16:45:34 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:50948 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269595AbRHCUp1>; Fri, 3 Aug 2001 16:45:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Date: Fri, 3 Aug 2001 22:50:49 +0200
X-Mailer: KMail [version 1.2]
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108031423280.3272-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0108031423280.3272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <0108032250490I.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 20:53, Alexander Viro wrote:
> On Fri, 3 Aug 2001, Daniel Phillips wrote:
> > > There is no _locked_ chain.
> >
> > Locked as in can't be destroyed (refcount) not i_sem or such, sorry for
> > the loose usage.
>
> Sigh... You need i_sem for fsync().

We can drop it before syncing the parent, the point is, the dcache entry
stays.

> Moreover, there is no warranty that
> set of objects you sync has _anything_ to path by the time when you start
> syncing the second one.

OK, you win, I'll provide this example:

	   A				   B

  echo hello >/a/b/c/d
  fsync(d)->
    fsync_one(d)
				rename /a/b/c/d as /x/y/z/d
      fsync_one(c)
        fsync_one(b)
          fsync_one(a)
            fsync_one(/)

where fsync_one looks roughly like our current sys_fsync.

So we fsynced and we still might have lost the path to d.

The moral of the story: if the filesystem isn't designed to provide a
guaranteed commit on rename then we shouldn't try to fix the VFS so it
sorta does.

> Application has information about the use of
> parts of tree it's interested in. Kernel doesn't. Notice that all this
> wankage was full of "oh, but MTA doesn't care for symlinks", "oh, but MTA
> doesn't deal with parents renamed", ad nausea. You know what it means?
> Right, that kernel shouldn't try to second-guess the userland. Application
> knows what fs objects it wants synced. Kernel provides a primitive for
> syncing an object and leaves the choice of objects to sync to application.
>
> Folks, putting policy into the kernel is Wrong(tm). And that's precisely
> what you are advocating here.

I needed an example where even a new, improved sys_fsync would fail to
do the right thing for Ext2 in the absence of specific coding in the
MTA.  So the MTA is either designed to handle dumb filesystems or it
isn't.  It's pretty much a moot point since we have four filesystems
now in a nearly usable state that can provide the needed commit
guarantees, which should, as has been pointed out in this thread,
provide MTA's with both faster and more reliable operation.

--
Daniel
