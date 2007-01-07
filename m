Return-Path: <linux-kernel-owner+w=401wt.eu-S932407AbXAGFkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbXAGFkX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 00:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbXAGFkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 00:40:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33110 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403AbXAGFkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 00:40:22 -0500
Date: Sat, 6 Jan 2007 21:39:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: git@vger.kernel.org, nigel@nigel.suspend2.net,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
In-Reply-To: <45A083F2.5000000@zytor.com>
Message-ID: <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
References: <20061214223718.GA3816@elf.ucw.cz>  <20061216094421.416a271e.randy.dunlap@oracle.com>
  <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com> 
 <1166297434.26330.34.camel@localhost.localdomain>  <1166304080.13548.8.camel@nigel.suspend2.net>
  <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net>
 <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jan 2007, H. Peter Anvin wrote:
> 
> During extremely high load, it appears that what slows kernel.org down more
> than anything else is the time that each individual getdents() call takes.
> When I've looked this I've observed times from 200 ms to almost 2 seconds!
> Since an unpacked *OR* unpruned git tree adds 256 directories to a cleanly
> packed tree, you can do the math yourself.

"getdents()" is totally serialized by the inode semaphore. It's one of the 
most expensive system calls in Linux, partly because of that, and partly 
because it has to call all the way down into the filesystem in a way that 
almost no other common system call has to (99% of all filesystem calls can 
be handled basically at the VFS layer with generic caches - but not 
getdents()).

So if there are concurrent readdirs on the same directory, they get 
serialized. If there is any file creation/deletion activity in the 
directory, it serializes getdents(). 

To make matters worse, I don't think it has any read-ahead at all when you 
use hashed directory entries. So if you have cold-cache case, you'll read 
every single block totally individually, and serialized. One block at a 
time (I think the non-hashed case is likely also suspect, but that's a 
separate issue)

In other words, I'm not at all surprised it hits on filldir time. 
Especially on ext3.

		Linus
