Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSL0Xu2>; Fri, 27 Dec 2002 18:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSL0Xu2>; Fri, 27 Dec 2002 18:50:28 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:59307 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S265285AbSL0XuZ>;
	Fri, 27 Dec 2002 18:50:25 -0500
Date: Sat, 28 Dec 2002 00:58:35 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@hera.kernel.org>, davem@redhat.com
Subject: [BUG+PATCH] binfmt_elf::create_elf_tables changes u_platform without refill
Message-ID: <20021227235835.GA2079@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I thing I found a bug in 2.4 (and someone should check if this applies to 2.5
also...). In short, when running on an HT box, create_elf_tables() changes
u_platform pointer (to separate stacks and avoid cache wars), without
copy_to_user'ing again.

Current code:

    if (k_platform) {
        platform_len = strlen(k_platform) + 1;
        u_platform = p - platform_len;
        __copy_to_user(u_platform, k_platform, platform_len);
    } else
...
#if defined(__i386__) && defined(CONFIG_SMP)
    if(smp_num_siblings > 1)
        u_platform = u_platform - ((current->pid % 64) << 7);
///// So original u_platform with data is lost !!!
#endif
...
    sp = (elf_addr_t *)(~15UL & (unsigned long)(u_platform));  // Set stack
...
    if (k_platform) {
        sp -= 2;
        NEW_AUX_ENT(0, AT_PLATFORM, (elf_addr_t)(unsigned long) u_platform);
///// What the h**l is copied here after changing u_platform ???
    }

Patch below (use an independent stack_top). Boots and works on my dual Xeon,
and glibc behaves correctly:

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
+		stack_top -= ((current->pid % 64) << 7);
 #endif	
 
 	/*
 	 * Force 16 byte _final_ alignment here for generality.
 	 */
-	sp = (elf_addr_t *)(~15UL & (unsigned long)(u_platform));
+	sp = (elf_addr_t *)(~15UL & (unsigned long)(stack_top));
 	csp = sp;
 	csp -= (1+DLINFO_ITEMS)*2 + (k_platform ? 2 : 0);
 #ifdef DLINFO_ARCH_ITEMS


One question: why the 64 value ? Because linux supports 64 processors ?
Why not just 2, because you have two siblings at most ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
