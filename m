Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVARB3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVARB3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVARBUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:20:32 -0500
Received: from tankkeri.nobman.com ([217.77.196.199]:988 "EHLO
	tankkeri.nobman.com") by vger.kernel.org with ESMTP id S262835AbVARBPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:15:16 -0500
Date: Tue, 18 Jan 2005 03:12:45 +0200
From: Juho Snellman <jsnell@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: x86-64: int3 no longer causes SIGTRAP in 2.6.10
Message-ID: <20050118011244.GA23256@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.10 changed the behaviour of the int3 instruction on x86-64. It
used to result in a SIGTRAP, now it's a SIGSEGV in both native and
32-bit legacy modes. This was apparently caused by the kprobe port,
specifically this part:

--- a/arch/x86_64/kernel/traps.c        2004-12-24 13:36:17 -08:00
+++ b/arch/x86_64/kernel/traps.c        2004-12-24 13:36:17 -08:00
@@ -862,8 +910,8 @@
        set_intr_gate(0,&divide_error);
        set_intr_gate_ist(1,&debug,DEBUG_STACK);
        set_intr_gate_ist(2,&nmi,NMI_STACK);
-       set_system_gate(3,&int3);       /* int3-5 can be called from all */
-       set_system_gate(4,&overflow);
+       set_intr_gate(3,&int3);
+       set_system_gate(4,&overflow);   /* int4-5 can be called from all */

Was effectively disabling int3 a conscious decision, or just an
unintended side-effect? This breaks at least Steel Bank Common Lisp
(x86 and x86-64) and CMU Common Lisp (x86), which use int3 for error
traps and breakpoints.

Simple test case:

% cat foo.c  
int main (void) {
    asm("int3");
    return 0;
}
% gcc -o foo foo.c
% ./foo
zsh: trace trap  ./foo
% gcc -m32 -o foo-32 foo.c
% ./foo-32
zsh: trace trap  ./foo-32

[ reboot ]

% uname -a
Linux kiki 2.6.10 #2 Sun Dec 26 04:54:05 EET 2004 x86_64 x86_64 x86_64
% ./foo
zsh: segmentation fault  ./foo
% ./foo-32
zsh: segmentation fault  ./foo-32

-- 
Juho Snellman
