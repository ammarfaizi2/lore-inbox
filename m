Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268847AbRG0NUg>; Fri, 27 Jul 2001 09:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268849AbRG0NU0>; Fri, 27 Jul 2001 09:20:26 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:38149 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S268847AbRG0NUG>;
	Fri, 27 Jul 2001 09:20:06 -0400
Date: Fri, 27 Jul 2001 15:20:00 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Hugh Dickins <hugh@veritas.com>
Subject: [PATCH 2.4.8-pre1 and 2.4.7-ac1] Motion Eye camera driver updates.
Message-ID: <20010727152000.B6860@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This patch applies cleanly to either 2.4.8-pre1 or 2.4.7-ac1
and updates the motion eye camera driver to remove an array
from the stack, and slightly optimize the code.

All the credit goes to Hugh Dickins <hugh@veritas.com>.

Alan, Linus, please apply.

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.6-ac5.orig/drivers/media/video/meye.c linux-2.4.6-ac5/drivers/media/video/meye.c
--- linux-2.4.6-ac5.orig/drivers/media/video/meye.c	Fri Jul 27 14:27:36 2001
+++ linux-2.4.6-ac5/drivers/media/video/meye.c	Thu Jul 26 11:45:57 2001
@@ -209,28 +209,23 @@
 
 /* return a page table pointing to N pages of locked memory */
 static void *ptable_alloc(int npages, u32 *pt_addr) {
-	int i = 0;
+	int i;
 	void *vmem;
-	u32 ptable[npages+1];
-	signed long size;
+	u32 *ptable;
 	unsigned long adr;
 
-	size = (npages + 1) * PAGE_SIZE;
-	vmem = rvmalloc(size);
+	vmem = rvmalloc((npages + 1) * PAGE_SIZE);
 	if (!vmem)
 		return NULL;
 
-	memset(ptable, 0, sizeof(ptable));
         adr = (unsigned long)vmem;
-	while (size > 0) {
-		ptable[i++] = virt_to_bus(__va(kvirt_to_pa(adr)));
+	ptable = (u32 *)(vmem + npages * PAGE_SIZE);
+	for (i = 0; i < npages; i++) {
+		ptable[i] = (u32) kvirt_to_bus(adr);
 		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
 	}
 
-	memcpy(vmem + npages * PAGE_SIZE, ptable, PAGE_SIZE);
-	*pt_addr = ptable[npages];
-
+	*pt_addr = (u32) kvirt_to_bus(adr);
 	return vmem;
 }
 
diff -uNr --exclude-from=dontdiff linux-2.4.6-ac5.orig/drivers/media/video/meye.h linux-2.4.6-ac5/drivers/media/video/meye.h
--- linux-2.4.6-ac5.orig/drivers/media/video/meye.h	Fri Jul 27 14:27:36 2001
+++ linux-2.4.6-ac5/drivers/media/video/meye.h	Fri Jul 27 10:12:35 2001
@@ -29,7 +29,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	0
+#define MEYE_DRIVER_MINORVERSION	1
 
 /****************************************************************************/
 /* Motion JPEG chip registers                                               */
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
