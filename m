Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTFKWhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTFKWhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:37:07 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:34953 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262720AbTFKWhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:37:04 -0400
Date: Wed, 11 Jun 2003 15:49:51 -0700
From: "H. J. Lu" <hjl@lucon.org>
Subject: PATCH: Use .incbin to incorporate binary files.
To: linux kernel <linux-kernel@vger.kernel.org>
Message-id: <20030611224951.GA1060@lucon.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_eJ7bv51FV3KMIxsKxL4zNw)"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_eJ7bv51FV3KMIxsKxL4zNw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

The Linux binutils 2.11.90.0.23 released on 2001-07-14 introduced
a new feature, .incbin, which allows you to include a set of binary
data at a given point in the assembly. It is better than

# ld -r --format binary --oformat ...

since it will set appropriate bits in the ELF header. Here is a patch
against 2.5.70 to use .incbin.


H.J.

--Boundary_(ID_eJ7bv51FV3KMIxsKxL4zNw)
Content-type: text/plain; charset=us-ascii; NAME=binary.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=binary.patch

--- linux/usr/Makefile.binary	Mon Mar 24 14:00:45 2003
+++ linux/usr/Makefile	Wed Jun 11 15:44:23 2003
@@ -5,11 +5,9 @@ host-progs  := gen_init_cpio
 
 clean-files := initramfs_data.cpio.gz
 
-LDFLAGS_initramfs_data.o := $(LDFLAGS_BLOB) -r -T
-
-$(obj)/initramfs_data.o: $(src)/initramfs_data.scr \
-			 $(obj)/initramfs_data.cpio.gz FORCE
-	$(call if_changed,ld)
+$(src)/initramfs_data.S: $(obj)/initramfs_data.cpio.gz
+	echo "	.section .init.ramfs,\"a\"" > $(src)/initramfs_data.S
+	echo ".incbin \"usr/initramfs_data.cpio.gz\"" >> $(src)/initramfs_data.S
 
 # initramfs-y are the programs which will be copied into the CPIO
 # archive. Currently, the filenames are hardcoded in gen_init_cpio,
--- linux/usr/initramfs_data.scr.binary	Mon Mar 24 14:00:11 2003
+++ linux/usr/initramfs_data.scr	Wed Jun 11 15:44:32 2003
@@ -1,4 +0,0 @@
-SECTIONS
-{
-	.init.ramfs : { *(.data) }
-}

--Boundary_(ID_eJ7bv51FV3KMIxsKxL4zNw)--
