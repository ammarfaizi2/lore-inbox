Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUJLBNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUJLBNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJLBLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:11:32 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:41859
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269390AbUJLBKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:10:04 -0400
Subject: [patch 1/1] uml: fix critical IP checksum corruption
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       Lars.Ellenberg@linbit.com
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:55:00 +0200
Message-Id: <20041012005500.B82CB7EAD@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Lars Ellenberg <Lars.Ellenberg@linbit.com>

Add a memory barrier to the assembly checksum code - the code was copied
straight from the i386 one, and the patch resyncs the code with the original.
I'll check if the original code can be included directly (i.e. "#include")
after 2.6.9.

Without this patch, every 2.6 UML release corrupts the checksum of every UDP
fragmented packet with size >= MTU (verified by various people, we all agree
on this issue; nobody reported "Works fine here"). The corrupted packets are
not accepted, thus blocking any kind of communication with large-sized UDP
packets.

In fact, I've even dissected the UML -> host traffic before and after this
patch with Ethereal - and it always reported an incorrect checksum for
fragmented UDP packets before and always correct after applying the patch.

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/include/sysdep-i386/checksum.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/include/sysdep-i386/checksum.h~uml-fix-checksum-code arch/um/include/sysdep-i386/checksum.h
--- linux-2.6.9-current/arch/um/include/sysdep-i386/checksum.h~uml-fix-checksum-code	2004-10-12 02:33:40.549763104 +0200
+++ linux-2.6.9-current-paolo/arch/um/include/sysdep-i386/checksum.h	2004-10-12 02:33:40.552762648 +0200
@@ -103,7 +103,8 @@ static inline unsigned short ip_fast_csu
 	   are modified, we must also specify them as outputs, or gcc
 	   will assume they contain their original values. */
 	: "=r" (sum), "=r" (iph), "=r" (ihl)
-	: "1" (iph), "2" (ihl));
+	: "1" (iph), "2" (ihl)
+	: "memory");
 	return(sum);
 }
 
_
