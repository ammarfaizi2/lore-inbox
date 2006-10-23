Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWJWTtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWJWTtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWJWTsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:48:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22475 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965011AbWJWTsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:48:01 -0400
Date: Mon, 23 Oct 2006 15:29:23 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 2/11] i386: Remove unnecessary ALIGN() in vmlinux.lds.S
Message-ID: <20061023192923.GC13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o There seems to be one extra ALIGN(4096) before symbol __smp_alt_end. The
  only usage of __smp_alt_end is to mark the end of smp alternative
  sections so that this memory can be freed. As a physical page is freed
  one has to just make sure that there is no other data on the same page
  where __smp_alt_end is pointing. There is already a ALIGN(4096) after
  this section which should take care of the above issue. Hence it looks
  like the ALIGN(4096) before __smp_alt_end is redundant and not required.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/vmlinux.lds.S |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/vmlinux.lds.S~i386-remove-unnecessary-align-option arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.19-rc2-git7-reloc/arch/i386/kernel/vmlinux.lds.S~i386-remove-unnecessary-align-option	2006-10-23 13:15:21.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/kernel/vmlinux.lds.S	2006-10-23 15:09:02.000000000 -0400
@@ -112,11 +112,15 @@ SECTIONS
   }
   .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
 	*(.smp_altinstr_replacement)
-	. = ALIGN(4096);
 	__smp_alt_end = .;
   }
 
-  /* will be freed after init */
+  /* will be freed after init
+   * Following ALIGN() is required to make sure no other data falls on the
+   * same page where __smp_alt_end is pointing as that page might be freed
+   * after boot. Always make sure that ALIGN() directive is present after
+   * the section which contains __smp_alt_end.
+   */
   . = ALIGN(4096);		/* Init code and data */
   .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
   	__init_begin = .;
_
