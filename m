Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUJFCFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUJFCFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUJFCFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:05:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:61129 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266687AbUJFCFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:05:34 -0400
Date: Tue, 5 Oct 2004 19:05:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: linux-kernel@vger.kernel.org, Riley@Williams.Name, davej@codemonkey.org.uk,
       hpa@zytor.com, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] i386/gcc bug with do_test_wp_bit 
In-Reply-To: <41634E21.6020808@vmware.com>
Message-ID: <Pine.LNX.4.58.0410051903090.8290@ppc970.osdl.org>
References: <41634E21.6020808@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Oct 2004, Zachary Amsden wrote:
> 
> I've included a small trivial fix that is harmless for users not using 
> gcc 3.3.3.  Testing: my 2.6 kernel now boots when compiled with gcc 
> 3.3.3 compiler.

Thanks. However, it really should use the "noinline" define that we have 
for this, and that doesn't upset older versions of gcc that don't 
understand the "noinline" attribute. 

Also, declaration and definition should match, even if gcc doesn't seem to 
catch that.

So here's the version I committed. It should be obviously ok, but it's 
still a good idea to verify..

		Linus

---
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/05 18:51:53-07:00 torvalds@evo.osdl.org 
#   i386: mark do_test_wp_bit() noinline
#   
#   As reported by Zachary Amsden <zach@vmware.com>,
#   some gcc versions will inline the function even when
#   it is declared after the call-site. This particular
#   function must not be inlined, since the exception
#   recovery doesn't like __init sections (which the caller
#   is in).
# 
# arch/i386/mm/init.c
#   2004/10/05 18:51:43-07:00 torvalds@evo.osdl.org +2 -2
#   i386: mark do_test_wp_bit() noinline
#   
#   As reported by Zachary Amsden <zach@vmware.com>,
#   some gcc versions will inline the function even when
#   it is declared after the call-site. This particular
#   function must not be inlined, since the exception
#   recovery doesn't like __init sections (which the caller
#   is in).
# 
diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	2004-10-05 19:04:53 -07:00
+++ b/arch/i386/mm/init.c	2004-10-05 19:04:53 -07:00
@@ -45,7 +45,7 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
 
-static int do_test_wp_bit(void);
+static int noinline do_test_wp_bit(void);
 
 /*
  * Creates a middle page table and puts a pointer to it in the
@@ -673,7 +673,7 @@
  * This function cannot be __init, since exceptions don't work in that
  * section.  Put this after the callers, so that it cannot be inlined.
  */
-static int do_test_wp_bit(void)
+static int noinline do_test_wp_bit(void)
 {
 	char tmp_reg;
 	int flag;
