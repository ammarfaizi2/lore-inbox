Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVAKW5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVAKW5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVAKWyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:54:24 -0500
Received: from orb.pobox.com ([207.8.226.5]:28835 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262921AbVAKWvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:51:33 -0500
Date: Tue, 11 Jan 2005 14:51:27 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 10:46:19AM -0800, Linus Torvalds wrote:
> Another issue is likely that we should make the whole "uselib()"
> interfaces configurable. I don't think modern binaries use it (where
> "modern" probably means "compiled within the last 8 years" ;).

Here's an initial stab at such a patch. It adds a new config option,
CONFIG_SYS_USELIB. I wrote the patch against 2.6.10-bk14 but I tested it
against vanilla 2.6.10. Also, it only updates defconfig for i386, as
that's the only platform I can test at the moment.

There's probably plenty to criticize in this patch, but it's a start...

Signed-off-by: Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.6.10-bk14/arch/i386/defconfig linux-2.6.10-bk14-bkn1/arch/i386/defconfig
--- linux-2.6.10-bk14/arch/i386/defconfig	2005-01-11 09:38:04.847566774 -0800
+++ linux-2.6.10-bk14-bkn1/arch/i386/defconfig	2005-01-11 11:15:02.127586567 -0800
@@ -195,6 +195,7 @@
 #
 # Executable file formats
 #
+CONFIG_SYS_USELIB=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_AOUT=y
 CONFIG_BINFMT_MISC=y
diff -ruN linux-2.6.10-bk14/fs/exec.c linux-2.6.10-bk14-bkn1/fs/exec.c
--- linux-2.6.10-bk14/fs/exec.c	2005-01-11 09:38:26.215892759 -0800
+++ linux-2.6.10-bk14-bkn1/fs/exec.c	2005-01-11 11:06:19.482007489 -0800
@@ -111,6 +111,7 @@
 	module_put(fmt->module);
 }
 
+#ifdef CONFIG_SYS_USELIB
 /*
  * Note that a shared library must be both readable and executable due to
  * security reasons.
@@ -167,6 +168,7 @@
 	path_release(&nd);
 	goto out;
 }
+#endif
 
 /*
  * count() counts the number of strings in array ARGV.
diff -ruN linux-2.6.10-bk14/fs/Kconfig.binfmt linux-2.6.10-bk14-bkn1/fs/Kconfig.binfmt
--- linux-2.6.10-bk14/fs/Kconfig.binfmt	2005-01-11 09:38:25.702932946 -0800
+++ linux-2.6.10-bk14-bkn1/fs/Kconfig.binfmt	2005-01-11 11:09:16.873962890 -0800
@@ -1,3 +1,16 @@
+config SYS_USELIB
+	bool "sys_uselib syscall support (needed for old binaries)"
+	---help---
+	  Many old binaries (e.g. dynamically linked a.out binaries, and
+	  ELF binaries that are dynamically linked against libc5), require
+	  the sys_uselib syscall. However, on the typical Linux system, this
+	  code is just old cruft that no longer serves a purpose.
+
+	  If you are unsure, say "N" if you care more about security and
+	  trimming bloat, or say "Y" if you care more about compatibility
+	  with old software. (If you will answer "Y" or "M" to BINFMT_AOUT,
+	  below, you probably should answer "Y" here.)
+
 config BINFMT_ELF
 	bool "Kernel support for ELF binaries"
 	depends on MMU
diff -ruN linux-2.6.10-bk14/kernel/sys_ni.c linux-2.6.10-bk14-bkn1/kernel/sys_ni.c
--- linux-2.6.10-bk14/kernel/sys_ni.c	2004-12-14 03:18:07.379372435 -0800
+++ linux-2.6.10-bk14-bkn1/kernel/sys_ni.c	2005-01-11 13:25:38.670751478 -0800
@@ -76,6 +76,7 @@
 cond_syscall(sys_keyctl)
 cond_syscall(compat_sys_keyctl)
 cond_syscall(compat_sys_socketcall)
+cond_syscall(sys_uselib)
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read)
