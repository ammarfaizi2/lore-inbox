Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVEJL6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVEJL6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVEJL6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:58:41 -0400
Received: from [195.23.16.24] ([195.23.16.24]:34748 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261618AbVEJL6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:58:33 -0400
Message-ID: <4280A1E5.8000601@grupopie.com>
Date: Tue, 10 May 2005 12:58:29 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux v2.6.12-rc4
References: <Pine.LNX.4.58.0505062245160.2233@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505062245160.2233@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090002090905000106050406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002090905000106050406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> You know the drill.

My build errors out at the end with:
    CC      init/version.o
    LD      init/built-in.o
    LD      .tmp_vmlinux1
    KSYM    .tmp_kallsyms1.S
    AS      .tmp_kallsyms1.o
    LD      .tmp_vmlinux2
    KSYM    .tmp_kallsyms2.S
    AS      .tmp_kallsyms2.o
    LD      vmlinux
    SYSMAP  System.map
    SYSMAP  .tmp_System.map
Inconsistent kallsyms data
Try setting CONFIG_KALLSYMS_EXTRA_PASS
make: *** [vmlinux] Error 1

Comparing .tmp_kallsyms1 with .tmp_kallsyms2 gives:

@@ -10368,8 +10368,8 @@ T ipv6_ext_hdr  PTR     0xc02fdf24
   T ipv6_skip_exthdr     PTR     0xc02fdf6a
   T sha_transform        PTR     0xc02fe084
   T sha_init     PTR     0xc02fe228
-T __sched_text_start   PTR     0xc02fe24f
   t __down       PTR     0xc02fe250
+T __sched_text_start   PTR     0xc02fe250
   t __down_interruptible         PTR     0xc02fe32e
   T __down_failed        PTR     0xc02fe448
   T __down_failed_interruptible  PTR     0xc02fe458

As you can see, the symbol "__sched_text_start" changes position with
"__down" from the first to the second pass.

This is a known bug that the attached patch by Sam Ravnborg fixes.

I really don't know if this is the proper fix or not. Maybe Sam (CC'ed)
can say better if this is more of a band aid or the correct solution.

Note that this is only a problem because the change in position makes
the compression algorithm produce a different result, with a different
size. The algorithm doesn't use all the symbols to optimize the token 
table, but instead it samples 1024 symbols to speed up the calculations.

In one case "__down" is the lucky sample, in the other it is 
"__sched_text_start". Given that my symbol table has 11300 symbols, 
there is a ~2/11 probability of being hit by this bug. The larger the 
symbol table the less likely it is to happen.

If the token table would be kept from the first to the second
pass, not only it would be faster, but also changing a symbol position
would not give inconsistent results, because the resulting size would be
the same.

I'll try to put together a patch to do this, if you feel this is the 
Right Thing (tm).

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)

--------------090002090905000106050406
Content-Type: text/plain;
 name="kallpatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kallpatch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/14 20:56:01+01:00 sam@mars.ravnborg.org
#   kbuild: Avoid inconsistent kallsyms data
#
#   Several reports on inconsistent kallsyms data has been caused by the aliased symbols
#   __sched_text_start and __down to shift places in the output of nm.
#   The root cause was that on second pass ld aligned __sched_text_start to a 4 byte boundary
#   which is the function alignment on i386.
#   sched.text and spinlock.text is now aligned to an 8 byte boundary to make sure they
#   are aligned to a function alignemnt on most (all?) archs.
#
#   Tested by: Paulo Marques <pmarques@grupopie.com>
#   Tested by: Alexander Stohr <Alexander.Stohr@gmx.de>
#
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
#
# include/asm-generic/vmlinux.lds.h
#   2005/03/14 20:55:39+01:00 sam@mars.ravnborg.org +9 -0
#   Align sched.text and spinlock.text to an 8 byte boundary
#
diff -Nru a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
--- a/include/asm-generic/vmlinux.lds.h	2005-03-26 09:07:42 +01:00
+++ b/include/asm-generic/vmlinux.lds.h	2005-03-26 09:07:42 +01:00
@@ -6,6 +6,9 @@
 #define VMLINUX_SYMBOL(_sym_) _sym_
 #endif

+/* Align . to a 8 byte boundary equals to maximum function alignment. */
+#define ALIGN_FUNCTION()  . = ALIGN(8)
+
 #define RODATA								\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		*(.rodata) *(.rodata.*)					\
@@ -79,12 +82,18 @@
 		VMLINUX_SYMBOL(__security_initcall_end) = .;		\
 	}

+/* sched.text is aling to function alignment to secure we have same
+ * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
+		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
 		VMLINUX_SYMBOL(__sched_text_end) = .;

+/* spinlock.text is aling to function alignment to secure we have same
+ * address even at second ld pass when generating System.map */
 #define LOCK_TEXT							\
+		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__lock_text_start) = .;			\
 		*(.spinlock.text)					\
 		VMLINUX_SYMBOL(__lock_text_end) = .;


--------------090002090905000106050406--
