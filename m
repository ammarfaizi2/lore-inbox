Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUALAJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 19:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUALAJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 19:09:39 -0500
Received: from mail.ccur.com ([208.248.32.212]:35340 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S266027AbUALAJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 19:09:36 -0500
Date: Sun, 11 Jan 2004 19:09:23 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, schwab@suse.de, paulus@samba.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040112000923.GA2743@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040107165607.GA11483@rudolph.ccur.com> <20040107113207.3aab64f5.akpm@osdl.org> <20040108051111.4ae36b58.pj@sgi.com> <16381.57040.576175.977969@cargo.ozlabs.ibm.com> <20040109064619.35c487ec.pj@sgi.com> <je1xq9duhc.fsf@sykes.suse.de> <20040109152533.A25396@infradead.org> <20040109092309.42bb6049.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109092309.42bb6049.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul & Andrew,
 This version of __mask_snprintf_len should work with all mixes of big
vs little endian and 32 vs 64 bit longs.  I tested it in user-land on
a 32 bit big and 32 bit little endian machine.  I tested the 64 bit
long issues by setting MASK_CHUNKSZ == 16 on both of my 32 bit processors.
This should be equivalent to MASK_CHUNKSZ == 32 test on a 64 bit
processor.

This patch preserves Paul's ideas of how a cpumask_t should be printed
out even though I do not agree with those ideas.  At a minimum I prefer
a constant-width display so that columns of cpumasks will be readable.

I expect __mask_parse_len will need similar fixes; I have not looked
as this patch is enough for a Sunday evening's worth of work.

Regards,
Joe

Against 2.6.1


diff -Nua 2.6/lib/mask.c.0 2.6/lib/mask.c
--- 2.6/lib/mask.c.0	2004-01-11 18:53:18.000000000 -0500
+++ 2.6/lib/mask.c	2004-01-11 18:52:43.000000000 -0500
@@ -85,21 +85,30 @@
  *   __mask_snprintf_len(buf, buflen, cpus_addr(mask), sizeof(mask))
  */
 
+#define MASK_CHUNKSZ	(32)		/* in bits.  legal values: 4, 8, 16, 32 */
+
 int __mask_snprintf_len(char *buf, unsigned int buflen,
 	const unsigned long *maskp, unsigned int maskbytes)
 {
-	u32 *wordp = (u32 *)maskp;
-	int i = maskbytes/sizeof(u32) - 1;
-	int len = 0;
+	int i, word, bit, len = 0; 
+	unsigned long val;
 	char *sep = "";
 
-	while (i >= 1 && wordp[i] == 0)
-		i--;
-	while (i >= 0) {
-		len += snprintf(buf+len, buflen-len, "%s%x", sep, wordp[i]);
-		sep = ",";
-		i--;
+	if (buflen <= 0)
+		return 0;
+	buflen--;
+
+	i = (maskbytes * 8 - 1) & ~(MASK_CHUNKSZ - 1);
+	for (; i >= 0; i -= MASK_CHUNKSZ) {
+		word = i / (sizeof(unsigned long) * 8);
+		bit = i % (sizeof(unsigned long) * 8);
+		val = (maskp[word] >> bit) & ((1ULL << MASK_CHUNKSZ) - 1);
+		if (!i || val || *sep == ',') {
+			len += snprintf(buf+len, buflen-len, "%s%lx", sep, val);
+			sep = ",";
+		}
 	}
+	buf[len++] = 0;
 	return len;
 }
 
