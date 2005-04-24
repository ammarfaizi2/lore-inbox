Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVDXFqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVDXFqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 01:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVDXFqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 01:46:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:4527 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262266AbVDXFqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 01:46:15 -0400
Date: Sat, 23 Apr 2005 22:45:52 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424054552.GB25561@kroah.com>
References: <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <20050423230023.GA17388@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423230023.GA17388@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 01:00:23AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Could we add some kind off "This-changeset-obsoletes: <sha1>" header?
> > > That would  allow me to send patches by hand and still make the SCM do the
> > > right thing during merge.
> > 
> > That doesn't really scale, plus I don't want to rely on that kind of hack
> > since it's simply not reliable (the patch may have gotten edited on the
> > way, so maybe the stuff I apply is 90% from your patch, but 10%
> > different).
> 
> (Well, at that point I probably want to drop that 10% anyway :-).
> 
> > Also, it doesn't actually handle the generic case, which is that the other
> > end used something else than git to maintain his patches (which in the end
> > has the exact same issues).
> 
> Actually this one should not be a problem. "This-changeset-obsoletes:"
> would probably be in changelog part, and remote end would just
> propagate it.
> 
> > > Alternatively I should just get public rsync-able space somewhere...
> > > Would kernel.org be willing to add people/pavel?
> > 
> > Now, that's actually something people are working on ("git.kernel.org"),
> > so I don't think that would be a problem. People _are_ trying to set up
> > things like a bkbits.net at least for the kernel. I know OSDL and OSL
> > (http://osuosl.org/) are interested, and I think the current kernel.org
> > works too.
> > 
> > A word of warning: in many ways it's easier to work with patches. In
> > particular, if you want to have me merge from your tree, I require a
> > certain amount of cleanliness in the trees I'm pulling from. All of the
> > people who used to use BK to sync are already used to that, but for people
> > who didn't historically use BK this is going to be a learning experience.
> > 
> > The reason patches are easier is that you can start out from a messy tree, 
> > and then whittle down the patch to just the part you want to send me, so 
> > it doesn't actually matter how messy your original tree is, you can always 
> > make the end result look nice. 
> 
> I created three trees here (with git fork): one ("clean-git") to track
> your changes, second ("linux-git") to do my development on and third
> ("linux-good") for good, nice, cleaned-up changes, for you to merge.
> 
> ...unfortunately pasky's git just symlinked object/ directories...
> 
> ...that means that if you pull from me using rsync, you'll get all my
> "development" files, too. Not accessible in any normal way, but still
> there.
> 
> That means that git fork can't be used for "good tree for
> Linus"... not until we have something better than rsync :-(.

I'm not really using the git-pasky part of git yet for development
(except for 'git log -c')  You can just "clone" the tree yourself with a
stupid little script like I do below.  It still uses hard-links so
common git objects are only in one place on the disk.

Feel free to make it better, I have never claimed to be a bash
programmer :)

thanks,

greg k-h

--------------

#!/bin/bash

DIR=$1

mkdir $DIR
cd $DIR
mkdir .git
cp ~/linux/kernel.org/people/torvalds/linux-2.6.git/HEAD .git/
cp -rl ~/linux/kernel.org/people/torvalds/linux-2.6.git/objects/ .git/objects/

HEAD=`cat .git/HEAD`
echo "HEAD=$HEAD"
echo ""

cat-file commit $HEAD
TREE_HEAD=`cat-file commit $HEAD | head -n 1 | cut -f 2 -d " "`
echo "TREE_HEAD=$TREE_HEAD"

echo "read-tree $TREE_HEAD"
read-tree $TREE_HEAD

echo "checkout-cache -a"
checkout-cache -a

echo "update-cache --refresh"
update-cache --refresh
