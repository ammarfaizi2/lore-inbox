Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTCDU6B>; Tue, 4 Mar 2003 15:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbTCDU6A>; Tue, 4 Mar 2003 15:58:00 -0500
Received: from [212.156.4.132] ([212.156.4.132]:50117 "EHLO fep02.ttnet.net.tr")
	by vger.kernel.org with ESMTP id <S266135AbTCDU57>;
	Tue, 4 Mar 2003 15:57:59 -0500
Date: Tue, 4 Mar 2003 23:08:27 +0200
From: Faik Uygur <faikuygur@ttnet.net.tr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] Slab after-before poisoning backport
Message-ID: <20030304210827.GA3179@ttnet.net.tr>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 15 C0 AA 31 59 F9 DE 4F 7D A6 C7 D8 A0 D5 67 73
X-PGP-Key-ID: 0x5C447959
X-PGP-Key-Size: 2048 bits
X-Editor: GNU Emacs 21.2.1
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial patch that backports Andrew Morton's slab poisoning
modification in 2.5. Patch makes it easier to understand if the BUG() 
at slab.c caused by a freed or an uninitialized slab object usage.

--- linux-2.4.21-pre5/mm/slab.c.orig	Tue Mar  4 22:47:21 2003
+++ linux-2.4.21-pre5/mm/slab.c	Tue Mar  4 22:45:51 2003
@@ -297,8 +297,9 @@
 #define	RED_MAGIC2	0x170FC2A5UL	/* when obj is inactive */
 
 /* ...and for poisoning */
-#define	POISON_BYTE	0x5a		/* byte value for poisoning */
-#define	POISON_END	0xa5		/* end-byte of poisoning */
+#define	POISON_BEFORE	0x5a	/* for use-uninitialised poisoning */
+#define	POISON_AFTER	0x6b	/* for use-after-free poisoning */
+#define	POISON_END	0xa5	/* end-byte of poisoning */
 
 #endif
 
@@ -522,14 +523,15 @@
 }
 
 #if DEBUG
-static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr)
+static inline void kmem_poison_obj (kmem_cache_t *cachep, void *addr, 
+				    unsigned char val)
 {
 	int size = cachep->objsize;
 	if (cachep->flags & SLAB_RED_ZONE) {
 		addr += BYTES_PER_WORD;
 		size -= 2*BYTES_PER_WORD;
 	}
-	memset(addr, POISON_BYTE, size);
+	memset(addr, val, size);
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
@@ -1083,7 +1085,7 @@
 			objp -= BYTES_PER_WORD;
 		if (cachep->flags & SLAB_POISON)
 			/* need to poison the objs */
-			kmem_poison_obj(cachep, objp);
+			kmem_poison_obj(cachep, objp, POISON_BEFORE);
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*((unsigned long*)(objp)) != RED_MAGIC1)
 				BUG();
@@ -1443,7 +1445,7 @@
 			BUG();
 	}
 	if (cachep->flags & SLAB_POISON)
-		kmem_poison_obj(cachep, objp);
+		kmem_poison_obj(cachep, objp, POISON_AFTER);
 	if (kmem_extra_free_checks(cachep, slabp, objp))
 		return;
 #endif
