Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263505AbTCNUps>; Fri, 14 Mar 2003 15:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263507AbTCNUps>; Fri, 14 Mar 2003 15:45:48 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:22199 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263505AbTCNUpr>; Fri, 14 Mar 2003 15:45:47 -0500
Date: Fri, 14 Mar 2003 21:56:33 +0100
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Lazy FPU handling in ptrace
Message-ID: <20030314205633.GA7373@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While working on some x86-64 ptrace problems I noticed that i386 
has bugs in this area too. 

Before doing PTRACE_SETFPREGS or PTRACE_SETFPXREGS you need to do
an unlazy_fpu(), otherwise there is no guarantee that the changed
state will be picked up.

Patch for 2.4, but 2.5 seems to have it too.

(untested, but obviously correct ;-)
-Andi 

--- linux-work/arch/i386/kernel/ptrace.c-o	2002-08-08 10:27:42.000000000 +0200
+++ linux-work/arch/i386/kernel/ptrace.c	2003-03-14 21:51:21.000000000 +0100
@@ -381,6 +381,7 @@
 			ret = -EIO;
 			break;
 		}
+		unlazy_fpu(child);
 		child->used_math = 1;
 		set_fpregs(child, (struct user_i387_struct *)data);
 		ret = 0;
@@ -405,6 +406,7 @@
 			ret = -EIO;
 			break;
 		}
+		unlazy_fpu(child);
 		child->used_math = 1;
 		ret = set_fpxregs(child, (struct user_fxsr_struct *)data);
 		break;

