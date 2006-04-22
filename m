Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWDVSxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWDVSxI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWDVSwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:52:45 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:40626 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750921AbWDVSwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:52:43 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
In-Reply-To: <20060422132032.GB5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422093328.GM19754@stusta.de>
	 <1145707384.16166.181.camel@shinybook.infradead.org>
	 <20060422123835.GA5010@stusta.de>
	 <1145710123.11909.241.camel@pmac.infradead.org>
	 <20060422132032.GB5010@stusta.de>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 16:30:12 +0100
Message-Id: <1145719812.11909.333.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 15:20 +0200, Adrian Bunk wrote:
> On Sat, Apr 22, 2006 at 01:48:43PM +0100, David Woodhouse wrote:
> > On Sat, 2006-04-22 at 14:38 +0200, Adrian Bunk wrote:
> > > What was the recommended way for getting userspace header at last
> > > year's kernel summit?
> > 
> > It was said that we need _incremental_ changes, and this is an attempt
> > to satisfy that request.

Let me expand on that...

There are a number of steps which we need to take.

1. Identify those files which contain stuff which should be
user-visible. I've done a first pass of this for arch-independent files
and asm-powerpc already. We need it done for other architectures.

2. Examine the contents of those files, and separate private parts from
parts which should be user-visible. This can be by splitting them into
separate files, or by using ifdefs -- it doesn't matter conceptually at
_this_ stage as long as the important work of _reading_ the code and
identifying it as either public or private is done. All else can be
scripted after that.

This much is undisputed -- _everyone_ agrees that it's necessary. We can
do that, and we can have a fairly simple post-processing stage which
creates a set of 'sanitised' kernel headers which we can inspect, and
which we can compare between releases. This is _also_ the bulk of the
real work. It's where we actually have to look at the code and _think_
about it.

But it's not _all_ we want to do, ideally. Ideally we want to take it
further...

3. Eliminate all the #ifdef __KERNEL__. Ifdefs are horrid -- we all know
that. We should split public bits into entirely separate files. Once
it's marked with #ifdef __KERNEL__ after stage #2, it's fairly simple to
split the files up -- it's scriptable; doesn't really need much thought.

4. Clean up the directory structure. It really ought to be just a copy
of certain directories, rather than picking selected files from
include/linux et al. Again, once we _have_ the public files marked in
some way, it's trivial to move them around once we agree where they
should go.

Linus has said he doesn't want to jump straight in at #4 and start
moving things around en masse. Adrian, you seem to be saying you won't
help _unless_ you can send patches which mix #2 and #4 instead of doing
it incrementally. 

Now, I'm perfectly happy with patches which do that, if you can actually
get them merged. The export step can happily pick up the headers you've
moved to include/kabi/ and put them back where userspace expects to see
them for now.

In fact, I think it's best to hold off on #4 for now -- not only because
Linus won't take the patches, but because once we've done steps 1-3
above, we'll have a _much_ clearer idea of what we have left and how it
should best be laid out. Maybe once we've moved the crap out of the way
we'll end up wanting chrdev/*.h, ioctl/*.h, sockopt/*.h etc....

But even though I think it's premature, I still don't _mind_ moving
stuff into kabi/ -- because as I said it's _trivial_ to move stuff
around after it's been cleaned up. That part isn't the interesting part
of the problem, and I'm uninterested in arguing about it. 

-- 
dwmw2

