Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267103AbUBSDVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 22:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267784AbUBSDVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 22:21:07 -0500
Received: from dp.samba.org ([66.70.73.150]:3202 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267103AbUBSDVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 22:21:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16436.11148.231014.822067@samba.org>
Date: Thu, 19 Feb 2004 14:20:44 +1100
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <20040219024426.GA3901@thunk.org>
References: <1qqzv-2tr-3@gated-at.bofh.it>
	<1qqJc-2A2-5@gated-at.bofh.it>
	<1qHAR-2Wm-49@gated-at.bofh.it>
	<1qIwr-5GB-11@gated-at.bofh.it>
	<1qIwr-5GB-9@gated-at.bofh.it>
	<1qIQ1-5WR-27@gated-at.bofh.it>
	<1qIZt-6b9-11@gated-at.bofh.it>
	<1qJsF-6Be-45@gated-at.bofh.it>
	<E1Atbi7-0004tf-O7@localhost>
	<16436.2817.900018.285167@samba.org>
	<20040219024426.GA3901@thunk.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted,

 > Actually, not necessarily.  What if Samba gets notifications of all
 > filename renames and creates in the directory, so that after the
 > initial directory scan, it can keep track of what filenames are
 > present in the directory?  It can then "prove the negative", as you
 > put it, without having to continuously do directory scans.

Currently dnotify doesn't give you the filename that is being
added/deleted/renamed. It just tells you that something has happened,
but not enough to actually maintain a name cache in user space.

That could be changed, so that on a dnotify event you do a fcntl() to
ask for the name of the file. Or perhaps we could cram it into the
structure the signal handler gets passed? I doubt that would make
sense, but maybe some signal guru can tell me otherwise. Maybe we
could even invent a new dnotify system where you do a read on a file
descriptor to get details on what event happened, and give some
"everything has changed" error when you run out of buffers.

If that happened then we could build our own dcache in user space, but
it will be a very second rate dcache, with a racy and slow update
mechanism that will in itself chew cpu. Maybe thats the best we can
do, or maybe I should be asking distro vendors if they would consider
a case-insensitive patch, especially the vendors aiming for
"enterprise" scalability which might include serving windows clients.

 > Yeah, there can be some race conditions, but Samba already has to deal
 > with the race condition where it tries to create "MaKeFiLe" either
 > just before or just after a Posix process creates "Makefile".  

yes, thats true. 

The races aren't my primary concern really. I've spent the last week
doing profiling of a large Samba install, and after fixing a
horrendous scalability problem do to with fcntl locking (more on that
later) the next thing on the profile is stat() and directory
scans. That's why the efficiency of this stuff is a hot topic for me
right now.

It's not all as bleak as perhaps I make it seem though. I suspect
there is still quite a bit of improvement that can be made in Samba
just because our code is so messy that sometimes we do a stat() call
or a directory scan when perhaps we can prove that we don't need
to. The Samba4 code is much cleaner, and maybe we have room to keep
improving things for a couple of years by finding those inefficiencies
and fixing them. We will eventually hit a wall, but it could be a fair
way off. Maybe windows will be dead by then.

Cheers, Tridge
