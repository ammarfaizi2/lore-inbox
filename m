Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVGaUGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVGaUGY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVGaUGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:06:23 -0400
Received: from nevyn.them.org ([66.93.172.17]:52642 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261958AbVGaUGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:06:03 -0400
Date: Sun, 31 Jul 2005 16:05:58 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Fix 32-bit thread debugging on x86_64
Message-ID: <20050731200557.GA4156@nevyn.them.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IA32 ptrace emulation currently returns the wrong registers for
fs/gs; it's returning what x86_64 calls gs_base.  We need regs.gsindex
in order for GDB to correctly locate the TLS area.  Without this patch,
the 32-bit GDB testsuite bombs on a 64-bit kernel.  With it, results
look about like I'd expect, although there are still a handful of
kernel-related failures (vsyscall related?).

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

diff -r -p -u z/linux-2.6.11/arch/x86_64/ia32/ptrace32.c linux-2.6.11/arch/x86_64/ia32/ptrace32.c
--- linux-2.6.12.3.orig/arch/x86_64/ia32/ptrace32.c	2005-03-02 02:37:52.000000000 -0500
+++ linux-2.6.12.3/arch/x86_64/ia32/ptrace32.c	2005-07-31 15:29:48.000000000 -0400
@@ -43,11 +43,11 @@ static int putreg32(struct task_struct *
 	switch (regno) {
 	case offsetof(struct user32, regs.fs):
 		if (val && (val & 3) != 3) return -EIO; 
-		child->thread.fs = val & 0xffff; 
+		child->thread.fsindex = val & 0xffff; 
 		break;
 	case offsetof(struct user32, regs.gs):
 		if (val && (val & 3) != 3) return -EIO; 
-		child->thread.gs = val & 0xffff;
+		child->thread.gsindex = val & 0xffff;
 		break;
 	case offsetof(struct user32, regs.ds):
 		if (val && (val & 3) != 3) return -EIO; 
@@ -138,10 +138,10 @@ static int getreg32(struct task_struct *
 
 	switch (regno) {
 	case offsetof(struct user32, regs.fs):
-	        *val = child->thread.fs; 
+	        *val = child->thread.fsindex;
 		break;
 	case offsetof(struct user32, regs.gs):
-		*val = child->thread.gs;
+		*val = child->thread.gsindex;
 		break;
 	case offsetof(struct user32, regs.ds):
 		*val = child->thread.ds;

-- 
Daniel Jacobowitz
CodeSourcery, LLC
