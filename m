Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSIAOFt>; Sun, 1 Sep 2002 10:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSIAOFt>; Sun, 1 Sep 2002 10:05:49 -0400
Received: from mons.uio.no ([129.240.130.14]:19180 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317024AbSIAOFr>;
	Sun, 1 Sep 2002 10:05:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15730.8121.554630.859558@charged.uio.no>
Date: Sun, 1 Sep 2002 16:10:01 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <15730.4100.308481.326297@charged.uio.no>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>
	<15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb>
	<15730.4100.308481.326297@charged.uio.no>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:
    >> For example, rather than this;
     > <snip>

    >> you can just do this:
    >> - uid_t saved_fsuid = current->fsuid;
    >> + uid_t saved_fsuid = current->fscred.uid;
    >> kernel_cap_t saved_cap =
    current-> cap_effective;
 
     > But I don't want to have to do that at all. Why should I change

Just to follow up on why the above 'optimization' is just plain wrong.

You are forgetting that the fscred might simultaneously be referenced
by an open struct file. Are you saying that this file should suddenly
see its credential change?
The alternative without copy on write is to make a full copy of the
fscred every time we open a file or schedule some form of asynchronous
I/O, and hence need to cache the current VFS credentials.

The copy-on-write rule is there in order to *minimize* the need to
copy the cred. It works because changing the cred's entries is
supposed to be a *rare* occurrence, whereas taking references and
reading are common.

Cheers,
  Trond
