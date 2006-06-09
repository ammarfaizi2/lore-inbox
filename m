Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWFIQ2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWFIQ2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWFIQ2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:28:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030296AbWFIQ2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:28:05 -0400
Date: Fri, 9 Jun 2006 09:25:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alex Tomas <alex@clusterfs.com>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <m33beecntr.fsf@bzzz.home.net>
Message-ID: <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Alex Tomas wrote:
> 
> I believe it's as stable as before until you mount with extents
> mount option.

That's always a possibility in theory, and almost never in practice.

Btw, I don't care about extents _per_se_. I do care about the fact that 
people seem to think that code gets better as it supports more features. 
Not so.

The whole logic of "code sharing is good" is a huge mistake. Shared code 
is not at all better than individual code snippets, and often much much 
worse. In particular, if the shared code has separate code-paths, not just 
twice as complicated: it's _more_ than twice as bad, since it introduces 
the conditionals _and_ it introduces the very real risk of the conditional 
being taken the wrong way by mistake.

In contrast, the last time two different filesystems introduced bugs in 
each other was approximately "never". They simply don't modify each others 
code, they don't look at each others data structures, and they don't jump 
into each others routines.

So two separate filesystems are _less_ to maintain than one big one. Even 
if there's a lot of code that -could- be shared.

And no, extents in themselves aren't necessarily "the thing" that drives 
it from maintainable to unmaintainable. This crap grows over time. But I 
would _serious_ suggest that starting anew with a "new" filesystem, and 
taking the time to actually also get _rid_ of some of the baggage would 
quite likely be a good idea.

Just as an example: ext3 _sucks_ in many ways. It has huge inodes that 
take up way too much space in memory. It has absolutely disgusting code to 
handle directory reading and writing (buffer heads! In 2006!). It's 
conditional indexing code is horrible. Its performance absolutely sucks 
when the journal is being drained or something.

Are you going to improve on any of those _fundamnetal_ problems? Or are 
you going to make them worse?

Hint: I'm betting you're not going to improve them by adding more 
features.

		Linus
