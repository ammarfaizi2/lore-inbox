Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTBCL2b>; Mon, 3 Feb 2003 06:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTBCL2b>; Mon, 3 Feb 2003 06:28:31 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:6251
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266199AbTBCL1K>; Mon, 3 Feb 2003 06:27:10 -0500
Date: Mon, 3 Feb 2003 06:35:51 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>
Subject: [PATCH][3/6] CPU Hotplug fs/
Message-ID: <Pine.LNX.4.44.0302030548190.9361-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 buffer.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.5.59-lch2/fs/buffer.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/fs/buffer.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 buffer.c
--- linux-2.5.59-lch2/fs/buffer.c	17 Jan 2003 11:16:13 -0000	1.1.1.1
+++ linux-2.5.59-lch2/fs/buffer.c	3 Feb 2003 11:06:59 -0000
@@ -2873,7 +2873,18 @@
 	bha->ratelimit = 0;
 	memset(bhl, 0, sizeof(*bhl));
 }
-	
+
+static void buffer_exit_cpu(int cpu)
+{
+	int i;
+	struct bh_lru *b = &per_cpu(bh_lrus, cpu);
+
+	for (i = 0; i < BH_LRU_SIZE; i++) {
+		brelse(b->bhs[i]);
+		b->bhs[i] = NULL;
+	}
+}
+
 static int __devinit buffer_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
@@ -2881,6 +2892,9 @@
 	switch(action) {
 	case CPU_UP_PREPARE:
 		buffer_init_cpu(cpu);
+		break;
+	case CPU_OFFLINE:
+		buffer_exit_cpu(cpu);
 		break;
 	default:
 		break;


