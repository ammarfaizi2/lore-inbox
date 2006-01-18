Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWARX7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWARX7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbWARX7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:37 -0500
Received: from [151.97.230.9] ([151.97.230.9]:15081 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030487AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/8] uml: fix hugest stack users
Date: Thu, 19 Jan 2006 00:55:04 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060118235503.4626.71474.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The C99 initialization, with GCC's bad handling, for 6K wide structs (which
_aren't_ on the stack), is causing GCC to use 12K for these silly procs with 3
vars. Workaround this.

Note that .name = { '\0' } translates to memset(->name, 0, '->name' size) - I verified
this with GCC's docs and a testprogram.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/slip_common.h |   13 +++++++------
 arch/um/drivers/slip_kern.c   |   15 ++++++++-------
 arch/um/drivers/slirp_kern.c  |   13 +++++++------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/um/drivers/slip_common.h b/arch/um/drivers/slip_common.h
index 2ae76d8..d574e0a 100644
--- a/arch/um/drivers/slip_common.h
+++ b/arch/um/drivers/slip_common.h
@@ -88,12 +88,13 @@ struct slip_proto {
 	int esc;
 };
 
-#define SLIP_PROTO_INIT { \
-	.ibuf  	= { '\0' }, \
-	.obuf  	= { '\0' }, \
-        .more	= 0, \
-	.pos	= 0, \
-	.esc	= 0 \
+static inline void slip_proto_init(struct slip_proto * slip)
+{
+	memset(slip->ibuf, 0, sizeof(slip->ibuf));
+	memset(slip->obuf, 0, sizeof(slip->obuf));
+	slip->more = 0;
+	slip->pos = 0;
+	slip->esc = 0;
 }
 
 extern int slip_proto_read(int fd, void *buf, int len,
diff --git a/arch/um/drivers/slip_kern.c b/arch/um/drivers/slip_kern.c
index 9a6f5c8..a62f5ef 100644
--- a/arch/um/drivers/slip_kern.c
+++ b/arch/um/drivers/slip_kern.c
@@ -21,13 +21,14 @@ void slip_init(struct net_device *dev, v
 
 	private = dev->priv;
 	spri = (struct slip_data *) private->user;
-	*spri = ((struct slip_data)
-		{ .name 	= { '\0' },
-		  .addr		= NULL,
-		  .gate_addr 	= init->gate_addr,
-		  .slave  	= -1,
-		  .slip		= SLIP_PROTO_INIT,
-		  .dev 		= dev });
+
+	memset(spri->name, 0, sizeof(spri->name));
+	spri->addr = NULL;
+	spri->gate_addr = init->gate_addr;
+	spri->slave = -1;
+	spri->dev = dev;
+
+	slip_proto_init(&spri->slip);
 
 	dev->init = NULL;
 	dev->header_cache_update = NULL;
diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
index 9864d27..33d7982 100644
--- a/arch/um/drivers/slirp_kern.c
+++ b/arch/um/drivers/slirp_kern.c
@@ -21,12 +21,13 @@ void slirp_init(struct net_device *dev, 
 
 	private = dev->priv;
 	spri = (struct slirp_data *) private->user;
-	*spri = ((struct slirp_data)
-		{ .argw 	= init->argw,
-		  .pid  	= -1,
-		  .slave  	= -1,
-		  .slip		= SLIP_PROTO_INIT,
-		  .dev 		= dev });
+
+	spri->argw = init->argw;
+	spri->pid = -1;
+	spri->slave = -1;
+	spri->dev = dev;
+
+	slip_proto_init(&spri->slip);
 
 	dev->init = NULL;
 	dev->hard_header_len = 0;

