Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSFXPbS>; Mon, 24 Jun 2002 11:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSFXPbR>; Mon, 24 Jun 2002 11:31:17 -0400
Received: from trained-monkey.org ([209.217.122.11]:58897 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S312962AbSFXPbP>; Mon, 24 Jun 2002 11:31:15 -0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: acenic >4gig sendfile problem
References: <3D05204B.4010103@us.ibm.com>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 24 Jun 2002 11:31:15 -0400
In-Reply-To: Dave Hansen's message of "Mon, 10 Jun 2002 14:55:23 -0700"
Message-ID: <m3r8iwvgl8.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Hansen <haveblue@us.ibm.com> writes:

Dave> When doing sendfile with my acenic card on my 8xPIII-700 and PAE
Dave> running 2.4.18, I'm getting all zeros in the files being
Dave> transmitted.  Running the Redhat 2.4.18-4 kernel fixes the
Dave> problem.  I saw this entry in the rpm's changelog: * Sat Aug 25
Dave> 2001 Ingo Molnar <mingo@redhat.com> - fix the acenic driver bug
Dave> that caused random kernel memory being sent out on the wire, on
Dave> x86 systems with more than 4 GB RAM.

Actually I think you're hitting a bug in pci_map_page() rather than in
the acenic.driver.

Try the patch from Ben LaHaise included below.

Jes


------- Start of forwarded message -------
Resent-Message-Id: <200206102358.g5ANwbx23959@toomuch.toronto.redhat.com>
Date: Mon, 10 Jun 2002 19:56:44 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
   Linux Kernel <linux-kernel@vger.kernel.org>
Subject: highmem pci dma mapping does not work, missing cast in asm-i386/pci.h
Message-ID: <20020610195644.C13225@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Resent-From: bcrl@redhat.com
Resent-Date: Mon, 10 Jun 2002 19:58:37 -0400
Resent-To: jes@wildopensource.com

Hello all,

There's a missing cast in pci_map_page that causes 64 bit capable 
drivers to access the wrong memory for highmem pages.  Please 
include the patch below to fix it.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.4/v2.4.19-pre10-pci_highmem.diff
diff -urN v2.4.19-pre10/include/asm-i386/pci.h pci-v2.4.19-pre10/include/asm-i386/pci.h
--- v2.4.19-pre10/include/asm-i386/pci.h	Thu Jun  6 20:10:08 2002
+++ pci-v2.4.19-pre10/include/asm-i386/pci.h	Mon Jun 10 19:54:16 2002
@@ -103,7 +103,7 @@
 	if (direction == PCI_DMA_NONE)
 		out_of_line_bug();
 
-	return (page - mem_map) * PAGE_SIZE + offset;
+	return (dma_addr_t)(page - mem_map) * PAGE_SIZE + offset;
 }
 
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------- End of forwarded message -------
