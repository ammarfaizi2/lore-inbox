Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUGZXqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUGZXqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUGZXqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:46:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55003 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266188AbUGZXpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:45:52 -0400
Message-ID: <410594FF.5040307@austin.ibm.com>
Date: Mon, 26 Jul 2004 18:34:23 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux ppc64; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, anton@samba.org, paulus@samba.org
CC: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpu hotplug ppc64 bug
Content-Type: multipart/mixed;
 boundary="------------080103010209070100080707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080103010209070100080707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On Power4 and earlier hardware there is no need to clear the CPPR (see 
RPAp 479 section 18.5.4.7.2 for what little info there is on the CPPR) 
when stopping a cpu. On hardware that uses Power5 an undocumented change 
has been made that requires the CPPR to be cleared if an isolate is to 
be done on the stopped cpu. So the following patch lets cpu hotplug work 
on the recent hardware.

I sent this patch to the ppc64-dev list back in mid April and Suse 
picked it up then for SLES9 so it has been well tested for several months.

--------------080103010209070100080707
Content-Type: text/plain;
 name="jul26.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jul26.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1883  -> 1.1884 
#	include/asm-ppc64/xics.h	1.5     -> 1.6    
#	arch/ppc64/kernel/xics.c	1.45    -> 1.46   
#	arch/ppc64/kernel/smp.c	1.72    -> 1.73   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/07/26	jschopp@zippy.ltc.austin.ibm.com	1.1884
# Power5 has a requirement to clear the CPPR before doing a stop_self or isolates will fail later on.  Clearing the CPPR is OK on Power4 so just 
# added it to the path.
# --------------------------------------------
#
diff -Nru a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	Mon Jul 26 18:26:45 2004
+++ b/arch/ppc64/kernel/smp.c	Mon Jul 26 18:26:45 2004
@@ -300,6 +300,10 @@
 void cpu_die(void)
 {
 	local_irq_disable();
+	/* Some hardware requires clearing the CPPR, while other hardware does not
+	 * it is safe either way
+	 */
+	pSeriesLP_cppr_info(0, 0);
 	rtas_stop_self();
 	/* Should never get here... */
 	BUG();
diff -Nru a/arch/ppc64/kernel/xics.c b/arch/ppc64/kernel/xics.c
--- a/arch/ppc64/kernel/xics.c	Mon Jul 26 18:26:45 2004
+++ b/arch/ppc64/kernel/xics.c	Mon Jul 26 18:26:45 2004
@@ -190,7 +190,7 @@
 		      val64); 
 }
 
-static void pSeriesLP_cppr_info(int n_cpu, u8 value)
+void pSeriesLP_cppr_info(int n_cpu, u8 value)
 {
 	unsigned long lpar_rc;
 
diff -Nru a/include/asm-ppc64/xics.h b/include/asm-ppc64/xics.h
--- a/include/asm-ppc64/xics.h	Mon Jul 26 18:26:45 2004
+++ b/include/asm-ppc64/xics.h	Mon Jul 26 18:26:45 2004
@@ -19,6 +19,9 @@
 void xics_setup_cpu(void);
 void xics_cause_IPI(int cpu);
 
+/* first argument is ignored for now*/
+void pSeriesLP_cppr_info(int n_cpu, u8 value);
+
 struct xics_ipi_struct {
 	volatile unsigned long value;
 } ____cacheline_aligned;

--------------080103010209070100080707--

