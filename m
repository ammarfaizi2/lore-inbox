Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVDIALm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVDIALm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 20:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDIALl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 20:11:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:25512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261210AbVDIALG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 20:11:06 -0400
Date: Fri, 8 Apr 2005 17:12:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050408083839.GC3957@opteron.random>
Message-ID: <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050406193911.GA11659@stingr.stingr.net> <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
 <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope>
 <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope>
 <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Andrea Arcangeli wrote:
> 
> We'd need a regenerated coherent copy of BKCVS to pipe into those SCM to
> evaluate how well they scale.

Yes, that makes most sense, I believe. Especially as BKCVS does the 
linearization that makes other SCM's _able_ to take the data in the first 
place. Few enough SCM's really understand the BK merge model, although the 
distributed ones obviously have to do something similar.

> OTOH if your git project already allows storing the data in there,
> that looks nice ;).

I can express the data, and I did a sparse .git archive to prove the 
concept. It doesn't even try to save BK-specific details, but as far as I 
can tell, my git-conversion did capture all the basic things (ie not just 
the actual source tree, but hopefully all the "who did what" parts too).

Of course, my git visualization tools are so horribly crappy that it is 
hard to make sure ;)

Also, I suspect that BKCVS actually bothers to get more details out of a
BK tree than I cared about. People have pestered Larry about it, so BKCVS
exports a lot of the nitty-gritty (per-file comments etc) that just
doesn't actually _matter_, but people whine about. Me, I don't care. My
sparse-conversion just took the important parts.

> I don't yet fully understand how the algorithms of the trees are meant
> to work

Well, things like actually merging two git trees is not even something git
tries to do. It leaves that to somebody else - you can see what the
relationship is, and you can see all the data, but as far as I'm
concerned, git is really a "filesystem". It's a way of expression
revisions, but it's not a way of creating them.

> It looks similar to a diff -ur of two hardlinked trees

Yes. You could really think of it that way. It's not really about
hardlinking, but the fact that objects are named by their content does
mean that two objects (regardless of their type) can be seen as
"hardlinked" whenever their contents match.

But the more interesting part is the hierarchical virtual format it has,
ie it is not only hardlinked, but it also has the three different levels
of "views" into those hardlinked objects ("blob", "tree", "revision").

So even though the hash tree looks flat in the _physcal_ filesystem, it 
detinitely isn't flat in its own virtual world. It's just flattened to fit 
in a normal filesystem ;)

[ There's also a fourth level view in "trust", but that one hasn't been
  implemented yet since I think it might as well be done at a higher
  level. ]

Btw, the sha1 file format isn't actually designed for "rsync", since rsync 
is really a hell of a lot more capable than my format needs. The format is 
really designed for something like a offline http grabber, in that you can 
just grab files purely by filename (and verify that you got them right by 
running sha1sum on the resulting local copy). So think "wget".

				Linus
