Return-Path: <linux-kernel-owner+w=401wt.eu-S1947537AbWLIAAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947537AbWLIAAv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 19:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947522AbWLIAAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:00:50 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37585 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761298AbWLIAAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:00:25 -0500
Message-Id: <20061208235928.195900000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:57:58 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Patrick McHardy <kaber@trash.net>,
       Jamal Hadi Salim <hadi@cyberus.ca>
Subject: [patch 07/32] NET_SCHED: policer: restore compatibility with old iproute binaries
Content-Disposition: inline; filename=net_sched-policer-restore-compatibility-with-old-iproute-binaries.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

The tc actions increased the size of struct tc_police, which broke
compatibility with old iproute binaries since both the act_police
and the old NET_CLS_POLICE code check for an exact size match.

Since the new members are not even used, the simple fix is to also
accept the size of the old structure. Dumping is not affected since
old userspace will receive a bigger structure, which is handled fine.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Acked-by: Jamal Hadi Salim <hadi@cyberus.ca>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/sched/act_police.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--- linux-2.6.19.orig/net/sched/act_police.c
+++ linux-2.6.19/net/sched/act_police.c
@@ -46,6 +46,18 @@ static struct tcf_hashinfo police_hash_i
 	.lock	=	&police_lock,
 };
 
+/* old policer structure from before tc actions */
+struct tc_police_compat
+{
+	u32			index;
+	int			action;
+	u32			limit;
+	u32			burst;
+	u32			mtu;
+	struct tc_ratespec	rate;
+	struct tc_ratespec	peakrate;
+};
+
 /* Each policer is serialized by its individual spinlock */
 
 #ifdef CONFIG_NET_CLS_ACT
@@ -131,12 +143,15 @@ static int tcf_act_police_locate(struct 
 	struct tc_police *parm;
 	struct tcf_police *police;
 	struct qdisc_rate_table *R_tab = NULL, *P_tab = NULL;
+	int size;
 
 	if (rta == NULL || rtattr_parse_nested(tb, TCA_POLICE_MAX, rta) < 0)
 		return -EINVAL;
 
-	if (tb[TCA_POLICE_TBF-1] == NULL ||
-	    RTA_PAYLOAD(tb[TCA_POLICE_TBF-1]) != sizeof(*parm))
+	if (tb[TCA_POLICE_TBF-1] == NULL)
+		return -EINVAL;
+	size = RTA_PAYLOAD(tb[TCA_POLICE_TBF-1]);
+	if (size != sizeof(*parm) && size != sizeof(struct tc_police_compat))
 		return -EINVAL;
 	parm = RTA_DATA(tb[TCA_POLICE_TBF-1]);
 
@@ -415,12 +430,15 @@ struct tcf_police *tcf_police_locate(str
 	struct tcf_police *police;
 	struct rtattr *tb[TCA_POLICE_MAX];
 	struct tc_police *parm;
+	int size;
 
 	if (rtattr_parse_nested(tb, TCA_POLICE_MAX, rta) < 0)
 		return NULL;
 
-	if (tb[TCA_POLICE_TBF-1] == NULL ||
-	    RTA_PAYLOAD(tb[TCA_POLICE_TBF-1]) != sizeof(*parm))
+	if (tb[TCA_POLICE_TBF-1] == NULL)
+		return NULL;
+	size = RTA_PAYLOAD(tb[TCA_POLICE_TBF-1]);
+	if (size != sizeof(*parm) && size != sizeof(struct tc_police_compat))
 		return NULL;
 
 	parm = RTA_DATA(tb[TCA_POLICE_TBF-1]);

--
