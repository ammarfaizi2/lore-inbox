Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278092AbRJ1Jx6>; Sun, 28 Oct 2001 04:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278095AbRJ1Jxt>; Sun, 28 Oct 2001 04:53:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25300 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278092AbRJ1Jxj>;
	Sun, 28 Oct 2001 04:53:39 -0500
Date: Sun, 28 Oct 2001 04:54:13 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@atnf.csiro.au>
cc: Rik van Riel <riel@conectiva.com.br>,
        Ryan Cumming <bodnar42@phalynx.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <200110280845.f9S8jjJ25269@mobilix.atnf.CSIRO.AU>
Message-ID: <Pine.GSO.4.21.0110280348320.23288-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Oct 2001, Richard Gooch wrote:

> Complete fucking bullshit. Over the last several months, I've been
> sending a steady stream of bugfix patches to Linus and the list, and
> if you'd been paying attention, you'd notice that in time they've been
> applied.

OK, _now_ I'm really pissed off.  As far as I can see there is only
one way to get you fix anything - posting to l-k.  This "steady
stream" consists of what?  Let's see:

0.118:	buffer underrun in try_modload().  Source: some Al Viro had hit
the function in question in grep over tree and took a couple of minutes
to read it.
0.118:  moving down_read() - yes, it had fixed the instance of deadlock
pointed to you by, damn, what a coincidence, same bastard.  Come to think
of that, let me grep for down_read()...  Aha.

static int devfs_follow_link (struct dentry *dentry, struct nameidata *nd)
{
    int err;
    struct devfs_entry *de;

    de = get_devfs_entry_from_vfs_inode (dentry->d_inode, TRUE);
    if (!de) return -ENODEV;
    down_read (&symlink_rwsem);
    err = de->registered ? vfs_follow_link (nd,
                                            de->u.symlink.linkname) : -ENODEV;
    up_read (&symlink_rwsem);
    return err;
}   /*  End Function devfs_follow_link  */

Umm... Hadn't we just been there?  Recursive down_read(&symlink_rwsem)...

0.117: oh, wow - finally.  devfs_link() is gone.

0.116: reverted previous broken patch, but result contained a deadlock instead
of race.  Result of race scenario described on l-k by... damn, this asshole
again.

0.115: bogus fix for breakage introduced by blkdev-in-pagecache patch.  Hadn't
got into Linus' tree, actually.

0.114: introduced broken refcounting for symlinks (see 0.116)

0.113: "quick and dirty hack" to protect symlink bodies.  Broken, at that.
BTW, breakage in 0.113 and 0.114 hadn't stopped Mandrake from deciding that
it fixed readlink() race and shipping the thing.  Funny, but race it was
supposed to fix had been described in private email several months before.
Then it was described on l-k.  Then description had been forwarded to Mandrake
- after a question about potential breakage.  _Then_ (and I assume that it
was a coincidence) said patches had appeared.

0.111, 0.112: not a fix by any stretch of imagination.

Oh, and before that we have a (finally, only after a year of mentioning
the crap in question, heavy-weight rant on l-k when I've finally ran out
of patience _and_ detailed discussion on the possible fixes) fix for
expand-entry-table races.


So far all I see is that beating you hard enough in public can make you
fix the bugs explicitly pointed to you.  That's it.  As far as I can
see you don't read your own code, judging by the fact that every damn
look at fs/devfs/base.c shows a new hole within a couple of minutes
_and_ said holes stay until posted on l-k.  Private mail doesn't work.
You read it, reply and ignore.  About hundred kilobytes of evidence
available at request.

