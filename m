Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUGAWN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUGAWN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUGAWNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:13:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27410 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266319AbUGAWND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:13:03 -0400
Date: Thu, 1 Jul 2004 23:12:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Martin Schlemmer <azarah@nosferatu.za.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: binutils woes
Message-ID: <20040701231256.G8389@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Schlemmer <azarah@nosferatu.za.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20040701175231.B8389@flint.arm.linux.org.uk> <20040701174731.GD15960@smtp.west.cox.net> <20040701190720.C8389@flint.arm.linux.org.uk> <1088711048.8875.5.camel@nosferatu.lan> <20040701205255.F8389@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040701205255.F8389@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jul 01, 2004 at 08:52:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 08:52:55PM +0100, Russell King wrote:
> Therefore, unless anyone has any objections, I shall be cooking up
> a patch which adds an extra pass to any final object link for the
> kernel build system.

Ok, I decided that touching the rules used for the boot loader(s) was
probably going to be too fraught, so here's one which just checks the
final link for the main kernel image.

Essentially, we run 'nm' against the object, and look for any line
which matches the pattern '^ *U '.  With this, a failing output looks
like:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
ldchk: .tmp_vmlinux1: final image has undefined symbols:
  SIZEOF_MACHINE_DESC
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [vmlinux] Error 2

and successful output:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux


===== Makefile 1.500 vs edited =====
--- 1.500/Makefile	Tue Jun 29 15:44:49 2004
+++ edited/Makefile	Thu Jul  1 23:10:04 2004
@@ -533,6 +533,8 @@
 endef
 
 #	set -e makes the rule exit immediately on error
+#	Note: Ensure that there are no undefined symbols in the final
+#	linked image.  Not doing this can lead to silent link failures.
 
 define rule_vmlinux__
 	+set -e;							\
@@ -545,6 +547,12 @@
 	$(if $($(quiet)cmd_vmlinux__),					\
 	  echo '  $($(quiet)cmd_vmlinux__)' &&) 			\
 	$(cmd_vmlinux__);						\
+	if $(NM) $@ | grep -q '^ *U '; then				\
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
