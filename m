Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVIVCal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVIVCal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 22:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVIVCal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 22:30:41 -0400
Received: from koto.vergenet.net ([210.128.90.7]:56704 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751427AbVIVCak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 22:30:40 -0400
Date: Thu, 22 Sep 2005 11:30:25 +0900
From: Horms <horms@debian.org>
To: Nikos Ntarmos <ntarmos@ceid.upatras.gr>, 329354@bugs.debian.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Frederik Schueler <fs@lowpingbastards.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CAN-2005-0204 and 2.4
Message-ID: <20050922023025.GA20981@verge.net.au>
References: <E1EI1tH-0006Yy-00@master.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EI1tH-0006Yy-00@master.debian.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 01:31:37PM +0300, Nikos Ntarmos wrote:
> Package: kernel-source-2.4.27
> Version: 2.4.27-11.hls.2005082200
> Severity: important
> Justification: fails to build from source
> 
> Patch 143_outs.diff.bz2 breaks the kernel compilation on x86_64. The
> problem is that it uses the IO_BITMAP_BYTES macro which is defined for
> i386 (in linux/include/asm-i386/processor.h) but not for x86_64.
> Reverting the patch lets the kernel build again, although I guess the
> correct solution would be to add an appropriate IO_BITMAP_BYTES to
> linux/include/asm-x86_64/processor.h as well.

Hi Nikos,

First up, thanks for testing out my prebuild kernels.  For the
uninitiated they are snapshots of what is in the deabian kernel-team's
SVN and live in http://packages.vergenet.net/testing/

The problem that you see is a patch that was included in
2.4.27-11 (the current version in sid), though it isn't built
for amd64.

Could you see if the following patch works for you.  I've CCed lkml and
Marcelo for their consideration.  It seems to me that 2.4 is indeed
vulnerable to CAN-2005-0204, perhaps someone can shed some light on
this.

-- 
Horms

Description: [CAN-2005-0204]: AMD64, allows local users to write to privileged IO ports via OUTS instruction
Patch author: Suresh Siddha (suresh.b.siddha@intel.com)
Upstream status: not applied
URL: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=146244
Patch source: Micah Anderson <micah@riseup.net> (debian-kernel)

Added definition of IO_BITMAP_BYTES for Debian's 2.4.27 and
submitted upstream for consideration for inclusion in 2.4 -- Horms
 
--- a/include/asm-x86_64/desc.h	2005-02-24 19:51:26.000000000 +0900
+++ b/include/asm-x86_64/desc.h	2005-02-24 19:52:40.000000000 +0900
@@ -128,7 +128,7 @@
 
 static inline void set_tss_desc(unsigned n, void *addr)
 { 
-	set_tssldt_descriptor((void *)&gdt_table + __CPU_DESC_INDEX(n,tss), (unsigned long)addr, DESC_TSS, sizeof(struct tss_struct)); 
+	set_tssldt_descriptor((void *)&gdt_table + __CPU_DESC_INDEX(n,tss), (unsigned long)addr, DESC_TSS, IO_BITMAP_OFFSET + IO_BITMAP_BYTES + 7); 
 } 
 
 static inline void set_ldt_desc(unsigned n, void *addr, int size)
--- a/include/asm-x86_64/processor.h	2005-09-22 11:12:40.000000000 +0900
+++ b/include/asm-x86_64/processor.h	2005-09-22 11:12:43.000000000 +0900
@@ -260,6 +260,7 @@
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
  */
 #define IO_BITMAP_SIZE	32
+#define IO_BITMAP_BYTES (IO_BITMAP_SIZE * sizeof(u32))
 #define IO_BITMAP_OFFSET offsetof(struct tss_struct,io_bitmap)
 #define INVALID_IO_BITMAP_OFFSET 0x8000
 
