Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWBBTYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWBBTYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWBBTYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:24:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751005AbWBBTYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:24:16 -0500
Date: Thu, 2 Feb 2006 14:24:15 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: discriminate single bit error hardware failure from slab corruption.
Message-ID: <20060202192414.GA22074@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the case where we detect a single bit has been flipped, we spew
the usual slab corruption message, which users instantly think
is a kernel bug.  In a lot of cases, single bit errors are
down to bad memory, or other hardware failure.

This patch adds an extra line to the slab debug messages in those
cases, in the hope that users will try memtest before they report a bug.

000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Single bit error detected. Possibly bad RAM. Please run memtest86.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15/mm/slab.c~	2006-01-09 13:25:17.000000000 -0500
+++ linux-2.6.15/mm/slab.c	2006-01-09 13:26:01.000000000 -0500
@@ -1313,8 +1313,11 @@ static void poison_obj(kmem_cache_t *cac
 static void dump_line(char *data, int offset, int limit)
 {
 	int i;
+	unsigned char total=0;
 	printk(KERN_ERR "%03x:", offset);
 	for (i = 0; i < limit; i++) {
+		if (data[offset+i] != POISON_FREE)
+			total += data[offset+i];
 		printk(" %02x", (unsigned char)data[offset + i]);
 	}
 	printk("\n");
@@ -1019,6 +1023,18 @@ static void dump_line(char *data, int of
 		}
 	}
 	printk("\n");
+	switch (total) {
+		case 0x36:
+		case 0x6a:
+		case 0x6f:
+		case 0x81:
+		case 0xac:
+		case 0xd3:
+		case 0xd5:
+		case 0xea:
+			printk (KERN_ERR "Single bit error detected. Possibly bad RAM. Please run memtest86.\n");
+			return;
+	}
 }
 #endif
 
