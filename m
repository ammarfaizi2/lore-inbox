Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWFISEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWFISEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWFISEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:04:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030278AbWFISEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:04:47 -0400
Date: Fri, 9 Jun 2006 11:04:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <20060609174146.GO1651@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0606091056100.5498@g5.osdl.org>
References: <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <m3y7w69s6v.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091018150.5498@g5.osdl.org>
 <20060609174146.GO1651@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Matthew Wilcox wrote:
> 
> One of the costs (and I'm not disagreeing with your main point;
> I think forking ext3 to ext4 at this point is reasonable), is that
> bugfixes applied to one don't necessarily get applied to the other.

I agree. However, that tends to be less of an issue of you fork off a 
stable base (which isn't always the case). Forking off something that is 
being stil actively developed is a different matter entirely. I don't 
think ext3 is in that situation, really.

Also, one of the issues is when there are big VFS layer changes, which 
affect all filesystems. Then, a lot of people will think that it's easier 
to fix up one unified filesystem than it is to fix up five separate ones, 
and the fact is, that's often _not_ the case.

The unified filesystem potentially has so much crud and crap and other 
issues that it ends up being much more work to understand and fix it up 
than it would have been to do the same thing for five different 
filesystems that didn't play a lot of games and have complex

  "if this flag is set, do this code, otherwise do that code, and this 
   whole directory reading code btw has a static CONFIG_EXT3_INDEX thing, 
   so you won't even know if you caught all the interface changes when you 
   get a clean compile"

So I'm not a huge believer in "shared code is good code". I believe shared 
code is good only if it has no conditionals.

Ie the VFS-layer kind of code that acts the SAME for everybody is the good 
kind of sharing. The kind where you call into different routines that will 
do different things depending on a flag (which may not even be obvious to 
the caller) is usually the _bad_ kind of sharing, because that's the kind 
of code that ends up working for one user and not working for another, and 
trying to make it work for both may be fundamentally hard.

The

	if (sb->option.extent) 
		.. do one thing ..
	else
		.. do another ..

kind of thing is exactly what leads to problems later. Even if it allows 
sharing of 90% of the code (the caller of the function), it leads to 
problems exactly because of things that end up not quite working because 
people only tested one code-path, and it broke the other case in some 
really subtle way.

		Linus
