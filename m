Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316686AbSFJGoE>; Mon, 10 Jun 2002 02:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSFJGoD>; Mon, 10 Jun 2002 02:44:03 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:27637 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316686AbSFJGoC>; Mon, 10 Jun 2002 02:44:02 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 10 Jun 2002 00:41:20 -0600
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvald@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Saurabh Desai <sdesai@austin.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c: Fix posix locking for threaded tasks
Message-ID: <20020610064120.GH20388@turbolinux.com>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvald@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Saurabh Desai <sdesai@austin.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020610034843.W27186@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2002  03:48 +0100, Matthew Wilcox wrote:
> Saurabh Desai believes that locks created by threads should not conflict
> with each other.  I'm inclined to agree; I don't know why the test for
> ->fl_pid was added, but the comment suggests that whoever added it wasn't
> sure either.
> 
> Frankly, I have no clue about the intended semantics for threads, and
> SUS v3 does not offer any enlightenment.  But it seems reasonable that
> processes which share a files_struct should share locks.  After all,
> if one process closes the fd, they'll remove locks belonging to the
> other process.

I would pass this by the Samba folks first.  I seem to recall them
complaining about this area.  The "one thread closing a file removes
locks from another thread" is one area that I'm sure they don't like.
Making it so that multiple threads ignore file locks is probably
not going to make them happy either.  I believe one of the issues is
that Samba is running server threads for many remote processes, and
it needs to be able to enforce these locks.

Otherwise, this change makes it impossible to write a multi-threaded
program that _does_ allow you use locking between threads.  If anything,
this PID check could be conditional on some extra lock flag (e.g.
THREADS_SHARE_LOCKS or whatever).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

