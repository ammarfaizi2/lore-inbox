Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbTHaJV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 05:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHaJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 05:21:59 -0400
Received: from aneto.able.es ([212.97.163.22]:60550 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262514AbTHaJVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 05:21:34 -0400
Date: Sun, 31 Aug 2003 11:21:27 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] correct AT_PLATFORM for HT cpus
Message-ID: <20030831092127.GA21970@werewolf.able.es>
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Aug 30, 2003 at 17:48:22 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.30, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre2. It contains an USB update, PPC merge, m68k merge, IDE
> changes from Alan, network drivers update from Jeff, amongst other fixes
> and updates.
> 

In shortest: Pentium4 with HT do not realize they are themselves an i686.
Even, they do not know what they are. This makes P4HT select i386 libraries
at runtime, instead of i686 ones.

In short: binfmt_elf::create_elf_tables() copies the AT_PLATFORM in the
place pointed by u_platform, and then copies the pointer to elf tables.
But, in the HT case, u_platform gets changed in the middle, beacuse it
is also used as the beginning of the stack, that is shifted for HT
processors to avoid cache collisions. So then
it puts a pointer to garbage in the elf tables:

    if (k_platform) {
        platform_len = strlen(k_platform) + 1;
        u_platform = p - platform_len;
        __copy_to_user(u_platform, k_platform, platform_len);
    } else
        u_platform = p;
...
    if(smp_num_siblings > 1)
        u_platform = u_platform - ((current->pid % 64) << 7);
...
    if (k_platform) {
        sp -= 2;
        NEW_AUX_ENT(0, AT_PLATFORM, (elf_addr_t)(unsigned long) u_platform);
    }

Solution is to use separate variables to store u_platform and the stack_top:

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

As other patches, tested by myself. And Mandrake kernel includes it.
Comments ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
