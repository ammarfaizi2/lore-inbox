Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754471AbWKHJTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbWKHJTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbWKHJTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:19:53 -0500
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:42137 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1754464AbWKHJTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:19:52 -0500
Subject: Re: [PATCH 0/1] mspec driver: compile error
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: Jes Sorensen <jes@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Robin Holt <holt@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       Tony Luck <tony.luck@gmail.com>
In-Reply-To: <20061107133512.a49b11e0.akpm@osdl.org>
References: <1162881017.13700.105.camel@sebastian.intellilink.co.jp>
	 <4550609A.7010908@sgi.com>  <20061107133512.a49b11e0.akpm@osdl.org>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Wed, 08 Nov 2006 18:19:49 +0900
Message-Id: <1162977589.7805.77.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 13:35 -0800, Andrew Morton wrote:
> On Tue, 07 Nov 2006 11:31:54 +0100
> Jes Sorensen <jes@sgi.com> wrote:
> 
> > Fix MSPEC driver to build for non SN2 enabled configs as the driver
> > should work in cached and uncached modes (no fetchop) on these systems.
> > In addition make MSPEC select IA64_UNCACHED_ALLOCATOR, which is required
> > for it.
> 
> i386 `make allmodconfig' says:
> 
> drivers/char/Kconfig:425:warning: 'select' used by config symbol 'MSPEC' refer to undefined symbol 'IA64_UNCACHED_ALLOCATOR'
The problem occurs because i386 (as expected) does not define
IA64_UNCACHED_ALLOCATOR. I thought that making the select expression
depend on IA64 as shown below might silence allmodconfig:

  select IA64_UNCACHED_ALLOCATOR if IA64

But my guess was wrong and the same warning appeared. It seems that "if"
expressions do not prevent allmodconfig from checking the symbol
indicated by the select the "if" is conditioning. By the way, is this
the expected behaviour? If so, we need to get rid of the reverse
dependency, modify the "depends on" line accordingly, and make
IA64_UNCACHED_ALLOCATOR selectable. I may be missing the whole point so
please correct if I am wrong.

Regards,

Fernando

---

The mspec driver's Kconfig entry has a reverse dependency on IA64-specific code, which causes "allmodconfig" to yell on non-Itanium architectures.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.19-rc4-mm2-orig/arch/ia64/Kconfig linux-2.6.19-rc4-mm2/arch/ia64/Kconfig
--- linux-2.6.19-rc4-mm2-orig/arch/ia64/Kconfig	2006-11-08 17:51:19.000000000 +0900
+++ linux-2.6.19-rc4-mm2/arch/ia64/Kconfig	2006-11-08 18:11:14.000000000 +0900
@@ -74,10 +74,6 @@ config SCHED_NO_NO_OMIT_FRAME_POINTER
 	bool
 	default y
 
-config IA64_UNCACHED_ALLOCATOR
-	bool
-	select GENERIC_ALLOCATOR
-
 config AUDIT_ARCH
 	bool
 	default y
@@ -226,6 +222,13 @@ config IOSAPIC
 	depends on !IA64_HP_SIM
 	default y
 
+config IA64_UNCACHED_ALLOCATOR
+	bool "Uncached allocator"
+	select GENERIC_ALLOCATOR
+	help
+	  A simple uncached page allocator using the generic allocator.
+	  It is needed to compile the special memory driver (mspec).
+
 config IA64_SGI_SN_XP
 	tristate "Support communication between SGI SSIs"
 	depends on IA64_GENERIC || IA64_SGI_SN2
diff -urNp linux-2.6.19-rc4-mm2-orig/drivers/char/Kconfig linux-2.6.19-rc4-mm2/drivers/char/Kconfig
--- linux-2.6.19-rc4-mm2-orig/drivers/char/Kconfig	2006-11-08 17:51:36.000000000 +0900
+++ linux-2.6.19-rc4-mm2/drivers/char/Kconfig	2006-11-08 16:31:55.000000000 +0900
@@ -436,8 +436,7 @@ config SGI_MBCS
 
 config MSPEC
 	tristate "Memory special operations driver"
-	depends on IA64
-	select IA64_UNCACHED_ALLOCATOR
+	depends on IA64_UNCACHED_ALLOCATOR
 	help
 	  If you have an ia64 and you want to enable memory special
 	  operations support (formerly known as fetchop), say Y here,


