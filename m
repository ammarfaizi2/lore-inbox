Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbTJPVFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTJPVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:05:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39394 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263116AbTJPVFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:05:31 -0400
Message-ID: <3F8F07FA.1030006@vnet.ibm.com>
Date: Thu, 16 Oct 2003 16:04:58 -0500
From: Peter Bergner <bergner@vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linuxppc64-dev@lists.linuxppc.org
Subject: [BUG][PATCH] fs/binfmt_elf.c:load_elf_binary() doesn't verify interpreter
 arch
Content-Type: multipart/mixed;
 boundary="------------040008010606020800060006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040008010606020800060006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

In fs/binfmt_elf.c:load_elf_binary() (both 2.6 and 2.4), there is some minimal
checking whether the interpreter it's about to load/run is a valid ELF file,
but it fails to check whether the interpreter is of the correct arch.
We ran into this when a borked powerpc64-linux toolchain set the interpreter
on our 64-bit app to our 32-bit ld.so.  Executing the app caused the kernel to
really chew up memory.  I'm assuming x86_64 and sparc64 might possibly see
the same behavior.

A patch against 2.6 is attached below for review (although it applies with some
fuzz on 2.4).  Note I'm not sure of the history behind INTERPRETER_AOUT, so I
added the test for INTERPRETER_ELF so as not to change it's behavior in case
someone still relies on it.

As an aside, it seems the elf_check_arch() macros should really be checking
for more than a valid e_machine value.  I'd think checking one or more of the
e_ident[EI_CLASS], e_ident[EI_DATA] and e_ident[EI_OSABI] values would be
required as well, no?

Peter



--------------040008010606020800060006
Content-Type: text/plain;
 name="binfmt_elf.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="binfmt_elf.diff"

--- linux-2.5-orig/fs/binfmt_elf.c	2003-10-16 13:35:24.000000000 -0500
+++ linux-2.5/fs/binfmt_elf.c	2003-10-16 15:23:34.000000000 -0500
@@ -602,6 +602,10 @@
 			// printk(KERN_WARNING "ELF: Ambiguous type, using ELF\n");
 			interpreter_type = INTERPRETER_ELF;
 		}
+		/* Verify the interpreter has a valid arch */
+		if ((interpreter_type == INTERPRETER_ELF) &&
+		    !elf_check_arch(&interp_elf_ex))
+			goto out_free_dentry;
 	} else {
 		/* Executables without an interpreter also need a personality  */
 		SET_PERSONALITY(elf_ex, ibcs2_interpreter);

--------------040008010606020800060006--

