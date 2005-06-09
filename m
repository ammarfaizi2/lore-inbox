Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVFINFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVFINFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVFINDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:03:50 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54144 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262385AbVFIM7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:59:04 -0400
Message-ID: <42A83DD6.9030607@jp.fujitsu.com>
Date: Thu, 09 Jun 2005 22:02:14 +0900
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
Subject: [PATCH 09/10] IOCHK interface for I/O error handling/detecting
References: <42A8386F.2060100@jp.fujitsu.com>
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is 9 of 10 patches, "iochk-09-cpeh.patch"]

- SAL behavior doesn't affect only MCA. There are other
   chances to call SAL_GET_STATE_INFO, that's when CMC, CPE,
   and INIT is happen.

    - CMC(Corrected Machine Check) is for non-fatal, processor
      local errors. Fortunately, calling SAL_GET_STATE_INFO for
      CMC only collect data from a processor issued it, without
      touching any bridge and its status. So, this is safe.

    - CPE(Corrected Platform Error) is for non-fatal, platform
      related errors. Even it says corrected, but calling
      SAL procedure for CPE touchs every bridge on the platform,
      and "correct" bridge status that's bad for iochk works.

    - INIT is a kind of system reset request, as far as I know.
      So restarting from INIT is out of design, also iochk after
      INIT is not required at this time.

   In short, only MCA and CPE have the problem of SAL behavior.
   One of the difference from MCA is that SAL will not gather
   data before OS actually request it.

   MCA:
       1) SAL gathers data and keep it internally
       2) OS gets control
       3) if OS requests, SAL returns data gathered at beginning.
   CPE:
       1) OS gets control
       2) OS request to SAL
       3) SAL gathers data and return it to OS

   Therefore, we can make CPE handler to care bridge states,
   to check states before calling SAL procedure.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---

  arch/ia64/kernel/mca.c      |   21 +++++++++++++++++++++
  arch/ia64/lib/iomap_check.c |   17 +++++++++++++++++
  2 files changed, 38 insertions(+)

Index: linux-2.6.11.11/arch/ia64/lib/iomap_check.c
===================================================================
--- linux-2.6.11.11.orig/arch/ia64/lib/iomap_check.c
+++ linux-2.6.11.11/arch/ia64/lib/iomap_check.c
@@ -19,6 +19,7 @@ static int have_error(struct pci_dev *de

  void notify_bridge_error(struct pci_dev *bridge);
  void clear_bridge_error(struct pci_dev *bridge);
+void save_bridge_error(void);

  void iochk_init(void)
  {
@@ -143,6 +144,22 @@ void clear_bridge_error(struct pci_dev *
  	}
  }

+void save_bridge_error(void)
+{
+	iocookie *cookie;
+
+	if (list_empty(&iochk_devices))
+		return;
+
+	/* mark devices if its root bus bridge have errors */
+	list_for_each_entry(cookie, &iochk_devices, list) {
+		if (cookie->error)
+			continue;
+		if (have_error(cookie->host))
+			notify_bridge_error(cookie->host);
+	}
+}
+
  EXPORT_SYMBOL(iochk_read);
  EXPORT_SYMBOL(iochk_clear);
  EXPORT_SYMBOL(iochk_devices);	/* for MCA driver */
Index: linux-2.6.11.11/arch/ia64/kernel/mca.c
===================================================================
--- linux-2.6.11.11.orig/arch/ia64/kernel/mca.c
+++ linux-2.6.11.11/arch/ia64/kernel/mca.c
@@ -80,6 +80,8 @@
  #ifdef CONFIG_IOMAP_CHECK
  #include <linux/pci.h>
  extern void notify_bridge_error(struct pci_dev *bridge);
+extern void save_bridge_error(void);
+extern spinlock_t iochk_lock;
  #endif

  #if defined(IA64_MCA_DEBUG_INFO)
@@ -288,11 +290,30 @@ ia64_mca_cpe_int_handler (int cpe_irq, v
  	IA64_MCA_DEBUG("%s: received interrupt vector = %#x on CPU %d\n",
  		       __FUNCTION__, cpe_irq, smp_processor_id());

+#ifndef CONFIG_IOMAP_CHECK
+
  	/* SAL spec states this should run w/ interrupts enabled */
  	local_irq_enable();

  	/* Get the CPE error record and log it */
  	ia64_mca_log_sal_error_record(SAL_INFO_TYPE_CPE);
+#else
+	/*
+	 * Because SAL_GET_STATE_INFO for CPE might clear bridge states
+	 * in process of gathering error information from the system,
+	 * we should check the states before clearing it.
+	 * While OS and SAL are handling bridge status, we have to protect
+	 * the states from changing by any other I/Os running simultaneously,
+	 * so this should be handled w/ lock and interrupts disabled.
+	 */
+	spin_lock(&iochk_lock);
+	save_bridge_error();
+	ia64_mca_log_sal_error_record(SAL_INFO_TYPE_CPE);
+	spin_unlock(&iochk_lock);
+
+	/* Rests can go w/ interrupt enabled as usual */
+	local_irq_enable();
+#endif

  	spin_lock(&cpe_history_lock);
  	if (!cpe_poll_enabled && cpe_vector >= 0) {

