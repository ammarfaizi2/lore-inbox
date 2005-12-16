Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVLPQg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVLPQg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVLPQg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:36:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49097 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932300AbVLPQg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:36:26 -0500
Date: Fri, 16 Dec 2005 11:36:18 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Jim Meyering <meyering@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH 0/3] *at syscalls: Intro
Message-ID: <20051216163618.GB6378@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com> <43A20B0B.5090205@pobox.com> <eeb5c3c50512160332v3f026766w2c954f1482e84616@mail.gmail.com> <43A2EA55.9070602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A2EA55.9070602@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 08:24:53AM -0800, Ulrich Drepper wrote:
> Jim Meyering wrote:
> >FYI, the rm in coreutils-cvs is finally thread-safe and race-free,
> >when using openat et al.
> 
> Actually, Jim, I doubt it.  There is one more race which cannot be 
> solved with the existing interfaces.  I want to tackle this next, after 
> these changes are decided on.
> 
> The problem is directory creation and then populating it.  As in cp -r 
> and any backup tool.  You currently have to use (at best)
> 
>    mkdirat(fd, "some-dir", 0666);
>    dfd = openat(fd, "some-dir", O_RDONLY);
> 
> What is needed is a way to create a new directory and return a file 
> descriptor for it.
> 
> I was thinking about using
> 
> dfd = openat(fd, "some-dir", O_RDONLY|O_DIRECTORY|O_CREAT, S_IFDIR|0666)
> 
> where the combination of using O_DIRECTORY, O_RDONLY, O_CREAT, and the 
> S_IFDIR flag can be recognized.  This is a configuration which cannot be 
> used successfully in current code.  Should probably also work with open().

At least for prelink I'd also like to be able to atomically
read/modify/write a file, but the Solaris renameat doesn't allow that.
What I do is open the original file, read it etc., then create a temporary
file in the same dir and as the final step I need to rename it over
the original file, but I'd like to do that only if nobody replaced
the original file in the mean time.
So a renameat variant that would have
olddirfd, oldname, oldfd, newdirfd, newname, newfd
arguments would be handy.  It would do the same thing as
renameat (olddirfd, oldname, newdirfd, newname),
but would fail if oldfd resp. newfd no longer corresponds to
the olddirfd/oldname resp. newdirfd/newname files.

	Jakub
