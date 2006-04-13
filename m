Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWDMXIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWDMXIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWDMXIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:08:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13262 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932154AbWDMXIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:08:13 -0400
Date: Thu, 13 Apr 2006 16:06:59 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Laurent Meyer <meyerlau@fr.ibm.com>, Paul Mackerras <paulus@samba.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/22] powerpc: fix incorrect SA_ONSTACK behaviour for 64-bit processes
Message-ID: <20060413230659.GC5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="powerpc-fix-incorrect-sa_onstack-behaviour-for-64-bit-processes.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Laurent MEYER <meyerlau@fr.ibm.com>

*) When setting a sighandler using sigaction() call, if the flag
SA_ONSTACK is set and no alternate stack is provided via sigaltstack(),
the kernel still try to install the alternate stack. This behavior is
the opposite of the one which is documented in Single Unix
Specifications V3.

*) Also when setting an alternate stack using sigaltstack() with the
flag SS_DISABLE, the kernel try to install the alternate stack on
signal delivery.

These two use cases makes the process crash at signal delivery.

This fixes it.

Signed-off-by: Laurent Meyer <meyerlau@fr.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/kernel/signal_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.5.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6.16.5/arch/powerpc/kernel/signal_64.c
@@ -213,7 +213,7 @@ static inline void __user * get_sigframe
         /* Default to using normal stack */
         newsp = regs->gpr[1];
 
-	if (ka->sa.sa_flags & SA_ONSTACK) {
+	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size) {
 		if (! on_sig_stack(regs->gpr[1]))
 			newsp = (current->sas_ss_sp + current->sas_ss_size);
 	}

--
