Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUAJVEw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbUAJVEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:04:52 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:26251 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265463AbUAJVEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:04:50 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 10 Jan 2004 13:04:47 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Bart Samwel <bart@samwel.tk>
cc: Tim Cambrant <tim@cambrant.com>, Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
In-Reply-To: <40005EA5.6070406@samwel.tk>
Message-ID: <Pine.LNX.4.44.0401101243110.2210-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Bart Samwel wrote:

> >>--- page.h.orig	2004-01-10 18:15:17.000000000 +0100
> >>+++ page.h	2004-01-10 18:15:47.000000000 +0100
> >>@@ -123,7 +123,7 @@
> >>
> >>  #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
> >>  #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
> >>-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
> >>+#define MAXMEM			(0xFFFFFFFF-__PAGE_OFFSET-__VMALLOC_RESERVE+1)
> > 
> > 
> > Try:
> > 
> > #define MAXMEM                       (~__PAGE_OFFSET + 1 - __VMALLOC_RESERVE)
> 
> I tried that first, before I came up with the solution in the patch, 
> because I didn't like the dependency of 0xFFFFFFFF being 32-bit. It was 
> a nice idea, but it didn't work. Apparently, gas interprets ~ as a one's 
> complement negation operator, not a bitwise or. Therefore, 
> ~__PAGE_OFFSET is just as negative as -__PAGE_OFFSET as far as gas is 
> concerned. It gives me the same warning.

That would mean a bug in as. __PAGE_OFFSET is unsigned and ~ is documented 
(not a surprise) as "bitwise not". The bitwise not of __PAGE_OFFSET 
(unsigned) is still unsigned. BTW 2.14 does not give warnings with both 
the original statement and the ~ one. This:

                                                                                                                        
        PG=0xC0000000                                                                                                   
        VM=(128 << 20)                                                                                                  
                                                                                                                        
        mov (~PG + 1 - VM), %eax                                                                                        
        mov (-PG - VM), %eax                                                                                            
                                                                                                                        
generate this:

zzzzzzzz:     file format elf32-i386

Disassembly of section .text:

00000000 <.text>:
   0:   a1 00 00 00 38          mov    0x38000000,%eax
   5:   a1 00 00 00 38          mov    0x38000000,%eax


w/out any warnings. And the result is obviously 0x38000000 and 
not 0x37ffffff.



- Davide



