Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVHNC1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVHNC1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 22:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVHNC1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 22:27:50 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:35999 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932428AbVHNC1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 22:27:50 -0400
X-IronPort-AV: i="3.96,105,1122872400"; 
   d="scan'208"; a="298478495:sNHT24490704"
Date: Sat, 13 Aug 2005 21:27:43 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-kernel@vger.kernel.org
Subject: [RFT][PATCH 2.6.13-rc] EDD: edd=skipmbr necessity fix
Message-ID: <20050814022743.GA19095@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a request for testers, specifically people whose i386 or
x86_64 systems won't boot properly if CONFIG_EDD=[ym] without the use
of edd=skipmbr.  If you're currently using edd=skipmbr, I'd really
appreciate knowing about it, and your results of booting with this
patch.

This patch uses an int13 Get Disk Type call before using a Read
Sectors call to read the MBR.  If Get Disk Type fails, this is a good
indication that the BIOS doesn't believe there's a disk there, without
actually trying to do I/O to the disk.

arch/i386/boot/edd.S |   15 ++++++++++++++-
 include/linux/edd.h  |    2 ++
 2 files changed, 16 insertions, 1 deletion

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff --git a/arch/i386/boot/edd.S b/arch/i386/boot/edd.S
--- a/arch/i386/boot/edd.S
+++ b/arch/i386/boot/edd.S
@@ -55,6 +55,19 @@ done_cl:
 # Read the first sector of each BIOS disk device and store the 4-byte signature
 edd_mbr_sig_start:
 	movb	$0x80, %dl			# from device 80
+edd_get_disk_type:
+	movw	$GET_DISK_TYPE, %ax
+	pushw	%cx				# this clobbers cx and dx
+	pushw	%dx				# 
+	stc					# work around buggy BIOSes
+	int	$0x13
+	sti					# work around buggy BIOSes
+	popw	%dx
+	popw	%cx
+	jc	edd_mbr_sig_done
+	cmpb	$GET_DISK_TYPE_DISK, %ah	# is this a disk?
+	jne	edd_mbr_sig_done
+
 	movw	$EDD_MBR_SIG_BUF, %bx		# store buffer ptr in bx
 edd_mbr_sig_read:
 	movl	$0xFFFFFFFF, %eax
@@ -82,7 +95,7 @@ edd_mbr_sig_read:
 	incb	%dl				# increment to next device
 	addw	$4, %bx				# increment sig buffer ptr
 	cmpb	$EDD_MBR_SIG_MAX, (EDD_MBR_SIG_NR_BUF)	# Out of space?
-	jb	edd_mbr_sig_read		# keep looping
+	jb	edd_get_disk_type		# keep looping
 edd_mbr_sig_done:
 
 # Do the BIOS Enhanced Disk Drive calls
diff --git a/include/linux/edd.h b/include/linux/edd.h
--- a/include/linux/edd.h
+++ b/include/linux/edd.h
@@ -39,6 +39,8 @@
 #define CHECKEXTENSIONSPRESENT 0x41
 #define GETDEVICEPARAMETERS 0x48
 #define LEGACYGETDEVICEPARAMETERS 0x08
+#define GET_DISK_TYPE 0x1500
+#define GET_DISK_TYPE_DISK 0x03
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
 
