Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVAVH4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVAVH4T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 02:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVAVH4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 02:56:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262679AbVAVH4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 02:56:09 -0500
Date: Fri, 21 Jan 2005 23:56:00 -0800
Message-Id: <200501220756.j0M7u06B021617@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>
X-Fcc: ~/Mail/linus
Subject: [PATCH] PPC: fix stack alignment for signal handlers
X-Shopping-List: (1) Multitudinous treasonous royalty organs
   (2) Ancient important cave incantations
   (3) Joyous fashion furniture
   (4) Radioactive corruption
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both the PPC32 and PPC64 ABIs specify that the stack should be kept aligned
to 16 bytes.  However, signal handlers on PPC64 are getting run with the
stack misaligned (sp % 16 == 8).  This patch fixes that by ensuring that
the signal frame allocated is a multiple of 16 bytes.  The PPC32 signal
frame structures are already sized appropriately, though it may be wise to
put an __attribute__ on them as well to make sure they stay that way.

In addition to the PPC64 signal frame itself being of misaligned size, the
explicit alignment of the starting stack pointer is also to 8 instead of
16.  I've corrected this as well, so signal frames are aligned even if the
interrupted registers contained a misaligned stack pointer.  

For PPC32 signal handlers, while the frame itself was of properly aligned
size, no alignment of the starting stack pointer was done at all, so that a
signal handler can still get a misaligned stack pointer if the interrupted
registers had one, though the kernel isn't gratuitously misaligning good
ones like it is for PPC64.  I added explicit alignment to fix that.

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/ppc64/kernel/signal.c
+++ linux-2.6/arch/ppc64/kernel/signal.c
@@ -67,7 +67,7 @@ struct rt_sigframe {
 	struct siginfo info;
 	/* 64 bit ABI allows for 288 bytes below sp before decrementing it. */
 	char abigap[288];
-};
+} __attribute__ ((aligned (16)));
 
 
 /*
@@ -254,7 +254,7 @@ static inline void __user * get_sigframe
 			newsp = (current->sas_ss_sp + current->sas_ss_size);
 	}
 
-        return (void __user *)((newsp - frame_size) & -8ul);
+        return (void __user *)((newsp - frame_size) & -16ul);
 }
 
 /*
--- linux-2.6/arch/ppc64/kernel/signal32.c
+++ linux-2.6/arch/ppc64/kernel/signal32.c
@@ -626,9 +626,12 @@ static int handle_rt_signal32(unsigned l
 {
 	struct rt_sigframe32 __user *rt_sf;
 	struct mcontext32 __user *frame;
-	unsigned long origsp = newsp;
+	unsigned long origsp;
 	compat_sigset_t c_oldset;
 
+	newsp &= -16UL;	     /* Force the stack to be aligned properly.  */
+	origsp = newsp;
+
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
 	newsp -= sizeof(*rt_sf);
@@ -799,7 +802,10 @@ static int handle_signal32(unsigned long
 {
 	struct sigcontext32 __user *sc;
 	struct sigregs32 __user *frame;
-	unsigned long origsp = newsp;
+	unsigned long origsp;
+
+	newsp &= -16UL;	     /* Force the stack to be aligned properly.  */
+	origsp = newsp;
 
 	/* Set up Signal Frame */
 	newsp -= sizeof(struct sigregs32);
--- linux-2.6/arch/ppc/kernel/signal.c
+++ linux-2.6/arch/ppc/kernel/signal.c
@@ -366,7 +366,10 @@ handle_rt_signal(unsigned long sig, stru
 {
 	struct rt_sigframe __user *rt_sf;
 	struct mcontext __user *frame;
-	unsigned long origsp = newsp;
+	unsigned long origsp;
+
+	newsp &= -16UL;	     /* Force the stack to be aligned properly.  */
+	origsp = newsp;
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
@@ -609,7 +612,10 @@ handle_signal(unsigned long sig, struct 
 {
 	struct sigcontext __user *sc;
 	struct sigregs __user *frame;
-	unsigned long origsp = newsp;
+	unsigned long origsp;
+
+	newsp &= -16UL;	     /* Force the stack to be aligned properly.  */
+	origsp = newsp;
 
 	/* Set up Signal Frame */
 	newsp -= sizeof(struct sigregs);
