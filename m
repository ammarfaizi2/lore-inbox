Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUFCQ6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUFCQ6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUFCQ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:58:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:55745 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265227AbUFCQ6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:58:00 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Symlinks for building external modules
Date: Thu, 3 Jun 2004 18:58:09 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.net>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406031858.09178.agruen@suse.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

modules not in the kernel source tree need to locate both the source tree and 
the object tree (O=). Currently, the /lib/modules/$(uname -r)/build symlink 
is the only reference we have; it historically points to the source tree from 
2.4 times. The following patch changes this as follows (this is what we have 
in the current SUSE tree now):

	/lib/modules/$(uname -r)/source ==> source tree
	/lib/modules/$(uname -r)/build ==> object tree

Both links are required for building external modules with:

	make -C /lib/modules/$(uname -r)/source \
		O=/lib/modules/$(uname -r)/build \
		M=$(pwd)


Index: linux-2.6.7-rc2/Makefile
===================================================================
--- linux-2.6.7-rc2.orig/Makefile
+++ linux-2.6.7-rc2/Makefile
@@ -732,9 +732,10 @@ _modinst_:
 		sleep 1; \
 	fi
 	@rm -rf $(MODLIB)/kernel
-	@rm -f $(MODLIB)/build
+	@rm -f $(MODLIB)/{source,build}
 	@mkdir -p $(MODLIB)/kernel
-	@ln -s $(TOPDIR) $(MODLIB)/build
+	@ln -s $(srctree) $(MODLIB)/source
+	@ln -s $(objtree) $(MODLIB)/build
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
 
 # If System.map exists, run depmod.  This deliberately does not have a


Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
