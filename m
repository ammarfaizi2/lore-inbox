Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRJAIgy>; Mon, 1 Oct 2001 04:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274765AbRJAIgp>; Mon, 1 Oct 2001 04:36:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35704 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274757AbRJAIgk>; Mon, 1 Oct 2001 04:36:40 -0400
To: Nilmoni Deb <ndeb@ece.cmu.edu>
Cc: Jim Meyering <jim@meyering.net>, viro@math.psu.edu, bug-fileutils@gnu.org,
        Remy.Card@linux.org, linux-kernel@vger.kernel.org
Subject: Re: fs/ext2/namei.c: dir link/unlink bug? [Re: mv changes dir timestamp
In-Reply-To: <Pine.LNX.3.96L.1010930151001.4952F-100000@d-alg.ece.cmu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Oct 2001 02:25:49 -0600
In-Reply-To: <Pine.LNX.3.96L.1010930151001.4952F-100000@d-alg.ece.cmu.edu>
Message-ID: <m17kuf4vhu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nilmoni Deb <ndeb@ece.cmu.edu> writes:

> On 30 Sep 2001, Eric W. Biederman wrote:
> 
> > Jim Meyering <jim@meyering.net> writes:
> > 
> > > Nilmoni Deb <ndeb@ece.cmu.edu> wrote:
> > > > When I move a directory its time stamp gets changed.
> > > > I am using mv version 4.1 (with mandrake-8.1).
> > > 
> > > Thanks a lot for reporting that!
> > > This appears to be a bug not in GNU mv, nor even in GNU libc, but
> > > rather in the underlying implementation in the kernel ext2 file system
> > > support.  The offending change seems to have come in with a rewrite
> > > of fs/ext2/namei.c that happened sometime between 2.4.4 and 2.4.9.
> > > 
> > > That file begins with this new comment:
> > > 
> > >  * Rewrite to pagecache. Almost all code had been changed, so blame me
> > >  * if the things go wrong. Please, send bug reports to viro@math.psu.edu
> > > 
> > > This demonstrates that the problem affects ext2, but not tmpfs
> > > using a 2.4.10 kernel (notice that the timestamp doesn't change
> > > in /t, but does in the ext2 /tmp):
> > 
> > This actually looks like a fix.  Ext2 keeps a directory entry named
> > .. in the directory so it knows what the parent directory is.
> > So to rename a directory besides it must unlink(..) and the link(..) inside
> > the directory being moved, at least logically.  In the case you gave
> > as the parent directory didn't change it could be optimized out, but
> > it probably isn't worth it. 
> > 
> > I know this is different but why is this a problem?
> 
> We are used to the preservation of time stamps during a dir move
> (both inside and outside its parent dir) in other working kernels such as
> 2.2.x and 2.4.2 and 2.4.3. After all, dir time-stamp lets us know when
> directory contents have been last changed. 

The contents of the .. directory entry where changed in the move.
This is why I don't see the immediate problem.  I see the difference
but I don't see the problem.

> In fact even "cp -p" allows
> the user to preserve the time stamp during dir copy. With the current
> implementation of mv the user will not have the option of preserving the
> time-stamp during a dir move. In any case, if we want to change the time
> stamp of a dir we always have the option of using touch.

Or vice versa, as touch will also go back in time.

My question is which semantics are desirable, and why.  I conceed
that something has changed.  And that changing the functionality back
to the way it was before may be desireable.  But given that the
directory is in fact changed my gut reaction is that the new behavior
is more correct than the old behavior.

Eric

