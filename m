Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269294AbUINLHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbUINLHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269276AbUINLE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:04:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37762 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269272AbUINLBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:01:15 -0400
Date: Tue, 14 Sep 2004 13:02:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched, mm: fix scheduling latencies in filemap_sync()
Message-ID: <20040914110237.GC31370@elte.hu>
References: <20040914091529.GA21553@elte.hu> <20040914093855.GA23258@elte.hu> <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20040914105904.GB31370@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The attached patch, written by Andrew Morton, fixes long scheduling
latencies in filemap_sync().

has been tested as part of the -VP patchset.

	Ingo

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-filemap_sync.patch"


The attached patch, written by Andrew Morton, fixes long scheduling
latencies in filemap_sync().

has been tested as part of the -VP patchset.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/mm/msync.c.orig	
+++ linux/mm/msync.c	
@@ -92,8 +92,8 @@ static inline int filemap_sync_pmd_range
 	return error;
 }
 
-static int filemap_sync(struct vm_area_struct * vma, unsigned long address,
-	size_t size, unsigned int flags)
+static int __filemap_sync(struct vm_area_struct *vma, unsigned long address,
+			size_t size, unsigned int flags)
 {
 	pgd_t * dir;
 	unsigned long end = address + size;
@@ -131,6 +131,31 @@ static int filemap_sync(struct vm_area_s
 	return error;
 }
 
+#ifdef CONFIG_PREEMPT
+static int filemap_sync(struct vm_area_struct *vma, unsigned long address,
+			size_t size, unsigned int flags)
+{
+	const size_t chunk = 64 * 1024;	/* bytes */
+	int error = 0;
+
+	while (size) {
+		size_t sz = min(size, chunk);
+
+		error |= __filemap_sync(vma, address, sz, flags);
+		cond_resched();
+		address += sz;
+		size -= sz;
+	}
+	return error;
+}
+#else
+static int filemap_sync(struct vm_area_struct *vma, unsigned long address,
+			size_t size, unsigned int flags)
+{
+	return __filemap_sync(vma, address, size, flags);
+}
+#endif
+
 /*
  * MS_SYNC syncs the entire file - including mappings.
  *

--4ZLFUWh1odzi/v6L--
