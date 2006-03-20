Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWCTNKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWCTNKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWCTNKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:10:03 -0500
Received: from thunk.org ([69.25.196.29]:38096 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750920AbWCTNKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:10:00 -0500
Date: Mon, 20 Mar 2006 08:09:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Xin Zhao <uszhaoxin@gmail.com>, mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
Message-ID: <20060320130950.GA9334@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Al Viro <viro@ftp.linux.org.uk>, Xin Zhao <uszhaoxin@gmail.com>,
	mingz@ele.uri.edu, mikado4vn@gmail.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com> <441CE71E.5090503@gmail.com> <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com> <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com> <1142792787.31358.28.camel@localhost.localdomain> <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com> <20060319194723.GA27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319194723.GA27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 07:47:23PM +0000, Al Viro wrote:
> As for "more efficient"...  300 lookups per second is less than an
> improvement.  It's orders of magnitude worse than e.g. ext2; I don't
> know in which world that would be considered more efficient, but I
> certainly glad that I don't live there.

There are two problems... well, more, but in the performance domain,
at least two issues that stick out like a sore thumb.

The first is throughput, and as Al and others have already pointed out
300 metadata operations per second is defintely nothing to write home
about.  The second is latency; how much *time* does it take to perform
an individual operations, especially if you have to do an upcall from
the kernel to a userspace database process, the user space process
then has to dick around its own general purpose,
non-optimized-for-a-filesystem data structures, possibly make syscalls
back down into the kernel only to have the data blocks pushed back up
into userspace, and then finally return the result of the "stat"
system call back to the kernel so the kernel can ship it off to the
original process that called stat(2).

Even in WinFS, dropped from Microsoft Longwait, it really wasn't using
the database to store all metadata.  A better way of thinking about it
is a forcible bundling of a Microsoft's database product (European
regulators take note) with the OS; all of the low-level filesystem
operations are still being done the traditional way, and it's only
high level indexing operation which are being done in userspace (and
only in userspace).  It would be like taking the taking the locate(1)
userspace program and claiming it was part of the filesystem; it's
more about packaging than anything else.

						- Ted
