Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSJJUgx>; Thu, 10 Oct 2002 16:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263989AbSJJUgw>; Thu, 10 Oct 2002 16:36:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263987AbSJJUgu>;
	Thu, 10 Oct 2002 16:36:50 -0400
Date: Thu, 10 Oct 2002 21:42:33 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: RFC: No more deadlock detection for POSIX locks
Message-ID: <20021010214233.G18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The deadlock detection for posix locks really isn't worth anything
any more.  It was always slightly dubious, since a parent/child could
remove each other's locks (thanks, POSIX!).  But now it's really dubious
since we store the TID, not the PID of the requesting process, and any
thread can unlock a lock set by another thread.

Here's one situation in which it can falsely return -EDEADLK:

TID 1001, PID 1002 takes lock A
TID 1003, PID 1004 takes lock B
TID 1001, PID 1005 takes lock B, blocks
TID 1003, PID 1004 takes lock A, gets -EDEADLK.
Even though (1001,1002) isn't blocking on any lock and will release lock A
in the future.

So how about we just delete the nasty deadlock detection code?  I've never
been fond of the user-triggerable O(N^2) algorithm, and we're permitted
to not implement it (POSIX suggests applications set a timer to detect
deadlock themselves, so anyone writing a portable application is already
doing this).

Objections?

-- 
Revolutions do not require corporate support.
