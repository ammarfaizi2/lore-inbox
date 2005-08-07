Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbVHGEjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVHGEjA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 00:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVHGEjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 00:39:00 -0400
Received: from mail.autoweb.net ([198.172.237.26]:40594 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1750976AbVHGEi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 00:38:59 -0400
Date: Sun, 7 Aug 2005 00:38:52 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: gcapatcch equivalent?
Message-ID: <20050807043852.GB5271@mythryan2.michonline.com>
References: <Pine.LNX.4.58.0508051157590.22353@skynet> <20050805151017.745f4188.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805151017.745f4188.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 03:10:17PM -0700, Andrew Morton wrote:
> I do this, which mostly works:
> 
> 	MERGE_BASE=$(git-merge-base $(cat .git/refs/heads/origin ) \
> 				$(cat .git/refs/heads/$patch_name))
> 
> 	cg-diff -r $MERGE_BASE:$(cat .git/refs/heads/$patch_name) >> \
> 				$PULL/$patch_name.patch
> 
> (I'm supposed to be doing real git merges of 40 trees and let git do more
> work for me.  I'll do that when I'm feeling really, really trusting).

Would something like this make you more comfortable?

You get one repository per tree, but hardlinked objects so space
shouldn't be an issue... and each one works "normally".

All you need to do is setup "origin" as the Linus's tree, then clone
each of the other repositories you want to track, then run this script.

(You *may* want to clone Linus's tree, then edit .git/branches/origin in
each of the sub-trees to save a lot of network bandwidth, but it
shouldn't matter, as the git relink will get you to about the same state
after the first run anyway.)

==========================

#!/bin/sh

repos="agpgart cpufreq net-2.6 sparc-2.6"

rm -rf merged
git clone -l origin merged
for i in $repos ; do echo "../$i" > "merged/.git/branches/$i" ; done

git relink agpgart/ cpufreq/ net-2.6/ sparc-2.6/ merged/ origin/

( cd origin ; git pull origin )
for i in $repos ; do
	(
		cd "$i"
		git pull origin
	)
done

cd merged
mkdir -p .git/refs/merge-points/

for i in $repos ; do
	cat .git/HEAD > ".git/refs/merge-points/pre-$i"

	git pull "$i"
	# Note, this should trigger off an error return from git pull
	# Unfortunately, git pull always returns an error, so it doesn't
	# work quite perfectly - hence this being unconditional.

	echo "Please fix up the merge if necessary, commit it, and exit this subshell."
	sh

	cat .git/HEAD > ".git/refs/merge-points/post-$i"
	git diff $(cat .git/refs/merge-points/pre-$i)..$(cat .git/refs/merge-points/post-$i) > "../$i.patch"
done




-- 

Ryan Anderson
  sometimes Pug Majere
