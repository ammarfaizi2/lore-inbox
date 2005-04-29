Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVD2GCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVD2GCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 02:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVD2GCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 02:02:41 -0400
Received: from waste.org ([216.27.176.166]:24555 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262430AbVD2GCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 02:02:00 -0400
Date: Thu, 28 Apr 2005 23:01:57 -0700
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050429060157.GS21897@waste.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 07:08:28PM -0700, Linus Torvalds wrote:
> 
> To make an interesting benchmark, try applying the first 200 patches in 
> the current git kernel archive. Can you do them three per second? THAT is 
> the thing you should optimize for, not checking in huge changes.

Ok, I've optimized for it a bit. This is basically:

 hg import -p1 -b ../broken-out `cat ../broken-out | grep -v #`

 ( latest code is at: http://selenic.com/mercurial/ )

My benchmark is to apply all 819 patches from -mm3 to 2.6.12-rc:

hg:

real    3m22.075s
user    1m57.195s
sys     0m14.068s

819/(60+57.195 + 14.068) = 6.239 patches/second  user+sys
repository: before 167M after 173M (3.5% growth)

git:

real    2m58.568s
user    1m11.196s
sys     0m50.144s

819/(60+11.196+50.144) = 6.750 patches/second  user+sys
repository: before 102M after 154M (51% growth)

Again, pretty close, time-wise. My code is actually spending a fair
amount of time doing delta compression in Python, which accounts for
most of the extra user time. So I think I can optimize most of that
away at some point. Interestingly hg is also using substantially less
system time.

What I'd like to highlight here is that git's repo is growing more
than 10 times faster. 52 megs is twice the size of a full kernel
tarball. And that's going to be the bottleneck for network pull
operations.

The fundamental problem I see with git is that the back-end has no
concept of the relation between files. This data is only present in
change nodes so you've got to potentially traverse all the commits to
reconstruct a file's history. That's gonna be O(top-level changes)
seeks. This introduces a number of problems:

- no way to easily find previous revisions of a file
  (being able to see when a particular change was introduced is a
  pretty critical feature)
- no way to do bandwidth-efficient delta transfer
- no way to do efficient delta storage
- no way to do merges based on the file's history[1]

Mercurial can grab look up and grab revisions of a file in O(1)
time/seeks. I haven't implemented annotate yet, but it can also be
done O(1) or O(file revisions).


[1] This last one is interesting. If we've got a repository with files A
and B:

M   M1   M2

AB
 |`-------v     M2 clones M
aB       AB     file A is change in mainline
 |`---v  AB'    file B is changed in M2
 |   aB / |     M1 clones M
 |   ab/  |     M1 changes B
 |   ab'  |     M1 merges from M2, changes to B conflict
 |    |  A'B'   M2 changes A
  `---+--.|
      |  a'B'   M2 merges from mainline, changes to A conflict
      `--.|
         ???    depending on which ancestor we choose, we will have
	        to redo A hand-merge, B hand-merge, or both
                but if we look at the files independently, everything
		is fine

-- 
Mathematics is the supreme nostalgia of our time.
