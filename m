Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264328AbUEDM2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbUEDM2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 08:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUEDM2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 08:28:55 -0400
Received: from ozlabs.org ([203.10.76.45]:14487 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264328AbUEDM2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 08:28:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16535.34664.662254.665975@cargo.ozlabs.ibm.com>
Date: Tue, 4 May 2004 22:07:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org, bcollins@debian.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sf.net
Subject: [PATCH] fix ohci1394 rmmod
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the current ieee1394 code, if I try to rmmod the ohci1394 module,
it hangs forever.  The reason is that it is waiting for the knodemgr_n
kernel thread to exit.  The thread exits when it gets a signal, and
the mainline code has tried to send it a signal.  However, the thread
has called daemonize(), which sets the signal mask to all 1s, so no
signals ever get through.

The patch below fixes this by unblocking SIGTERM after the daemonize
call.  I looked around and found the same problem with the khpsbpkt
thread, so I applied the same fix there.  With this patch I can once
again successfully rmmod the ohci1394 module.

Ben, any comments on this patch?  I think it should go in.

Regards,
Paul.

diff -urN linux-2.5/drivers/ieee1394/ieee1394_core.c g5-ppc64/drivers/ieee1394/ieee1394_core.c
--- linux-2.5/drivers/ieee1394/ieee1394_core.c	2004-04-19 08:07:02.000000000 +1000
+++ g5-ppc64/drivers/ieee1394/ieee1394_core.c	2004-05-03 22:53:03.000000000 +1000
@@ -1017,9 +1017,15 @@
 	struct hpsb_packet *packet;
 	void (*complete_routine)(void*);
 	void *complete_data;
+	sigset_t sset;
 
 	daemonize("khpsbpkt");
 
+	/* Make us susceptible to SIGTERM */
+	sigemptyset(&sset);
+	sigaddset(&sset, SIGTERM);
+	sigprocmask(SIG_UNBLOCK, &sset, NULL);
+
 	while (!down_interruptible(&khpsbpkt_sig)) {
 		while ((skb = skb_dequeue(&hpsbpkt_queue)) != NULL) {
 			packet = (struct hpsb_packet *)skb->data;
diff -urN linux-2.5/drivers/ieee1394/nodemgr.c g5-ppc64/drivers/ieee1394/nodemgr.c
--- linux-2.5/drivers/ieee1394/nodemgr.c	2004-04-19 08:07:02.000000000 +1000
+++ g5-ppc64/drivers/ieee1394/nodemgr.c	2004-05-03 22:51:32.000000000 +1000
@@ -1464,10 +1464,16 @@
 	struct host_info *hi = (struct host_info *)__hi;
 	struct hpsb_host *host = hi->host;
 	int reset_cycles = 0;
+	sigset_t sset;
 
 	/* No userlevel access needed */
 	daemonize(hi->daemon_name);
 
+	/* Make us susceptible to SIGTERM */
+	sigemptyset(&sset);
+	sigaddset(&sset, SIGTERM);
+	sigprocmask(SIG_UNBLOCK, &sset, NULL);
+
 	/* Setup our device-model entries */
 	nodemgr_create_host_dev_files(host);
 
