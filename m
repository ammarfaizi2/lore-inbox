Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423726AbWJaSJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423726AbWJaSJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423728AbWJaSJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:09:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:30287 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423726AbWJaSJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:09:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P12cVdSoQ9cDUnZ6EnnVXISGMajOGFtRGiaGlzmvi9UhgUenWP1zRWWZ/SnPA9KHtmwOrHEQ7I6S7hmsdHFpiqtwRJ+naeyucWVPg/UkuFZVt8uUP0a/q1cqf4hw1M/6mwha4WLqsSoucBbTbyYjXZtzRAPv1PacHS1joCgniiE=
Message-ID: <787b0d920610311009i17b4101cg85229603df64880e@mail.gmail.com>
Date: Tue, 31 Oct 2006 13:09:26 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andi Kleen" <ak@suse.de>
Subject: [PATCH] SA_SIGINFO was forgotten
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change to make x86_64 support i386 binaries compiled
with -mregparm=3 only covered signal handlers without SA_SIGINFO.
(the 3-arg "real-time" ones)

To be compatible with i386, both types should be supported.

Signed-off-by: Albert Cahalan <acahalan@gmail.com>

diff -Naurd old/arch/x86_64/ia32/ia32_signal.c
new/arch/x86_64/ia32/ia32_signal.c
--- old/arch/x86_64/ia32/ia32_signal.c  2006-10-29 20:36:01.000000000 -0500
+++ new/arch/x86_64/ia32/ia32_signal.c  2006-10-29 21:58:01.000000000 -0500
@@ -579,6 +579,11 @@
       regs->rsp = (unsigned long) frame;
       regs->rip = (unsigned long) ka->sa.sa_handler;

+       /* Make -mregparm=3 work */
+       regs->rax = sig;
+       regs->rdx = (unsigned long) &frame->info;
+       regs->rcx = (unsigned long) &frame->uc;
+
       asm volatile("movl %0,%%ds" :: "r" (__USER32_DS));
       asm volatile("movl %0,%%es" :: "r" (__USER32_DS));
