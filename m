Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWA3QiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWA3QiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWA3QiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:38:06 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:64664 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S964771AbWA3QiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:38:05 -0500
Date: Tue, 31 Jan 2006 00:37:49 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: linux-kernel@vger.kernel.org
Subject: Unique /proc/<pid>/fd/ inode numbers?
Message-ID: <20060130163748.GC8154@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Dagobah Systems
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A useful thing to be able to determine when checkpointing a process
from userspace is whether two file descriptors that point to the
same file are
   (a) two independently open()'d instances of the file; or
   (b) one open() and one dup().
(the latter case meaning the FDs share locks & seek offsets).

I haven't yet found a clean way to do this from userspace. What did
cross my mind is to look at the inode number of the symlink in
/proc/<pid>/fd/.

Currently, the inode number amounts to ((pid<<16) | 0x8000 + fd_num)
(from fs/proc/base.c), which appears rather arbitrary, but
sufficient not to cause conflicts. I was thinking it would be
convenient if dup()'d files had identical inode numbers (think of
them as hard links :)

There is a comment at the top of base.c:
/*
 * For hysterical raisins we keep the same inumbers as in the old procfs.
 * Feel free to change the macro below - just keep the range distinct from
 * inumbers of the rest of procfs (currently those are in 0x0000--0xffff).
 * As soon as we'll get a separate superblock we will be able to forget
 * about magical ranges too.
 */

Where should I be looking for the status on this separate
superblock? 

Would it be potentially possible to make the inode number some
unique hash of the struct file pointer relevant to the FD?

Or alternately, is there another way to solve the original problem
at the start of this email?

I'd be happy to prepare and send a patch when I'm certain things
won't collide, but I'd appreciate any guidance.

Thanks in advance,

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
