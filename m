Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUHYVea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUHYVea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUHYVdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:33:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40078 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268602AbUHYVZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:25:18 -0400
Date: Wed, 25 Aug 2004 22:25:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 02:00:01PM -0700, Linus Torvalds wrote:
> Of course, the dcache introduces some new problems of its own wrt
> directory aliasing, but I don't actually think that should be fundamental
> either. Treating them more as a "static mountpoint" from an FS angle and
> less as a traditional Unix hardlink should be doable, I'd have thought.

Yeah, if we ditch the "mountpoints are busy and untouchable" stuff.  Which
I'd love to, but it's a hell of a visible (and admin-visible) change.

FWIW, current deadlocks are unrelated to actual operation succeeding.
Look: we have sys_link() making sure that parent of target is a directory
(PATH_LOOKUP, in a "it has ->lookup()" sense), then locking target's parent,
then checking that it has ->link() (everyone on reiser4 does) and then
checking that source (old link to file) is *not* a directory (in S_ISDIR
sense).  Then we lock source.

Note that currently it's OK - we get "all non-directories are always locked
after all directories".  With filesystem that provides hybrid objects with
non-NULL ->link() it's not true and we are in deadlock country.  Before
we get anywhere near fs code.

I'm not saying that this particular instance is hard to fix, but it wasn't
even looked at.  All it would take is checking the description of current
locking scheme and looking through the proof of correctness (present in the
tree).  That's the first point where said proof breaks if we have hybrids.
And it's what, about 4 screenfuls of text?

I have no problems with discussing such stuff and no problems with having it
merged if it actually works.  But let's start with something better than
"let's hope nothing breaks if we just add such objects and do nothing else,
'cause hybridi files/directories are good, mmmkay?"
