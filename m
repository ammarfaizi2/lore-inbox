Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWHOP0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWHOP0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWHOP0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:26:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39881 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752109AbWHOP0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:26:43 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/2] Use 64-bit inode numbers internally in the kernel [try #2]
Date: Tue, 15 Aug 2006 16:26:27 +0100
To: torvalds@osdl.org, akpm@osdl.org, trond.myklebust@fys.uio.no,
       aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@linux-nfs.org, dhowells@redhat.com
Message-Id: <20060815152627.29222.71414.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches make the kernel pass 64-bit inode numbers internally when
communicating to userspace, even on a 32-bit system.  They are required
because some filesystems have intrinsic 64-bit inode numbers: NFS3+ and XFS
for example.  The 64-bit inode numbers are then propagated to userspace
automatically where the arch supports it.

Problems have been seen with userspace (eg: ld.so) using the 64-bit inode
number returned by stat64() or getdents64() to differentiate files, and failing
because the 64-bit inode number space was compressed to 32-bits, and so
overlaps occur.


There are two patches:

 (1) Make struct kstat::ino and filldir_t's inode number argument u64 rather
     than ino_t and give an EOVERFLOW if an inode number can't be represented
     to userspace without shedding the top bits of the number.

 (2) Make NFS represent 64-bit fileids as 64-bit inode numbers to the VFS
     rather than compressing them to 32-bits on 32-bit systems.

David
