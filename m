Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293433AbSCARjL>; Fri, 1 Mar 2002 12:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSCARjC>; Fri, 1 Mar 2002 12:39:02 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:30715 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293433AbSCARiv>; Fri, 1 Mar 2002 12:38:51 -0500
Date: Fri, 01 Mar 2002 11:38:47 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.19-pre2] Make max_threads be based on normal zone size
Message-ID: <71650000.1015004327@baldur>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1875939384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1875939384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


The max_threads config parameter (used to determine how many tasks to
allow) is currently calculated based on the total amount of physical memory
in the machine.  This is wrong, since the real limiting factor is the
amount of memory in the normal zone.

This patch fixes the initialization of max_threads by allowing an
architecture to specify how much memory is in the normal zone, and using
that value to initialize max_threads.

My apologies for sending it as an attachment, but I don't trust my mail
client not to screw up an inline patch.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1875939384==========
Content-Type: text/plain; charset=iso-8859-1; name="memsize-2.4.19-pre2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="memsize-2.4.19-pre2.diff";
 size=2301

--- linux-2.4.19-pre2/./init/main.c	Thu Feb 28 16:06:01 2002
+++ linux-2.4.19-pre2-memsize/./init/main.c	Fri Mar  1 09:44:15 2002
@@ -348,7 +348,6 @@
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
-	unsigned long mempages;
 	extern char saved_command_line[];
 /*
  * Interrupts are still disabled. Do necessary setups, then
@@ -399,13 +398,21 @@
 	kmem_cache_sizes_init();
 	pgtable_cache_init();
=20
-	mempages =3D num_physpages;
-
-	fork_init(mempages);
+	/*
+	 * For architectures that have highmem, num_mappedpages represents
+	 * the amount of memory the kernel can use.  For other architectures
+	 * it's the same as the total pages.  We need both numbers because
+	 * some subsystems need to initialize based on how much memory the
+	 * kernel can use.
+	 */
+	if (num_mappedpages =3D=3D 0)
+		num_mappedpages =3D num_physpages;
+ =20
+	fork_init(num_mappedpages);
 	proc_caches_init();
-	vfs_caches_init(mempages);
-	buffer_init(mempages);
-	page_cache_init(mempages);
+	vfs_caches_init(num_physpages);
+	buffer_init(num_physpages);
+	page_cache_init(num_physpages);
 #if defined(CONFIG_ARCH_S390)
 	ccwcache_init();
 #endif
--- linux-2.4.19-pre2/./mm/memory.c	Thu Feb 28 16:06:02 2002
+++ linux-2.4.19-pre2-memsize/./mm/memory.c	Thu Feb 28 16:34:06 2002
@@ -52,6 +52,7 @@
=20
 unsigned long max_mapnr;
 unsigned long num_physpages;
+unsigned long num_mappedpages;
 void * high_memory;
 struct page *highmem_start_page;
=20
--- linux-2.4.19-pre2/./include/linux/mm.h	Thu Feb 28 16:06:01 2002
+++ linux-2.4.19-pre2-memsize/./include/linux/mm.h	Fri Mar  1 09:44:17 2002
@@ -15,6 +15,7 @@
=20
 extern unsigned long max_mapnr;
 extern unsigned long num_physpages;
+extern unsigned long num_mappedpages;
 extern void * high_memory;
 extern int page_cluster;
 /* The inactive_clean lists are per zone. */
--- linux-2.4.19-pre2/./arch/i386/mm/init.c	Fri Dec 21 11:41:53 2001
+++ linux-2.4.19-pre2-memsize/./arch/i386/mm/init.c	Thu Feb 28 16:34:06 =
2002
@@ -462,8 +462,9 @@
 #ifdef CONFIG_HIGHMEM
 	highmem_start_page =3D mem_map + highstart_pfn;
 	max_mapnr =3D num_physpages =3D highend_pfn;
+	num_mappedpages =3D max_low_pfn;
 #else
-	max_mapnr =3D num_physpages =3D max_low_pfn;
+	max_mapnr =3D num_mappedpages =3D num_physpages =3D max_low_pfn;
 #endif
 	high_memory =3D (void *) __va(max_low_pfn * PAGE_SIZE);
=20

--==========1875939384==========--

