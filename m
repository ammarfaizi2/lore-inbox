Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVC1N0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVC1N0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVC1N0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:26:10 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33196 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261738AbVC1NZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:25:56 -0500
Subject: [RFC/PATCH 1/17][kexec-tools-1.101] vmlinux parameter segment
	stomping fix
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-7GtgTDefXbi6g2KFynVz"
Date: Mon, 28 Mar 2005 18:55:53 +0530
Message-Id: <1112016353.4001.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7GtgTDefXbi6g2KFynVz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-7GtgTDefXbi6g2KFynVz
Content-Disposition: attachment; filename=kexec-tools-vmlinux-parameter-segment-stomping-fix.patch
Content-Type: text/x-patch; name=kexec-tools-vmlinux-parameter-segment-stomping-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


During loading of panic kernel(vmlinux), it was found that on some systems,
parameter segment was being stomped over by kernel. This was resulting in 
corruption of e820 memory map and leading to boot memory allocator
initialization failures while booting into new kernel. This patch fixes the
problem by loading the parameter segment beyond alrady loaded kernel image
and setup code. A 64K buffer has been provided to avoid any stomping by
kernel.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff -puN kexec/arch/i386/kexec-elf-x86.c~kexec-tools-vmlinux-parameter-segment-stomping-fix kexec/arch/i386/kexec-elf-x86.c
--- kexec-tools-1.101/kexec/arch/i386/kexec-elf-x86.c~kexec-tools-vmlinux-parameter-segment-stomping-fix	2005-03-21 16:43:50.000000000 +0530
+++ kexec-tools-1.101-root/kexec/arch/i386/kexec-elf-x86.c	2005-03-21 16:43:50.000000000 +0530
@@ -199,15 +199,27 @@ int elf_x86_load(int argc, char **argv, 
 	}
 	else if (arg_style == ARG_STYLE_LINUX) {
 		struct x86_linux_faked_param_header *hdr;
-		unsigned long param_base;
+		unsigned long param_base, min_param_base = 0;
 		const unsigned char *ramdisk_buf;
 		off_t ramdisk_length;
 		struct entry32_regs regs;
+		int i;
 
 		/* Get the linux parameter header */
 		hdr = xmalloc(sizeof(*hdr));
+		/* Add parameter segment beyond already loaded segments, so that
+		 * it does not get stomped by kernel. */
+		for (i = 0; i < info->nr_segments; i++) {
+			unsigned long temp;
+			temp = (unsigned long) info->segment[i].mem +
+				info->segment[i].memsz;
+			if (temp > min_param_base)
+				min_param_base =  temp;
+		}
+		/* 64K of buffer to keep enough distance from kernel. */
+		min_param_base += 64*1024;
 		param_base = add_buffer(info, hdr, sizeof(*hdr), sizeof(*hdr),
-			16, 0, max_addr, 1);
+			16, min_param_base, max_addr, 1);
 
 		/* Initialize the parameter header */
 		memset(hdr, 0, sizeof(*hdr));
_

--=-7GtgTDefXbi6g2KFynVz--

