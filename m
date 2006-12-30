Return-Path: <linux-kernel-owner+w=401wt.eu-S1755149AbWL3Pz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbWL3Pz1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 10:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbWL3Pz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 10:55:27 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:27414 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755149AbWL3Pz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 10:55:26 -0500
Message-Id: <20061230154941.176582000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sat, 30 Dec 2006 07:49:41 -0800
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
CC: mingo@elte.hu
Subject: [PATCH -mm] fix for crash in adummy_init()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was reported by Ingo Molnar here,

http://lkml.org/lkml/2006/12/18/119

The problem is that adummy_init() depends on atm_init() , but adummy_init() is
called first.

So I put atm_init() into subsys_initcall which seems appropriate, and it will
still get module_init() if it becomes a module.

Interesting to note that you could crash your system here if you just load the
modules in the wrong order.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 net/atm/common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.19/net/atm/common.c
===================================================================
--- linux-2.6.19.orig/net/atm/common.c
+++ linux-2.6.19/net/atm/common.c
@@ -816,7 +816,8 @@ static void __exit atm_exit(void)
 	proto_unregister(&vcc_proto);
 }
 
-module_init(atm_init);
+subsys_initcall(atm_init);
+
 module_exit(atm_exit);
 
 MODULE_LICENSE("GPL");
--
