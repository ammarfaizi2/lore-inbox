Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUBNSxi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 13:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUBNSxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 13:53:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262827AbUBNSxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 13:53:37 -0500
Date: Sat, 14 Feb 2004 13:53:38 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [SELINUX] Fix error handling bug.
Message-ID: <Xine.LNX.4.44.0402141348490.6206-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes an error handling flaw, where we need to return a 
Netfilter verdict from the function rather than a standard error code.

Please apply.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urpN -X dontdiff linux-2.6.3-rc2-mm1.o/security/selinux/hooks.c linux-2.6.3-rc2-mm1.w3/security/selinux/hooks.c
--- linux-2.6.3-rc2-mm1.o/security/selinux/hooks.c	2004-02-13 20:27:58.000000000 -0500
+++ linux-2.6.3-rc2-mm1.w3/security/selinux/hooks.c	2004-02-14 13:44:52.000000000 -0500
@@ -3179,8 +3179,9 @@ static unsigned int selinux_ip_postroute
 		
 	/* Fixme: this lookup is inefficient */
 	iph = skb->nh.iph;
-	err = security_node_sid(PF_INET, &iph->daddr, sizeof(iph->daddr), &node_sid);
-	if (err)
+	err = security_node_sid(PF_INET, &iph->daddr, sizeof(iph->daddr),
+				&node_sid) ? NF_DROP : NF_ACCEPT;
+	if (err != NF_ACCEPT)
 		goto out;
 	
 	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE,

