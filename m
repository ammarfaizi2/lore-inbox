Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbSKZDwB>; Mon, 25 Nov 2002 22:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266144AbSKZDwB>; Mon, 25 Nov 2002 22:52:01 -0500
Received: from thunk.org ([140.239.227.29]:60361 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266135AbSKZDwA>;
	Mon, 25 Nov 2002 22:52:00 -0500
Date: Mon, 25 Nov 2002 22:55:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hugo Mills <hugo-lkml@carfax.org.uk>,
       Clemmitt Sigler <siglercm@jrt.me.vt.edu>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Message-ID: <20021126035556.GB11903@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hugo Mills <hugo-lkml@carfax.org.uk>,
	Clemmitt Sigler <siglercm@jrt.me.vt.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
References: <Pine.LNX.4.33L2.0211242351001.2368-100000@jrt.me.vt.edu> <20021125105739.GA7531@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125105739.GA7531@carfax.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 10:57:39AM +0000, Hugo Mills wrote:
>    Running fsck recovers the missing files into lost+found, but
> doesn't remove the duplicated filenames. 

E2fsck doesn't currently check for duplicated files in a directory.
It probably should, but doing so would increase its required memory
usuage and/or its run-time, at least in the non-HTREE case, which is
why I never implemented it.  (Currently we scan all directory blocks
in the filesystem sorted by disk block number, to avoid seeks.  So in
order to check for duplicates, we would either need to allocate enough
disk space to store all directory entries on the filesystem in memory
--- which would take up lost of memory --- or scan directory blocks
directory by directory, which would significantly increase the number
of seeks needed by e2fsck in its pass 2 processing.)

If the directory is indexed using the HTREE format, or the directories
are going to be optimized anyway by specifying the -D option in newer
versions e2fsck, adding support for detecting duplicate filenames
would be really cheap, so I'll very likely end up adding this feature
in an upcoming release of e2fsck.

Given the reports that people with xfs filesystems are also seeing
filesystem corruption, it sounds like filesystem blocks are getting
written to the wrong location on disk.  That would explain the
duplicate filenames in the directory, as well as files disappearing.
In general this sort of corruption is relatively rare, which is
another reason why I havne't bothered with adding that support to
e2fsck.

						- Ted
