Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269881AbUH0BIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269881AbUH0BIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269863AbUH0BFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:05:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3976 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269809AbUH0BCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:02:30 -0400
Date: Fri, 27 Aug 2004 02:01:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: [some sanity for a change] possible design issues for hybrids
Message-ID: <20040827010147.GE21964@parcelfarce.linux.theplanet.co.uk>
References: <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org> <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org> <20040826223625.GB21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261538030.2304@ppc970.osdl.org> <20040826225308.GC21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261619230.2304@ppc970.osdl.org> <20040826234048.GD21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261652240.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261652240.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 04:57:01PM -0700, Linus Torvalds wrote:
> Right. We obviously need to mark the dentry somehow, and only do the 
> "create vfsmount" special case in this special case. If we didn't do that, 
> then it wouldn't be a special case, now would it?
> 
> So clearly lookup_mnt() needs to check the dentry in the failure case. The 
> marking could be in any of three places
>  - mark the dentry itself by just using a dentry flag ("DCACHE_AUTOVFSMNT")
>    or by having a dentry operation for this.
>  - mark the inode itself (same logic as dentry)
>  - look up the first vfsmount (on the inode list), and look if that one is 
>    of the automatic type.
> 
> Clearly we should not _always_ create a vfsmount, that would just break 
> the existign logic.

Hmm...  IOW, you are suggesting to use normal trigger for lookup_mnt() and
then have extra check in lookup_mnt() failure exit.  That will probably
work (and I'd prefer to mark dentry here).

Freeing these guys will not be fun.  The final reference could be given
up under very different locking conditions - it's certainly a blocking
operation (it can trigger final umount, among other things), but having
it trigger removal from mount tree(s) can get ugly.  We might be able to
tweak that, but it will probably need require major surgery in several
places.

Right now we assume that vfsmount lock *and* per-namespace semaphore are
held when detaching from the tree (attaching what could be the first at
given dentry --- same + i_sem on its ->i_sem).  We also assume that vfsmount is
detached before refcount reaches zero.  The thing is, that final refcount
can be dropped while holding namespace semaphore.  It's not fatal (we'll
need to hold onto these guys until dropping that semaphore or add an analog
of mntput() for places under namespace sem), but it can get messy.

Situation with unlink(): we need to (a) check that all vfsmounts over
given point are "hybrid" ones (locking is not a problem at that point)
and (b) after successful operation (unlink() and rename() alike, AFAICS)
we want to go and kill everything under the victim dentry.  *That*
can get very ugly, since fs could be mounted in a lot of places and/or
in a lot of namespaces.

Note that we also need to do in VFS what NFS tries to do in revalidation -
if dentry is invalidated, everything under it should be detached and
dropped.  So it's not something new - we do need something that would
be called outside of any superblock/namespace/vfsmount locks (both
unlink() and revalidation qualify) and would kill the vfsmounts that
become unreachable.

Locking rules for attaching might need adjustment (the logics with ->i_sem
is that we want !d_mountpoint() stay true around call of ->unlink(),
->rmdir() and ->rename(); so cloning or replacing doesn't need that
protection.  Now it might become interesting - we'll need to be careful
in pivot_root(2) and possibly some other places).

I'll see what can be done (it'll definitely take careful looking at the
code), but there is a chance of things getting very ugly.

BTW, shared subtrees *are* compatible with that puppy - there's a lot
of corner cases to look at, but AFAICS they are all doable.  Lifetime
rules can get ugly in some of them, but that's on par with the situation
without sharing.

One thing that looks like a bad interface: we get forcible "use same
dentry for file and directory" with that design.  That can lead to
a big can of worms - without a large audit I wouldn't bet a dime on
ability to get that right (and same applies to reiser4 code as-is,
for the same reasons).  No idea how bad it will turn out to be - right
now all I can say is that we might run into trouble and that we almost
certainly will get extra "be careful not to do <list of things>" rules
out of that.
