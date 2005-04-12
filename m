Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVDLE77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVDLE77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 00:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVDLE77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 00:59:59 -0400
Received: from [61.51.204.158] ([61.51.204.158]:49633 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261960AbVDLDR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 23:17:29 -0400
Date: Tue, 12 Apr 2005 11:02:19 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200504120302.j3C32JJ00772@freya.yggdrasil.com>
To: barkalow@iabervon.org
Subject: Re: New SCM and commit list
Cc: benh@kernel.crashing.org, dwmw2@infradead.org, greg@kroah.com,
       james.bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mason@suse.com, mingo@elte.hu,
       torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-11, Daniel Barkalow wrote:
>If merge took trees instead of single files, and had some way of detecting
>renames (or it got additional information about the differences between
>files), would that give BK-quality performance? Or does BK also support
>cases like:
>
>orig ---> first ---> first-merge -
> |                /               \
> |------> second -                 -> final
> |                \               /
> |------> third ---> third-merge -
>
>where the final merge requires, for complete cleanliness, a comparison of
>more than 3 states (since some changes will have orig as the common
>ancestor and some will have second).

	With 3-way merge and the ability to regenerate the relevant
files from each step, this should be easy to handle as long
as you have a list of which patches are considered to have been
duplicated.  Let's detail your example:

orig ---> first 1a 1b 1c ---> first-merge - 1d 1e
 |                          /                    \
 |------> second 2a 2b 2c -                       -> final
 |                          \                    /
 |------> third 3a 3b 3c ---> third-merge - 3d 3e

Here, 1a, 1b, etc. refer to specific states of the source tree.
I will refer to differences by a notation like "1a->1b", which
is the difference to go from snapshot 1a to 1b.  All that the
merge algorithm for the final merge needs to know is that the
ends of the branches (that is, 1e and 3e) both contain the
following diffs:

		orig->2a
		2a->2b
		2b->2c

	The function merge(orig, ver1, ver2) can try to reverse
the duplicate merges in one of the branches:

		1e' = merge( 1e, 2c->2b);
		1e'' = merge(1e', 2b->2a);
		1e''' = merge(1e'', 2a->orig);
		return merge(1e''', 2c->3e)

	Of course, conflicts can happen, but that can happen
in any merge.  There are also other ways to calculate the
merge and because there are different ways one can write a
merge function, it is possible that merging in a different
order might produce slightly different results.  For example,
it would be possible to reverse the dpulicates in your "third merge"
branch instead of your "first merge" branch, or one could
reconstruct a branch without the duplicated merges by executing
the other changes forward from a common ancestor, like so:

		1e''' = merge(orig, 3d->3e);

	...regardless, the point is that all the information
that is absolutely needed is a list of instance of diffs
to be skipped.  It is not even necessary that the changes
have such a clearly explainable ancestory as that you have
described.  All the merge program needs to know are the changes
to be skipped, although information like changes the skipped
patches are duplicating may be useful for things like trying
to reverse a patch in your "third-merge" branch in your
example if reverseing the patch in "first-merge" fails.

	I believe that at least bitkeeper, darcs, a free python-based
system that I can't remember at the moment, and possibly arch do this
sort of machination already.


>Does this happen in real life? [...]

	Yes.  Both individual users and Linux distributions incorporate
patches that they think are useful to them and then futher patches
that they develop.  The time costs of rejecting such patches would
likely be paid for by other integration or development work not being
done.

>It seems like sane development processes
               ^^^^
>wouldn't have multiple mainline-candidate patch sets including the same
>patches, if for no other reason than that, should the merge fail, nobody
>with any clue about the original patches would be anywhere nearby.

	If you could avoid prejudicial subjective adjectives, it
it would make it easier for the saneness or insaneness of an
approach to be apparent just by discussing your more objective criteria,
like the remainder of your sentence, which is where the focus should
be.

	(1) Does allowing duplicate patches really mean that
	   "nobody with any clue about the original patches would be
	   anywhere near by?"  What attracts these clueful people
	   just by third parties having to rebase their patches?

	(2) Does this supposed benefit outweigh the cost of rejecting
	    many patches unnecessarily?  I know from my own experience
	    that I have either given up on or had to put into a very low
	    priority mode at least 66% of the patches that I haven't
	    gotten integrated, but which I am confident the kernel
	    would be better having (e.g.: devfs shrink, lookup()
	    trapping, ipv4 as a loadable (not not yet removable) module,
	    sysfs memory shrink, factoring much of the DMA mapping to
	    the common bus code from individual drivers, fewer kmap's
	    in crypto, I could go on).

>It
>seems better to throw something back to someone to rebase their diffs.
       ^^^^^^

	I try to avoid a general subjective adjectives like "better"
unless I am claiming that I've covered the trade-offs fully, and, even
then, avoiding it keeps the focus on analyzing the trade-offs.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
