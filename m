Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262306AbRERMlx>; Fri, 18 May 2001 08:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbRERMln>; Fri, 18 May 2001 08:41:43 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:51718 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S262306AbRERMli>;
	Fri, 18 May 2001 08:41:38 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15109.5911.790765.946985@argo.ozlabs.ibm.com>
Date: Fri, 18 May 2001 22:35:35 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: cort@fsmlabs.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] fs/binfmt_elf.c changes vs 2.4.5-pre3
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch against 2.4.5-pre3 makes 3 changes to fs/binfmt_elf.c:

1. It fixes the csp calculation so that it actually achieves the 16
   byte final alignment that the comment claims.  Previously the csp
   calculation didn't take the AT_NULL entry into account.  If you
   look at the current fs/binfmt_elf.c there is a "sp -= 2" that is
   not reflected in the csp calculation, unlike all the other
   decrements of sp.

2. It allows each architecture to add extra aux table entries by
   defining DLINFO_ARCH_ITEMS and ARCH_DLINFO in <asm/elf.h>.  We need
   this on PowerPC to add entries for the cache line size, and to add
   entries for compatibility with older broken glibc's.

3. It removes the extra 16 bytes that were left free for PowerPC - in
   the past we had to move the auxiliary table up to cope with broken
   glibc's (now we cope by adding special AT_IGNORE entries using the
   ARCH_DLINFO macro).

Please apply this to your tree.

Thanks,
Paul.

diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	Wed May 16 18:45:10 2001
+++ b/fs/binfmt_elf.c	Wed May 16 18:45:10 2001
@@ -135,12 +135,13 @@
 
 	/*
 	 * Force 16 byte _final_ alignment here for generality.
-	 * Leave an extra 16 bytes free so that on the PowerPC we
-	 * can move the aux table up to start on a 16-byte boundary.
 	 */
-	sp = (elf_addr_t *)((~15UL & (unsigned long)(u_platform)) - 16UL);
+	sp = (elf_addr_t *)(~15UL & (unsigned long)(u_platform));
 	csp = sp;
-	csp -= DLINFO_ITEMS*2 + (k_platform ? 2 : 0);
+	csp -= (1+DLINFO_ITEMS)*2 + (k_platform ? 2 : 0);
+#ifdef DLINFO_ARCH_ITEMS
+	csp -= DLINFO_ARCH_ITEMS*2;
+#endif
 	csp -= envc+1;
 	csp -= argc+1;
 	csp -= (!ibcs ? 3 : 1);	/* argc itself */
@@ -174,6 +175,13 @@
 	NEW_AUX_ENT(10, AT_EUID, (elf_addr_t) current->euid);
 	NEW_AUX_ENT(11, AT_GID, (elf_addr_t) current->gid);
 	NEW_AUX_ENT(12, AT_EGID, (elf_addr_t) current->egid);
+#ifdef ARCH_DLINFO
+	/* 
+	 * ARCH_DLINFO must come last so platform specific code can enforce
+	 * special alignment requirements on the AUXV if necessary (eg. PPC).
+	 */
+	ARCH_DLINFO;
+#endif
 #undef NEW_AUX_ENT
 
 	sp -= envc+1;
