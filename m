Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVDHTCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVDHTCC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVDHTCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:02:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:60138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262923AbVDHTB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:01:59 -0400
Date: Fri, 8 Apr 2005 12:03:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050408180540.GA4522@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
 <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
 <20050408180540.GA4522@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Chris Wedgwood wrote:
> 
> Actually, I could probably make this *much* still faster with a
> caveat.  Given that my editor when I write a file will write a
> temporary file and rename it, for files in directories where nlink==2
> I can check chat first and skip the stat of the individual files.

Yes, doing the stat just on the directory (on leaf directories only, of
course, but nlink==2 does say that on most filesystems) is indeed a huge
potential speedup.

It doesn't matter so much for the cached case, but it _does_ matter for
the uncached one. Makes a huge difference, in fact (I was playing with
exactly that back when I started doing "bkr" in BK/tools - three years
ago).

It turns out that I expect to cache my source tree (at least the mail
outline), and that guides my optimizations, but yes, your dir stat does
help in the case of "occasionally working with lots of large projects"  
rather than "mostly working on the same ones with enough RAM to cache it
all".

And "git" is actually fairly anal in this respect: it not only stats all
files, but the index file contains a lot more of the stat info than you'd
expect. So for example, it checks both ctime and mtime to the nanosecond
(did I mention that I didn't worry too much about portability?) exactly so
that it can catch any changes except for actively malicious things.

And if you do actively malicious things in your own directory, you get
what you deserve. It's actually _hard_ to try to fool git into believing a
file hasn't changed: you need to not only replace it with the exact same
file length and ctime/mtime, you need to reuse the same inode/dev numbers
(again - I didn't worry about portability, and filesystems where those
aren't stable are a "don't do that then") and keep the mode the same. Oh,
and uid/gid, but that was much me being silly.

			Linus
