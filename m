Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUCUAqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 19:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbUCUAqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 19:46:30 -0500
Received: from waste.org ([209.173.204.2]:12970 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263580AbUCUAq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 19:46:28 -0500
Date: Sat, 20 Mar 2004 18:46:19 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: [patch] minor fix to kgdboe configuration logic
Message-ID: <20040321004618.GV11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have gotten dropped. Without it, kgdboe can get into a
half-configured state.

kgdboe - fix configuration of MAC address


 tiny-mpm/drivers/net/kgdb_eth.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/net/kgdb_eth.c~kgdboe-mac-init drivers/net/kgdb_eth.c
--- tiny/drivers/net/kgdb_eth.c~kgdboe-mac-init	2004-03-16 12:03:11.000000000 -0600
+++ tiny-mpm/drivers/net/kgdb_eth.c	2004-03-16 12:03:11.000000000 -0600
@@ -46,6 +46,7 @@ static struct netpoll np = {
 	.remote_port = 6442,
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
 };
+static int configured;
 
 int eth_getDebugChar(void)
 {
@@ -101,9 +102,9 @@ static void rx_hook(struct netpoll *np, 
 	}
 }
 
-static int option_setup(char *opt)
+static void option_setup(char *opt)
 {
-	return netpoll_parse_options(&np, opt);
+        configured = !netpoll_parse_options(&np, opt);
 }
 
 __setup("kgdboe=", option_setup);
@@ -119,7 +120,7 @@ static int init_kgdboe(void)
 
 	set_debug_traps();
 
-	if(!np.remote_ip || netpoll_setup(&np))
+	if(!configured || netpoll_setup(&np))
 		return 1;
 
 	kgdboe = 1;

_

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
