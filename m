Return-Path: <linux-kernel-owner+w=401wt.eu-S1751199AbWLLG2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWLLG2V (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWLLG2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:28:21 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:60021 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbWLLG2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:28:20 -0500
Message-ID: <457E4C01.1010206@bx.jp.nec.com>
Date: Tue, 12 Dec 2006 15:28:17 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 1/6] cleanup for netconsole
References: <457E498C.1050806@bx.jp.nec.com>
In-Reply-To: <457E498C.1050806@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

This patch contains the following cleanups.
 - add __init for initialization functions(option_setup() and init_netconsole()).
 - define name of magic number.

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
---
--- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:06.985584500 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.cleanup	2006-12-06
14:34:52.561183500 +0900
@@ -50,8 +50,14 @@ MODULE_AUTHOR("Maintainer: Matt Mackall
 MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");

-static char config[256];
-module_param_string(netconsole, config, 256, 0);
+enum {
+	MAX_PRINT_CHUNK = 1000,
+	MAX_CONFIG_LENGTH = 256,
+};
+
+static char config[MAX_CONFIG_LENGTH];
+
+module_param_string(netconsole, config, MAX_CONFIG_LENGTH, 0);
 MODULE_PARM_DESC(netconsole, "
netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]\n");

 static struct netpoll np = {
@@ -62,9 +68,8 @@ static struct netpoll np = {
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
 	.drop = netpoll_queue,
 };
-static int configured = 0;

-#define MAX_PRINT_CHUNK 1000
+static int configured = 0;

 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
@@ -75,14 +80,12 @@ static void write_msg(struct console *co
 		return;

 	local_irq_save(flags);
-
 	for(left = len; left; ) {
 		frag = min(left, MAX_PRINT_CHUNK);
 		netpoll_send_udp(&np, msg, frag);
 		msg += frag;
 		left -= frag;
 	}
-
 	local_irq_restore(flags);
 }

@@ -92,7 +95,7 @@ static struct console netconsole = {
 	.write = write_msg
 };

-static int option_setup(char *opt)
+static int __init option_setup(char *opt)
 {
 	configured = !netpoll_parse_options(&np, opt);
 	return 1;
@@ -100,7 +103,7 @@ static int option_setup(char *opt)

 __setup("netconsole=", option_setup);

-static int init_netconsole(void)
+static int __init init_netconsole(void)
 {
 	if(strlen(config))
 		option_setup(config);

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
