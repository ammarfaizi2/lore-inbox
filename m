Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWIKHoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWIKHoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWIKHoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:44:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41394 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751175AbWIKHoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:44:21 -0400
From: Balbir Singh <balbir@in.ibm.com>
To: akpm@osdl.org
Cc: Jamal Hadi <hadi@cyberus.ca>, Shailabh Nagar <nagar@watson.ibm.com>,
       Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
       Balbir Singh <balbir@in.ibm.com>, linux-kernel@vger.kernel.org
Date: Mon, 11 Sep 2006 13:10:43 +0530
Message-Id: <20060911074043.26844.94895.sendpatchset@localhost.localdomain>
In-Reply-To: <20060911074021.26844.70576.sendpatchset@localhost.localdomain>
References: <20060911074021.26844.70576.sendpatchset@localhost.localdomain>
Subject: [RFC][PATCH -mm] Fix getdelays.c - cpumask length and error reporting.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix the length passed while (un)registering cpumask. We were passing
sizeof the array, make it strlen().

Error value printed in fatal errors should be derived from the message.
The message contains an nlmsgerr embedded with an error value. We must
report that value to the user.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 Documentation/accounting/getdelays.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN Documentation/accounting/getdelays.c~taskstats-fix-delayacct-utility Documentation/accounting/getdelays.c
--- linux-2.6.18-rc6/Documentation/accounting/getdelays.c~taskstats-fix-delayacct-utility	2006-09-11 12:43:50.000000000 +0530
+++ linux-2.6.18-rc6-balbir/Documentation/accounting/getdelays.c	2006-09-11 12:46:57.000000000 +0530
@@ -285,7 +285,7 @@ int main(int argc, char *argv[])
 	if (maskset) {
 		rc = send_cmd(nl_sd, id, mypid, TASKSTATS_CMD_GET,
 			      TASKSTATS_CMD_ATTR_REGISTER_CPUMASK,
-			      &cpumask, sizeof(cpumask));
+			      &cpumask, strlen(cpumask) + 1);
 		PRINTF("Sent register cpumask, retval %d\n", rc);
 		if (rc < 0) {
 			printf("error sending register cpumask\n");
@@ -315,7 +315,8 @@ int main(int argc, char *argv[])
 		}
 		if (msg.n.nlmsg_type == NLMSG_ERROR ||
 		    !NLMSG_OK((&msg.n), rep_len)) {
-			printf("fatal reply error,  errno %d\n", errno);
+			struct nlmsgerr *err = NLMSG_DATA(&msg);
+			printf("fatal reply error,  errno %d\n", err->error);
 			goto done;
 		}
 
@@ -383,7 +384,7 @@ done:
 	if (maskset) {
 		rc = send_cmd(nl_sd, id, mypid, TASKSTATS_CMD_GET,
 			      TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK,
-			      &cpumask, sizeof(cpumask));
+			      &cpumask, strlen(cpumask) + 1);
 		printf("Sent deregister mask, retval %d\n", rc);
 		if (rc < 0)
 			err(rc, "error sending deregister cpumask\n");
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
