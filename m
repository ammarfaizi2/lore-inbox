Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUAJRjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUAJRji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:39:38 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:28298 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265276AbUAJRja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:39:30 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 10 Jan 2004 09:39:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Bart Samwel <bart@samwel.tk>
cc: Tim Cambrant <tim@cambrant.com>, Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
In-Reply-To: <40003655.3010702@samwel.tk>
Message-ID: <Pine.LNX.4.44.0401100938270.1798-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Bart Samwel wrote:

> Tim Cambrant wrote:
> > On Sat, Jan 10, 2004 at 04:40:30PM +0100, Mario Vanoni wrote:
> > 
> >>Compiling the kernel under 2.6.1-mm2, gcc-3.3.2
> >>(same messages as under 2.6.1-rc1-mm1, re-tested),
> >>
> >>arch/i386/boot/setup.S: Assembler messages:
> >>arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 
> >>0x37ffffff
> > 
> > This is apparently a known problem and has existed for a long time,
> > but no-one has fixed it for some reason. I asked the exacly same
> > question a few months ago, and someone told me that this issue has
> > been around forever, but is noticed under 2.6, since it is less
> > verbose during the compilation. I'll pass the message that was told
> > to me: If you've got a fix, it would surely be included in the kernel.
> 
> The problem is in the MAXMEM macro. This macro takes the inverse of a 
> positive number, subtracts another number, and the negative result 
> overflows the negative range of a 32-bit integer. The assembler 
> truncates it, but apparently it can't print overly negative numbers 
> correctly, that's why it looks so strange.
> 
> My proposed fix is attached: change the macro to subtract the numbers 
> from 0xFFFFFFFF, and then add 1 at the end. That yields the same result, 
> but without going through a negative intermediate value that needs to be 
> truncated.
> 
> -- Bart
> 
> 
> 
> --- page.h.orig	2004-01-10 18:15:17.000000000 +0100
> +++ page.h	2004-01-10 18:15:47.000000000 +0100
> @@ -123,7 +123,7 @@
> 
>   #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
>   #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
> -#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
> +#define MAXMEM			(0xFFFFFFFF-__PAGE_OFFSET-__VMALLOC_RESERVE+1)

Try:

#define MAXMEM                       (~__PAGE_OFFSET + 1 - __VMALLOC_RESERVE)



- Davide


