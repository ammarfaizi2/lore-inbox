Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWB0WcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWB0WcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWB0Wbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:55 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2944 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932087AbWB0Wbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:37 -0500
Message-Id: <20060227223316.558197000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:01 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Tom Rini <trini@kernel.crashing.org>, Paul Janzen <pcj@linux.sez.to>,
       Paul Mackerras <paulus@samba.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 01/39] ppc32: Put cache flush routines back into .relocate_code section
Content-Disposition: inline; filename=ppc32-put-cache-flush-routines-back-into-.relocate_code-section.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

[PATCH] ppc32: Put cache flush routines back into .relocate_code section

In 2.6.14, we had the following definition of _GLOBAL() in
include/asm-ppc/processor.h:

#define _GLOBAL(n)\
        .stabs __stringify(n:F-1),N_FUN,0,0,n;\
        .globl n;\
n:

In 2.6.15, as part of the great powerpc merge, we moved this definition to
include/asm-powerpc/ppc_asm.h, where it appears (to 32-bit code) as:

#define _GLOBAL(n)      \
        .text;          \
        .stabs __stringify(n:F-1),N_FUN,0,0,n;\
        .globl n;       \
n:

Mostly, this is fine.  However, we also have the following, in
arch/ppc/boot/common/util.S:

        .section ".relocate_code","xa"
[...]
_GLOBAL(flush_instruction_cache)
[...]
_GLOBAL(flush_data_cache)
[...]

The addition of the .text section definition in the definition of
_GLOBAL overrides the .relocate_code section definition.  As a result,
these two functions don't end up in .relocate_code, so they don't get
relocated correctly, and the boot fails.

There's another suspicious-looking usage at kernel/swsusp.S:37 that
someone should look into.  I did not exhaustively search the source
tree, though.

The following is the minimal patch that fixes the immediate problem.
I could easily be convinced that the _GLOBAL definition should be
modified to remove the ".text;" line either instead of, or in addition
to, this fix.

Signed-off-by: Paul Janzen <pcj@linux.sez.to>
Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/ppc/boot/common/util.S |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.15.3.orig/arch/ppc/boot/common/util.S
+++ linux-2.6.15.3/arch/ppc/boot/common/util.S
@@ -234,7 +234,8 @@ udelay:
  * First, flush the data cache in case it was enabled and may be
  * holding instructions for copy back.
  */
-_GLOBAL(flush_instruction_cache)
+        .globl flush_instruction_cache
+flush_instruction_cache:
 	mflr	r6
 	bl	flush_data_cache
 
@@ -279,7 +280,8 @@ _GLOBAL(flush_instruction_cache)
  * Flush data cache
  * Do this by just reading lots of stuff into the cache.
  */
-_GLOBAL(flush_data_cache)
+        .globl flush_data_cache
+flush_data_cache:
 	lis	r3,cache_flush_buffer@h
 	ori	r3,r3,cache_flush_buffer@l
 	li	r4,NUM_CACHE_LINES

--
