Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTJIXbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 19:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTJIXbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 19:31:12 -0400
Received: from pat.uio.no ([129.240.130.16]:5302 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262674AbTJIXbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 19:31:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16261.61366.97329.707780@charged.uio.no>
Date: Thu, 9 Oct 2003 19:31:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
References: <16261.56894.8109.858323@charged.uio.no>
	<Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@osdl.org> writes:

    >> Note that f_bsize is usually larger than f_frsize, hence
    >> conversions from the former to the latter are subject to
    >> rounding errors...

     > User space shouldn't know or care about frsize, and it doesn't
     > even necessarily make any sense on a lot of filesystems, so
     > make it easy for the user. It's not as if the rounding errors
     > really matter.

It can lead to funny quirks when doing df: Used + Available != Total

Granted the effects won't be enormous (typically you'll see between 1
and 63 blocks off in the case of NFS w/ 32kwsize and 512byte frsize)
but people get upset about this. That was the reason for adding an
f_frsize field in the first place...

Note: one solution might be to swap the positions of f_frsize and
f_bsize in the kernel struct that is passed up to userland. I.e. pass
up

 struct statfs {
         __u32 f_type;
-         __u32 f_bsize;
+         __u32 f_frsize;
         __u32 f_blocks;
         __u32 f_bfree;
         __u32 f_bavail;
         __u32 f_files;
         __u32 f_ffree;
         __kernel_fsid_t f_fsid;
         __u32 f_namelen;
-         __u32 f_frsize;
+         __u32 f_bsize;
         __u32 f_spare[5];
 };

That will give correct values for the f_bfree, f_bavail,... in the
legacy statfs() case for all existing filesystems.

glibc's statvfs() can then do the correct thing if it detects a >=2.6.0
kernel. It needs to do a copy to its private statvfs struct anyway.

Cheers,
  Trond
