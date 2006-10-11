Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161422AbWJKVXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161422AbWJKVXH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161427AbWJKVHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:07:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:19617 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161423AbWJKVHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:07:20 -0400
Date: Wed, 11 Oct 2006 14:07:06 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, haveblue@us.ibm.com, bunk@stusta.de,
       vgoyal@in.ibm.com, Keith Mannthey <kmannth@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 40/67] i386 bootioremap / kexec fix
Message-ID: <20061011210706.GO16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="i386-bootioremap-kexec-fix.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: keith mannthey <kmannth@us.ibm.com>

With CONFIG_PHYSICAL_START set to a non default values the i386
boot_ioremap code calculated its pte index wrong and users of boot_ioremap
have their areas incorrectly mapped (for me SRAT table not mapped during
early boot).  This patch removes the addr < BOOT_PTE_PTRS constraint.

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/mm/boot_ioremap.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/arch/i386/mm/boot_ioremap.c
+++ linux-2.6.18/arch/i386/mm/boot_ioremap.c
@@ -29,8 +29,11 @@
  */
 
 #define BOOT_PTE_PTRS (PTRS_PER_PTE*2)
-#define boot_pte_index(address) \
-	     (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
+
+static unsigned long boot_pte_index(unsigned long vaddr)
+{
+	return __pa(vaddr) >> PAGE_SHIFT;
+}
 
 static inline boot_pte_t* boot_vaddr_to_pte(void *address)
 {

--
