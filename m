Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbTI2HTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTI2HTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:19:41 -0400
Received: from pat.uio.no ([129.240.130.16]:32466 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262851AbTI2HTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:19:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16247.56578.861224.328086@charged.uio.no>
Date: Mon, 29 Sep 2003 00:19:30 -0700
To: Frank Cusack <fcusack@fcusack.com>
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: effect of nfs blocksize on I/O ?
In-Reply-To: <20030928234236.A16924@google.com>
References: <20030928234236.A16924@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > 2.6 sets this to nfs_fsinfo.wtmult?nfs_fsinfo.wtmult:512 = 512
     >     typically.

     > (My estimation of "typical" may be way off though.)

     > At a 512 byte blocksize, this overflows struct statfs for fs >
     > 1TB.  Most of my NFS filesystems (on netapp) are larger than
     > that.

Then you should use statfs64()/statvfs64(). Nobody is going to
guarantee to you that the equivalent 32-bit syscalls will hold for
arbitrary disk sizes.

     > But more importantly, what does the VFS *do* with the
     > blocksize?  strace seems to show that glibc/stdio does consider
     > it.  If I fprintf() two 4096 byte strings, libc does a single
     > write() with 8192 blocksize, and 3 write()'s for 512 blocksize.
     > I haven't looked to see what goes over the wire, but I assume
     > that still follows rsize/wsize.

In NFS you need to distinguish between the 'block size' (bsize) and
the 'fragment size' (frsize). The former is defined as the "optimal
transfer block size", the latter is the "block size on the underlying
filesystem" according to the manpages.

These are SUS-mandated definitions...


The VFS itself cares little about the blocksize, however programs like
'df' are supposed to use the fragment size as their basic unit when
reporting space usage. Putting arbitrary values in place of the true
fragment size typically leads to rounding errors, and so is not
recommended.

OTOH, bsize is of informational interest to programs that wish to
optimize I/O throughput by grouping their data into appropriately
sized records.

Cheers,
  Trond
