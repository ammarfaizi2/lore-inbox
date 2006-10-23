Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWJWTsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWJWTsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWJWTs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:48:26 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:43476 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964994AbWJWTr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:47:57 -0400
Date: Mon, 23 Oct 2006 15:32:19 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 4/11] i386: define __pa_symbol()
Message-ID: <20061023193219.GE13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On x86_64 we have to be careful with calculating the physical
address of kernel symbols.  Both because of compiler odditities
and because the symbols live in a different range of the virtual
address space.

Having a defintition of __pa_symbol that works on both x86_64 and
i386 simplifies writing code that works for both x86_64 and
i386 that has these kinds of dependencies.

So this patch adds the trivial i386 __pa_symbol definition.

Added assembly magic similar to RELOC_HIDE as suggested by Andi Kleen.
Just picked it up from x86_64.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 include/asm-i386/page.h |    3 +++
 1 file changed, 3 insertions(+)

diff -puN include/asm-i386/page.h~i386-define-__pa_symbol include/asm-i386/page.h
--- linux-2.6.19-rc2-git7-reloc/include/asm-i386/page.h~i386-define-__pa_symbol	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/include/asm-i386/page.h	2006-10-23 15:08:55.000000000 -0400
@@ -124,6 +124,9 @@ extern int page_is_ram(unsigned long pag
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
 #define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
+/* __pa_symbol should be used for C visible symbols.
+   This seems to be the official gcc blessed way to do such arithmetic. */
+#define __pa_symbol(x)          __pa(RELOC_HIDE((unsigned long)(x),0))
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
 #ifdef CONFIG_FLATMEM
_
