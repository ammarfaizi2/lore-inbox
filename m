Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbWHNVPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWHNVPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWHNVPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:15:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26841 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932735AbWHNVPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:15:17 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/4] Use 64-bit inode numbers internally in the kernel
Date: Mon, 14 Aug 2006 22:15:04 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org#,
       dhowells@redhat.com
Message-Id: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches make the kernel use 64-bit inode numbers internally, even on a
32-bit system.  They are required because some filesystems have intrinsic
64-bit inode numbers: NFS and XFS for example.  The 64-bit inode numbers are
then propagated to userspace automatically where the arch supports it.

Problems have been seen with userspace (eg: ld.so) using the 64-bit inode
number returned by stat64() or getdents64() to differentiate files, and failing
because the 64-bit inode number space was compressed to 32-bits, and so
overlaps occur.


There are four patches:

 (1) Supply __udivdi3() and __umoddi3() so that the compiler can do 64-bit
     division and modulus.  __udivmoddi4() is also supplied as the other two
     are wrappers around that.

 (2) Make __kernel_ino_t consistently typedef'd to "unsigned long long" on all
     archs.

     Where ino_t has been used in userspace facing structures (such as struct
     stat), it has been replaced with whatever ino_t used to be defined as on
     that arch.

     struct inode::i_ino and struct kstat::ino are changed to ino_t type.

 (3) Fix print format warnings in general code due to the change in type of
     i_ino.  These should now all carry an "ll" modifier.

 (4) As for (3), but fix the CacheFiles code.

David
