Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWHaKWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWHaKWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWHaKWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:22:16 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:7754 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751009AbWHaKWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:22:15 -0400
Message-ID: <44F6B846.9090405@openvz.org>
Date: Thu, 31 Aug 2006 14:21:58 +0400
From: Pavel <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Serge Hallyn <serue@us.ibm.com>, ebiederm@xmission.com, clg@fr.ibm.com
CC: Kirill Korotaev <dev@openvz.org>
Subject: [PATCH] nsproxy cloning error path fix
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes copy_namespaces()'s error path.

when new nsproxy (new_ns) is created pointers to namespaces (ipc, uts)
are copied from the old nsproxy. Later in copy_utsname, copy_ipcs, etc.
according namespaces are get-ed. On error path needed namespaces are
put-ed, so there's no need to put new nsproxy itelf as it woud cause
putting namespaces for the second time.

Found when incorporating namespaces into OpenVZ kernel.

Signed-off-by: Pavel Emelianov <xemul@openvz.org>
---

 nsproxy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- ./kernel/nsproxy.c.veboot	2006-08-30 17:48:59.000000000 +0400
+++ ./kernel/nsproxy.c	2006-08-31 10:54:56.000000000 +0400
@@ -115,7 +115,7 @@ out_uts:
 		put_namespace(new_ns->namespace);
 out_ns:
 	tsk->nsproxy = old_ns;
-	put_nsproxy(new_ns);
+	kfree(new_ns);
 	goto out;
 }
 


