Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbUBVUl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUBVUl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:41:29 -0500
Received: from terminus.zytor.com ([63.209.29.3]:53139 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261749AbUBVUl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:41:28 -0500
Message-ID: <403913F0.2040001@zytor.com>
Date: Sun, 22 Feb 2004 12:41:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net> <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz> <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org> <c1b2f9$sfj$1@terminus.zytor.com> <Pine.LNX.4.58.0402221230390.1395@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402221230390.1395@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out wrmsr64() and rdmsr64() is already in the code, except 
they're called wrmsrl() and rdmsrl().

So I'd suggest the following:

Index: microcode.c
===================================================================
RCS file: /home/hpa/kernel/bkcvs/linux-2.5/arch/i386/kernel/microcode.c,v
retrieving revision 1.27
diff -u -r1.27 microcode.c
--- microcode.c 19 Feb 2004 04:48:45 -0000      1.27
+++ microcode.c 22 Feb 2004 20:40:30 -0000
@@ -371,9 +371,8 @@
         spin_lock_irqsave(&microcode_update_lock, flags);

         /* write microcode via MSR 0x79 */
-       wrmsr(MSR_IA32_UCODE_WRITE,
-               (unsigned long) uci->mc->bits,
-               (unsigned long) uci->mc->bits >> 16 >> 16);
+       /* Note: unsigned long is 32 bits on i386, 64 bits on x86-64 */
+       wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long) uci->mc->bits);
         wrmsr(MSR_IA32_UCODE_REV, 0, 0);

         __asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");

