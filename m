Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268487AbTBWPL6>; Sun, 23 Feb 2003 10:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268488AbTBWPKX>; Sun, 23 Feb 2003 10:10:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9233 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268484AbTBWPKP>; Sun, 23 Feb 2003 10:10:15 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] [3/6] Remove "fn" argument from read_cb_mem()
Message-Id: <20020223151803@raistlin.arm.linux.org.uk>
References: <20020223151802@raistlin.arm.linux.org.uk>
In-Reply-To: <20020223151802@raistlin.arm.linux.org.uk>
Date: Sun, 23 Feb 2003 15:20:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.62, but applies cleanly.

Subject: [3/6] Remove "fn" argument from read_cb_mem()
read_cb_mem is only ever called with its "fn" argument set to zero.
We therefore do not need to pass it.

 drivers/pcmcia/cardbus.c     |    5 ++---
 drivers/pcmcia/cistpl.c      |    4 ++--
 drivers/pcmcia/cs_internal.h |    3 +--
 3 files changed, 5 insertions, 7 deletions

diff -ur -x sa11* -x Kconfig -x Makefile orig/drivers/pcmcia/cardbus.c linux/drivers/pcmcia/cardbus.c
--- orig/drivers/pcmcia/cardbus.c	Sun Feb 23 12:41:54 2003
+++ linux/drivers/pcmcia/cardbus.c	Sun Feb 23 12:43:55 2003
@@ -175,8 +175,7 @@
     
 =====================================================================*/
 
-int read_cb_mem(socket_info_t * s, u_char fn, int space,
-		u_int addr, u_int len, void *ptr)
+int read_cb_mem(socket_info_t * s, int space, u_int addr, u_int len, void *ptr)
 {
 	struct pci_dev *dev;
 	struct resource *res;
@@ -186,7 +185,7 @@
 	if (!s->cb_config)
 		goto fail;
 
-	dev = &s->cb_config[fn].dev;
+	dev = &s->cb_config[0].dev;
 
 	/* Config space? */
 	if (space == 0) {
diff -ur -x sa11* -x Kconfig -x Makefile orig/drivers/pcmcia/cistpl.c linux/drivers/pcmcia/cistpl.c
--- orig/drivers/pcmcia/cistpl.c	Sun Nov 24 10:12:25 2002
+++ linux/drivers/pcmcia/cistpl.c	Sun Feb 23 10:23:58 2003
@@ -327,7 +327,7 @@
     }
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS)
-	ret = read_cb_mem(s, 0, attr, addr, len, ptr);
+	ret = read_cb_mem(s, attr, addr, len, ptr);
     else
 #endif
 	ret = read_cis_mem(s, attr, addr, len, ptr);
@@ -358,7 +358,7 @@
     for (i = 0; i < s->cis_used; i++) {
 #ifdef CONFIG_CARDBUS
 	if (s->state & SOCKET_CARDBUS)
-	    read_cb_mem(s, 0, s->cis_table[i].attr, s->cis_table[i].addr,
+	    read_cb_mem(s, s->cis_table[i].attr, s->cis_table[i].addr,
 			s->cis_table[i].len, buf);
 	else
 #endif
diff -ur -x sa11* -x Kconfig -x Makefile orig/drivers/pcmcia/cs_internal.h linux/drivers/pcmcia/cs_internal.h
--- orig/drivers/pcmcia/cs_internal.h	Sun Feb 23 12:39:27 2003
+++ linux/drivers/pcmcia/cs_internal.h	Sun Feb 23 11:39:32 2003
@@ -200,8 +200,7 @@
 void cb_free(socket_info_t *s);
 void cb_enable(socket_info_t *s);
 void cb_disable(socket_info_t *s);
-int read_cb_mem(socket_info_t *s, u_char fn, int space,
-		u_int addr, u_int len, void *ptr);
+int read_cb_mem(socket_info_t *s, int space, u_int addr, u_int len, void *ptr);
 void cb_release_cis_mem(socket_info_t *s);
 
 /* In cistpl.c */
