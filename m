Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263173AbUJ2JjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUJ2JjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbUJ2JjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:39:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51927 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263173AbUJ2Jij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:38:39 -0400
Message-ID: <41820F72.5020203@in.ibm.com>
Date: Fri, 29 Oct 2004 15:07:54 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
CC: ebiederm@xmission.com, Vara Prasad <varap@us.ibm.com>, fastboot@osdl.org
Subject: Compile error on 2.6.10-rc1-mm1
Content-Type: multipart/mixed;
 boundary="------------060605050007080401040906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060605050007080401040906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

The compile time error that few people have been seeing with 
the last couple of -mm releases are due to the changes 
introduced to arch/i386/kernel/vmlinux.lds.S to enable kexec 
based crashdumps. Since fixing this error needs an upgrade 
of the binutils package on those machines, I was looking at 
a possible workaround within the kernel code itself.

The problem seems to arise from the fact that the 
.bss.page_aligned section (defined in head.S) is included 
within the .bss section. Older binutils does not export the 
proper physical address (LMA) for the .bss section. I made a 
patch which moves the .bss.page_aligned section to just 
before the .bss section. This compiles fine with both older 
and newer binutils packages. I have done some amount of 
testing with this change and it has not thrown up any problems.

I am not completely sure though if this does not have any 
side effects.  Could you kindly review this patch and let me 
know if it looks ok.

If we can use this patch, it will spare us from having to 
upgrade to the newer binutils package.

Regards, Hari

--------------060605050007080401040906
Content-Type: text/plain;
 name="kdump-fix-bss-compile-error.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-fix-bss-compile-error.patch"



Signed-off-by: Hariprasad Nellitheertha <hari@in.ibm.com>
---

 linux-2.6.10-rc1-hari/arch/i386/kernel/vmlinux.lds.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/vmlinux.lds.S~kdump-fix-bss-compile-error arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.10-rc1/arch/i386/kernel/vmlinux.lds.S~kdump-fix-bss-compile-error	2004-10-28 15:15:43.000000000 +0530
+++ linux-2.6.10-rc1-hari/arch/i386/kernel/vmlinux.lds.S	2004-10-28 15:18:04.000000000 +0530
@@ -117,8 +117,9 @@ SECTIONS
   /* freed after init ends here */
 	
   __bss_start = .;		/* BSS */
+  .bss.page_aligned  : AT(ADDR(.bss.page_aligned) - LOAD_OFFSET) {
+	*(.bss.page_aligned) }
   .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
-	*(.bss.page_aligned)
 	*(.bss)
   }
   . = ALIGN(4);
_

--------------060605050007080401040906--
