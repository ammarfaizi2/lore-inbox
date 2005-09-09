Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVIIAUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVIIAUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 20:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVIIAUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 20:20:47 -0400
Received: from mail.suse.de ([195.135.220.2]:65226 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965092AbVIIAUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 20:20:46 -0400
Date: Fri, 9 Sep 2005 02:20:45 +0200
From: Andi Kleen <ak@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: Andreas Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] [PATCH] add and handle NMI_VECTOR
Message-ID: <20050909002045.GA19913@wotan.suse.de>
References: <43207DFC0200007800024543@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43207DFC0200007800024543@emea1-mh.id2.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 06:07:56PM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> Declare NMI_VECTOR and handle it in the IPI sending code.

The earlier consensus was to just rename KDB_VECTOR to NMI vector.

I added the following patch.

-Andi


Rename KDB_VECTOR to NMI_VECTOR

As a generic NMI IPI vector to be used by debuggers.

And clean up the ICR setup for that slightly (code is equivalent, but cleaner 
now)

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-x86_64/hw_irq.h
===================================================================
--- linux.orig/include/asm-x86_64/hw_irq.h
+++ linux/include/asm-x86_64/hw_irq.h
@@ -52,7 +52,7 @@ struct hw_interrupt_type;
 #define ERROR_APIC_VECTOR	0xfe
 #define RESCHEDULE_VECTOR	0xfd
 #define CALL_FUNCTION_VECTOR	0xfc
-#define KDB_VECTOR		0xfb	/* reserved for KDB */
+#define NMI_VECTOR		0xfb	/* IPI NMIs for debugging */
 #define THERMAL_APIC_VECTOR	0xfa
 /* 0xf9 free */
 #define INVALIDATE_TLB_VECTOR_END	0xf8
Index: linux/include/asm-x86_64/ipi.h
===================================================================
--- linux.orig/include/asm-x86_64/ipi.h
+++ linux/include/asm-x86_64/ipi.h
@@ -29,11 +29,14 @@
  * We use 'broadcast', CPU->CPU IPIs and self-IPIs too.
  */
 
-static inline unsigned int __prepare_ICR (unsigned int shortcut, int vector, unsigned int dest)
+static inline unsigned int
+__prepare_ICR (unsigned int shortcut, int vector, unsigned int dest)
 {
-	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
-	if (vector == KDB_VECTOR)
-		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;
+	unsigned int icr =  shortcut | dest;
+	if (vector == NMI_VECTOR)
+		icr |= APIC_DM_DMI;
+	else
+		icr |= APIC_DM_FIXED | vector;
 	return icr;
 }
 
