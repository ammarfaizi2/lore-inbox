Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVEaPer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVEaPer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVEaPer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:34:47 -0400
Received: from imap.gmx.net ([213.165.64.20]:49385 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261907AbVEaPeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:34:37 -0400
Date: Tue, 31 May 2005 17:34:33 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <20050503231408.7c045648.sfr@canb.auug.org.au>
Subject: File leases and fork()
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <19606.1117553673@www82.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

The other recent thread on F_SETLEASE prompted me to go
and recheck another blemish in the file lease code,
which still exists: viz leases and fork().

Via its inherited file descriptors, a child of fork() inherits 
a reference to the file leases held by the parent (file leases 
are maintained in the open file table).  The following details 
are relevant:

-- The file lease is registered only to the parent (as seen
   in /proc/locks).  If a lease breaker arrives, only the 
   parent is signalled.

-- If no explicit F_SETLEASE is done to remove a lease, then
   the lease is only removed when all file descriptors referring 
   to the open file table entry are closed.

These two factors lead to various weirdnesses.  Some examples:

1. If the parent closes its file descriptor, or simply terminates,
   then the lease continues exist (because of the child's open 
   descriptor).  However, if a lease breaker arrives, the
   kernel does not know what process to signal: the child is not 
   signalled and the lease breaker's open() (or truncate()) is
   blocked until /proc/sys/fs/lease-break-time expires (default 
   of 45 seconds), at which point the kernel forcibly breaks or 
   downgrades the lease, allowing the lease breaker to proceed.

2. Suppose a parent does the following:

   -- opens a file, yielding a file descriptor fd
   -- calls fork()
   -- and the child takes out a lease on fd, and then exits

   At this point, the lease continues to exist (because of 
   the *parent's* open file descriptor).  If a lease breaker
   arrives, then as above, no process is signalled (the lease 
   is marked as belonging to the now dead child, as can be
   seen in /proc/locks), and the lease breaker blocks until 
   /proc/sys/fs/lease-break-time expires.

What are the intended semantics of file leases with respect 
to fork()?  I realize that file leases were designed with
SAMBA in mind, and fork() probably wasn't part of the 
original vision, but the current semantics seem broken and 
confusing.  Simplest would perhaps be that a child did not
inherit a reference to the same lease, but I'm not sure
how achievable that would be in the existing design.

Cheers,

Michael

-- 
Weitersagen: GMX DSL-Flatrates mit Tempo-Garantie!
Ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
