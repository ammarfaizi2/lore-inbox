Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTDEWus (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbTDEWus (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:50:48 -0500
Received: from jalon.able.es ([212.97.163.2]:11999 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id S262703AbTDEWuq (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:50:46 -0500
Date: Sun, 6 Apr 2003 01:02:11 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] AT_PLATFORM on HT-P4
Message-ID: <20030405230211.GC12746@werewolf.able.es>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405224233.GA12746@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030405224233.GA12746@werewolf.able.es>; from jamagallon@able.es on Sun, Apr 06, 2003 at 00:42:33 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.06, J.A. Magallon wrote:
> 
> On 04.04, Marcelo Tosatti wrote:
> > 
> > So here goes -pre7. Hopefully the last -pre.
> > 
> 

This makes P4 Xeon to report correct i686 platform. Without this, 
all those people that think its ld.so automatically picks i686 libs
are wrong...

The original code takes u_platform for coyping ELF_PLATFORM, but
also supposes it is the top of stack. This changes when we have
siblings:

    if(smp_num_siblings > 1)
        u_platform = u_platform - ((current->pid % 64) << 7);

Later:

        NEW_AUX_ENT(0, AT_PLATFORM, (elf_addr_t)(unsigned long) u_platform);

that on HT cpus is broken, isn't it ?

This separates the two things, stack top and u_platform. It could be
even cleaner, with something like

stack_top = p;
if (k_platform)
	sz = strlen(k_platform)+1
	u_platform = stack_top - sz
	__copy_to_user(...)
	stack_top -= sz
else
	u_platform = NULL
...
if(smp_num_siblings > 1)
        stack_top = stack_top - ((current->pid % 64) << 7);
...
if (u_platform)
	NEW_AUX_ENT(...)

But I have not tested it. Current patch below.

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
Mandrake Linux release 9.2 (Bamboo) for i586
Linux 2.4.21-pre7-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
