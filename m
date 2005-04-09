Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVDIToW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVDIToW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDIToW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 15:44:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:27837 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261373AbVDIToJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 15:44:09 -0400
Date: Sat, 9 Apr 2005 12:45:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: more git updates..
Message-ID: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry guys,
 several of you have sent me small fixes and scripts to "git", but I've 
been busy on breaking/changing the core infrastructure, so I didn't get 
around to looking at the scripts yet.

The good news is, the data structures/indexes haven't changed, but many of 
the tools to interface with them have new (and improved!) semantics:

In particular, I changed how "read-tree" works, so that it now mirrors
"write-tree", in that instead of actually changing the working directory,
it only updates the index file (aka "current directory cache" file from
the tree).

To actually change the working directory, you'd first get the index file
setup, and then you do a "checkout-cache -a" to update the files in your
working directory with the files from the sha1 database.

Also, I wrote the "diff-tree" thing I talked about: 

	torvalds@ppc970:~/git> ./diff-tree 8fd07d4b7778cd0233ea0a17acd3fe9d710af035 8c6d29d6a496d12f1c224db945c0c56fd60ce941 | tr '\0' '\n'
	<100664 4870bcf91f8666fc788b07578fb7473eda795587 Makefile
	>100664 5493a649bb33b9264e8ed26cc1f832989a307d3b Makefile
	<100664 9e1bee21e17c134a2fb008db62679048fc819528 cache.h
	>100664 56ef561e590fd99e938bd47fd1f2c7ed46126ff0 cache.h
	<100664 fd690acc02ef9c06d7c4c3541f69b10ca4b4f8c9 cat-file.c
	>100664 6e6d89291ced17a406e64b97fe8bb96a22eefc9d cat-file.c
	+100664 fd00e5603dcc4a93acceda0b8cb914fabc8645d5 checkout-cache.c
	<100664 a4a8c3d9ef0c4cc6c82b96b5d1a91ac6d3bed466 commit-tree.c
	>100664 236ceb7646e3f5d110fd83f815b82e94cc5b2927 commit-tree.c
	+100664 01c92f2620a8e13e7cb7fd98ee644c6b65eeccb7 fsck-cache.c
	<100664 0eaa053919e0cc400ab9bc40d9272360117e6978 init-db.c
	>100664 815743e92dad7e451c65bab01448ee8ae9deeb56 init-db.c
	<100664 e7bfaadd5d2331123663a8f14a26604a3cdcb678 read-cache.c
	>100664 71d0cb6fe9b7ff79e3b2c5a61e288ac9f62b39dc read-cache.c
	<100664 ec0f167a6a505659e5af6911c97f465506534c34 read-tree.c
	>100664 f5c50ba79d02f002b9675fd8f129fa388e3282c6 read-tree.c
	<100664 00a29c403e751c2a2a61eb24fa2249c8956d1c80 show-diff.c
	>100664 b963dd738989bc92bf02352bbedad13a74e66a7d show-diff.c
	<100664 aff074c63ac827801a7d02ff92781365957f1430 update-cache.c
	>100664 3a672397164d5ff27a19a6888b578af96824ede7 update-cache.c
	<100664 7abeeba116b2b251c12ae32c7b38cb048199b574 write-tree.c
	>100664 9525c6fc975888a394477339db86216cd5bd5d7c write-tree.c

(ie the output of "diff-tree" has the same NUL-termination, but if you 
insist on getting ASCII output, you can just use "tr" to change the NUL 
into a NL).

The format of the "diff-tree" output is that the first character is "-"  
for "remove file", "+" for "add file" and "<"/">" for "change file" (where
the "<" shows the old state, and ">" shows the new state).

Btw, the NUL-termination makes this really easy to use even in shell
scripts, ie you can do

	diff-tree <sha1> <sha1> | xargs -0 do_something

and you'll get each line as one nice argument to your "do_something"  
script. So a do_diff could be based on something like

	#!/bin/sh
	while [ "$1" != "" ]; do
		filename="$(echo $1 | cut -d' ' -f3-)"
		first_sha="$(echo $1 | cut -d' ' -f2)"
		second_sha="$(echo $2 | cut -d' ' -f2)"
		c="$(echo $1 | cut -c1)"
		case "$c" in
		"+")
			echo diff -u /dev/null "$filename($first_sha)";;
		"-")
			echo diff -u "$filename($first_sha)" /dev/null;;
		"<")
			echo diff -u "$filename($first_sha)" "$filename($second_sha)"
			shift;;
		*)
			echo WHAT?
			exit 1;;
		esac
		shift
	done

which really shows what a horrid shell-person I am (I still use the old 
tools I learnt to use fifteen years ago. I bet you can do it trivially in 
perl or something sane, and I'm just stuck in the stone age of UNIX).

That makes it _very_ easy to parse. The example above is the diff between 
the initial commit and one of the more recent trees, so it has changes to 
everything, but a more normal thing would be

	torvalds@ppc970:~/git> diff-tree 787763499dc4f8cc345bc6ed8ee1e0ae31adedd6 5b0c2695634b5bab2f5d63c7bb30f7e5815af470 | tr '\0' '\n'
	<100664 01c92f2620a8e13e7cb7fd98ee644c6b65eeccb7 fsck-cache.c
	>100664 81aa7bee003264ea302db835158e725eefa4012d fsck-cache.c

which tells you that the last commit changed just one file (it's from this 
one:

	torvalds@ppc970:~/git> cat-file commit `cat .dircache/HEAD`
	tree 5b0c2695634b5bab2f5d63c7bb30f7e5815af470
	parent 81c53a1d3551f358860731481bb2d87179d221e6
	author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr  9 12:02:30 2005
	committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr  9 12:02:30 2005
	
	Make "fsck-cache" print out all the root commits it finds.
	
	Once I do the reference tracking, I'll also make it print out all the
	HEAD commits it finds, which is even more interesting.

in case you care).

I've rsync'ed the new git repository to kernel.org, it should all be there
in /pub/linux/kernel/people/torvalds/git.git/ (and it looks like the
mirror scripts already picked it up on the public side too).

Can you guys re-send the scripts you wrote? They probably need some 
updating for the new semantics. Sorry about that ;(

			Linus
