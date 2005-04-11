Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVDKU1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVDKU1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVDKU07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:26:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:24988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261915AbVDKURM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:17:12 -0400
Date: Mon, 11 Apr 2005 13:18:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Ingo Molnar <mingo@elte.hu>, Paul Jackson <pj@engr.sgi.com>, pasky@ucw.cz,
       rddunlap@osdl.org, ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
In-Reply-To: <Pine.LNX.4.58.0504111127320.1267@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0504111310110.1267@ppc970.osdl.org>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu>
 <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu>
 <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org> <20050411153905.GA7284@elte.hu>
 <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org> <20050411181319.GA11302@taniwha.stupidest.org>
 <Pine.LNX.4.58.0504111127320.1267@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Linus Torvalds wrote:
> >      bk changes -R
> > 
> >      bk changes -L
> 
> You'd dowload all the sha1 objects (they don't actually do anything to
> _your_ state - they only show the possible other states), and then it's a 
> "simple thing" to generate a full tree of your local HEAD commit and 
> compare it to a full tree of the remove HEAD commit.

Ok, there's a "rev-tree" program there now to generate these things. 

If you control both ends, or have some other means of a "smart"  
communications protocol, you don't actually have to download the blobs
themselves. Just download the "rev-tree" from the other side, and you can
generate the differences by comparing your rev-tree against theirs.

(And since they are sorted, the compare is very cheap).

The downside? A revtree can get quite large. My "rev-tree" program allows
you to cache previous state so that you don't have to follow the whole
thing down, though, so it's possible to just send incrementals (since a
"commit" _uniquely_ generates the whole rev-tree, you really can do
reasonably smart things and create "superset revtrees" etc).

So the change difference between two commits is literally

	rev-tree [commit-id1]  > commit1-revtree
	rev-tree [commit-id2]  > commit2-revtree
	join -t : commit1-revtree commit2-revtree > common-revisions

(this is also how to find the most common parent - you'd look at just the
head revisions - the ones that aren't referred to by other revisions - in
"common-revision", and figure out the best one. I think.)

		Linus
