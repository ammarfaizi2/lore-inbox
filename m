Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWBUEkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWBUEkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWBUEkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:40:10 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33742 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932263AbWBUEkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:40:09 -0500
Date: Tue, 21 Feb 2006 04:40:04 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
Message-ID: <20060221044004.GV27946@ftp.linux.org.uk>
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9B8A9.4000506@reub.net> <20060220201506.GU27946@ftp.linux.org.uk> <20060220165327.64f15bba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220165327.64f15bba.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 04:53:27PM -0800, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > It really would be more useful to pick individual branches
> >  	fixes.b8
> >  	m32r.b0
> >  	m68k.b8
> >  	xfs.b8
> >  	uml.b1
> >  	net.b6
> >  	frv.b8
> >  	misc.b8
> >  	upf.b5
> >  	volatile.b0
> >  	endian.b8
> >  	net-endian.b3
> 
> OK...  But it looks like these are liable to be removed, renamed or added
> to at the drop of a hat.  I don't know how to keep up with that.

No renaming...  FWIW, the workflow looks that way:

* origin follows mainline; no merges, no commits, only fetching from Linus
* everything else is branched off origin; branches starting at Nth branch
point have .b<N> as suffix.
* all topic branches (everything except bird) _never_ get merges; only
commits, 100% linear history.
* composite branch (bird), OTOH, gets only merges - from origin and from
topic branches.
* whenever a conflict would happen:
	* new bird.b<N> is spawned;
	* all affected branches are respawned (off the same point on mainline)
and cherry-picked from their previous versions.
	* the latest versions of all topic branches are merged into composite
one.

That's it for master repository.  Work repositories are cloned from it;
there I have a transient branch (work) starting at the tip of bird.b<latest>.
All changes go there; to get them back into master I cherry-pick from work
to appropriate topic branches and fetch them into master.  Then (in master)
I merge them into composite branch and push the result to work repos.
At that point I again have all of them in sync and just reset work branch
to tip of composite one.

It works surprisingly well; nice properties:
	* latest versions of all topic branches merge clean and have linear
history.  IOW, git-format-patch on any of them gives a set of patches that
will apply to the tip of mainline and won't conflict each other.
	* at all times composite branch is equal to merge of topic ones and
latest mainline.
	* all build boxen are kept in sync easily
	* I never have to trust build boxen with anything about master or each
other.
	* Adding new build boxen is trivial; so's redistributing work between
those.
	* Branches in master are never renamed, removed or reset.

The last one is a big win compared to davem's "rebase everything all the
time" and this setup does, AFAICS, behave no worse wrt giving clean
patchset.

As for the "what to pick" - I've just put that into
ftp.kernel.org/pub/linux/kernel/people/viro/bird-branches (and will put
composite patch there) and I can send mail whenever that changes...
