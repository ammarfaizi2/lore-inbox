Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUIIQjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUIIQjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUIIQiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:38:52 -0400
Received: from [69.25.196.29] ([69.25.196.29]:21727 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266243AbUIIQgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:36:05 -0400
Date: Thu, 9 Sep 2004 05:03:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea ofwhat reiser4 wants to do with metafiles and why
Message-ID: <20040909090342.GA30303@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	William Stearns <wstearns@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com> <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409080009.52683.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 12:09:52AM +0200, Robin Rosenberg wrote:
> Maybe file/./attribute then. /. on a file is currently meaningless. That does 
> not avoid the unpleasant fact that has been brought up by others (only to be 
> ignored), that the directory syntax does not allow metadata on directories.

*Not* that I am endorsing the idea of being able to access metadata
via a standard pathname --- I continue to believe that named streams
are a bad idea that will be an attractive nuisance to application
developers, and if we must do them, then Solaris's openat(2) API is
the best way to proceed --- HOWEVER, if people are insistent on being
able to do this via standard pathnames, and not introducing a new
system call, I would suggest /|/ as the separator as the third least
worst option.  Why?

Any such scheme will violate POSIX and SUS, since we are stealing from
the filename namespace, and thus could cause a previously working
program to stop working --- however, assuming that we don't care about
this, the virtical bar is the least likely to collide with existing
file usages, because of its status as a shell meta-character (i.e.,
pipe).  This means that in order to use it on the shell command line,
programs will have to quote it:

	cat /home/tytso/word.doc/\|/meta/silly-stupid-metadata-or-named-stream

This may seem to be inconvenient, but one very good thing about this
is that PHP and existing Perl scripts already already treat pathnames
that contain pipes with a certain amount of suspicion --- and this is
a good thing!  Otherwise, programs that take input from untrusted
sources (say, URL's or http form posts), may convert such input into a
metadata access, and that may be a very, very, very bad thing.  (For
example, it may mean that you will have accidentally allowed a web
user to read or possibly modify an ACL with whatever privileges of the
CGI-perl or php script.)  By using a pipe character, it avoids this
problem, since secure CGI scripts must be already checking for the
pipe character anyway.

> I'm not convinced that totally transparent access to meta-data actually 
> benefits anyone. If metadata is that useful (which I believe) it may well be
> worth fixing those apps that need, and can use them. The rest should just
> ignore it, even loose it. 

Totally agreed.  As I said above, I would prefer openat(2) to trying
to do this within a standard pathname, and I would prefer not doing it
all since aside from Samba, which is simply trying to maintain
backwards compatibility with a Really Bad Idea, the number of
protocols and data formats (ftp, tar, zip, gzip, cpio, etc., etc.,
etc.) that would need to be revamped is huge. 

						- Ted
