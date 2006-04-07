Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWDGSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWDGSsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWDGSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:48:37 -0400
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:912
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S964870AbWDGSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:48:36 -0400
From: =?utf-8?q?T=C3=B6r=C3=B6k_Edwin?= <edwin@gurde.com>
To: linux-security-module@vger.kernel.org
Subject: [RFC][PATCH 4/7] exports
Date: Fri, 7 Apr 2006 21:41:05 +0300
User-Agent: KMail/1.9.1
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net, sds@tycho.nsa.gov
References: <200604021240.21290.edwin@gurde.com> <200604072034.20972.edwin@gurde.com> <200604072124.24000.edwin@gurde.com>
In-Reply-To: <200604072124.24000.edwin@gurde.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072141.05791.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These symbols are exported, to be used by an iptables module.

---
 exports.c   |   33 +++++++++++++++++++++++++++++++++
 fireflier.h |    9 +++++++++
 2 files changed, 42 insertions(+)
diff -uprN null/exports.c fireflier_lsm/exports.c
--- null/exports.c	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/exports.c	2006-04-07 14:39:27.000000000 +0300
@@ -0,0 +1,33 @@
+#include "fireflier.h"
+#include "structures.h"
+#include "autolabel.h"
+#include <linux/socket.h>
+#include <net/sock.h>
+void fireflier_sk_ctxid(struct sock *sk,u32 *sid) 
+{
+	struct socket *sock;
+	sock = sk->sk_socket;
+	if (sock)
+	{
+		struct inode *inode;
+		inode = SOCK_INODE(sock);
+		if (inode)
+		{
+			struct fireflier_inode_security_struct *isec;
+			isec = inode->i_security;
+			if (sid && isec)
+				*sid = isec->sid;
+			//	     if (class)
+			//	       *class = isec->sclass;
+		}
+	}
+}
+
+int fireflier_available(void)
+{
+	return 1;
+}
+
+EXPORT_SYMBOL_GPL(fireflier_sk_ctxid);
+EXPORT_SYMBOL_GPL(fireflier_available);
+
diff -uprN null/fireflier.h fireflier_lsm/fireflier.h
--- null/fireflier.h	1970-01-01 02:00:00.000000000 +0200
+++ fireflier_lsm/fireflier.h	2006-03-29 23:07:46.000000000 +0300
@@ -0,0 +1,9 @@
+#ifndef _FIREFLIER_H
+#define _FIREFLIER_H
+#include <linux/types.h>
+#include <linux/module.h>
+struct sock;
+void fireflier_sk_ctxid(struct sock *sk,u32 *ctxid);
+int fireflier_available(void);
+int fireflier_ctx_to_id(const char* dev,unsigned long inode,u32 *ctxid);
+#endif
