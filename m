Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266160AbUF3A3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266160AbUF3A3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbUF3A3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:29:10 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:32896 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266150AbUF3A3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:29:06 -0400
Subject: [PATCH 0/5] POSIX Locking fixes. Take 2...
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1088555277.4573.106.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 20:29:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright's Oops appears to show that relying on the fl_pid is
untenable, since CLONE_FILES does not imply CLONE_THREAD.

The alternative fix is to switch to having the locking code entirely
rely on the file_lock->fl_owner field in order to determine whether or
not locks are owned by the same process. In the special cases of fork()
and NPTL threads, this will still lead to correct POSIX behaviour.

For those that like to fool around with CLONE_THREAD or CLONE_FILES on
their own, however, there is no way to guarantee "correct" behaviour.
The effort has therefore gone towards making it consistent, and allowing
the filesystem to override VFS semantics when it is incapable of
following them.
For NFSv2/v3 this means that we have to allow lockd to manage its own
lockowners. In particular the steal_locks() abomination is impossible to
implement, and so the only secure thing to do is to drop those locks
(note that this is not an issue if the process kills all its threads
before calling exec*() as is required to by the SuS).

Cheers,
  Trond
