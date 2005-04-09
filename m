Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVDIU62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVDIU62 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDIU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 16:58:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:47053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261383AbVDIU6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 16:58:14 -0400
Date: Sat, 9 Apr 2005 14:00:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <20050409200709.GC3451@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, Petr Baudis wrote:
> 
> > Also, I wrote the "diff-tree" thing I talked about: 
> ..snip..
> 
> Hmm, I wonder, is this better done in C instead of a simple shell
> script, like my gitdiff.sh?

With 17,000 files in the kernel, and most commits just changing a small 
number of them, I actually think "diff-tree" matters. You use "join" 
(which is quite reasonable), but let's put it this way: just the list of 
files in the current kernel is about half a megabyte of data. Ie your 
temporary files that you use in the "ls-tree + ls-tree + join" is actually 
going to be quite sizeable.

My goal here is that the speed of "git" really should be almost totally
independent of the size of the project. You clearly cannot avoid _some_ 
size-dependency: my "diff-tree" clearly also has to work through the same 
1MB of data, but I think it's worth making the constant factor be as small 
as humanly possible.

I just tried checking in a kernel tree tar-file, and the initial checkin 
(which is allt he compression and the sha1 calculations for every single 
file) took about 1:35 (minutes, not hours ;).

Doing a commit (trivial change to the top-level Makefile) and then doing a 
"treediff" between those two things took 0.05 seconds using my C thing. Ie 
we're talking so fast that we really don't care.

Doing a "show-diff" takes 0.15 secs or so (that's all the "stat" calls), 
and now that I test it out I realize that the most expensive operation is 
actually _writing_ the "index" file out. These are the two most expensive 
steps:

	torvalds@ppc970:~/lx-test/linux-2.6.12-rc2> time update-cache Makefile

	real    0m0.283s
	user    0m0.171s
	sys     0m0.113s


	torvalds@ppc970:~/lx-test/linux-2.6.12-rc2> time write-tree
	5ca21c9d808fa4bee1eb6948a59dfb9c7d73f36a
	
	real    0m0.441s
	user    0m0.354s
	sys     0m0.087s

ie with the current infrastructure it looks like I can do a "patch + 
commit" in less than one second on the kernel, and 0.75 secs of that is 
because the "tree" file actually grows pretty large:

	cat-file tree 5ca21c9d808fa4bee1eb6948a59dfb9c7d73f36a | wc -c 

says that the uncompressed tree-file is 950,874 bytes. Compressing it 
means that the archival version of it is "just" 462,546 bytes, but this is 
really the part that is going to eat _tons_ of disk-space.

In other words, each "commit" file is very small and cheap, but since 
almost every commit will also imply a totally new tree-file, "git" is 
going to have an overhead of half a megabyte per commit. Oops.

Damn, that's painful. I suspect I will have to change the format somehow.

One option (which I haven't tested yet) is that since the tree-file is 
already sorted, I could always write it out with the common subdirectory 
part "collapsed", ie instead of writing

	...
	include/asm-i386/mach-default/bios_ebda.h
	include/asm-i386/mach-default/do_timer.h
	...

I'd write just

	...
	///bios_ebda.h
	///do_timer.h
	...

since the directory names are implied by the predecessor.

However, that doesn't help with the 20-byte sha1 associated with each
file, which is also obviously uncompressible, so with 17,000+ files, we
have a minimum overhead of abotu 350kB per tree-file.

So even if I did the pathname compression, it wouldn't help all that much.  
I'd only be removing the only part of the file that _is_ very
compressible, and I'd probably end up with something that isn't all that
far away from the 450kB+ it is now.

I suspect that I have to change the file format. Maybe make the "tree" 
object a two-level thing, and have a "directory" object.

Then a "tree" object would point to a "directory" object, which would in
turn point to the individual files (and other "directory" objects, of
course). That way a commit that only changes a few files will only need to
create a few new "directory" objects, instead of creating one huge "tree"
object.

Sadly, that will make "tree-diff" potentially more expensive. On the other
hand, maybe not: it will also speed it _up_, since directories that are
totally shared will be trivially seen as such and need no further
operation.

Thougths? That would break the current repository formats, and I'd have to 
create a converter thing (which shouldn't be that bad, of course).

I don't have to do it right now. In fact, I'd almost prefer for the
current thing to become good enough that it's not painful to work with,
since right now I'm using it to develop itself. Then I can convert the
format with an automated script later, before I actually start working on
the kernel...

> BTW, do we care about changed modes? If so, they should probably have
> their place in the diff-tree output.

They're there. If you want to ignore them, you can just notice that the 
sha1 matches between two lines, and then you don't even have to diff them.

			Linus
