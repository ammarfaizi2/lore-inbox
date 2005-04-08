Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVDHX1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVDHX1s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVDHX1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:27:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:53400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261195AbVDHX1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:27:17 -0400
Date: Fri, 8 Apr 2005 16:29:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <4257055A.7010908@umich.edu>
Message-ID: <Pine.LNX.4.58.0504081613180.28951@ppc970.osdl.org>
References: <4257055A.7010908@umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Rajesh Venkatasubramanian wrote:
> 
> Although directory changes are tracked using change-sets, there 
> seems to be no easy way to answer "give me the diff corresponding to
> the commit (change-set) object <sha1>".  That will be really helpful to
> review the changes.

Actually, it is very easy indeed. Here's what you do:

 - look up the commit object ("cat-file commit <sha1>")

   This object starts out with "tree <sha1>", followed by a list of
   parent commit objects: "parent <sha1>"

   Remember the tree object (it defines what the tree looks like at
   the time of the commit). Pick the parent object you want to diff
   against (normally the first one).

   Also, print the checking messages at the end of the commit object.

 - look up the parent object ("cat-file commit <parentsha1>")

   Here you have the same kind of object, but this time you don't care
   about going deeper, you just pick up the tree <sha1> that describes
   the tree at the parent.

 - look up the two tree objects. Unlike a commit object, a tree object
   is a binary data blob, but the format is an _extremely_ simple table
   of thse guys:

	<ascii octal filemode> <space> <pathname> <NUL character> <20-byte sha1>

  and the reason it's binary is really that that way "git" doesn't end
  up having any issues with strange pathnames. If you want to have spaces
  and newlines in your pathname, go wild.

  In particular, the tree object is also _sorted_ by the pathname. This 
  makes things simple, because you now have to sorted trees, and the 
  first thing you do is just walk the two trees in lock-step, which is 
  trivial thanks to the sorted nature of the tree "array".

  So now you have three cases:
	- you have the same name, and the same sha1

	  ignore it - the file didn't change, you don't even have to look 
	  at the contents (although if the file mode changed you might
	  want to note that)

	- you have the same name in parent and child tree lists, but the
	  sha differs. Now you just need to do a "cat-file" on both of the 
	  SHA1 values, and do a "diff -u" between them.

	- you have the filename in only parent or only child. Do a 
	  "create" or "delete" diff with the content of the sha1 file.

See? Very efficient. For any files that didn't change, you didn't have to 
do anything at all - you didn't even have to look at their data.

Also note that the above algorithm really works for _any_ two commit 
points (apart for the two first steps, which are obviously all about 
finding the parent tree when you want to diff against a predecessor). 

It doesn't have to be parent and child. Pick any commit you have. And pick
them in the other order, and you'll automatically get the reverse diff.

You can even do diffs between unrelated projects this way if you use the
shared sha1 directory model, although that obviously doesn't tend to be
all that sensible ;)

		Linus
