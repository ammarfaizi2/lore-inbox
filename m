Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVBSRxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVBSRxy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 12:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVBSRxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 12:53:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3401
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261749AbVBSRxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 12:53:50 -0500
Date: Sat, 19 Feb 2005 18:53:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org, darcs-users@darcs.net
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050219175348.GE7247@opteron.random>
References: <20050214020802.GA3047@bitmover.com> <845b6e8705021803533ba8cc34@mail.gmail.com> <20050218125057.GE2071@opteron.random> <200502190410.31960.pmcfarland@downeast.net> <20050219164213.GB7247@opteron.random> <20050219171457.GA20285@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219171457.GA20285@abridgegame.org>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 12:15:02PM -0500, David Roundy wrote:
> The linux-2.5 tree right now (I'm re-doing the conversion, and am up to
> October of last year, so far) is at 141M, if you don't count the pristine
> cache or working directory.  That's already compressed, so you don't get
> any extra bonuses.  Darcs stores with each changeset both the old and new
> versions of each hunk, which gives you some redundancy, and probably
> accounts for the factor of two greater size than CVS.  This gives a bit of
> redundancy, which can be helpful in cases of repository corruption.

Double size of the compressed backup is about the same as SVM with fsfs
(not tested on l-k tree but in something much smaller). Why not to
simply checksum instead of having data redundancy? Knowing when
something is corrupted is a great feature, but doing raid1 without the
user asking for it, is a worthless overhead.

The same is true for arch of course, last time I checked they were using
the default -U 3 format instead of -U 0.

> I presume you're referring to a local checkout? That is already done using
> hard links by darcs--only of course the working directory has to actually
> be copied over, since there are editors out there that aren't friendly to
> hard-linked files.

arch allows to hardlink the copy too (optionally) and it's up to you to
use the right switch in the editor (Davide had a LD_PRELOAD to do a
copy-on-write since the kernel doesn't provide the feature).

> And here's where darcs really falls down.  To track the history of a single
> file it has to read the contents of every changeset since the creation of
> that file, which will take forever (well, not quite... but close).

Indeed, and as I mentioned this is the *major* feature as far as I'm
concerned (and frankly the only one I really care about and that helps a
lot to track changes in the tree and understand why the code evolved).

Note that cvsps works great for this, it's very efficient as well (not
remotely comparable to arch at least, even if arch provided a tool
equivalent to cvsps), the only problem is that CVS is out of sync...

> I hope to someday (when more pressing issues are dealt with) add a per-file
> cache indicating which patches affect which files, which should largely
> address this problem, although it won't help at all with files that are
> touched by most of the changesets, and won't be optimimal in any case. :(

Wouldn't using the CVS format help an order of magnitude here? With
CVS/SCCS format you can extract all the patchsets that affected a single
file in a extremely efficient manner, memory utilization will be
extremely low too (like in cvsps indeed). You'll only have to lookup the
"global changeset file", and then open the few ,v files that are
affected and extract their patchsets. cvsps does this optimally
already. The only difference is that what cvsps is a "readonly" cache,
while with a real SCM it would be a global file that control all the
changesets in an atomic way.

Infact *that* global file could be a bsddb too, I don't care about how
the changset file is being encoded, all I care is that the data is a ,v
file or SCCS file so cvsps won't have to read >20000 files every time I
ask that question, which is currently unavoidable with both darcs and
arch.
