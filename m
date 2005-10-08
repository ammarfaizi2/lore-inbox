Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVJHHTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVJHHTn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 03:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVJHHTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 03:19:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16135 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750834AbVJHHTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 03:19:42 -0400
Date: Sat, 8 Oct 2005 09:19:36 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: why is NFS performance poor when decompress linux kernel
Message-ID: <20051008071936.GF22601@alpha.home.local>
References: <4ae3c140510072139n68b9b2eeyc0a400be32d958fe@mail.gmail.com> <1128751189.17981.62.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128751189.17981.62.camel@mindpipe>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 08, 2005 at 01:59:48AM -0400, Lee Revell wrote:
> On Sat, 2005-10-08 at 00:39 -0400, Xin Zhao wrote:
> > I noticed that when doing large file copy or linux kernel compilation
> > in a NFS direcotry, the performance is not bad compared to local disk
> > filesystem such as ext2. However, if I do linux kernel tarball
> > decompression on a NFS directory, the performance is much worse than
> > local disk filesystem (over 3 times slower). Anybody know the reason?
> 
> Because NFS requires all writes to be synchronous by default, and
> uncompressing the kernel is the most write intensive of those three
> operations.  Mount with the async option and the performance should be
> closer to a local disk.  Obviously this is more dangerous.

I don't agree with you, Lee. My NFS is mounted with async by default,
and what takes the most time when extracting a kernel archive is that
tar does a stat() on every file before writing it. And THAT stat()
prevents writes from being buffered. A better solution might be to
process several files in parallel (multi-process/multi-thread).
Perhaps a project for a new tar ?

Just for a test, I tried extracting multiple files in parallel. The
method is completely crappy, but I could saturate my NFS server this
way :

$ tar ztf /tmp/linux-2.6.9.tar.gz >/tmp/file-list
$ sed -n '1~4p' < /tmp/file-list >/tmp/file-list1
$ sed -n '2~4p' < /tmp/file-list >/tmp/file-list2
$ sed -n '3~4p' < /tmp/file-list >/tmp/file-list3
$ sed -n '4~4p' < /tmp/file-list >/tmp/file-list4

$ tar zxf /tmp/linux-2.6.9.tar.gz -T /tmp/file-list1 & tar zxf /tmp/linux-2.6.9.tar.gz -T /tmp/file-list2 & tar zxf /tmp/linux-2.6.9.tar.gz -T /tmp/file-list3 & tar zxf /tmp/linux-2.6.9.tar.gz -T /tmp/file-list4 & wait

OK, it finally took more time, although the server was saturated (maybe
it crawled under seeks at the end, I did not check). This may constitute
a starting point for people having more time to research in this area.

> Lee

Cheers,
Willy

