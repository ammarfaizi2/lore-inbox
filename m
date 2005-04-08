Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVDHSMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVDHSMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVDHSMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:12:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:60612 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262906AbVDHSMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:12:20 -0400
Date: Fri, 8 Apr 2005 11:14:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <4256BE7D.5040308@tiscali.de>
Message-ID: <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
 <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <4256BE7D.5040308@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Matthias-Christian Ott wrote:
>
> Ok, but if you want to search for information in such big text files it 
> slow, because you do linear search 

No I don't. I don't search for _anything_. I have my own
content-addressable filesystem, and I guarantee you that it's faster than
mysql, because it depends on the kernel doing the right thing (which it
does).

I never do a single "readdir". It's all direct data lookup, no "searching"  
anywhere.

Databases aren't magical. Quite the reverse. They easily end up being
_slower_ than doing it by hand, simply because they have to solve a much
more generic issue. If you design your data structures and abstractions
right, a database is pretty much guaranteed to only incur overhead.

The advantage of a database is the abstraction and management it gives 
you. But I did my own special-case abstraction in git.

Yeah, I bet "git" might suck if your OS sucks. I definitely depend on name
caching at an OS level so that I know that opening a file is fast. In
other words, there _is_ an indexing and caching database in there, and
it's called the Linux VFS layer and the dentry cache.

The proof is in the pudding. git is designed for _one_ thing, and one 
thing only: tracking a series of directory states in a way that can be 
replicated. It's very very fast at that. A database with a more flexible 
abstraction migt be faster at other things, but the fact is, you do take a 
hit.

The problem with databases are:

 - they are damn hard to just replicate wildly and without control. The 
   database backing file inherently has a lot of internal state. You may 
   be able to "just copy it", but you have to copy the whole damn thing.

   In "git", the data is all there in immutable blobs that you can just 
   rsync. In fact, you don't even need rsync: you can just look at the 
   filenames, and anything new you copy. No need for any fancy "read the 
   files to see that they match". They _will_ match, or you can tell 
   immediately that a file is corrupt.

   Look at this:

	torvalds@ppc970:~/git> sha1sum .dircache/objects/e7/bfaadd5d2331123663a8f14a26604a3cdcb678 
	e7bfaadd5d2331123663a8f14a26604a3cdcb678  .dircache/objects/e7/bfaadd5d2331123663a8f14a26604a3cdcb678

   see a pattern anywhere? Imagine that you know the list of files you 
   have, and the list of files the other side has (never mind the 
   contents), and how _easy_ it is to synchronize. Without ever having to 
   even read the remote files that you know you already have.

   How do you replicate your database incrementally? I've given you enough 
   clues to do it for "git" in probably five lines of perl.

 - they tend to take time to set up and prime.

   In contrast, the filesystem is always there. Sure, you effectively have 
   to "prime" that one too, but the thing is, if your OS is doing its job, 
   you basically only need to prime it once per reboot. No need to prime 
   it for each process you start or play games with connecting to servers 
   etc. It's just there. Always. 

So if you think of the filesystem as a database, you're all set. If you 
design your data structure so that there is just one index, you make that 
the name, and the kernel will do all the O(1) hashed lookups etc for you. 
You do have to limit yourself in some ways. 

Oh, and you have to be willing to waste diskspace. "git" is _not_
space-efficient. The good news is that it is cache-friendly, since it is
also designed to never actually look at any old files that aren't part of
the immediate history, so while it wastes diskspace, it does not waste the
(much more precious) page cache.

IOW big file-sets are always bad for performance if you need to traverse
them to get anywhere, but if you index things so that you only read the 
stuff you really really _need_ (which git does), big file-sets are just an 
excuse to buy a new disk ;)

			Linus
