Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290752AbSBLEKy>; Mon, 11 Feb 2002 23:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290753AbSBLEKo>; Mon, 11 Feb 2002 23:10:44 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:31137 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S290752AbSBLEKd>; Mon, 11 Feb 2002 23:10:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.38242.112277.248114@gargle.gargle.HOWL>
Date: Tue, 12 Feb 2002 15:09:06 +1100
From: Christopher Yeoh <cyeoh@samba.org>
To: marcelo@conectiva.com.br, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mmap can return incorrect errno
X-Mailer: VM 7.01 under Emacs 21.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mmap currently sets errno to EINVAL when it should be ENOMEM.
SUS/POSIX states that ENOMEM should be returned when:

"MAP_FIXED was specified, and the range [addr, addr + len) exceeds
that allowed for the address space of a process; or if MAP_FIXED was
not specified and there is insufficient room in the address space to
effect the mapping."

The following patch (against 2.4.17) fixes this behaviour:

--- mm/mmap.c~	Tue Nov  6 11:12:25 2001
+++ mm/mmap.c	Mon Feb 11 15:49:58 2002
@@ -620,7 +620,7 @@
 {
 	if (flags & MAP_FIXED) {
 		if (addr > TASK_SIZE - len)
-			return -EINVAL;
+			return -ENOMEM;
 		if (addr & ~PAGE_MASK)
 			return -EINVAL;
 		return addr;

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
