Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbREZW6z>; Sat, 26 May 2001 18:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbREZW6q>; Sat, 26 May 2001 18:58:46 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262060AbREZW6i>;
	Sat, 26 May 2001 18:58:38 -0400
Date: Sat, 26 May 2001 21:56:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ben LaHaise <bcrl@redhat.com>, Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526215644.F1834@athlon.random>
In-Reply-To: <20010526203104.E1834@athlon.random> <Pine.LNX.4.33.0105262141010.1695-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105262141010.1695-100000@localhost.localdomain>; from mingo@elte.hu on Sat, May 26, 2001 at 09:42:37PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 09:42:37PM +0200, Ingo Molnar wrote:
> Andrea, can you rather start running the Cerberus testsuite instead? All

I run cerberus all the time but I don't have locally x86 machines with
>1G of ram so it will take some time for me to try on a real highmem, I
am pretty sure I just tested cerberus with highmem emulation and it
didn't deadlocked for me, I can try again with an higher highmem/normal
ratio later. The ratio I am using right now is half of the ram in
highmem (that is almost the same ratio of a 2G machine):

diff -urN 2.4.3aa/arch/i386/config.in 2.4.3aa-highmemdebug/arch/i386/config.in
--- 2.4.3aa/arch/i386/config.in	Sun Apr  1 11:59:37 2001
+++ 2.4.3aa-highmemdebug/arch/i386/config.in	Sun Apr  1 13:00:01 2001
@@ -369,4 +369,7 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+if [ "$CONFIG_HIGHMEM" = "y" ]; then
+   bool 'Debug HIGHMEM on lowmem machines' CONFIG_HIGHMEM_DEBUG
+fi
 endmenu
diff -urN 2.4.3aa/arch/i386/kernel/setup.c 2.4.3aa-highmemdebug/arch/i386/kernel/setup.c
--- 2.4.3aa/arch/i386/kernel/setup.c	Sat Mar 31 15:17:07 2001
+++ 2.4.3aa-highmemdebug/arch/i386/kernel/setup.c	Sun Apr  1 13:00:01 2001
@@ -649,7 +649,19 @@
  */
 #define VMALLOC_RESERVE	(unsigned long)(128 << 20)
 #define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
+#ifdef CONFIG_HIGHMEM_DEBUG
+#define MAXMEM_PFN				\
+({						\
+	int __max_pfn;				\
+	if (max_pfn > PFN_DOWN(MAXMEM))		\
+	     __max_pfn = PFN_DOWN(MAXMEM);	\
+	else					\
+	     __max_pfn = max_pfn / 2;		\
+	__max_pfn;				\
+})
+#else
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+#endif
 #define MAX_NONPAE_PFN	(1 << 20)
 
 	/*


Andrea
