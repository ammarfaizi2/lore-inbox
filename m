Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVDJP7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVDJP7d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 11:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVDJP7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 11:59:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:17618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261517AbVDJP72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 11:59:28 -0400
Date: Sun, 10 Apr 2005 09:01:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: tony.luck@intel.com
cc: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <200504101200.j3AC0Mu13146@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0504100854110.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <200504101200.j3AC0Mu13146@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005 tony.luck@intel.com wrote:
>
> With 60,000 changesets in the current tree, we will start out our git
> repository with about 600,000 files.  Assuming the first byte of the
> SHA1 hash is random, that means an average of 2343 files in each of the
> objects/xx directories.  Give it a few more years at the current pace,
> and we'll have over 10,000 files per directory.  This sounds like a lot
> to me ... but perhaps filesystems now handle large directories enough
> better than they used to for this to not be a problem?

The good news is that git itself doesn't really care. I think it's
literally _one_ function ("get_sha1_filename()") that you need to change,
and then you need to write a small script that moves files around, and
you're really much done.

Also, I did actually debate that issue with myself, and decided that even
if we do have tons of files per directory, git doesn't much care. The
reason? Git never _searches_ for them. Assuming you have enough memory to
cache the tree, you just end up doing a "lookup", and inside the kernel
that's done using an efficient hash, which doesn't actually care _at_all_
about how many files there are per directory.

So I was for a while debating having a totally flat directory space, but 
since there are _some_ downsides (linear lookup for cold-cache, and just 
that "ls -l" ends up being O(n**2) and things), I decided that a single 
fan-out is probably a good idea.

> Or maybe the files should be named objects/xx/yy/zzzzzzzzzzzzzzzz?

Hey, I may end up being wrong, and yes, maybe I should have done a 
two-level one. The good news is that we can trivially fix it later (even 
dynamically - we can make the "sha1 object tree layout" be a per-tree 
config option, and there would be no real issue, so you could make small 
projects use a flat version and big projects use a very deep structure 
etc). You'd just have to script some renames to move the files around..

		Linus
