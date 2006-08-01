Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWHASoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWHASoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWHASoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:44:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51387 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751781AbWHASox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:44:53 -0400
Date: Tue, 1 Aug 2006 14:44:51 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: single bit flip detector.
Message-ID: <20060801184451.GP22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case where we detect a single bit has been flipped, we spew
the usual slab corruption message, which users instantly think
is a kernel bug.  In a lot of cases, single bit errors are
down to bad memory, or other hardware failure.

This patch adds an extra line to the slab debug messages
in those cases, in the hope that users will try memtest before
they report a bug.

000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Single bit error detected. Possibly bad RAM. Run memtest86.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/mm/slab.c~	2006-03-22 18:29:27.000000000 -0500
+++ linux-2.6.16.noarch/mm/slab.c	2006-03-22 18:30:58.000000000 -0500
@@ -1516,10 +1516,33 @@ static void poison_obj(struct kmem_cache
 static void dump_line(char *data, int offset, int limit)
 {
 	int i;
+	unsigned char total=0, bad_count=0;
 	printk(KERN_ERR "%03x:", offset);
-	for (i = 0; i < limit; i++)
+	for (i = 0; i < limit; i++) {
+		if (data[offset+i] != POISON_FREE) {
+			total += data[offset+i];
+			++bad_count;
+		}
 		printk(" %02x", (unsigned char)data[offset + i]);
+	}
 	printk("\n");
+	if (bad_count == 1) {
+		switch (total) {
+		case POISON_FREE ^ 0x01:
+		case POISON_FREE ^ 0x02:
+		case POISON_FREE ^ 0x04:
+		case POISON_FREE ^ 0x08:
+		case POISON_FREE ^ 0x10:
+		case POISON_FREE ^ 0x20:
+		case POISON_FREE ^ 0x40:
+		case POISON_FREE ^ 0x80:
+			printk (KERN_ERR "Single bit error detected. Possibly bad RAM.\n");
+#ifdef CONFIG_X86
+			printk (KERN_ERR "Run memtest86 or other memory test tool.\n");
+#endif
+			return;
+		}
+	}
 }
 #endif

-- 
http://www.codemonkey.org.uk
