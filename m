Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTBQVpf>; Mon, 17 Feb 2003 16:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbTBQVpf>; Mon, 17 Feb 2003 16:45:35 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:22532 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267540AbTBQVpe>;
	Mon, 17 Feb 2003 16:45:34 -0500
Date: Mon, 17 Feb 2003 22:55:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix warning in kernel/dma.c
Message-ID: <20030217215532.GA8984@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling without PROC_FS enabled a warning is issued about
proc_dma_show defined but not used.
Move both versions of proc_dma_show inside the #ifdef CONFIG_PROC_FS

	Sam


===== kernel/dma.c 1.5 vs edited =====
--- 1.5/kernel/dma.c	Wed Aug 28 09:53:26 2002
+++ edited/kernel/dma.c	Mon Feb 17 22:30:17 2003
@@ -98,6 +98,22 @@
 
 } /* free_dma */
 
+#else
+
+int request_dma(unsigned int dmanr, const char *device_id)
+{
+	return -EINVAL;
+}
+
+void free_dma(unsigned int dmanr)
+{
+}
+
+#endif
+
+#ifdef CONFIG_PROC_FS
+
+#ifdef MAX_DMA_CHANNELS
 static int proc_dma_show(struct seq_file *m, void *v)
 {
 	int i;
@@ -110,27 +126,14 @@
 	}
 	return 0;
 }
-
 #else
-
-int request_dma(unsigned int dmanr, const char *device_id)
-{
-	return -EINVAL;
-}
-
-void free_dma(unsigned int dmanr)
-{
-}
-
 static int proc_dma_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "No DMA\n");
 	return 0;
 }
+#endif /* MAX_DMA_CHANNELS */
 
-#endif
-
-#ifdef CONFIG_PROC_FS
 static int proc_dma_open(struct inode *inode, struct file *file)
 {
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
