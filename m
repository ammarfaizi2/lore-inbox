Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277136AbRJDGco>; Thu, 4 Oct 2001 02:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277137AbRJDGcY>; Thu, 4 Oct 2001 02:32:24 -0400
Received: from rwp58.dsl.frii.net ([216.17.153.58]:8207 "HELO
	joseki.proulx.com") by vger.kernel.org with SMTP id <S277136AbRJDGcQ>;
	Thu, 4 Oct 2001 02:32:16 -0400
Date: Thu, 4 Oct 2001 00:32:35 -0600
Message-Id: <200110040632.f946WZG02255@torment.proulx.com>
From: Bob Proulx <bob@proulx.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Nilmoni Deb <ndeb@ece.cmu.edu>, Jim Meyering <jim@meyering.net>,
        viro@math.psu.edu, bug-fileutils@gnu.org, Remy.Card@linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: fs/ext2/namei.c: dir link/unlink bug? [Re: mv changes dir timestamp
In-Reply-To: <m17kuf4vhu.fsf@frodo.biederman.org>
In-Reply-To: <Pine.LNX.3.96L.1010930151001.4952F-100000@d-alg.ece.cmu.edu>
	<m17kuf4vhu.fsf@frodo.biederman.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This actually looks like a fix.  Ext2 keeps a directory entry
> > > named .. in the directory so it knows what the parent directory
> > > is.  So to rename a directory besides it must unlink(..) and the
> > > link(..) inside the directory being moved, at least logically.
> > > In the case you gave as the parent directory didn't change it
> > > could be optimized out, but it probably isn't worth it.
[...]
> > > I know this is different but why is this a problem?
> My question is which semantics are desirable, and why.  I conceed
> that something has changed.  And that changing the functionality back
> to the way it was before may be desireable.  But given that the
> directory is in fact changed my gut reaction is that the new behavior
> is more correct than the old behavior.

I would preserve the timestamp for these reasons.

1. Changing the timestamp is counter-intuitive.  Over time many people
   will be surprised by this behavior.  It is less surprising to
   preserve the timestamp for the cases where nothing changed.

2. Since the .. entry did not change this variance seems gruitous.
   That is, a listing of the directory contents will not show any
   change whatsoever.  So in the case that there was no real changes
   the timestamp update seems out of place.

3. It is a common practice to use timestamp and file size to determine
   if changes have occured.  It is also common to move directories
   (and files) out of the way while testing a copy of data for
   specific test purposes.  I can easily construct examples where no
   changes *should* exist but this new behavior would show gratitious
   timestamp updates.
      mv foo foo.bak
      cp -a foo.bak foo
      hack on foo
      rm -rf foo
      mv foo.bak foo

4. This new behavior is different from traditional UNIX filesystems.
   If the difference is arbitrary but neither good nor bad I would
   stick with the traditional behavior.

I tested this on both HP-UX, IBM AIX and Linux.  HP-UX always
preserved the previous timestamps.  The same with 2.2.x versions of
Linux.  AIX was different and preserved the previous timestamp if
the .. entry was the same as before but updated the timestamp if .. was
different than before.  But in the case where no real changes occurred
none updated the timestamp.  It would be interesting to see what
Sun's Solaris and other systems do in those cases.  This does not seem
like a huge deal.  There were differences in the different commercial
flavors.  But I like to think that we can do better than that.

Bob
