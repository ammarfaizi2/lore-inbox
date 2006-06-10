Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWFJTKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWFJTKu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWFJTKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:10:49 -0400
Received: from xenotime.net ([66.160.160.81]:17099 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751676AbWFJTKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:10:49 -0400
Date: Sat, 10 Jun 2006 12:13:35 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik <jgarzik@pobox.com>, akpm <akpm@osdl.org>
Subject: [PATCH] [2.6.17-rc6] Section mismatch in drivers/net/ne.o during
 modpost
Message-Id: <20060610121335.447e19f2.rdunlap@xenotime.net>
In-Reply-To: <200606101211.k5ACBgtl029545@harpo.it.uu.se>
References: <200606101211.k5ACBgtl029545@harpo.it.uu.se>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 14:11:42 +0200 (MEST) Mikael Pettersson wrote:

> While compiling 2.6.17-rc6 for a 486 with an NE2000 ISA ethernet card, I got:
> 
> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x158) and 'ne_block_input'
> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x176) and 'ne_block_input'
> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x183) and 'ne_block_input'
> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x1ea) and 'ne_block_input'
> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.data:isapnp_clone_list from .text between 'init_module' (at offset 0x251) and 'ne_block_input'
> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x266) and 'ne_block_input'
> WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x29b) and 'ne_block_input'
> 
> Not sure how serious this is; the driver seems to work fine later on.

Doesn't look serious.  init_module() is not __init, but it calls
some __init functions and touches some __initdata.

BTW, I would be happy to see some consistent results from modpost
section checking.  I don't see all of these warnings (I see only 1)
when using gcc 3.3.6.  What gcc version are you using?
Does that matter?  (not directed at anyone in particular)

Patch below fixes it for me.  Please test/report.
---

From: Randy Dunlap <rdunlap@xenotime.net>

Fix section mismatch warnings:
WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x396) and 'cleanup_card'
WARNING: drivers/net/ne2.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x483) and 'cleanup_card'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/net/ne.c  |    2 +-
 drivers/net/ne2.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2617-rc6.orig/drivers/net/ne.c
+++ linux-2617-rc6/drivers/net/ne.c
@@ -829,7 +829,7 @@ that the ne2k probe is the last 8390 bas
 is at boot) and so the probe will get confused by any other 8390 cards.
 ISA device autoprobes on a running machine are not recommended anyway. */
 
-int init_module(void)
+int __init init_module(void)
 {
 	int this_dev, found = 0;
 
--- linux-2617-rc6.orig/drivers/net/ne2.c
+++ linux-2617-rc6/drivers/net/ne2.c
@@ -780,7 +780,7 @@ MODULE_PARM_DESC(bad, "(ignored)");
 
 /* Module code fixed by David Weinehall */
 
-int init_module(void)
+int __init init_module(void)
 {
 	struct net_device *dev;
 	int this_dev, found = 0;
