Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132710AbRDJQy5>; Tue, 10 Apr 2001 12:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132972AbRDJQyu>; Tue, 10 Apr 2001 12:54:50 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:32005 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S132710AbRDJQyj>; Tue, 10 Apr 2001 12:54:39 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: adilger@turbolinux.com
Subject: Ext2 Directory Index - File Structure
Cc: linux-kernel@vger.kernel.org
Message-Id: <20010410165316Z92272-3053+23@humbolt.nl.linux.org>
Date: Tue, 10 Apr 2001 18:53:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you going to go to a COMPAT flag before final release?  This is
> pretty much needed for e2fsck to be able to detect/correct indexes.

I will if I know what the exact semantics are.  I have only an
approximate idea of how this works and I'd appreciate a more precise
definition.

> One thing I was thinking about the root entry - for compatibility with 2.0
> and earlier kernels (which don't clear INDEX_FL) there is a simple
> solution:
>
> - deleted dirents do not pose any problems, because a hash index is no
>   guarantee that a specific dirent exists, only a range of possible entries
> - adding a dirent will _always_ go into the first empty block (which is the
>   index root block), and overwrite the dx_root_info data after "." and ".."
>
> In the latter case (and also in the case of data corruption), it is useful
> to have some sort of integrity check within dx_root_info.  If a dirent
> overwrote the root index block, the first 4 bytes of the dirent after
> "." and ".." would be an inode number, this could be anything and is not
> very useful for detecting if it is a valid number or not.  However, if you
> put the "reserved_zero" field first and swap the order of "hash_version"
> and "info_length", then "info_length" and "hash_version" will overlap with
> the "rec_len" field of a new dirent.  If (hash_version & 3) is always true,
> a valid "rec_len" is always a multiple of 4, so it is possible to detect if
> the dx_root_info has been overwritten by an old version of ext2 code.  So:
>
>                 struct dx_root_info {
>                         struct fake_dirent fake1;
>                         char dot1[4];
>                         struct fake_dirent fake2;
>                         char dot2[4];
> /* __u32 inode; */      le_u32 reserved_zero;
> /* __u16 rec_len lo */  u8 hash_version; /* 1, or 2, or 3, but not 0 or 4 
> /* __u16 rec_len hi */  u8 info_length;  /* 8 */
>                         u8 indirect_levels
>                         u8 unused_flags;
>                 } info;
>
> It will also be easy to detect if reserved_zero is changed, because zero is
> not a valid inode number.  We can't rely on fake2's rec_len in case a dir
> entry was added and then deleted (corrupting dx_root_info, but leaving
> fake1 and fake2 as they should be).

OK, this really does give a lot better protection against those wild and
crazy admins who switch back and forth between 2.0 and 2.5 systems on a
regular basis.  ;-)  Since it costs next to nothing I think this is a
good idea.  It looks a little funny to have the info_length in the
middle of the info instead of at the beginning, but it would hardly be
the strangest layout I've ever seen.

So this is the new plan: reorder the fields as you suggest and let
hash_version be 1 when the hash function is finally frozen.  Then we are
ok until somebody comes up with a hash function version 4, and we have
to decide to skip that one or throw caution to the winds and use it. 
(By this time, Linux 2.0 may be as distant a memory as 1.0)  As a fringe
benefit we will automatically flag any test directories inadvertently
left around after being created by pre-release code.  A comment goes
into the code advising against hash functions which are even multiples
of 4, and why.  On detecting an invalid hash function we kprint a
message advising a fsck and fail the lookup.

> > The high four bits of the block pointer field are reserved for use by
> > a coalesce-on-delete feature which may be implemented in the future.
> > The remaining 28 bits are capable of indexing up to 1TB per directory
> > file.  (Perhaps I should coopt 8 bits instead of 4.)
>
> Might be worthwhile, even if you don't use all of the bits for coalesce
> flags.  Nothing better than having free space for future expansion.  Even
> for a 1kB block filesystem, this would give us directories up to 16GB, at
> worst case about 32M 256-character entries, average case 595M 9-to-12-character
> names.  Having 24 bits for 4kB block (64GB) directories gives us worst-case
> 117M 256-character entries, and average case 2.2B 9-to-12 character names.
> Assumes 50% full leaf blocks for worst case, 70% full for average case.
>
> For that matter, I'm not even sure if ext2 supports directory files larger
> than 2GB?  Anyone?  I'm not 100% sure, but it may be that e2fsck considers
> directories >2GB as invalid.
>
> > Thus, directory leafs will average no more than 75% full and typically
> > a few points less than that since the hash function never produces a
> > perfectly uniform distribution.  (The better the hash function, the
> > closer we get to 75%; we are currently at 71%.)
>
> Have you been testing this with different kinds of input for filenames,
> or only synthetic input data?

Only very boring, sequentially numbered names so far.  Which reminds me:
I should probably improve the method of finding the middle of the block
for a split, which currently just picks the n/2th entry as the midpoint.
The correct thing to do is walk the sorted list of names twice, once to
find the total length of entries and again to find the entry closest to
1/2 that.  This code is easy to write but it's a little distasteful
because of its bulk in comparison to the small average performance
improvement we'd see.  For now I guess I'll just stick with the crude
approximation and beef up the comment.

Because I'm not relying on any particular properties of coherence of
names, i.e., my hash function is as random as I can make it, I think the
sequential names are a pretty good test, except that they are all of
similar length.

