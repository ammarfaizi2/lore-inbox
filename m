Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbTK0QXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbTK0QXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:23:12 -0500
Received: from pat.uio.no ([129.240.130.16]:20412 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264550AbTK0QXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:23:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16326.9448.320003.775274@charged.uio.no>
Date: Thu, 27 Nov 2003 11:23:04 -0500
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.4] NFS unlocking operation accesses invalid file struct
In-Reply-To: <200311272054.22316.mita@miraclelinux.com>
References: <200311252000.32094.mita@miraclelinux.com>
	<shs1xrwvudw.fsf@charged.uio.no>
	<200311272054.22316.mita@miraclelinux.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Akinobu Mita <mita@miraclelinux.com> writes:

     > Thanks, Trond.  but, your patch causes memory leak.


Yep. Worse: pthreads assumes that we don't use the pid as the lock
owner. That again means that the test in locks_same_owner() is
incorrect.
For 2.6.x, the NPTL further complicates matters by introducing the
tgid as their equivalent of the posix process id, and not tying
CLONE_THREAD to CLONE_FILES. AFAICS there's nothing we can do about
that...



So then the correct thing to do is indeed to wrap the call to
locks_unlock_delete() with an fget()/fput() pair, and then to remove
the test for fl_pid in locks_same_owner().

We then need to fix lockd so that it generates correct fl_owners for
its locks...

Let me see if I can get that right.

Cheers,
  Trond
