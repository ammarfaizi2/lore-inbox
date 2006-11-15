Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWKOL1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWKOL1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 06:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbWKOL1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 06:27:05 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:45455 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932838AbWKOL1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 06:27:03 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: akpm@osdl.org
Subject: [PATCH] i386-pda UP optimization
Date: Wed, 15 Nov 2006 12:27:04 +0100
User-Agent: KMail/1.9.5
Cc: Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, ak@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <4506665D.2090001@goop.org> <1158047806.2992.7.camel@laptopd505.fenrus.org>
In-Reply-To: <1158047806.2992.7.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ImvWFko6SxDWlqE"
Message-Id: <200611151227.04777.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ImvWFko6SxDWlqE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Seeing %gs prefixes used now by i386 port, I recalled seeing strange oprofile 
results on Opteron machines.

I really think %gs prefixes can be expensive in some (most ?) cases, even if 
the Intel/AMD docs say they are free.

I wrote this trivial User program to benchmark vfs_read()/vfs_write() that 
happens to use 'current' many times.

#include <unistd.h>
#include <errno.h>

int main()
{
        int i, fd[2];
        char c = 0;
        pipe(fd);
        for (i = 0; i < 10000000; i++) {
                errno = 0; // glibc also use %gs
                write(fd[1], &c, 1);
                read(fd[0], &c, 1);
        }
        return 0;
}

The best elap time I got for this program on 10 runs was : 12.811 s
(Intel(R) Pentium(R) M processor 1.60GHz)

With the attached patch, I got 12.212 s, and a kernel text size reduction of 
3400 bytes.

I wish Jeremy give us patches for UP machines so that %gs can be let untouched 
in entry.S (syscall entry/exit). A lot of ia32 machines are still using one 
CPU.

Note : I dont have a x86_64 machine here, but I suspect a similar patch could 
be done for x86_64 too.

Thank you

[PATCH] i386-pda UP optimization

On a !CONFIG_SMP machine, there is only one PDA, (one CPU).
We can avoid %gs prefixes when reading/writing fields in PDA.
This reduce kernel text size and also give better performance.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_ImvWFko6SxDWlqE
Content-Type: text/plain;
  charset="utf-8";
  name="i386-pda-up.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="i386-pda-up.patch"

--- linux-2.6.19-rc5-mm2/include/asm-i386/pda.h	2006-11-15 11:21:24.000000000 +0100
+++ linux-2.6.19-rc5-mm2-ed/include/asm-i386/pda.h	2006-11-15 11:23:49.000000000 +0100
@@ -91,10 +91,19 @@
 	((typeof(_proxy_pda.field) *)((unsigned char *)read_pda(_pda) + \
 				      pda_offset(field)))
 
+#if defined(CONFIG_SMP)
 #define read_pda(field) pda_from_op("mov",field)
 #define write_pda(field,val) pda_to_op("mov",field,val)
 #define add_pda(field,val) pda_to_op("add",field,val)
 #define sub_pda(field,val) pda_to_op("sub",field,val)
 #define or_pda(field,val) pda_to_op("or",field,val)
+#else
+extern struct i386_pda boot_pda;
+#define read_pda(field)      boot_pda.field 
+#define write_pda(field,val) do { boot_pda.field = (val);} while (0)
+#define add_pda(field,val) ) do { boot_pda.field += (val);} while (0)
+#define sub_pda(field,val)   do { boot_pda.field -= (val);} while (0)
+#define or_pda(field,val)    do { boot_pda.field |= (val);} while (0)
+#endif
 
 #endif	/* _I386_PDA_H */
--- linux-2.6.19-rc5-mm2/arch/i386/kernel/cpu/common.c	2006-11-15 11:21:25.000000000 +0100
+++ linux-2.6.19-rc5-mm2-ed/arch/i386/kernel/cpu/common.c	2006-11-15 11:45:09.000000000 +0100
@@ -609,6 +609,14 @@
 	return regs;
 }
 
+/* Initial PDA used by boot CPU */
+struct i386_pda boot_pda = {
+	._pda = &boot_pda,
+	.cpu_number = 0,
+	.pcurrent = &init_task,
+};
+EXPORT_SYMBOL(boot_pda);
+
 static __cpuinit int alloc_gdt(int cpu)
 {
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
@@ -628,11 +636,10 @@
 		BUG_ON(gdt != NULL || pda != NULL);
 
 		gdt = alloc_bootmem_pages(PAGE_SIZE);
-		pda = alloc_bootmem(sizeof(*pda));
+		pda = &boot_pda;
 		/* alloc_bootmem(_pages) panics on failure, so no check */
 
 		memset(gdt, 0, PAGE_SIZE);
-		memset(pda, 0, sizeof(*pda));
 	} else {
 		/* GDT and PDA might already have been allocated if
 		   this is a CPU hotplug re-insertion. */
@@ -655,13 +662,6 @@
 	return 1;
 }
 
-/* Initial PDA used by boot CPU */
-struct i386_pda boot_pda = {
-	._pda = &boot_pda,
-	.cpu_number = 0,
-	.pcurrent = &init_task,
-};
-
 static inline void set_kernel_gs(void)
 {
 	/* Set %gs for this CPU's PDA.  Memory clobber is to create a

--Boundary-00=_ImvWFko6SxDWlqE--
