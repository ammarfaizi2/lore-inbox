Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272627AbRIKWxt>; Tue, 11 Sep 2001 18:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272631AbRIKWxj>; Tue, 11 Sep 2001 18:53:39 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:6715 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272627AbRIKWxU>; Tue, 11 Sep 2001 18:53:20 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: iafilius@xs4all.nl, ledzep37@home.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 11 Sep 2001 18:53:43 -0400
Message-Id: <1000248825.20106.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan, Jordan, and anyone using preemption and highmem:

Can you _please_ test the following patch?  It is my final version of
the highmem patch, and the one I would like to include in the preempt
patch itself.

It should be faster than the patch you have been using before, the locks
in the previous patch were held for the duration that the entire page
remained map.  I don't see any reason for that.

I would appreciate if you could patch your kernel and let me know.  I am
putting 2.4.10-pre8 patches up at http://tech9.net/rml/linux shortly. 
2.4.9-ac10 patches are there, too.

If you test, please reply with: kernel version, do you lock/oops with
highmem enabled but no extra patch (you should), do you lock/oops with
highmem enabled and the original highmem patch (you should not), and do
you lock/oops/something with this new highmem patch (I hope not). 
Obviously enable CONFIG_PREEMPT and CONFIG_HIGHMEM, and test well. 
Please tell me if CONFIG_SMP is enabled (that is another bag of fun...).

Thank you...




--- linux-not-rml/include/asm-i386/highmem.h	Tue Sep 11 17:54:32 2001
+++ linux/include/asm-i386/highmem.h	Tue Sep 11 18:42:13 2001
@@ -88,6 +88,8 @@
 	if (page < highmem_start_page)
 		return page_address(page);
 
+	ctx_sw_off();
+
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 #if HIGHMEM_DEBUG
@@ -97,6 +99,8 @@
 	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
 	__flush_tlb_one(vaddr);
 
+	ctx_sw_on();
+
 	return (void*) vaddr;
 }
 
@@ -106,6 +110,8 @@
 	unsigned long vaddr = (unsigned long) kvaddr;
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
+	ctx_sw_off();
+
 	if (vaddr < FIXADDR_START) // FIXME
 		return;
 
@@ -118,6 +124,8 @@
 	 */
 	pte_clear(kmap_pte-idx);
 	__flush_tlb_one(vaddr);
+
+	ctx_sw_on();
 #endif
 }
 


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

