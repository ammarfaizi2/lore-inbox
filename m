Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWCGDkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWCGDkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWCGDkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:40:10 -0500
Received: from palrel12.hp.com ([156.153.255.237]:21161 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932645AbWCGDkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:40:08 -0500
Date: Mon, 6 Mar 2006 22:40:05 -0500
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: linux-audit@redhat.com
Subject: [PATCH] fix audit_init failure path
Message-ID: <20060307034005.GA8285@zk3.dec.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-audit@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make audit_init() failure path handle situations where the audit_panic()
action is not AUDIT_FAIL_PANIC (default is AUDIT_FAIL_PRINTK).  Other uses
of audit_sock are not reached unless audit's netlink message handler is
properly registered.  Bug noticed by Peter Staubach.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

diff --git a/kernel/audit.c b/kernel/audit.c
index 0a813d2..75861e3 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -519,8 +519,9 @@ static int __init audit_init(void)
 					   THIS_MODULE);
 	if (!audit_sock)
 		audit_panic("cannot initialize netlink socket");
+	else
+		audit_sock->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
 
-	audit_sock->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
 	skb_queue_head_init(&audit_skb_queue);
 	audit_initialized = 1;
 	audit_enabled = audit_default;
