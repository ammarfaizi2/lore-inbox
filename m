Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281415AbRKMB3C>; Mon, 12 Nov 2001 20:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281424AbRKMB2y>; Mon, 12 Nov 2001 20:28:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:45561
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281415AbRKMB2l>; Mon, 12 Nov 2001 20:28:41 -0500
Date: Mon, 12 Nov 2001 17:28:32 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andrew Morton <akpm@zip.com.au>, Ben Israel <ben@genesis-one.com>,
        linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011112172832.F32099@mikef-linux.matchmail.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Andrew Morton <akpm@zip.com.au>, Ben Israel <ben@genesis-one.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> <3BF02702.34C21E75@zip.com.au> <200111121959.fACJxsj08462@vindaloo.ras.ucalgary.ca> <20011112150740.B32099@mikef-linux.matchmail.com> <200111130004.fAD04v912703@vindaloo.ras.ucalgary.ca> <20011112160822.E32099@mikef-linux.matchmail.com> <200111130026.fAD0QVK13232@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111130026.fAD0QVK13232@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 05:26:31PM -0700, Richard Gooch wrote:
> Mike Fedyk writes:
> > On Mon, Nov 12, 2001 at 05:04:57PM -0700, Richard Gooch wrote:
> > > I thought the current implementation was that when creating a
> > > directory, ext2fs searches forward from the block group the parent
> > > directory is in, looking for a "relatively free" block group. So, a
> > > number of successive calls to mkdir(2) with the same parent directory
> > > will result in the child directories being in the same block group.
> > > 
> > > So, creating the directory tree by creating directories in the base
> > > directory and then shuffling should result in the directories be
> > > spread out over a modest number of block groups, rather than a large
> > > number.
> > > 
> > > Addendum to my scheme: leaf nodes should be created in their
> > > directories, not in the base directory. IOW, it's only directories
> > > that should use this trick.
> > > 
> > > Am I wrong in my understanding of the current algorithm?
> > 
> > You are almost describing the new algo to a "T"...
>

This is talking about the previous post only...  The two messages above are
comment and reply, and are meant for each other. The part about tar moved
below...

> I assume you mean my scheme for tar. Which is an adaptation for
> user-space of a scheme that's been proposed for in-kernel ext2fs.
>

Nope, not one bit...

> > It deals very well with fast growth, but not so well with slow
> > growth, as mentioned in previous posts in this thread...
> 
> Yes, yes. I know that.
>

Ok...  We're getting somewhere.

> > There is a lengthy thread in ext2-devel right now, if you read it
> > it'll answer many of your questions.
> 
> Is this different from the long thread that's been on linux-kernel?
>

Yes.  The thread on ext2-devel will give you *much* more detail on the patch
you are trying to understand.

> Erm, I'm not really asking a bunch of questions. The only question I
> asked was whether I mis-read the current code, and that in turn is a
> response to your assertion that my scheme would not help, as part of
> an explanation of why it should work. Which you haven't responded to.

Hmm, I don't see the part I didn't reply to...

> If you claim my tar scheme wouldn't help, then you're also saying that
> the new algorithm for ext2fs won't help. Is that what you meant to
> say?
>

No, I'm not saying that...

> In any case, my point (I think you missed it, although I guess I
> didn't make it explicit) was that, rather than tuning the in-kernel
> algorithm for this fast-growth scenario, we may be better off adding
> an option to tar so we can make the choice in user-space. From the
> posts that I've seen, it's not clear that we have an obvious choice
> for a scheme that works well for both slow and fast growth cases.
>

Maybe not obvious, but with a little work, both can probably be made *better*.

> Having an option for tar would allow the user to make the choice.
> Ultimately, the user knows best (or at least can, if they care enough
> to sit down and think about it) what the access patterns will be.
>

Fixing tar won't help anyone except for tar users.  What about the other
programs that create activity much like tar?  This isn't a user space issue.

> However, I see that people are banging away at figuring out a generic
> in-kernel mechanism that will work with both slow and fast growth
> cases. We may see something good come out of that.
> 

Yep

===================

Let me disect our previous conversation...

> > > > On Mon, Nov 12, 2001 at 12:59:54PM -0700, Richard Gooch wrote:
> > > > > Here's an idea: add a "--compact" option to tar, so that it creates
> > > > > *all* inodes (files and directories alike) in the base directory, and
> > > > > then renames newly created entries to shuffle them into their correct
> > > > > positions. That should limit the number of block groups that are used,
> > > > > right?
> > > > > 

Currently, without any patching, any new directory will be put in a
different block group from its parent.

So, if you create the dirs in the same dir and then shuffle them around, you
gain nothing.

> > > > > It would probably also be a good idea to do that for cp as well, so
> > > > > that when I do a "cp -al" of a virgin kernel tree, I can keep all the
> > > > > directory inodes together. It will make a cold diff even faster.
> > > > 

This doesn't fix all fast growth type apps, only tar and cp...

> > > Mike Fedyk writes:
> > > > I don't think that would help at all... With the current file/dir
> > > > allocator it will choose a new block group for each directory no
> > > > matter what the parent is...
> > > 

Now does this make sence?

> > On Mon, Nov 12, 2001 at 05:04:57PM -0700, Richard Gooch wrote:
> > > I thought the current implementation was that when creating a
> > > directory, ext2fs searches forward from the block group the parent
> > > directory is in, looking for a "relatively free" block group. So, a
> > > number of successive calls to mkdir(2) with the same parent directory
> > > will result in the child directories being in the same block group.
> > >

Not currently, but the patch that is out will do this.

> > > So, creating the directory tree by creating directories in the base
> > > directory and then shuffling should result in the directories be
> > > spread out over a modest number of block groups, rather than a large
> > > number.
> > >
> > > Addendum to my scheme: leaf nodes should be created in their
> > > directories, not in the base directory. IOW, it's only directories
> > > that should use this trick.
> > > 

If the kernel is patched...

> > > Am I wrong in my understanding of the current algorithm?
> > 

Yes.

> Mike Fedyk writes:
> > You are almost describing the new algo to a "T"...
>

The above is a little more verbose, does it help?

Now, if I am not stating fact, as things currently are, and the state of
available patches are not what I am describing, someone please let me know.
Though to my understanding there is no error.

Mike
