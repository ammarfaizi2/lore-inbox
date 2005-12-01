Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVLATe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVLATe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVLATe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:34:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932415AbVLATe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:34:28 -0500
Date: Thu, 1 Dec 2005 11:34:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
cc: Kasper Sandberg <lkml@metanurb.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
In-Reply-To: <6f6293f10512011112m6e50fe0ejf0aa5ba9d09dca1e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0512011125280.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org> 
 <1133445903.16820.1.camel@localhost>  <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org>
 <6f6293f10512011112m6e50fe0ejf0aa5ba9d09dca1e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Dec 2005, Felipe Alfaro Solana wrote:
> 
> Exactly that's what I'm seeing with the propietary nVidia driver:

Does yours work despite the messages?

Also, can both of you apply this debugging patch that just adds a bit more 
information about exactly what kind of mapping these drivers are trying to 
do..

		Thanks,
			Linus

---
diff --git a/mm/memory.c b/mm/memory.c
index 4b4fc3a..b0ab902 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1241,22 +1241,33 @@ static int incomplete_pfn_remap(struct v
 
 	if (!(vma->vm_flags & VM_INCOMPLETE)) {
 		if (warn) {
+			unsigned long val = pgprot_val(prot);
 			warn--;
 			printk("%s does an incomplete pfn remapping", current->comm);
+			printk("vma: %lx-%lx remap: %lx-%lx pfn: %lx, prot: %lx",
+				vma->vm_start, vma->vm_end,
+				start, end,
+				pfn, val);
 			dump_stack();
 		}
 	}
 	vma->vm_flags |= VM_INCOMPLETE | VM_IO | VM_RESERVED;
 
-	if (start < vma->vm_start || end > vma->vm_end)
+	if (start < vma->vm_start || end > vma->vm_end) {
+		printk("pfn remap outside the vma!\n");
 		return -EINVAL;
+	}
 
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(pfn)) {
+		printk("incomplete pfn remap with IO pages not supported\n");
 		return -EINVAL;
+	}
 
 	page = pfn_to_page(pfn);
-	if (!PageReserved(page))
+	if (!PageReserved(page)) {
+		printk("incomplete pfn remap with non-reserved pages!??!\n");
 		return -EINVAL;
+	}
 
 	retval = 0;
 	while (start < end) {
