Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261951AbTCHAwd>; Fri, 7 Mar 2003 19:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbTCHAwd>; Fri, 7 Mar 2003 19:52:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34060 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261951AbTCHAn3>;
	Fri, 7 Mar 2003 19:43:29 -0500
Date: Fri, 7 Mar 2003 16:44:05 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gen_init_cpio fixes for 2.5.64
Message-ID: <20030308004405.GC23071@kroah.com>
References: <20030305060817.GC26458@kroah.com> <20030308004249.GA23071@kroah.com> <20030308004340.GB23071@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308004340.GB23071@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1125, 2003/03/07 16:46:13-08:00, greg@kroah.com

kbuild: handle any failures of the gen_init_cpio or initramfs image to stop the build.

This also shows how to add files to the initramfs build, but is 
commented out.

Patch originally done by Kai.


 usr/Makefile |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)


diff -Nru a/usr/Makefile b/usr/Makefile
--- a/usr/Makefile	Fri Mar  7 16:48:16 2003
+++ b/usr/Makefile	Fri Mar  7 16:48:16 2003
@@ -1,16 +1,34 @@
 
 obj-y := initramfs_data.o
 
-host-progs := gen_init_cpio
+host-progs  := gen_init_cpio
 
 clean-files := initramfs_data.cpio.gz
 
 LDFLAGS_initramfs_data.o := $(LDFLAGS_BLOB) -r -T
 
-$(obj)/initramfs_data.o: $(src)/initramfs_data.scr $(obj)/initramfs_data.cpio.gz FORCE
+$(obj)/initramfs_data.o: $(src)/initramfs_data.scr \
+			 $(obj)/initramfs_data.cpio.gz FORCE
 	$(call if_changed,ld)
 
-$(obj)/initramfs_data.cpio.gz: $(obj)/gen_init_cpio
-	./$< | gzip -9c > $@
+# initramfs-y are the programs which will be copied into the CPIO
+# archive. Currently, the filenames are hardcoded in gen_init_cpio,
+# but we need the information for the build as well, so it's duplicated
+# here.
 
+# Commented out for now
+# initramfs-y := $(obj)/root/hello
+
+quiet_cmd_cpio = CPIO    $@
+      cmd_cpio = ./$< > $@
+
+$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio $(initramfs-y) FORCE
+	$(call if_changed,cpio)
+
+targets += $(obj)/initramfs_data.cpio
+
+$(obj)/initramfs_data.cpio.gz: $(obj)/initramfs_data.cpio FORCE
+	$(call if_changed,gzip)
+
+targets += $(obj)/initramfs_data.cpio.gz
 
