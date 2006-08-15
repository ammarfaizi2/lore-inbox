Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWHOVuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWHOVuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWHOVuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:50:22 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48287 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750740AbWHOVuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:50:21 -0400
Date: Tue, 15 Aug 2006 17:49:52 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Don Zickus <dzickus@redhat.com>
Subject: [PATCH] x86_64: Re-positioning the bss segment
Message-ID: <20060815214952.GB11719@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o Currently bss segment is being placed somewhere in the middle (after .data)
  section and after bss lots of init section and data sections are coming.
  Is it intentional?

o One side affect of placing bss in the middle is that objcopy keeps the
  bss in raw binary image (vmlinux.bin) hence unnecessarily increasing
  the size of raw binary image. (In my case ~600K). It also increases
  the size of generated bzImage, though the increase is very small
  (896 bytes), probably a very high compression ratio for stream
  of zeros.

o This patch moves the bss at the end hence reducing the size of
  bzImage by 896 bytes and size of vmlinux.bin by 600K.

o This change benefits in the context of relocatable kernel patches. If
  kernel bss is not part of compressed data (vmlinux.bin) then it does
  not have to be decompressed and this area can be used by the decompressor
  for its execution hence keeping the memory requirements bounded and 
  decompressor code does not stomp over any other data loaded beyond
  kernel image (As might be the case with bootloaders like kexec).

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/vmlinux.lds.S |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff -puN arch/x86_64/kernel/vmlinux.lds.S~x86_64-bss-segment-placing-fix arch/x86_64/kernel/vmlinux.lds.S
--- linux-2.6.18-rc3-1M/arch/x86_64/kernel/vmlinux.lds.S~x86_64-bss-segment-placing-fix	2006-08-14 18:46:32.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/x86_64/kernel/vmlinux.lds.S	2006-08-14 20:43:35.000000000 -0400
@@ -61,13 +61,6 @@ SECTIONS
 
   _edata = .;			/* End of data section */
 
-  __bss_start = .;		/* BSS */
-  .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
-	*(.bss.page_aligned)	
-	*(.bss)
-	}
-  __bss_stop = .;
-
   . = ALIGN(PAGE_SIZE);
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   .data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) {
@@ -222,6 +215,13 @@ SECTIONS
   . = ALIGN(4096);
   __nosave_end = .;
 
+  __bss_start = .;		/* BSS */
+  .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
+	*(.bss.page_aligned)
+	*(.bss)
+	}
+  __bss_stop = .;
+
   _end = . ;
 
   /* Sections to be discarded */
_
