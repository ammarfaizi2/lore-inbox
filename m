Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTBQIOz>; Mon, 17 Feb 2003 03:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbTBQIOz>; Mon, 17 Feb 2003 03:14:55 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:30878
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266933AbTBQIFs>; Mon, 17 Feb 2003 03:05:48 -0500
Date: Mon, 17 Feb 2003 03:14:19 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][2.5][3/5] CPU Hotplug fs/
Message-ID: <Pine.LNX.4.50.0302170305310.18087-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 buffer.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.5.61-trojan/fs/buffer.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/fs/buffer.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 buffer.c
--- linux-2.5.61-trojan/fs/buffer.c	15 Feb 2003 12:32:24 -0000	1.1.1.1
+++ linux-2.5.61-trojan/fs/buffer.c	15 Feb 2003 19:35:22 -0000
@@ -2866,7 +2866,18 @@
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
@@ -2874,6 +2885,9 @@
 	switch(action) {
 	case CPU_UP_PREPARE:
 		buffer_init_cpu(cpu);
+		break;
+	case CPU_OFFLINE:
+		buffer_exit_cpu(cpu);
 		break;
 	default:
 		break;
