Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269384AbUJFTiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269384AbUJFTiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269382AbUJFTiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:38:14 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:40196 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S269384AbUJFTeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:34:07 -0400
Message-ID: <416448A8.5040305@vmware.com>
Date: Wed, 06 Oct 2004 12:34:00 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, Riley@Williams.Name, davej@codemonkey.org.uk,
       hpa@zytor.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386/gcc bug with do_test_wp_bit
References: <41634E21.6020808@vmware.com> <20041006115550.GA58628@muc.de>
In-Reply-To: <20041006115550.GA58628@muc.de>
Content-Type: multipart/mixed;
 boundary="------------080301040308010408070802"
X-OriginalArrivalTime: 06 Oct 2004 19:34:00.0736 (UTC) FILETIME=[6E259200:01C4ABDB]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.5; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080301040308010408070802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Confirmed.  As Andi says, sorting the exception table does fix the problem.  Tested 2.6.9-rc3 with gcc 3.3.3 and there are no issues.  My major malfunction was working on an older 2.6 kernel and believing the patches were still relevant.  Linus, please revert the following commit, it is no longer needed and do_test_wp_bit is better inlined into __init and subsequently discarded now that exceptions in __init work.

I've added a nicer patch that inlines the do_test_wp_bit function and deprecates the outdated comment.

Zach


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


Andi Kleen wrote:

>On Tue, Oct 05, 2004 at 06:45:05PM -0700, Zachary Amsden wrote:
>  
>
>>Playing around with gcc 3.3.3, I compiled a 2.6 series kernel for i386 
>>and discovered it panics on boot.  The problem was gcc 3.3.3 can inline 
>>functions even if declared after their call sites.  This causes i386 to 
>>not boot, since do_test_wp_bit() must not exist in the __init section.  
>>Similar problems may exist in the boot code for other architectures, but 
>>I can't confirm that at this time.  x86_64 is not affected.
>>    
>>
>
>That should have been fixed long ago by sorting the exception
>table. I checked and the code is still there: 
>
>asmlinkage void __init start_kernel(void)
>{
>	...
>        sort_main_extable();
>
>
>Something must be rotten in your setup. I definitely don't see the
>same problems with a unit-at-a-time 3.3 gcc. 
>
>Can you double check that the sort is really done?
>
>The patch is imho not needed.
>
>-Andi
>  
>


--------------080301040308010408070802
Content-Type: text/plain;
 name="i386-wp-bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-wp-bit.patch"

diff -ru linux-2.6.9-rc3/arch/i386/mm/init.c linux-2.6.9-rc3-za1/arch/i386/mm/init.c
--- linux-2.6.9-rc3/arch/i386/mm/init.c	2004-10-05 18:21:03.000000000 -0700
+++ linux-2.6.9-rc3-za1/arch/i386/mm/init.c	2004-10-06 12:26:03.000000000 -0700
@@ -45,8 +45,6 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
 
-static int do_test_wp_bit(void);
-
 /*
  * Creates a middle page table and puts a pointer to it in the
  * given global directory entry. This only returns the gd entry
@@ -525,6 +523,28 @@
  * used to involve black magic jumps to work around some nasty CPU bugs,
  * but fortunately the switch to using exceptions got rid of all that.
  */
+static inline int do_test_wp_bit(void)
+{
+	char tmp_reg;
+	int flag;
+
+	__asm__ __volatile__(
+		"	movb %0,%1	\n"
+		"1:	movb %1,%0	\n"
+		"	xorl %2,%2	\n"
+		"2:			\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4	\n"
+		"	.long 1b,2b	\n"
+		".previous		\n"
+		:"=m" (*(char *)fix_to_virt(FIX_WP_TEST)),
+		 "=q" (tmp_reg),
+		 "=r" (flag)
+		:"2" (1)
+		:"memory");
+	
+	return flag;
+}
 
 void __init test_wp_bit(void)
 {
@@ -669,33 +689,6 @@
 		panic("pgtable_cache_init(): Cannot create pgd cache");
 }
 
-/*
- * This function cannot be __init, since exceptions don't work in that
- * section.  Put this after the callers, so that it cannot be inlined.
- */
-static int do_test_wp_bit(void)
-{
-	char tmp_reg;
-	int flag;
-
-	__asm__ __volatile__(
-		"	movb %0,%1	\n"
-		"1:	movb %1,%0	\n"
-		"	xorl %2,%2	\n"
-		"2:			\n"
-		".section __ex_table,\"a\"\n"
-		"	.align 4	\n"
-		"	.long 1b,2b	\n"
-		".previous		\n"
-		:"=m" (*(char *)fix_to_virt(FIX_WP_TEST)),
-		 "=q" (tmp_reg),
-		 "=r" (flag)
-		:"2" (1)
-		:"memory");
-	
-	return flag;
-}
-
 void free_initmem(void)
 {
 	unsigned long addr;
Only in linux-2.6.9-rc3: .MAINTAINERS.swp

--------------080301040308010408070802--
