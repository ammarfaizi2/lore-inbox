Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266597AbUGKN4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbUGKN4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 09:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUGKN4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 09:56:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16137 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266597AbUGKN4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 09:56:43 -0400
Date: Sun, 11 Jul 2004 14:56:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: binutils woes
Message-ID: <20040711145639.A23328@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20040701175231.B8389@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040701175231.B8389@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jul 01, 2004 at 05:52:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 05:52:31PM +0100, Russell King wrote:
> On ARM, we appear to have somewhat of a problem with binutils.  At
> least the following binutils suffer from a problem whereby it is
> possible to create programs which contain undefined symbols:

Ok, here's the latest version of the patch.  It shouldn't complain
on Sparc64, and neither should it complain while linking the
.tmp_vmlinux* objects - the original regexp on the objdump --syms
output was catching the weak kallsyms symbols.

The only issue with this is that, when a problem is detected, the
reported symbols will also include the Sparc64 register symbols.

===== Makefile 1.500 vs edited =====
--- 1.500/Makefile	Tue Jun 29 15:44:49 2004
+++ edited/Makefile	Sun Jul 11 14:52:37 2004
@@ -534,6 +534,8 @@
 
 #	set -e makes the rule exit immediately on error
 
+#	Note: Ensure that there are no undefined symbols in the final
+#	linked image.  Not doing this can lead to silent link failures.
 define rule_vmlinux__
 	+set -e;							\
 	$(if $(filter .tmp_kallsyms%,$^),,				\
@@ -545,6 +547,12 @@
 	$(if $($(quiet)cmd_vmlinux__),					\
 	  echo '  $($(quiet)cmd_vmlinux__)' &&) 			\
 	$(cmd_vmlinux__);						\
+	if $(OBJDUMP) --syms $@ | egrep -q '^([^R]|R[^E]|RE[^G])[^w]*\*UND\*'; then	\
+		echo 'ldchk: $@: final image has undefined symbols:';	\
+		$(NM) $@ | sed 's/^ *U \(.*\)/  \1/p;d';		\
+		$(RM) -f $@;						\
+		exit 1;							\
+	fi;								\
 	echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 endef
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
