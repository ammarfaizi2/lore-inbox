Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263009AbVDLV0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbVDLV0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVDLVXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:23:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:14035 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262969AbVDLVUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:20:12 -0400
Date: Tue, 12 Apr 2005 14:21:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Eger <eger@havoc.gtf.org>
cc: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
In-Reply-To: <20050412204429.GA24910@havoc.gtf.org>
Message-ID: <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org>
 <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Apr 2005, David Eger wrote:
> 
> The reason I am questioning this point is the GIT README file.
> 
> Linus makes explicit that a "blob" is just the "file contents," and that
> really, a "blob" is not just the SHA1 of the "blob":
> 
> > In particular, the "current directory cache" certainly does not need to
> > be consistent with the current directory contents, but it has two very
> > important attributes:
> > 
> > (a) it can re-generate the full state it caches (not just the directory
> >     structure: through the "blob" object it can regenerate the data too)
> 
> And he defines "TREE" with the same name: blob

Yes. A tree is defined by the blobs it references (and the subtrees) but 
it doesn't _contain_ them. It just contains a pointer to them.

> Therefore, "TREE" must be the *full* data, and since we have the following
> definition for CHANGESET:

No. A tree is not the full data. A tree contains enough information to 
_recreate_ the full data, but the tree itself just tells you _how_ to do 
that. It doesn't contain very much of the data itself at all.

> That each changeset remembers *everything* for *each point in the tree*.

But only BY REFERENCE. A "commit" is usually very small. For example, the
top-of-tree commit-file for my currest kernel test is literally 401
_bytes_ in size. Because it just references a tree (20 bytes of
_reference_).

> Linus, if you actually mean to differentiate between the full data
> and a SHA1 of the data

There is no differentiation. The sha1 _is_ the data as far as git is 
concerned. 

It's only confusing if you think they are different. 

> Also, the details of just what data constitutes a 'changeset' would be
> lovely... i.e. a precise spec of what Pat is describing below...

	torvalds@ppc970:~/test-tools/linux-2.6.12-rc2> cat-file commit `cat .git/HEAD `
	tree cf9fd295d3048cd84c65d5e1a5a6b606bf4fddc6
	parent c7a1a189dd0fe2c6ecd0aa33f2bd2f414c7892a0
	author NeilBrown <neilb@cse.unsw.edu.au> Tue Apr 12 08:27:08 2005
	committer Linus Torvalds <torvalds@ppc970.osdl.org> Tue Apr 12 08:27:08 2005

	[PATCH] md: remove a number of misleading calls to MD_BUG

	The conditions that cause these calls to MD_BUG are not kernel bugs, just
	oddities in what userspace is asking for.

	Also convert analyze_sbs to return void, and the value it returned was
	always 0.

	Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
	Signed-off-by: Andrew Morton <akpm@osdl.org>
	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

That's it. In all it's glory. Compressed and tagged it's 401 bytes. 

The tree it references is 677 bytes in size. That in turn references a 
number of subtrees, but almost all of the sub-trees are shared with 
_other_ tree commits, so their size is spread out over all the commits.

The full archive of the 2.6.12-rc2 kernel that I used for testing (only
_one_ version) is 102MB in size. That's about half of what the kernel is
uncompressed.

The full .git archive for 199 versions of the kernel (the 2.6.12-rc2 one
and a test-run of 198 patches from Andrew) is 111MB. In other words,
adding 198 "full" new kernels only grew the archive by 9MB (that's all
"actual disk usage" btw - the files themselves are smaller, but since they
all end up taking up a full disk block..)

Basically, the whole point of git is that objects are equated with their 
sha1 name, and that you can thus "include" an object by just referring to 
its name. The two are equivalent. 

		Linus
