Return-Path: <linux-kernel-owner+w=401wt.eu-S1750999AbXALMwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbXALMwq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 07:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXALMwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 07:52:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37703 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbXALMwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 07:52:45 -0500
Date: Fri, 12 Jan 2007 13:48:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] audit: fix audit_filter_user_rules() initialization bug
Message-ID: <20070112124841.GA6970@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] audit: fix audit_filter_user_rules() initialization bug

gcc emits this warning:

 kernel/auditfilter.c: In function 'audit_filter_user':
 kernel/auditfilter.c:1611: warning: 'state' is used uninitialized in this function

i tend to agree with gcc - there are a couple of plausible exit paths 
from audit_filter_user_rules() where it does not set 'state', keeping 
the variable uninitialized. For example if a filter rule has an 
AUDIT_POSSIBLE action. Initialize to 'wont audit'. Fix whitespace damage 
too.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/kernel/auditfilter.c
===================================================================
--- linux.orig/kernel/auditfilter.c
+++ linux/kernel/auditfilter.c
@@ -1601,8 +1601,8 @@ static int audit_filter_user_rules(struc
 
 int audit_filter_user(struct netlink_skb_parms *cb, int type)
 {
+	enum audit_state state = AUDIT_DISABLED;
 	struct audit_entry *e;
-	enum audit_state   state;
 	int ret = 1;
 
 	rcu_read_lock();
