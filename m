Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbUKBXwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbUKBXwf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbUKBXve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:51:34 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:31877
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S261818AbUKBXnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:43:14 -0500
Subject: [patch 1/1] ptrace POKEUSR: add comment about the DR7 check.
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it,
       roland@redhat.com, ak@suse.de
From: blaisorblade_spam@yahoo.it
Date: Wed, 03 Nov 2004 00:20:26 +0100
Message-Id: <20041102232026.6D4AE4F6D7@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Roland McGrath <roland@redhat.com>, Andi Kleen <ak@suse.de>

(Please CC me on replies as I'm not subscribed).

The DR7 register on i386/x86_64 has a special meaning, so there is a special
check to do. Since the code is rather difficult, I added an explaination about
it. Also, while studying the i386 Intel Manual, I saw that x86_64, even on
32bit emulation, allows using values which are disallowed on i386. It's almost
obvious that what it allows is setting a 8-byte wide data watchpoint (in fact
I double checked the AMD manuals, just in case, and this is true; I couldn't
find a mention of this in my Intel manuals).

But since the original ia32 emulation code has this comment:

	/* You are not expected to understand this ... I don't neither. */

I am dubious that the code in ptrace32.c is wrong: does x86_64 supports
8byte-wide watchpoints in 32-bit emulation? I've checked the AMD manual Vol.
2 (no. 24593), which says that to set the length to 8 bits "long mode must be
enabled". This means, actually, that the current code is safe, notwithstanding
the comment (which I removed).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c   |   30 ++++++++++++++++++
 vanilla-linux-2.6.9-paolo/arch/x86_64/ia32/ptrace32.c |    3 +
 vanilla-linux-2.6.9-paolo/arch/x86_64/kernel/ptrace.c |    2 +
 3 files changed, 34 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/ia32/ptrace32.c~ptrace-POKEUSR-x86-comment-about-DR7-check arch/x86_64/ia32/ptrace32.c
--- vanilla-linux-2.6.9/arch/x86_64/ia32/ptrace32.c~ptrace-POKEUSR-x86-comment-about-DR7-check	2004-11-03 00:18:17.696539184 +0100
+++ vanilla-linux-2.6.9-paolo/arch/x86_64/ia32/ptrace32.c	2004-11-03 00:18:17.702538272 +0100
@@ -109,7 +109,8 @@ static int putreg32(struct task_struct *
 
 	case offsetof(struct user32, u_debugreg[7]):
 		val &= ~DR_CONTROL_RESERVED;
-		/* You are not expected to understand this ... I don't neither. */
+		/* See arch/i386/kernel/ptrace.c for an explaination of
+		 * this awkward check.*/
 		for(i=0; i<4; i++)
 			if ((0x5454 >> ((val >> (16 + 4*i)) & 0xf)) & 1)
 			       return -EIO;
diff -puN arch/i386/kernel/ptrace.c~ptrace-POKEUSR-x86-comment-about-DR7-check arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ptrace.c~ptrace-POKEUSR-x86-comment-about-DR7-check	2004-11-03 00:18:17.698538880 +0100
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c	2004-11-03 00:18:17.702538272 +0100
@@ -345,6 +345,36 @@ asmlinkage int sys_ptrace(long request, 
 			  if(addr < (long) &dummy->u_debugreg[4] &&
 			     ((unsigned long) data) >= TASK_SIZE-3) break;
 			  
+			  /* Sanity-check data. Take one half-byte at once with
+			   * check = (val >> (16 + 4*i)) & 0xf. It contains the
+			   * R/Wi and LENi bits; bits 0 and 1 are R/Wi, and bits
+			   * 2 and 3 are LENi. Given a list of invalid values,
+			   * we do mask |= 1 << invalid_value, so that
+			   * (mask >> check) & 1 is a correct test for invalid
+			   * values.
+			   *
+			   * R/Wi contains the type of the breakpoint /
+			   * watchpoint, LENi contains the length of the watched
+			   * data in the watchpoint case.
+			   *
+			   * The invalid values are:
+			   * - LENi == 0x10 (undefined), so mask |= 0x0f00.
+			   * - R/Wi == 0x10 (break on I/O reads or writes), so
+			   *   mask |= 0x4444.
+			   * - R/Wi == 0x00 && LENi != 0x00, so we have mask |=
+			   *   0x1110.
+			   *
+			   * Finally, mask = 0x0f00 | 0x4444 | 0x1110 == 0x5f54.
+			   *
+			   * See the Intel Manual "System Programming Guide",
+			   * 15.2.4
+			   *
+			   * Note that LENi == 0x10 is defined on x86_64 in long
+			   * mode (i.e. even for 32-bit userspace software, but
+			   * 64-bit kernel), so the x86_64 mask value is 0x5454.
+			   * See the AMD manual no. 24593 (AMD64 System
+			   * Programming)*/
+
 			  if(addr == (long) &dummy->u_debugreg[7]) {
 				  data &= ~DR_CONTROL_RESERVED;
 				  for(i=0; i<4; i++)
diff -puN arch/x86_64/kernel/ptrace.c~ptrace-POKEUSR-x86-comment-about-DR7-check arch/x86_64/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/x86_64/kernel/ptrace.c~ptrace-POKEUSR-x86-comment-about-DR7-check	2004-11-03 00:18:17.699538728 +0100
+++ vanilla-linux-2.6.9-paolo/arch/x86_64/kernel/ptrace.c	2004-11-03 00:18:17.703538120 +0100
@@ -323,6 +323,8 @@ asmlinkage long sys_ptrace(long request,
 			ret = 0;
 			break;
 		case offsetof(struct user, u_debugreg[7]):
+			/* See arch/i386/kernel/ptrace.c for an explaination of
+			 * this awkward check.*/
 				  data &= ~DR_CONTROL_RESERVED;
 				  for(i=0; i<4; i++)
 					  if ((0x5454 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
_
