Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbUJZV6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbUJZV6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUJZV6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:58:54 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:21765 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261504AbUJZVzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:55:14 -0400
Message-ID: <417EC7BA.3050604@vmware.com>
Date: Tue, 26 Oct 2004 14:55:06 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, hpa@zytor.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] faster signal handling on x86
Content-Type: multipart/mixed;
 boundary="------------070400020104010700090602"
X-OriginalArrivalTime: 26 Oct 2004 21:55:06.0989 (UTC) FILETIME=[74B041D0:01C4BBA6]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.11; VDF: 6.28.0.39; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070400020104010700090602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I noticed an unneeded write to dr7 in the signal handling path for x86.  
We only need to write to dr7 if there is a breakpoint to re-enable, and 
MOVDR is a serializing instruction, which is expensive.  Getting rid of 
it gets a 33% faster signal delivery path (at least on Xeon - I didn't 
test other CPUs, so your gain may vary).

Cheers,

Zachary Amsden
zach@vmware.com

--------------070400020104010700090602
Content-Type: text/plain;
 name="README.i386-fast-signal"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.i386-fast-signal"

Optimize away the unconditional write to debug registers on signal delivery
path.  This is already done on x86_64.  Measured delta TSC for three paths
on a 2.4GHz Xeon.

1) With unconditional write to dr7 :  800-1000 cycles
2) With conditional write to dr7   :  84-112 cycles
3) With unlikely write to dr7      :  84 cycles

Performance test using divzero microbenchmark (3 million divide by zeros):

With unconditional write: 
   7.445 real / 6.136 system
   7.529 real / 6.482 system
   7.541 real / 5.974 system
   7.546 real / 6.217 system
   7.445 real / 6.167 system

With unlikely write:
   5.779 real / 4.518 system
   5.783 real / 4.591 system
   5.552 real / 4.569 system
   5.790 real / 4.528 system
   5.554 real / 4.382 system

That's about a 33% speedup - more than I expected; apparently getting rid
of the serializing instruction makes the do_signal path much faster.

Zachary Amsden (zach@vmware.com)

--------------070400020104010700090602
Content-Type: text/plain;
 name="i386-fast-signal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-fast-signal.patch"

--- linux-2.6.10-rc1/arch/i386/kernel/signal.c	2004-10-25 11:15:43.000000000 -0700
+++ linux-2.6.10-rc1-nsz/arch/i386/kernel/signal.c	2004-10-26 14:30:54.000000000 -0700
@@ -600,7 +600,9 @@
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		if (unlikely(current->thread.debugreg[7])) {
+			__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		}
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, &info, &ka, oldset, regs);

--------------070400020104010700090602--
