Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274995AbTHQBeb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 21:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274996AbTHQBeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 21:34:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:7841 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274995AbTHQBea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 21:34:30 -0400
Date: Sat, 16 Aug 2003 18:34:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Richard Henderson <rth@twiddle.net>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <jakub@redhat.com>, <szepe@pinerecords.com>, <jamagallon@able.es>,
       <kwall@kurtwerks.com>, <lcapitulino@prefeitura.sp.gov.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
In-Reply-To: <20030817012551.GB22022@twiddle.net>
Message-ID: <Pine.LNX.4.44.0308161830110.25379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Aug 2003, Richard Henderson wrote:
> 
> Fixed by doing
> 
> 	__asm__ __volatile__("lidt %0": :"m" (*no_idt));

Good catch, although I'd prefer something like this instead (ie change 
"no_idt" to be a real IDT descriptor, like the other ones).

It shouldn't matter all that much, since the only thing that really 
matters is to load the IDT with bogus values, so just about anything 
should do it.

		Linus

--- 1.9/arch/i386/kernel/reboot.c	Mon Aug 11 14:55:58 2003
+++ edited/arch/i386/kernel/reboot.c	Sat Aug 16 18:33:05 2003
@@ -16,7 +16,6 @@
  */
 void (*pm_power_off)(void);
 
-static long no_idt[2];
 static int reboot_mode;
 int reboot_thru_bios;
 
@@ -87,7 +86,9 @@
 	unsigned long long * base __attribute__ ((packed));
 }
 real_mode_gdt = { sizeof (real_mode_gdt_entries) - 1, real_mode_gdt_entries },
-real_mode_idt = { 0x3ff, 0 };
+real_mode_idt = { 0x3ff, 0 },
+no_idt = { 0, 0 };
+
 
 /* This is 16-bit protected mode code to disable paging and the cache,
    switch to real mode and jump to the BIOS reset code.

