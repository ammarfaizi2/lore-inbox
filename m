Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbUKJEnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbUKJEnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 23:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUKJEnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 23:43:11 -0500
Received: from imap.gmx.net ([213.165.64.20]:54705 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261871AbUKJEnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 23:43:04 -0500
X-Authenticated: #21910825
Message-ID: <41919C54.8040403@gmx.net>
Date: Wed, 10 Nov 2004 05:43:00 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] Add boot sector checksums to EDD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

this first draft of a patch to implement boot sector checksums in EDD.
Since the comments in edd.S and edd.h discourage changing some offsets,
I made my code overwrite the /sys/firmware/edd/int13_dev*/mbr_signature
file contents. For a later patch I would suggest to add a mbr_checksum
file, so the two can coexist.
The patch is tested and didn't break anything on my machine so far.
Please comment.

Regards,
Carl-Daniel
http://www.hailfinger.org/

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>

--- ./linux-2.6.9/arch/i386/boot/edd.S~	2004-11-05 14:27:08.000000000 +0100
+++ ./linux-2.6.9/arch/i386/boot/edd.S	2004-11-06 23:55:23.000000000 +0100
@@ -5,7 +5,9 @@
  *   projects 1572D, 1484D, 1386D, 1226DT
  * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
  *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003, June 2004
- * legacy CHS retreival by Patrick J. LoPresti <patl@users.sourceforge.net>
+ * disk checksum computation by Carl-Daniel Hailfinger
+ *	<c-d.hailfinger.kernel.2004@gmx.net> November 2004
+ * legacy CHS retrieval by Patrick J. LoPresti <patl@users.sourceforge.net>
  *      March 2004
  * Use EXTENDED READ calls if possible, Matt Domsch, October 2004
  */
@@ -88,10 +90,21 @@
 	movb	%dl, %bl			# copy drive number to ebx
 	sub	$0x80, %bl			# subtract 80h from drive number
 	shlw	$2, %bx				# multiply by 4
+	movw	%bx, %cx			# save bx
 	addw	$EDD_MBR_SIG_BUF, %bx		# add to sig_buf
 						# bx now points to the right sig slot
 	movl	(EDDBUF+EDD_MBR_SIG_OFFSET), %eax # read sig out of the MBR
 	movl	%eax, (%bx)			# store success
+	movw	%cx, %bx			# restore bx
+	addw	$EDD_MBR_CKSUM_BUF, %bx		# add to cksum_buf
+						# bx now points to the right cksum slot
+	xorl	%eax, %eax			# clear eax
+	movl	$0x7f, %ecx			# loop counter
+edd_mbr_compute_checksum:
+	xorl	EDDBUF(,%ecx,4), %eax		# compute checksum of mbr
+	decl	%ecx
+	jns	edd_mbr_compute_checksum	# until the checksum in complete
+	movl	%eax, (%bx)			# store success
 	incb	(EDD_MBR_SIG_NR_BUF)		# note that we stored something
 edd_mbr_sig_next:
 	incb	%dl				# increment to next device
--- ./linux-2.6.9/include/linux/edd.h~	2004-11-05 14:27:47.000000000 +0100
+++ ./linux-2.6.9/include/linux/edd.h	2004-11-06 23:43:20.000000000 +0100
@@ -50,6 +50,7 @@
 #define EDD_MBR_SIG_OFFSET 0x1B8  /* offset of signature in the MBR */
 #define EDD_DEV_ADDR_PACKET_LEN 0x10  /* for int13 fn42 */
 #define EDD_MBR_SIG_BUF    0x290  /* addr in boot params */
+#define EDD_MBR_CKSUM_BUF    0x290  /* addr in boot params */
 #define EDD_MBR_SIG_MAX 16        /* max number of signatures to store */
 #define EDD_MBR_SIG_NR_BUF 0x1ea  /* addr of number of MBR signtaures at EDD_MBR_SIG_BUF
 				     in boot_params - treat this as 1 byte  */
