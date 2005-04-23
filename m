Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVDWOOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVDWOOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 10:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVDWOOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 10:14:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:39881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261591AbVDWOOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 10:14:02 -0400
Date: Sat, 23 Apr 2005 07:15:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Petr Baudis <pasky@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
In-Reply-To: <20050423111900.GA2226@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz>
 <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz>
 <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz>
 <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Apr 2005, Pavel Machek wrote:
> 
> Could we add some kind off "This-changeset-obsoletes: <sha1>" header?
> That would  allow me to send patches by hand and still make the SCM do the
> right thing during merge.

That doesn't really scale, plus I don't want to rely on that kind of hack
since it's simply not reliable (the patch may have gotten edited on the
way, so maybe the stuff I apply is 90% from your patch, but 10%
different).

Also, it doesn't actually handle the generic case, which is that the other
end used something else than git to maintain his patches (which in the end
has the exact same issues).

So I think you'd just need to have some separate logic that says "if this
patch looks like it has been applied to 'base', ignore it". The most
trivial such logic is to just see if the patch even applies cleanly any
more (which is a test you'd have to do _anyway_). That, together with a
list of "known applied" patches, and you should be able to automate it
pretty well.

The fact is, you pretty much end up using something like quilt. That works
really well, as Andrew has proven.

> Alternatively I should just get public rsync-able space somewhere...
> Would kernel.org be willing to add people/pavel?

Now, that's actually something people are working on ("git.kernel.org"),
so I don't think that would be a problem. People _are_ trying to set up
things like a bkbits.net at least for the kernel. I know OSDL and OSL
(http://osuosl.org/) are interested, and I think the current kernel.org
works too.

A word of warning: in many ways it's easier to work with patches. In
particular, if you want to have me merge from your tree, I require a
certain amount of cleanliness in the trees I'm pulling from. All of the
people who used to use BK to sync are already used to that, but for people
who didn't historically use BK this is going to be a learning experience.

The reason patches are easier is that you can start out from a messy tree, 
and then whittle down the patch to just the part you want to send me, so 
it doesn't actually matter how messy your original tree is, you can always 
make the end result look nice. 

One of the things a distributed SCM brings with it is that you can't edit
history after the fact, which means that if you use git and you've got a
messy tree, you can't just "clean it up". You either have to keep your
tree clean all the time, or you have to generate a new clean tree (usually
by exporting patches from your messy one) and throw the messy ones away
periodically.

("throw-away" git trees are actually very very useful).

git is actually even _more_ strict than BK in this respect, since the git
model means that everything is based on SHA1 hashes, and you can't edit
_anything_. With BK, some people were used to edit the checkin comments
after the fact, and you could do that kind of limited cleanup before you
asked me to merge. With git, that's all hashed cryptographically and is
part of the "name" of the result, so if you want to change the checkin
comments, you literally have to throw the old one (and every later checkin
that has it as its parents) away, and re-generate the whole chain.

This is very much by design. This is how git (and I) can trust the end 
result. It is how git can know that if we have a common parent, all the 
history before that common parent is guaranteed to be the same for both 
you and me, and git can thus ignore it. But as mentioned, it does mean 
that git history is set in stone, and the only way to "fix" things is 
literally to re-create it all.

				Linus
