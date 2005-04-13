Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVDMUpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVDMUpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 16:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDMUpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 16:45:18 -0400
Received: from waste.org ([216.27.176.166]:35046 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261191AbVDMUpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 16:45:11 -0400
Date: Wed, 13 Apr 2005 13:44:51 -0700
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, David Eger <eger@havoc.gtf.org>,
       Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050413204451.GP25554@waste.org>
References: <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org> <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <20050412234005.GJ1521@opteron.random> <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org> <20050413001408.GL1521@opteron.random> <Pine.LNX.4.58.0504121809380.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121809380.4501@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 06:10:27PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 13 Apr 2005, Andrea Arcangeli wrote:
> > 
> > I wasn't suggesting to use CVS. I meant that for a newly developed SCM,
> > the CVS/SCCS format as storage may be more appealing than the current
> > git format.
> 
> Go wild. I did mine in six days, and you've been whining about other 
> peoples SCM's for three years.

I wrote a hack to do efficient delta storage with O(1) seeks for
lookup and append last week, I believe it's been integrated into the
latest Bazaar-NG. I expect it'll give better compression and
performance than BK. Of course it ends up being O(revisions) for
modifications or insertions (but that is probably a non-issue for the
SCM models we're looking at).

The git model is obviously very different, but I worry about the slop
space implied. With 200k file revision and an average of 2k slop per
file, that's 400MB of slop, or almost the size of an equivalent delta
compressed kernel repo.

Now if you can assume that blobs never change and are never deleted,
you can simply append them all onto a log, and then index them with a
separate file containing an htree of (sha1, offset, length) or the
like. Since the key is already a strong hash, this is an excellent
match and avoids rehashing in the kernel's directory lookup. And it'll
save an inode, a directory entry, and about half a data block per
entry. "Open" will also be cheaper as there's no per-revision inode to
grab.

I could hack on this if you think it fits with the git model,
otherwise I'll go back to my other experiments..

-- 
Mathematics is the supreme nostalgia of our time.
