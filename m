Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270326AbTGRXDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270069AbTGRXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:03:36 -0400
Received: from aneto.able.es ([212.97.163.22]:44480 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S270414AbTGRXDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:03:07 -0400
Date: Sat, 19 Jul 2003 01:18:02 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre7
Message-ID: <20030718231802.GG6166@werewolf.able.es>
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jul 18, 2003 at 21:53:25 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.18, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre7.
> 
> This is a feature freeze, only bugfixes will be accepted from now on.
> 

HyperThreaded P4s will still fail to set AT_PLATFORM correctly.
Do you want to kill this bug from .22 ? ;)

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
Linux 2.4.22-pre6-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.3mdk))
