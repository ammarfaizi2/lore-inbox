Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbTFRWk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbTFRWk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:40:56 -0400
Received: from aneto.able.es ([212.97.163.22]:11250 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265590AbTFRWkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:40:40 -0400
Date: Thu, 19 Jun 2003 00:54:36 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [RFC][PATCH] Correct AT_PLATFORM for HT P4 in 2.4.21
Message-ID: <20030618225436.GE3768@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Current kernel fails to set AT_PLATFORM when siblings are present, so HT-P4
fails to publish itself as an i686, and ld.so does not pick automatically
i686 optmized libraries.

Explanation of current bug in create_elf_tables::fs/binfmt_elf.c:
u_platform is used both as the place where platform info is copied at the
beginning of the process data area, and as the stack begin:
- if (k_platform), it is copied at stack top, and u_platform is set to the
  beginning of that info.
- if siblings are present, u_platform is moved to avoid cache conflicts and
  predictability
- the address of u_platform is put to user space, but it has changed and now
  does not point to correct info

This patch separates the two uses, stack and u_platform
Note: it also changes the shifting factor from a fixed 64 to NR_CPUS to save
some space...

Comments ?

--- linux/fs/binfmt_elf.c.orig	2002-12-28 00:12:32.000000000 +0100
+++ linux/fs/binfmt_elf.c	2002-12-28 00:32:37.000000000 +0100
@@ -116,11 +116,14 @@
 	elf_caddr_t *argv;
 	elf_caddr_t *envp;
 	elf_addr_t *sp, *csp;
+	char *stack_top;
 	char *k_platform, *u_platform;
 	long hwcap;
 	size_t platform_len = 0;
 	size_t len;
 
+	stack_top = p;
+
 	/*
 	 * Get hold of platform and hardware capabilities masks for
 	 * the machine we are running on.  In some cases (Sparc), 
@@ -135,8 +138,8 @@
 		platform_len = strlen(k_platform) + 1;
 		u_platform = p - platform_len;
 		__copy_to_user(u_platform, k_platform, platform_len);
-	} else
-		u_platform = p;
+		stack_top = u_platform;
+	}
 
 #if defined(__i386__) && defined(CONFIG_SMP)
 	/*
@@ -149,15 +152,14 @@
 	 * processors. This keeps Mr Marcelo Person happier but should be
 	 * removed for 2.5
 	 */
-	 
 	if(smp_num_siblings > 1)
-		u_platform = u_platform - ((current->pid % 64) << 7);
+		stack_top -= ((current->pid % NR_CPUS) << 7);
 #endif	
 
 	/*
 	 * Force 16 byte _final_ alignment here for generality.
 	 */
-	sp = (elf_addr_t *)(~15UL & (unsigned long)(u_platform));
+	sp = (elf_addr_t *)(~15UL & (unsigned long)(stack_top));
 	csp = sp;
 	csp -= (1+DLINFO_ITEMS)*2 + (k_platform ? 2 : 0);
 #ifdef DLINFO_ARCH_ITEMS


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
