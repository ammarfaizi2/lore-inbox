Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSFRUot>; Tue, 18 Jun 2002 16:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317617AbSFRUor>; Tue, 18 Jun 2002 16:44:47 -0400
Received: from host194.steeleye.com ([216.33.1.194]:27396 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317616AbSFRUn0>; Tue, 18 Jun 2002 16:43:26 -0400
Message-Id: <200206182043.g5IKhMi07395@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: 2.5.22 make dep problem with symbol versions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Jun 2002 15:43:22 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make dep generates broken versioning (actually empty .ver files) if the local 
Makefile rule has more than one export-obj.  The new rules to generate the 
.ver files actually only apply to the first export-obj in the list, and not 
the subsequent ones.  The fix is to add the prefix correctly (see below).  
This finally gives me a working build for 2.5.22.

James

===== Rules.make 1.59 vs edited =====
--- 1.59/Rules.make	Mon Jun 10 21:59:33 2002
+++ edited/Rules.make	Tue Jun 18 15:14:39 2002
@@ -131,9 +131,9 @@
 	genksyms_smp_prefix := 
 endif
 
-$(MODVERDIR)/$(real-objs-y:.o=.ver): modkern_cflags := $(CFLAGS_KERNEL)
-$(MODVERDIR)/$(real-objs-m:.o=.ver): modkern_cflags := $(CFLAGS_MODULE)
-$(MODVERDIR)/$(export-objs:.o=.ver): export_flags   := -D__GENKSYMS__
+$(addprefix $(MODVERDIR)/,$(real-objs-y:.o=.ver)): modkern_cflags := 
$(CFLAGS_KERNEL)
+$(addprefix $(MODVERDIR)/,$(real-objs-m:.o=.ver)): modkern_cflags := 
$(CFLAGS_MODULE)
+$(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver)): export_flags   := 
-D__GENKSYMS__
 
 c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \



