Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTDJRet (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTDJRes (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:34:48 -0400
Received: from ns.avalon.ru ([195.209.229.227]:44980 "EHLO smtp.avalon.ru")
	by vger.kernel.org with ESMTP id S264115AbTDJRes convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 13:34:48 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: [PATCH] [2.4.20] filter_list destroy fix in net/sched/sch_prio.c
Date: Thu, 10 Apr 2003 21:46:12 +0400
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B381773AD@frodo.avalon.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [2.4.20] filter_list destroy fix in net/sched/sch_prio.c
Thread-Index: AcL2BZM+86EVewkGQc+3orAwc2LBoQ==
From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
To: <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Cc: <kuznet@ms2.inr.ac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The prio qdisc does not destroy its filter list, when someone deletes
qdisc from interface without explicit filter deleting.
This patch fixes that behavior. 

--- linux-2.4.20/net/sched/sch_prio.c	Sat Aug  3 04:39:46 2002
+++ linux/net/sched/sch_prio.c	Thu Apr 10 17:52:55 2003
@@ -158,11 +158,19 @@
 {
 	int prio;
 	struct prio_sched_data *q = (struct prio_sched_data *)sch->data;
+	struct tcf_proto *tp;
 
 	for (prio=0; prio<q->bands; prio++) {
 		qdisc_destroy(q->queues[prio]);
 		q->queues[prio] = &noop_qdisc;
 	}
+
+	while((tp = q->filter_list) != NULL)
+	{
+		q->filter_list = tp->next;
+		tp->ops->destroy(tp);
+	}
+
 	MOD_DEC_USE_COUNT;
 }

