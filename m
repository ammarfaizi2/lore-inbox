Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTDKI7x (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 04:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTDKI7x (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 04:59:53 -0400
Received: from ns.avalon.ru ([195.209.229.227]:17731 "EHLO smtp.avalon.ru")
	by vger.kernel.org with ESMTP id S261572AbTDKI7w convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 04:59:52 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: [PATCH] [2.4.20] filter_list destroy fix in net/sched/sch_csz.c
Date: Fri, 11 Apr 2003 13:11:17 +0400
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B381773AE@frodo.avalon.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [2.4.20] filter_list destroy fix in net/sched/sch_csz.c
Thread-Index: AcL2BZM+86EVewkGQc+3orAwc2LBoQ==
From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
To: <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Cc: <kuznet@ms2.inr.ac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same as prio qdisc, the csz qdisc does not destroy its filter list, when
someone deletes qdisc from interface without explicit filter deleting.
So here is the patch. :)

--- linux-2.4.20/net/sched/sch_csz.c	Fri Dec 21 20:42:06 2001
+++ linux/net/sched/sch_csz.c	Fri Apr 11 12:33:08 2003
@@ -749,6 +749,15 @@
 static void
 csz_destroy(struct Qdisc* sch)
 {
+	struct csz_sched_data *q = (struct csz_sched_data *)sch->data;
+	struct tcf_proto *tp;
+
+	while((tp = q->filter_list) != NULL)
+	{
+		q->filter_list = tp->next;
+		tp->ops->destroy(tp);
+	}
+
 	MOD_DEC_USE_COUNT;
 }

