Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273349AbRJPHRh>; Tue, 16 Oct 2001 03:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273385AbRJPHR1>; Tue, 16 Oct 2001 03:17:27 -0400
Received: from zok.sgi.com ([204.94.215.101]:42155 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S273349AbRJPHRW>;
	Tue, 16 Oct 2001 03:17:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.4.12 optionally prevent kbuild reading /usr/include
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 17:17:45 +1000
Message-ID: <21371.1003216665@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few bits of kernel code are incorrectly reading from /usr/include,
giving different results on different distributions.  kbuild 2.5 will
prevent this, all include files must be in the kernel tree.  The patch
below (for 2.4.12 but fits 2.4.13-pre3) defines kbuild_2_4_nostdinc.
Linus, please add to 2.4.13-prex.

The various maintainers can optionally check that their code is not
reading from outside the kernel, see the comments in the patch.  I
strongly recommend that maintainers check their code now, even if it is
only on their own machine.  There is no need to patch the sub Makefiles
in Linus's tree, as long as the code has been tested.

Based on a suggestion by Christoph Hellwig.

Index: 12.1/Makefile
--- 12.1/Makefile Thu, 11 Oct 2001 20:11:18 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.4 644)
+++ 12.1(w)/Makefile Tue, 16 Oct 2001 17:08:15 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.4 644)
@@ -240,6 +240,16 @@ MRPROPER_DIRS = \
 
 include arch/$(ARCH)/Makefile
 
+# Optional cflags for kbuild 2.4, to prevent individual files or an entire
+# directory including files from outside the kernel.  To control an individual
+# file, use CFLAGS_foo.o += $(kbuild_2_4_nostdinc), to control an entire
+# directory use EXTRA_CFLAGS += $(kbuild_2_4_nostdinc).  In kbuild 2.5 the
+# default is to forbid includes from outside the kernel tree, you can use this
+# variable in kbuild 2.4 to ensure that your code is clean before 2.5.  KAO.
+
+kbuild_2_4_nostdinc     := -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
+export kbuild_2_4_nostdinc
+
 export	CPPFLAGS CFLAGS AFLAGS
 
 export	NETWORKS DRIVERS LIBS HEAD LDFLAGS LINKFLAGS MAKEBOOT ASFLAGS

