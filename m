Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbULTBL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbULTBL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULTBL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:11:58 -0500
Received: from mail13.bluewin.ch ([195.186.18.62]:2944 "EHLO mail13.bluewin.ch")
	by vger.kernel.org with ESMTP id S261376AbULTBKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:10:32 -0500
Date: Mon, 20 Dec 2004 02:09:56 +0100
To: akpm@osdl.org
Cc: hollisb@us.ibm.com, trini@kernel.crashing.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Resurrect Documentation/powerpc/cpu_features.txt
Message-ID: <20041220010956.GB13452@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Documentation/powerpc/cpu_features.txt mysteriously disappeared
sometime when 2.5 forked off.

Searching through BK logs on linux.bkbits.net didn't reveal anything,
unfortunately. The only reference I could pick up from searching the
available lkml archives is the 2.4.20-pre11 ChangeLog where this was
first merged.

Thus far, nothing indicates it was intentionally removed, and AFAICS,
is still up to date with the current code.

Against 2.6.9. Applies cleanly against 2.6.10-rc3. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 00-INDEX         |    3 ++
 cpu_features.txt |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff -uprN a/Documentation/powerpc/00-INDEX b/Documentation/powerpc/00-INDEX
--- a/Documentation/powerpc/00-INDEX	2003-12-18 03:59:16.000000000 +0100
+++ b/Documentation/powerpc/00-INDEX	2004-05-22 13:38:54.000000000 +0200
@@ -5,6 +5,9 @@ please mail me.
 
 00-INDEX
 	- this file
+cpu_features.txt
+	- info on how we support a variety of CPUs with minimal compile-time
+	options.
 ppc_htab.txt
 	- info about the Linux/PPC /proc/ppc_htab entry
 smp.txt
diff -uprN a/Documentation/powerpc/cpu_features.txt b/Documentation/powerpc/cpu_features.txt
--- a/Documentation/powerpc/cpu_features.txt	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/powerpc/cpu_features.txt	2004-05-22 13:38:27.000000000 +0200
@@ -0,0 +1,56 @@
+Hollis Blanchard <hollis@austin.ibm.com>
+5 Jun 2002
+
+This document describes the system (including self-modifying code) used in the
+PPC Linux kernel to support a variety of PowerPC CPUs without requiring
+compile-time selection.
+
+Early in the boot process the ppc32 kernel detects the current CPU type and
+chooses a set of features accordingly. Some examples include Altivec support,
+split instruction and data caches, and if the CPU supports the DOZE and NAP
+sleep modes.
+
+Detection of the feature set is simple. A list of processors can be found in
+arch/ppc/kernel/cputable.c. The PVR register is masked and compared with each
+value in the list. If a match is found, the cpu_features of cur_cpu_spec is
+assigned to the feature bitmask for this processor and a __setup_cpu function
+is called.
+
+C code may test 'cur_cpu_spec[smp_processor_id()]->cpu_features' for a
+particular feature bit. This is done in quite a few places, for example
+in ppc_setup_l2cr().
+
+Implementing cpufeatures in assembly is a little more involved. There are
+several paths that are performance-critical and would suffer if an array
+index, structure dereference, and conditional branch were added. To avoid the
+performance penalty but still allow for runtime (rather than compile-time) CPU
+selection, unused code is replaced by 'nop' instructions. This nop'ing is
+based on CPU 0's capabilities, so a multi-processor system with non-identical
+processors will not work (but such a system would likely have other problems
+anyways).
+
+After detecting the processor type, the kernel patches out sections of code
+that shouldn't be used by writing nop's over it. Using cpufeatures requires
+just 2 macros (found in include/asm-ppc/cputable.h), as seen in head.S
+transfer_to_handler:
+
+	#ifdef CONFIG_ALTIVEC
+	BEGIN_FTR_SECTION
+		mfspr	r22,SPRN_VRSAVE		/* if G4, save vrsave register value */
+		stw	r22,THREAD_VRSAVE(r23)
+	END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	#endif /* CONFIG_ALTIVEC */
+
+If CPU 0 supports Altivec, the code is left untouched. If it doesn't, both
+instructions are replaced with nop's.
+
+The END_FTR_SECTION macro has two simpler variations: END_FTR_SECTION_IFSET
+and END_FTR_SECTION_IFCLR. These simply test if a flag is set (in
+cur_cpu_spec[0]->cpu_features) or is cleared, respectively. These two macros
+should be used in the majority of cases.
+
+The END_FTR_SECTION macros are implemented by storing information about this
+code in the '__ftr_fixup' ELF section. When do_cpu_ftr_fixups
+(arch/ppc/kernel/misc.S) is invoked, it will iterate over the records in
+__ftr_fixup, and if the required feature is not present it will loop writing
+nop's from each BEGIN_FTR_SECTION to END_FTR_SECTION.