Here is my "makefiles" test code:

	int main (int argc, char *argv[])
	{
		int n = (argc > 2)? strtol(argv[2], 0, 10): 0;
		int i, size = 50, show = argc > 3 && !strncmp(argv[3], "y", 1);
		char name[size];
		for (i = 0; i < n; i++)
		{
			snprintf(name, size, "%s%i", argv[1], i);
			if (show) printf("create %s\n", name);
			close(open(name, 0100));
		}
		return 0;
	}

Sample usage:

	makefiles /mountpoint/testdir/basename 1000000 y

Which creates 1,000,000 files named basename0..basename999999 in
testdir (which better have been created with an index or this test will
take several days to finish).  The "y" enables listing of names and
should be off for a real benchmark run.

It would be a good idea to elaborate this code to generate names with
randomly varying lengths.

> One interesting dataset would be to get
> the filename generation code from sendmail (for /var/spool/mqueue) and/or
> inn and/or squid to see how those names are hashed.  These are legitimate
> applications which tend to store lots of files in a single directory.

Yes, I won't do that myself but I'd be happy if somebody did.

> > It is quite likely that the hash function will be improved in the
> > future, therefore a hash function version field is included in the root
> > header.  If the current code sees a nonzero hash function version it
> > will fail the directory operation gracefully.  Thus, the worst possible
> > effect of adding a new hash function in the future is that old versions
> > of ext2 will not be able to access a directory created with the new hash
> > function.  (Alternatively, we could arrange a fallback to a linear
> > search.)
>
> The fallback to a linear search is pretty much a requirement anyways, isn't
> it?

Yes, in the sense that the new code also has to be able to handle
nonindexed directories, which it does now.  As far as falling back to a
linear search after somebody has done something boneheaded - I think
it's better to fail and kprint a suggestion to run fsck, which can
easily fix the problem instead of allowing it to go unnoticed and
perhaps adversely affect system performance.  The problem here is that
most users do not check their log files unless something doesn't work.
In this case, failing instead of pressing on constitutes helping, not
hurting.

> What happens with an existing directory larger than a single block
> when you are mounting "-o index"?  You can't index it after-the-fact, so
> you need to linear search.

This works now.

> This also needs to be the case if you detect
> bogus data in the index blocks.  If there is any erronous data in the index
> blocks, you basically need to turn off the INDEX flag, mark the filesystem
> in error, and revert to linear searching for that directory (leaving it to
> e2fsck to fix (based on a COMPAT flag).

Hmm.  How about just marking the filesystem in error, issuing an advice
to run fsck, and failing.  We are most likely talking about a situation
that came about as an ill-conceived series of kernel upgrades and
fallbacks between 2.0 and 2.4/2.5 kernels.  An admin who really wants to
do this would be better advised to upgrade to a recent 2.2 kernel as an
intermediate step.

Another possibility is that we're seeing real disk corruption because of
faultly hardware or a kernel bug.  In that case, we really don't want to
continue, we want to deal with it.

> > To Do
> > -----
> >
> >   - Finalize hash function
> >   - Test/debug big endian
> >   - Convert to page cache
> >
> > Future Work
> > -----------
> >
> >   - Fail gracefully on random data
> >   - Defer index creation until 1st block full
>
> I would consider both of these in the "To Do" category before it goes into
> the kernel.  Otherwise, in 99% of the normal directories, you are doubling
> the space needed for a directory, which means you will need to weigh on a
> filesystem-by-filesystem basis whether to use indexing.  I would rather be
> able to turn it on for all filesystems.

OK, that's settled.  For the release version I'll just try to reduce the
likelihood of oopsing on random data rather than trying to provide an
airtight guarantee.

> > [1] The index tree could have been made finer-grained than one block,
> > but not without sacrificing the desireable property of forward
> > compatibility with older Linux versions (because the directory block
> > format would have had to have been changed) and it is not clear that a
> > finer-grained index would perform better.
>
> Interestingly, I was reading on the reiserfs list that they are looking
> at (for performance reasons) using linear hash searching for under about
> 100 because of reduced overhead.  Whether this goes into the code or not
> will obviously be determined by their testing, it does make some sense.
> If we had sub-block indexing, then we would need to keep the index entries
> sorted to a finer resolution, adding more overhead to each entry.

I have designed an incompatible directory block format that includes an
internal index and uses the same number of bytes per entry, including
the index overhead.  I intend to code this up and try it sometime later
this year just to see if the performance improvement is significant.  If
it is then, well... we'll deal with it then.

As far as bulking up the index goes, my guess is that just costs
performance because of the bigger cache footprint.

> > [4] The test for directory size could be eliminated if we are willing to
> > accept that indexing be used on all new directories.  In that case the
> > index flag would be set on any directory larger than a block.  A
> > decision was made to err on the side of more control by the
> > administrator, who can now be offered the option of specifying which
> > directories should be indexed and which not.
>
> I'm not sure I follow this.  Isn't this the case already (or at least the
> same as "only add the index after we grow past 1 block")?  Namely, don't
> all directories get an index block (especially those growing larger than
> 1 block), or do you need to "chattr" each directory which will get an
> index?

New directories get the index flag set but with the planned
optimization, don't get an index until they grow over a block.

> If e2fsck gets into the picture with a COMPAT flag, I would think it
> will build an index for any directory larger than 1 block (to free the
> kernel from having to do this on existing filesystems).

That makes sense to me.  There probably should be some way to suppress
the automatic index addition, for example, when a user has a partition
that's 100% full.
