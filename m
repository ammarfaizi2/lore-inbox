Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVA2XoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVA2XoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVA2XoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:44:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:44929 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261605AbVA2XmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:42:17 -0500
Date: Sun, 30 Jan 2005 00:45:38 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Paul `Rusty' Russell" <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] micro optimization in kernel/params.c; don't call
 to_module_kobject before we really have to.
Message-ID: <Pine.LNX.4.62.0501300024110.2829@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In kernel/params.c::module_attr_show and 
kernel/params.c::module_attr_store we call to_module_kobject() and save 
the result in a local variable right before a conditional statement that 
does not depend on the call to to_module_kobject() and may cause the 
function to return. If the function returns before we use the result of 
to_module_kobject() then the call is just a waste of time. 
The patch moves the call to to_module_kobject() down just before it is 
actually used, thus we save a call to the function in a few cases. I doubt 
this is in any way measurable, but I see no reason to not move the call - 
it should be an infinitesimal improvement with no ill sideeffects.
Please consider applying.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-rc2-bk7-orig/kernel/params.c linux-2.6.11-rc2-bk7/kernel/params.c
--- linux-2.6.11-rc2-bk7-orig/kernel/params.c	2005-01-29 23:54:53.000000000 +0100
+++ linux-2.6.11-rc2-bk7/kernel/params.c	2005-01-30 00:27:08.000000000 +0100
@@ -625,11 +625,12 @@ static ssize_t module_attr_show(struct k
 	int ret;
 
 	attribute = to_module_attr(attr);
-	mk = to_module_kobject(kobj);
 
 	if (!attribute->show)
 		return -EPERM;
 
+	mk = to_module_kobject(kobj);
+
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
 
@@ -649,11 +650,12 @@ static ssize_t module_attr_store(struct 
 	int ret;
 
 	attribute = to_module_attr(attr);
-	mk = to_module_kobject(kobj);
 
 	if (!attribute->store)
 		return -EPERM;
 
+	mk = to_module_kobject(kobj);
+
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
 



