Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWBCEUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWBCEUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 23:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWBCEUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 23:20:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750930AbWBCEUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 23:20:45 -0500
Date: Thu, 2 Feb 2006 23:20:35 -0500
From: Dave Jones <davej@redhat.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
Message-ID: <20060203042035.GF10209@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Avi Kivity <avi@argo.co.il>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060202192414.GA22074@redhat.com> <43E2A784.2070809@argo.co.il> <20060203014645.GD10209@redhat.com> <43E2BA63.5050505@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E2BA63.5050505@argo.co.il>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 04:05:23AM +0200, Avi Kivity wrote:

 >    unsigned char modified_bits = data[offset+i] ^ POSION_FREE;
 >    int modified_bits_count = hweight8(modified_bits);
 >    total += modified_bits_count;
 > 
 > >wrt correctness, what do you see wrong with my approach?
 > Your code will generate a false positive 8 times in 256 runs, or 1 in 
 > 32. A 3% false positive rate seems excessive, It's also sensitive to 
 > changes to POISON_FREE.

Hmm, I made a mistake in my maths somewhere, and some of those values
are incorrect, so having the compiler do the work would have stopped
me screwing up, but once the correct values are used, I doubt there's
ever a really compelling reason to change the slab poison pattern.

		Dave

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
@@ -1019,6 +1023,22 @@ static void dump_line(char *data, int of
 		}
 	}
 	printk("\n");
+	switch (total) {
+					/* 01101011 (0x6b - SLAB_POISON) */
+		case 0x6a:	/* 01101010 bit 0 flipped */
+		case 0x69:	/* 01101001 bit 1 flipped */
+		case 0x6f:	/* 01101111 bit 2 flipped */
+		case 0x63:	/* 01100011 bit 3 flipped */
+		case 0x7b:	/* 01111011 bit 4 flipped */
+		case 0x4b:	/* 01001011 bit 5 flipped */
+		case 0x2b:	/* 00101011 bit 6 flipped */
+		case 0xeb:	/* 11101011 bit 7 flipped */
+			printk (KERN_ERR "Single bit error detected. Possibly bad RAM\n"
+#ifdef CONFIG_X86
+			printk (KERN_ERR "Run memtest86 or other memory test tool.\n");
+#endif
+			return;
+	}
 }
 #endif
 
