Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUAMBBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUAMBBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:01:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:19891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbUAMBBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:01:16 -0500
Date: Mon, 12 Jan 2004 16:34:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bart Oldeman <bartoldeman@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6.1 (not 2.4.24!) mremap fixes broke shm alias mappings
In-Reply-To: <Pine.LNX.4.44.0401110020260.25252-100000@enm-bo-lt.enm.bris.ac.uk>
Message-ID: <Pine.LNX.4.58.0401121632230.14305@evo.osdl.org>
References: <Pine.LNX.4.44.0401110020260.25252-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Jan 2004, Bart Oldeman wrote:
> 
> DOSEMU needs to alias memory, for instance to emulate the HMA. A long time
> ago this was done using mmaps of /proc/self/mem. This was replaced by
> mremap combined with IPC SHM during 2.1 development.
> 
> According to DOSEMUs changelog you agreed to allow old_len==0:
>             - using _one_ big IPC shm segment and mremap(addr, 0 ...)
>               (Linus agreed on keeping shmat()+mremap(,0,..) functionality)
> so you agreed on something you have removed after all now!

Hey, I wouldn't remember all the special cases that aren't commented. But 
I agree that a zero "old_len" is not bad in itself, and if DOSEMU uses it, 
let's just continue to support it, and document it while we're at it.

So if this makes DOSEMU happy again, let's do it..

Pls confirm.

		Linus

----
===== mm/mremap.c 1.35 vs edited =====
--- 1.35/mm/mremap.c	Wed Jan  7 18:26:37 2004
+++ edited/mm/mremap.c	Mon Jan 12 16:32:15 2004
@@ -315,8 +315,12 @@
 	old_len = PAGE_ALIGN(old_len);
 	new_len = PAGE_ALIGN(new_len);
 
-	/* Don't allow the degenerate cases */
-	if (!old_len || !new_len)
+	/*
+	 * We allow a zero old-len as a special case
+	 * for DOS-emu "duplicate shm area" thing. But
+	 * a zero new-len is nonsensical.
+	 */
+	if (!new_len)
 		goto out;
 
 	/* new_addr is only valid if MREMAP_FIXED is specified */
