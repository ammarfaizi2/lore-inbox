Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVFIM4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVFIM4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVFIM4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:56:01 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63181 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262379AbVFIMxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:53:42 -0400
Message-ID: <42A83C63.5080604@jp.fujitsu.com>
Date: Thu, 09 Jun 2005 21:56:03 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH 06/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 6 of 10 patches, "iochk-06-mcanotify.patch"]

- This is a headache:
   When ia64 get a problem on hardware, OS could request
   SAL(System Abstraction Layer: ia64 firmware) to gather
   system status via calling SAL_GET_STATE_INFO procedure.

   However (depend on implementation of SAL for its platform,
   hopefully), on the way of gathering, SAL also checks
   every host bridges and its status, and after that, resets
   the state...

   So we should take care of this reset by SAL.

   Handling MCA(Machine Check Abort) is one of a situation
   should we take care. Originally MCA is designed as a
   critical interruption, so when MCA comes, without OS's
   order, SAL gathers system status before OS gets its control.
   So since states of bridges are already reset on entrance of
   MCA, OS should notify "lost of state" to all "check-in"
   contexts, by marking its error flag, iocookie->error.

   There would be better way if OS can know the bridge state
   from data which SAL gathered, but in the meanwhile, I
   just do simple way.

PCI-parity error is one of MCA causes, is it OK?
Next, "data poisoning" helps us... see next (7 of 10).

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/kernel/mca.c      |   13 +++++++++++++
  arch/ia64/lib/iomap_check.c |    7 ++++++-
  2 files changed, 19 insertions(+), 1 deletion(-)

Index: linux-2.6.11.11/arch/ia64/kernel/mca.c
===================================================================
--- linux-2.6.11.11.orig/arch/ia64/kernel/mca.c
+++ linux-2.6.11.11/arch/ia64/kernel/mca.c
@@ -77,6 +77,11 @@
  #include <asm/irq.h>
  #include <asm/hw_irq.h>

+#ifdef CONFIG_IOMAP_CHECK
+#include <linux/pci.h>
+extern void notify_bridge_error(struct pci_dev *bridge);
+#endif
+
  #if defined(IA64_MCA_DEBUG_INFO)
  # define IA64_MCA_DEBUG(fmt...)	printk(fmt)
  #else
@@ -893,6 +898,14 @@ ia64_mca_ucmc_handler(void)
  		sal_log_record_header_t *rh = IA64_LOG_CURR_BUFFER(SAL_INFO_TYPE_MCA);
  		rh->severity = sal_log_severity_corrected;
  		ia64_sal_clear_state_info(SAL_INFO_TYPE_MCA);
+
+#ifdef CONFIG_IOMAP_CHECK
+		/*
+		 * SAL already reads and clears error bits on bridge registers,
+		 * so we should have all running transactions to retry.
+		 */
+		notify_bridge_error(0);
+#endif
  	}
  	/*
  	 *  Wakeup all the processors which are spinning in the rendezvous
Index: linux-2.6.11.11/arch/ia64/lib/iomap_check.c
===================================================================
--- linux-2.6.11.11.orig/arch/ia64/lib/iomap_check.c
+++ linux-2.6.11.11/arch/ia64/lib/iomap_check.c
@@ -109,7 +109,12 @@ void notify_bridge_error(struct pci_dev
  		return;

  	/* notify error to all transactions using this host bridge */
-	if (bridge) {
+	if (!bridge) {
+		/* global notify, ex. MCA */
+		list_for_each_entry(cookie, &iochk_devices, list) {
+			cookie->error = 1;
+		}
+	} else {
  		/* local notify, ex. Parity, Abort etc. */
  		list_for_each_entry(cookie, &iochk_devices, list) {
  			if (cookie->host == bridge)

