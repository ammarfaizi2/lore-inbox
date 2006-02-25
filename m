Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWBYTHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWBYTHo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWBYTHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:07:43 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:5519 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1161069AbWBYTHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:07:39 -0500
Date: Sat, 25 Feb 2006 16:08:12 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 4/6] pktgen: Fix Initialization fail leak.
Message-ID: <20060225160812.0ae0ee94@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Even if pktgen's thread initialization fails for all CPUs, the module
will be successfully loaded.

 This patch changes that behaivor, by returning an error on module load time,
and also freeing all the resources allocated. It also prints a warning if a
thread initialization has failed.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

---

 net/core/pktgen.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

7084c4ee538fcac59f0d9f64c840c45f8caeab8f
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 1c565fe..89480e3 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3216,11 +3216,24 @@ static int __init pg_init(void)
 	register_netdevice_notifier(&pktgen_notifier_block);
 
 	for_each_online_cpu(cpu) {
+		int err;
 		char buf[30];
 
 		sprintf(buf, "kpktgend_%i", cpu);
-		pktgen_create_thread(buf, cpu);
+		err = pktgen_create_thread(buf, cpu);
+		if (err)
+			printk("pktgen: WARNING: Cannot create thread for cpu %d (%d)\n",
+					cpu, err);
 	}
+
+	if (list_empty(&pktgen_threads)) {
+		printk("pktgen: ERROR: Initialization failed for all threads\n");
+		unregister_netdevice_notifier(&pktgen_notifier_block);
+		remove_proc_entry(PGCTRL, pg_proc_dir);
+		proc_net_remove(PG_PROC_DIR);
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
-- 
1.2.1.g3397f9



-- 
Luiz Fernando N. Capitulino
