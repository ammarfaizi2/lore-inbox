Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbUAKAmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUAKAmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:42:12 -0500
Received: from dire.bris.ac.uk ([137.222.10.60]:37300 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id S265528AbUAKAmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:42:10 -0500
Date: Sun, 11 Jan 2004 00:39:59 +0000 (GMT)
From: Bart Oldeman <bartoldeman@users.sf.net>
X-X-Sender: enbeo@enm-bo-lt.enm.bris.ac.uk
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, torvalds <torvalds@osdl.org>
Subject: [PATCH] 2.6.1 (not 2.4.24!) mremap fixes broke shm alias mappings
Message-ID: <Pine.LNX.4.44.0401110020260.25252-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

DOSEMU needs to alias memory, for instance to emulate the HMA. A long time
ago this was done using mmaps of /proc/self/mem. This was replaced by
mremap combined with IPC SHM during 2.1 development.

According to DOSEMUs changelog you agreed to allow old_len==0:
            - using _one_ big IPC shm segment and mremap(addr, 0 ...)
              (Linus agreed on keeping shmat()+mremap(,0,..) functionality)
so you agreed on something you have removed after all now!

(comment in DOSEMU source)
  /* The trick is to set old_len = 0,
   * this won't unmap at the old address, but with
   * shared mem the 'nopage' vm_op will map in the right
   * pages.
   */

An example usage is as follows:
shmget(IPC_PRIVATE, 31498240, 0x1c0|0600) = 11337732
shmat(11337732, 0, 0)                   = 0x40299000
shmctl(11337732, IPC_RMID, 0)           = 0
mremap(0x402a9000, 0, 65536, MREMAP_MAYMOVE|MREMAP_FIXED, 0) = 0
mremap(0x402a9000, 0, 65536, MREMAP_MAYMOVE|MREMAP_FIXED, 0x100000) = 0x100000

The security problems only affect the case new_len==0 so I don't see any
reason for not applying this patch.

Bart

--- mm/mremap.c~	Sat Jan 10 19:22:39 2004
+++ mm/mremap.c	Sun Jan 11 00:19:13 2004
@@ -315,8 +315,11 @@
 	old_len = PAGE_ALIGN(old_len);
 	new_len = PAGE_ALIGN(new_len);

-	/* Don't allow the degenerate cases */
-	if (!old_len || !new_len)
+	/* Don't allow the degenerate cases
+	 * however, old_len == 0 can be used in combination with shmat()
+	 * to create alias mappings.
+	 */
+	if (!new_len)
 		goto out;

 	/* new_addr is only valid if MREMAP_FIXED is specified */

