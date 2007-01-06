Return-Path: <linux-kernel-owner+w=401wt.eu-S1751150AbXAFCgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbXAFCgq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbXAFCdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:10 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36899 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbXAFCdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:33:06 -0500
Message-Id: <20070106023500.400989000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:26 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Robert Olsson <Robert.Olsson@data.slu.se>
Subject: [patch 33/50] PKTGEN: Fix module load/unload races.
Content-Disposition: inline; filename=pktgen-fix-module-load-unload-races.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Robert Olsson <Robert.Olsson@data.slu.se>

---
 net/core/pktgen.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- linux-2.6.19.1.orig/net/core/pktgen.c
+++ linux-2.6.19.1/net/core/pktgen.c
@@ -147,6 +147,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/wait.h>
+#include <linux/completion.h>
 #include <linux/etherdevice.h>
 #include <net/checksum.h>
 #include <net/ipv6.h>
@@ -206,6 +207,11 @@ static struct proc_dir_entry *pg_proc_di
 #define VLAN_TAG_SIZE(x) ((x)->vlan_id == 0xffff ? 0 : 4)
 #define SVLAN_TAG_SIZE(x) ((x)->svlan_id == 0xffff ? 0 : 4)
 
+struct pktgen_thread_info {
+       struct pktgen_thread *t;
+       struct completion *c;
+};
+
 struct flow_state {
 	__u32 cur_daddr;
 	int count;
@@ -3264,10 +3270,11 @@ out:;
  * Main loop of the thread goes here
  */
 
-static void pktgen_thread_worker(struct pktgen_thread *t)
+static void pktgen_thread_worker(struct pktgen_thread_info *info)
 {
 	DEFINE_WAIT(wait);
 	struct pktgen_dev *pkt_dev = NULL;
+	struct pktgen_thread *t = info->t;
 	int cpu = t->cpu;
 	sigset_t tmpsig;
 	u32 max_before_softirq;
@@ -3307,6 +3314,8 @@ static void pktgen_thread_worker(struct 
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
 
+        complete(info->c);
+
 	while (1) {
 
 		__set_current_state(TASK_RUNNING);
@@ -3518,6 +3527,8 @@ static struct pktgen_thread *__init pktg
 static int __init pktgen_create_thread(const char *name, int cpu)
 {
 	int err;
+	struct pktgen_thread_info info;
+        struct completion started;
 	struct pktgen_thread *t = NULL;
 	struct proc_dir_entry *pe;
 
@@ -3558,7 +3569,11 @@ static int __init pktgen_create_thread(c
 
 	t->removed = 0;
 
-	err = kernel_thread((void *)pktgen_thread_worker, (void *)t,
+	init_completion(&started);
+        info.t = t;
+        info.c = &started;
+
+	err = kernel_thread((void *)pktgen_thread_worker, (void *)&info,
 			  CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 	if (err < 0) {
 		printk("pktgen: kernel_thread() failed for cpu %d\n", t->cpu);
@@ -3568,6 +3583,7 @@ static int __init pktgen_create_thread(c
 		return err;
 	}
 
+	wait_for_completion(&started);
 	return 0;
 }
 

--
