Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVIAE74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVIAE74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 00:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVIAE74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 00:59:56 -0400
Received: from lemon.gelato.unsw.edu.au ([203.143.174.44]:55680 "EHLO
	lemon.gelato.unsw.edu.au") by vger.kernel.org with ESMTP
	id S932363AbVIAE7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 00:59:55 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17174.35525.283392.703723@berry.gelato.unsw.EDU.AU>
Date: Thu, 1 Sep 2005 14:59:49 +1000
To: linux-ia64@vger.kernel.org, tony.luck@intel.com, dmosberger@gmail.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <ed5aea43050830150112ee6103@mail.gmail.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0443A5FA@scsmsx401.amr.corp.intel.com>     <ed5aea430508301229386fc596@mail.gmail.com>     <17172.54563.329758.846131@wombat.chubb.wattle.id.au>
X-Mailer: VM 7.19 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
X-SA-Exim-Connect-IP: 203.143.160.117
X-SA-Exim-Mail-From: peterc@gelato.unsw.edu.au
Subject: RE: ip_contrack refuses to load if built UP as a module on IA64
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:39:27 +0000)
X-SA-Exim-Scanned: Yes (on lemon.gelato.unsw.edu.au)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch makes UP and SMP do the same thing as far as module per-cpu
data go.

Unfortunately it affects core code.

To repeat the problem:
  IA64 keeps per-cpu data in a small data area that is referenced by a
  22-bit offset, for both UP and SMP cases.  If a module defines
  per-cpu data, it too will end up in the small-data area.  But the
  module loader at present special-cases the UP treatment of per-cpu
  data, assumes that it is in the GP-relative data area, and does
  nothing (for SMP it allocates space, and copies initialised data
  items into it) 

  The effect is that modules defining per-cpu data fail to load if
  they're built UP, because of an impossible relocation.

  The appended patch makes the treatment of per-cpu data uniform
  between UP and SMP cases.  For most architectures, the per-cpu data
  section will be empty for UP, and so the per-cpu setup code will not
  be invoked.

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
--- a/arch/ia64/kernel/module.c
+++ b/arch/ia64/kernel/module.c
@@ -951,4 +951,10 @@ percpu_modcopy (void *pcpudst, const voi
 		if (cpu_possible(i))
 			memcpy(pcpudst + __per_cpu_offset[i], src, size);
 }
+#else
+void
+percpu_modcopy (void *pcpudst, const void *src, unsigned long size)
+{
+	memcpy(pcpudst, src, size);
+}
 #endif /* CONFIG_SMP */
diff --git a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -209,7 +209,6 @@ static struct module *find_module(const 
 	return NULL;
 }
 
-#ifdef CONFIG_SMP
 /* Number of blocks used and allocated. */
 static unsigned int pcpu_num_used, pcpu_num_allocated;
 /* Size of each block.  -ve means used. */
@@ -352,29 +351,7 @@ static int percpu_modinit(void)
 	return 0;
 }	
 __initcall(percpu_modinit);
-#else /* ... !CONFIG_SMP */
-static inline void *percpu_modalloc(unsigned long size, unsigned long align,
-				    const char *name)
-{
-	return NULL;
-}
-static inline void percpu_modfree(void *pcpuptr)
-{
-	BUG();
-}
-static inline unsigned int find_pcpusec(Elf_Ehdr *hdr,
-					Elf_Shdr *sechdrs,
-					const char *secstrings)
-{
-	return 0;
-}
-static inline void percpu_modcopy(void *pcpudst, const void *src,
-				  unsigned long size)
-{
-	/* pcpusec should be 0, and size of that section should be 0. */
-	BUG_ON(size != 0);
-}
-#endif /* CONFIG_SMP */
+
 
 #ifdef CONFIG_MODULE_UNLOAD
 #define MODINFO_ATTR(field)	\
