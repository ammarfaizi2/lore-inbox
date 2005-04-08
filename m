Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVDHThp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVDHThp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVDHThp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:37:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:47241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262905AbVDHThf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:37:35 -0400
Date: Fri, 8 Apr 2005 12:39:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050408191638.GA5792@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0504081232430.28951@ppc970.osdl.org>
References: <20050408041341.GA8720@taniwha.stupidest.org>
 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random>
 <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de>
 <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
 <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
 <20050408191638.GA5792@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Apr 2005, Chris Wedgwood wrote:
> 
> > It doesn't matter so much for the cached case, but it _does_ matter
> > for the uncached one.
> 
> Doing the minimal stat cold-cache here is about 6s for local disk.
> I'm somewhat surprised it's that bad actually.

One of the reasons I do inode numbers in the "index" file (apart from 
checking that the inode hasn't changed) is in fact that "stat()" is damn 
slow if it causes seeks. Since your stat loop is entirely 

You can optimize your stat() patterns on traditional unix-like filesystems
by just sorting the stats by inode number (since the inode number is
historically a special index into the inode table - even when filesystems
distribute the inodes over several tables, sorting will generally do the
right thing from a seek perspective). It's a disgusting hack, but it
literally gets you orders-of-magnitude performance improvments in many
real-life cases.

It does have some downsides:
 - it buys you nothing when it's cached (and obviously you have the 
   sorting overhead, although that's pretty cheap)
 - on other filesystems it can make things slower.

But if the cold-cache case actually is a concern, I do have the solution 
for it. Just a simple "prime-cache" program that does a qsort on the index 
file entries and does the stat() on them all will bring the numbers down. 
Those 6 seconds you see are the disk head seeking around like mad.

			Linus
