Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265210AbUFROpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUFROpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUFROpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:45:39 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:48050 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265201AbUFROpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:45:03 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: sys_ioctl export
Date: Fri, 18 Jun 2004 10:44:10 -0400
User-Agent: KMail/1.6.2
Cc: davidm@hpl.hp.com, Mark Haverkamp <markh@osdl.org>,
       Grant Grundler <iod00d@hp.com>, Andi Kleen <ak@suse.de>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1087494747.28235.28.camel@markh1.pdx.osdl.net> <200406181032.17967.jbarnes@engr.sgi.com> <20040618143718.GA21206@infradead.org>
In-Reply-To: <20040618143718.GA21206@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6+v0AQ9dE0iqhEp"
Message-Id: <200406181044.10771.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_6+v0AQ9dE0iqhEp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, June 18, 2004 10:37 am, Christoph Hellwig wrote:
> > > Just put the export into common code and guard it by CONFIG_COMPAT,
> > > matches exactly the intended users.
> >
> > Like this totally untested and uncompiled patch?
>
> Looks good.  Maybe a small comment?

Small patch to export sys_ioctl if CONFIG_COMPAT is set.  This allows 
platforms to implement 32 bit compatibility ioctl handlers in modules.

Submitted-by: Jesse Barnes <jbarnes@sgi.com>


--Boundary-00=_6+v0AQ9dE0iqhEp
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sys-ioctl-export-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sys-ioctl-export-2.patch"

===== arch/ppc64/kernel/ppc_ksyms.c 1.40 vs edited =====
--- 1.40/arch/ppc64/kernel/ppc_ksyms.c	2004-04-12 13:54:03 -04:00
+++ edited/arch/ppc64/kernel/ppc_ksyms.c	2004-06-18 10:28:45 -04:00
@@ -50,7 +50,6 @@
 int abs(int);
 
 EXPORT_SYMBOL(do_signal);
-EXPORT_SYMBOL(sys_ioctl);
 
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(pci_io_base);
===== arch/s390/kernel/s390_ksyms.c 1.23 vs edited =====
--- 1.23/arch/s390/kernel/s390_ksyms.c	2004-06-12 23:52:29 -04:00
+++ edited/arch/s390/kernel/s390_ksyms.c	2004-06-18 10:28:58 -04:00
@@ -76,4 +76,3 @@
 EXPORT_SYMBOL_NOVERS(do_call_softirq);
 EXPORT_SYMBOL(sys_wait4);
 EXPORT_SYMBOL(cpcmd);
-EXPORT_SYMBOL(sys_ioctl);
===== arch/sparc64/kernel/sparc64_ksyms.c 1.69 vs edited =====
--- 1.69/arch/sparc64/kernel/sparc64_ksyms.c	2004-06-09 01:29:44 -04:00
+++ edited/arch/sparc64/kernel/sparc64_ksyms.c	2004-06-18 10:29:12 -04:00
@@ -327,7 +327,6 @@
 EXPORT_SYMBOL(sys_getgid);
 EXPORT_SYMBOL(svr4_getcontext);
 EXPORT_SYMBOL(svr4_setcontext);
-EXPORT_SYMBOL(sys_ioctl);
 EXPORT_SYMBOL(compat_sys_ioctl);
 EXPORT_SYMBOL(sparc32_open);
 EXPORT_SYMBOL(sys_close);
===== arch/x86_64/kernel/x8664_ksyms.c 1.32 vs edited =====
--- 1.32/arch/x86_64/kernel/x8664_ksyms.c	2004-05-17 17:12:13 -04:00
+++ edited/arch/x86_64/kernel/x8664_ksyms.c	2004-06-18 10:29:26 -04:00
@@ -218,4 +218,3 @@
 EXPORT_SYMBOL_GPL(flush_tlb_all);
 #endif
 
-EXPORT_SYMBOL(sys_ioctl);
===== fs/ioctl.c 1.12 vs edited =====
--- 1.12/fs/ioctl.c	2004-05-29 14:22:13 -04:00
+++ edited/fs/ioctl.c	2004-06-18 10:42:23 -04:00
@@ -4,11 +4,13 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -133,3 +135,11 @@
 out:
 	return error;
 }
+
+/*
+ * Platforms implementing 32 bit compatibility ioctl handlers in
+ * modules need this exported
+ */
+#ifdef CONFIG_COMPAT
+EXPORT_SYMBOL(sys_ioctl);
+#endif

--Boundary-00=_6+v0AQ9dE0iqhEp--
