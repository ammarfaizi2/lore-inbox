Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUGFWbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUGFWbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUGFWbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:31:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:42895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264584AbUGFWbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:31:12 -0400
Date: Tue, 6 Jul 2004 15:34:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-Id: <20040706153417.237e454e.akpm@osdl.org>
In-Reply-To: <20040706125438.GS21066@holomorphy.com>
References: <20040705023120.34f7772b.akpm@osdl.org>
	<20040706125438.GS21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Third, some naive check for undefined symbols failed to understand the
> relocation types indicating that a given operand refers to some hard
> register, which manifest as undefined symbols in ELF executables. A
> patch to refine its criteria, which I used to build with, follows. rmk
> and hpa have some other ideas on this undefined symbol issue I've not
> quite had the opportunity to get a clear statement of yet.

I converted that to a non-fatal warning due to the same problem on sparc64.

Here's the current patch against -linus.  I think I'll drop it.  Could you
please work with rmk to come up with a final version?


diff -puN Makefile~check-for-undefined-symbols Makefile
--- 25/Makefile~check-for-undefined-symbols	Tue Jul  6 14:41:49 2004
+++ 25-akpm/Makefile	Tue Jul  6 15:33:15 2004
@@ -586,6 +586,15 @@ define rule_verify_kallsyms
 		(echo Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS ; rm .tmp_kallsyms* ; false)
 endef
 
+# Warn if there are undefined symbols in the final linked image.  They can lead
+# to silent link failures.
+define rule_check_vmlinux
+	if $(NM) $@ | grep -q '^ *U '; then				\
+		echo 'ldchk: $@: final image has undefined symbols:';	\
+		$(NM) $@ | sed 's/^ *U \(.*\)/  \1/p;d';		\
+	fi;
+endef
+
 quiet_cmd_kallsyms = KSYM    $@
 cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) $(foreach x,$(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
 
@@ -612,6 +621,7 @@ define rule_vmlinux
 	$(rule_vmlinux__); \
 	$(call do_system_map, $@, System.map)
 	$(rule_verify_kallsyms)
+	$(rule_check_vmlinux)
 endef
 
 vmlinux: $(vmlinux-objs) $(kallsyms.o) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
_

