Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVKDQ1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVKDQ1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVKDQ1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:27:42 -0500
Received: from pat.uio.no ([129.240.130.16]:29136 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932094AbVKDQ1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:27:41 -0500
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek()
	bugfix
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: jblunck@suse.de
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051104151104.GA22322@hasse.suse.de>
References: <20051104113851.GA4770@hasse.suse.de>
	 <20051104115101.GH7992@ftp.linux.org.uk>
	 <20051104122021.GA15061@hasse.suse.de>
	 <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu>
	 <20051104131858.GA16622@hasse.suse.de>
	 <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu>
	 <20051104151104.GA22322@hasse.suse.de>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 11:27:21 -0500
Message-Id: <1131121642.8806.42.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.836, required 12,
	autolearn=disabled, AWL 1.98, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 16:11 +0100, jblunck@suse.de wrote:
> On Fri, Nov 04, Miklos Szeredi wrote:
> 
> > > As I said: "Old glibc implementations (e.g. glibc-2.2.5) are
> > > lseeking after every call to getdents() ..."
> > 
> > Hmm, why would it do that?  This seems like it's glibc being stupid.
> > 
> 
> Well, glibc is that stupid and triggers the bug.

It is due to the kernel's 32-bit struct dirent being smaller than
glibc's 32-bit struct dirent (glibc has the extra ->d_type field).
Because the dirent record length depends on the filename length, the
exact expansion factor for the results of a call to getdents() may not
be precomputed.
glibc uses a heuristic in order to estimate the expansion size, and then
uses that to allocate an intermediate buffer in which to store the
results of the getdents syscall.
If the contents of said intermediate buffer still happen to overflow the
user-allocated buffer, then glibc calls lseek() in order to rewind the
file pointer to the next entry it wants to read (and screws any
filesystem that doesn't support lseek on directories).

This code appears still to be part of glibc, however it is rarely
triggered these days because glibc's implementation now defaults to
using the getdents64 syscall (if it exists) instead of the 32-bit
version. Since the kernel's struct dirent64 is the same size as the
glibc struct dirent64 (and larger than the 32-bit struct dirent), there
is never any chance of buffer overflow.

The new bug is rather that glibc will return EOVERFLOW, and try to
rewind your file pointer if your filesystem happens to return 64-bit
offsets to getdents64().

> > Unfortunately I can't since I don't have such old glibc.
> 
> The testcase is similar to what "rm *" with the old glibc would do. It just
> a testcase to show where the problem is.

'rm -rf' on a large directory used to be a great way to trigger it.

Cheers,
  Trond

