Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTHTSnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbTHTSnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:43:24 -0400
Received: from pat.uio.no ([129.240.130.16]:25766 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262128AbTHTSnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:43:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16195.49464.935754.526386@charged.uio.no>
Date: Wed, 20 Aug 2003 11:43:04 -0700
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
In-Reply-To: <20030820192409.A2868@pclin040.win.tue.nl>
References: <3F4268C1.9040608@redhat.com>
	<shszni499e9.fsf@charged.uio.no>
	<20030820192409.A2868@pclin040.win.tue.nl>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andries Brouwer <aebr@win.tue.nl> writes:

     > I don't think it will. My analysis of yesterday night was:
     > - no silly rename is done
     > - this is because d_count equals 1
     > - this is because we have two different dentries for the same
     >   file
     > - this is caused by the fragment

     >         /* If we're doing an exclusive create, optimize away
     >         the lookup */ if (nfs_is_exclusive_create(dir, nd))
     >                 return NULL;

     > in nfs/dir.c.  Do you agree?

No... The above snippet just short-circuits the process of doing an
RPC call in order to look the file up on the *server*. Doing such a
lookup would be wrong since it can race with a file creation on
another NFS client.
IOW the result of the above 2 lines should be the immediate creation
of a negative dentry (i.e. one without an inode) that open_namei() can
pass on to vfs_create().

When we get to the unlink() call, we shouldn't be hitting nfs_lookup()
at all unless something somewhere is causing this first dentry to be
permanently dropped out of the dcache.

In short the scenario should be that

  - mkstemp() does an open(O_EXCL) -> nfs_lookup() creates hashed
    negative dentry -> nfs_create() then does an O_EXCL call to the
    server and instantiates the dentry.

  - unlink() walks the pathname -> finds the existing dentry using
    cached_lookup() and only calls down to nfs_lookup_revalidate().

Cheers,
  Trond
