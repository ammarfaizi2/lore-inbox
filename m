Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263889AbTDVWre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTDVWre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:47:34 -0400
Received: from aneto.able.es ([212.97.163.22]:53498 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263889AbTDVWrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:47:32 -0400
Date: Wed, 23 Apr 2003 00:59:31 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030422225931.GA9066@werewolf.able.es>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Apr 21, 2003 at 20:47:32 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.21, Marcelo Tosatti wrote:
> 
> Here goes the first candidate for 2.4.21.
> 
> Please test it extensively.
> 

binfmt_elf.c is still buggy wrt HT cpus when setting AT_PLATFORM.
This patch corrects it and also optimizes stack usage changing from
fixed 64 cpus to NR_CPUS (unless I misunderstood what the '64' stands for...)

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
Linux 2.4.21-rc1-jam1 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
