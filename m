Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291545AbSBAFKN>; Fri, 1 Feb 2002 00:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291546AbSBAFKH>; Fri, 1 Feb 2002 00:10:07 -0500
Received: from 2Cust41.tnt15.sfo3.da.uu.net ([67.218.141.41]:40718 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S291548AbSBAFJv>;
	Fri, 1 Feb 2002 00:09:51 -0500
Date: Fri, 1 Feb 2002 00:16:13 -0800 (PST)
Message-Id: <200202010816.AAA25882@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: linux-kernel@vger.kernel.org
Subject: searching patch space (linear->bushy revisions)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Please CC me on replies]

Suppose two programmers each work on improving the performance of the
scheduler.  Each of them make a series of small, mostly independent
changes, checking each set into a revision control system (`arch' in
particular).


We then have two development paths:


	A1 -> A2 -> A3 -> A4 .... -> Am

	B1 -> B2 -> B3 -> B4 .... -> Bn


Now consider all non-empty subsets of the two development paths.
These would include, for example:


	{A1, B3, A5, B6}

	{ B1 }

	....

There are (if I'm not doing my math too quickly):

		(2^(m + n) - 1)

subsets of patches.

For each subset of N patches, there are N! ways of ordering those
patches.  So, with no other information to narrow the choices, there
are:


	       (m + n) * 1!
	    +  (2 choose (m + n)) * 2!
	    +  (3 choose (m + n)) * 3!
	    ...

ways in which we might pick a subset of the patches and apply them
to a tree.  If you remember your combinatorics, you can reduce
that equation to:


    "a very large number unless m and n are very small"

In the general case, some of those sequences of patches won't apply
without conflicts.  Some of them will result in the same final tree as
others.  Some final trees won't even compile.  Of those that compile,
some will have better performance than others.

Assuming all the patches meet other criteria, such as coding style,
Linus' job is to find the optimal subset and sequence of patches
according to some metric.

Linus has asked for a particular revision control feature that can 
help him search the space of patches: the ability to turn a linear
sequence of patches into a bushy collection of patches by discovering
which ones are orthogonal to the others.

If you use arch, discovering the bushiness of a linear sequence of
patches can be done with a 5 line shell script: (use `get' to build
`m' copies of the base revision, then use `replay' to apply one of the
`Ax' patches to each tree, noting the exit status of replay to find
out which patches apply cleanly).

You could extend such a shell script indefinitely: add additional
criteria such as ``the final tree must be able to compile'', or
recursively find all sequences of two or more patches, perhaps using
an automated benchmark to prune or order the search.

`arch' is fun that way.

-t
