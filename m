Return-Path: <linux-kernel-owner+w=401wt.eu-S964983AbWLTK41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWLTK41 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWLTK41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:56:27 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42761 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964983AbWLTK40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:56:26 -0500
Date: Wed, 20 Dec 2006 11:53:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [patch] x86_64: fix boot time hang in detect_calgary()
Message-ID: <20061220105332.GA20922@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] x86_64: fix boot time hang in detect_calgary()
From: Ingo Molnar <mingo@elte.hu>

if CONFIG_CALGARY_IOMMU is built into the kernel via 
CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT, or is enabled via the 
iommu=calgary boot option, then the detect_calgary() function runs to 
detect the presence of a Calgary IOMMU.

detect_calgary() first searches the BIOS EBDA area for a "rio_table_hdr" 
BIOS table. It has this parsing algorithm for the EBDA:

	while (offset) {
		...
		/* The next offset is stored in the 1st word. 0 means no more */
 		offset = *((unsigned short *)(ptr + offset));
	}

got that? Lets repeat it slowly: we've got a BIOS-supplied data 
structure, plus Linux kernel code that will only break out of an 
infinite parsing loop once the BIOS gives a zero offset. Ok?

Translation: what an excellent opportunity for BIOS writers to lock up 
the Linux boot process in an utterly hard to debug place! Indeed the 
BIOS jumped on that opportunity on my box, which has the following EBDA 
chaining layout:

  384, 65282, 65535, 65535, 65535, 65535, 65535, 65535 ...

see the pattern? So my, definitely non-Calgary system happily locks up 
in detect_calgary()!

the patch below fixes the boot hang by trusting the BIOS-supplied data 
structure a bit less: the parser always has to make forward progress, 
and if it doesnt, we break out of the loop and i get the expected kernel 
message:

  Calgary: Unable to locate Rio Grande Table in EBDA - bailing!

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/pci-calgary.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -1052,7 +1052,7 @@ void __init detect_calgary(void)
 	void *tbl;
 	int calgary_found = 0;
 	unsigned long ptr;
-	int offset;
+	unsigned int offset, prev_offset;
 	int ret;
 
 	/*
@@ -1071,15 +1071,20 @@ void __init detect_calgary(void)
 	ptr = (unsigned long)phys_to_virt(get_bios_ebda());
 
 	rio_table_hdr = NULL;
+	prev_offset = 0;
 	offset = 0x180;
-	while (offset) {
+	/*
+	 * The next offset is stored in the 1st word.
+	 * Only parse up until the offset increases:
+	 */
+	while (offset > prev_offset) {
 		/* The block id is stored in the 2nd word */
 		if (*((unsigned short *)(ptr + offset + 2)) == 0x4752){
 			/* set the pointer past the offset & block id */
 			rio_table_hdr = (struct rio_table_hdr *)(ptr + offset + 4);
 			break;
 		}
-		/* The next offset is stored in the 1st word. 0 means no more */
+		prev_offset = offset;
 		offset = *((unsigned short *)(ptr + offset));
 	}
 	if (!rio_table_hdr) {
