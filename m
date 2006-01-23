Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWAWQMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWAWQMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWAWQMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:12:49 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:43655 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751485AbWAWQM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:12:27 -0500
Date: Mon, 23 Jan 2006 13:47:34 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 00/04] pktgen: Fix Initialization fail leak.
Message-Id: <20060123134734.4674646b.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 2.2.0beta4 (GTK+ 2.8.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Even if pktgen's thread initialization fails for all CPUs, the module
will be successfully loaded.

 This patch changes that behaivor, by returning error on module load time,
and also freeing all the resources allocated. It also prints a warning if a
thread initialization has failed.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 net/core/pktgen.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ccffcbb..83d875b 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3132,11 +3132,24 @@ static int __init pg_init(void)
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
Luiz Fernando N. Capitulino
