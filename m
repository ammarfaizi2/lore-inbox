Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVDHPsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVDHPsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVDHPsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:48:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:26843 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262857AbVDHPs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:48:28 -0400
Date: Fri, 8 Apr 2005 08:50:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: ross@jose.lug.udel.edu
cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050408071720.GA23128@jose.lug.udel.edu>
Message-ID: <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071720.GA23128@jose.lug.udel.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005 ross@jose.lug.udel.edu wrote:
> 
> Here's a partial solution.  It does depend on a modified version of
> cat-file that behaves like cat.  I found it easier to have cat-file
> just dump the object indicated on stdout.  Trivial patch for that is included.

Your trivial patch is trivially incorrect, though. First off, some files
may be binary (and definitely are - the "tree" type object contains
pathnames, and in order to avoid having to worry about special characters
they are NUL-terminated), and your modified "cat-file" breaks that.  

Secondly, it doesn't check or print the tag.

That said, I think I agree with your concern, and cat-file should not use 
a temp-file. I'll fix it, but I'll also make it verify the tag (so you'd 
now have to know the tag in advance if you want to cat the data).

Something like

	cat-file -t <sha1>		# output the tag
	cat-file <tag> <sha1>		# output the data

or similar. Easy enough. That way you can do

	torvalds@ppc970:~/git> ./cat-file -t `cat .dircache/HEAD `
	commit

and

	torvalds@ppc970:~/git> ./cat-file commit `cat .dircache/HEAD `

	tree ca30cdf8df2f31545cc1f2c1be62619111b6f6aa
	parent c2474b336d7a96fb4e03e65d229bcddc62b244fc
	author Linus Torvalds <torvalds@ppc970.osdl.org> Fri Apr  8 08:16:38 2005
	committer Linus Torvalds <torvalds@ppc970.osdl.org> Fri Apr  8 08:16:38 2005

	Make "cat-file" output the file contents to stdout.

	New syntax: "cat-file -t <sha1>" shows the tag, while "cat-file <tag> <sha1>"
	outputs the file contents after checking that the supplied tag matches.

I'll rsync the .dircache directory to kernel.org. You'll need to update 
your scripts.

> Now to see what I come up with for commit, push, and pull...

A "commit" (*) looks roughly like this:

	# check with "show-diff" what has changed, and check if
	# you need to add any files..

	update-cache <list of files that have been changed/added/deleted>

	# check with "show-diff" that it all looks right

	oldhead=$(cat .dircache/HEAD)
	newhead=$(commit-tree $(write-tree) -p $oldhead < commit-message)

	# update the head information
	if [ "$newhead" != "" ] ; then echo $newhead > .dircache/HEAD; fi

(*) I call this "commit", but it's really something much simpler. It's
really just a "I now have <this directory state>, I got here from
<collection of previous directory states> and the reason was <reason>". 

The "push" I use is

	rsync -avz --exclude index .dircache/ <destination-dir>

and you can pull the same way, except when you pull you should save _your_
HEAD file first (and then you're screed. There's no way to merge. If
you've made changes and committed them, your changes are still there, but
they are now on a different HEAD than the new one).

That, btw, is kind of the design. "git" really doesn't care about things
like merges. You can use _any_ SCM to do a merge. What "git" does is track
directory state (and how you got to that state), and nothing else. It
doesn't merge, it doesn't really do a whole lot of _anything_.

So when you "pull" or "push" on a git archive, you get the "union" of all
directory states in the destination. The HEAD thing is _one_ pointer into 
the "sea of directory states", but you really have to use something else 
to merge two directory states together. 

			Linus
