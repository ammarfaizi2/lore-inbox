Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUHNT3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUHNT3G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUHNT3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:29:05 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:48770 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264826AbUHNT3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:29:01 -0400
Subject: PATCH [0/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092511739.4109.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 15:28:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches fix up a number of inconsistencies within
the current VFS locking code.

The main problems addressed are

  - Inconsistent definition of what the lock owner means.
  	Currently, the VFS code is sometimes using current->files,
	sometimes current->tgid, and sometimes a combination of both.
    It turns out that CLONE_FILES more or less forces us to use
    current->files as the basis for the lock owner (or bad things
    will happen) so we must drop the checks for current->tgid.
  - Design worries: separate out callbacks used by lock managers,
    such as lockd, and those used by filesystems.
  - posix_lock_file() is called by the VFS *AFTER* the filesystem
    has been notified. However because it uses no locking, and
    may even sleep, there are serious race issues.
    By moving the posix_lock_file() call into the filesystem
    callback, the filesystem may implement its own locking scheme
    to avoid trouble.

Cheers,
  Trond

