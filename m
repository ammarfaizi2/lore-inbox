Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUIWUYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUIWUYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUIWUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:22:24 -0400
Received: from baikonur.stro.at ([213.239.196.228]:41152 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S265805AbUIWUTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:19:44 -0400
Subject: [patch 2/5]  pcmcia/cs: replace schedule_timeout() 	with msleep()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:19:44 +0200
Message-ID: <E1CAa48-00077m-Po@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. 



Description: Remove unnecessary cs_to_timeout() macro. Use msleep()
instead of schedule_timeout() to guarantee the task delays for the
desired time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/pcmcia/cs.c |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff -puN drivers/pcmcia/cs.c~msleep-drivers_pcmcia_cs drivers/pcmcia/cs.c
--- linux-2.6.9-rc2-bk7/drivers/pcmcia/cs.c~msleep-drivers_pcmcia_cs	2004-09-21 20:51:15.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/pcmcia/cs.c	2004-09-21 20:51:15.000000000 +0200
@@ -427,8 +427,6 @@ static int send_event(struct pcmcia_sock
     return ret;
 } /* send_event */
 
-#define cs_to_timeout(cs) (((cs) * HZ + 99) / 100)
-
 static void socket_remove_drivers(struct pcmcia_socket *skt)
 {
 	client_t *client;
@@ -448,8 +446,7 @@ static void socket_shutdown(struct pcmci
 
 	socket_remove_drivers(skt);
 	skt->state &= SOCKET_INUSE|SOCKET_PRESENT;
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(cs_to_timeout(shutdown_delay));
+	msleep(shutdown_delay * 10);
 	skt->state &= SOCKET_INUSE;
 	shutdown_socket(skt);
 }
@@ -467,8 +464,7 @@ static int socket_reset(struct pcmcia_so
 	skt->socket.flags &= ~SS_RESET;
 	skt->ops->set_socket(skt, &skt->socket);
 
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(cs_to_timeout(unreset_delay));
+	msleep(unreset_delay * 10);
 	for (i = 0; i < unreset_limit; i++) {
 		skt->ops->get_status(skt, &status);
 
@@ -478,8 +474,7 @@ static int socket_reset(struct pcmcia_so
 		if (status & SS_READY)
 			return CS_SUCCESS;
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(cs_to_timeout(unreset_check));
+		msleep(unreset_check * 10);
 	}
 
 	cs_err(skt, "time out after reset.\n");
@@ -496,8 +491,7 @@ static int socket_setup(struct pcmcia_so
 	if (!(status & SS_DETECT))
 		return CS_NO_CARD;
 
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(cs_to_timeout(initial_delay));
+	msleep(initial_delay * 10);
 
 	for (i = 0; i < 100; i++) {
 		skt->ops->get_status(skt, &status);
@@ -507,8 +501,7 @@ static int socket_setup(struct pcmcia_so
 		if (!(status & SS_PENDING))
 			break;
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(cs_to_timeout(10));
+		msleep(100);
 	}
 
 	if (status & SS_PENDING) {
@@ -541,8 +534,7 @@ static int socket_setup(struct pcmcia_so
 	/*
 	 * Wait "vcc_settle" for the supply to stabilise.
 	 */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(cs_to_timeout(vcc_settle));
+	msleep(vcc_settle * 10);
 
 	skt->ops->get_status(skt, &status);
 	if (!(status & SS_POWERON)) {
@@ -659,10 +651,8 @@ static void socket_detect_change(struct 
 	if (!(skt->state & SOCKET_SUSPEND)) {
 		int status;
 
-		if (!(skt->state & SOCKET_PRESENT)) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(cs_to_timeout(2));
-		}
+		if (!(skt->state & SOCKET_PRESENT))
+			msleep(20);
 
 		skt->ops->get_status(skt, &status);
 		if ((skt->state & SOCKET_PRESENT) &&
_
