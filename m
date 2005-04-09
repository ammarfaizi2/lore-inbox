Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVDIXaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVDIXaD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVDIXaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:30:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:57066 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261411AbVDIX3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:29:18 -0400
Date: Sat, 9 Apr 2005 16:31:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, Linus Torvalds wrote:
> 
> Actually, I guess I wouldn't have to change the format. I could just 
> extend the existing "tree" object to be able to point to other trees, and 
> that's it.

Done, and pushed out. The current git.git repository seems to do all of 
this correctly.

NOTE! This means that each "tree" file basically tracks just a single
directory. The old style of "every file in one tree file" still works, but 
fsck-cache will warn about it. Happily, the git archive itself doesn't 
have any subdirectories, so git itself is not impacted by it.

Now, this means that I should add a "recusive" option to "tree-diff", but 
I haven't done so yet. So right now if I change the top-level Makefile,
_and_ change kernel/exit.c, then the "tree diff" between the two commit 
trees ends up looking like:

	torvalds@ppc970:~/lx-test/linux-2.6.12-rc2> diff-tree 7bec1223736d7e02c755e9a365984b3cbfa1e6e9 d64817f809a60cd960d3078ae91b4d19cb649501 | tr '\0' '\n'
	<100644 e1e7f7430c0297f22042cff58da5ca73ef121b95 Makefile
	>100644 8ee21134577e98fb642dffc5b797a0121645c543 Makefile
	<40000 2239383d00ae746f5e79ceccf8ac3fbca62f949d kernel
	>40000 a8fad219cb78a6b6a05a10f8643d615fefc8160f kernel

ie it shows that the Makefile blob has changed, and the kernel directory 
has changed. You then need to recurse into the kernel tree to see what the 
changes were there:

	torvalds@ppc970:~/lx-test/linux-2.6.12-rc2> diff-tree 2239383d00ae746f5e79ceccf8ac3fbca62f949d a8fad219cb78a6b6a05a10f8643d615fefc8160f | tr '\0' '\n'
	<100644 1a50b58453679b6fee8de4f744f4befc39397bb1 exit.c
	>100644 e8df1325bf25816827a1a64404ad533a97bfdae2 exit.c

but it clearly all seems to work. And it means that a subdirectory that 
didn't change at all (the common case) will be able to re-use the old sha1 
file when you create a tree (this may in fact make "diff-tree" much less 
important, since now it tends to handle objects that are just a few kB in 
size, rather than almost a megabyte.

So in this case, the "commit cost" of changing two files was two small 
tree files (1468 and 679 bytes respectively for the kernel/ and top-level 
directory) and the commit file itself (251 bytes). In addition to the 
actual data files that were changed, of course.

Goodie. Big difference between that and the 460kB of the old monolithic
tree file.

			Linus
