Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVBUNGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVBUNGf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 08:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVBUNGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 08:06:35 -0500
Received: from smtp-out.fr.clara.net ([212.43.194.59]:9375 "EHLO
	smtp-out.fr.clara.net") by vger.kernel.org with ESMTP
	id S261965AbVBUNGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 08:06:30 -0500
Message-ID: <4219DCCA.1090509@idtect.com>
Date: Mon, 21 Feb 2005 14:06:18 +0100
From: Charles-Edouard Ruault <ce@idtect.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org, akpm@osdl.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Reserve only needed regions for PC timers on i386 and x86_64
References: <420734DC.4020900@idtect.com> <1108487045.4618.12.camel@localhost.localdomain>
In-Reply-To: <1108487045.4618.12.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020503000707020002010103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020503000707020002010103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

>On Llu, 2005-02-07 at 09:29, Charles-Edouard Ruault wrote:
>  
>
>>- Why is the generic timer using this address ? isn't it reserving a too 
>>wide portion of IO ports ? Should it be modified for this board ?
>>    
>>
>
>It just reserved the entire chip space since way back when.
>
>  
>
>>-  If there's a good reason for the timer to request this address, is  
>>there a clean way to share it with the timer ?
>>    
>>
>
>Submit a small patch to Linus/Andrew to make the generic code only
>reserve the ports it should. It's just a historical oversight
>
>  
>
Linus, Andrew,
As suggested by Alan, here's a small patch against kernel 2.4.29 to 
split the IO addresses reserved for the  PC timer into two regions 
instead of a large one.
It mimics what has been done in kernel 2.6.
Instead of reserving 0x40 through 0x5f it reserves only what the two 
timers need, i.e 0x40-0x43 and 0x50-0x53.
It patches both i386 and x86_64 architecture.

Please CC me in replies since i did not subscribe to the list.

-- 
Charles-Edouard Ruault
Idtect SA
115 rue Reaumur - 75002, Paris, France
Tel: +33-1-55-34-76-65
Fax: +33-1-55-34-76-75
Web: http://www.idtect.com


--------------020503000707020002010103
Content-Type: text/plain;
 name="i386-x86_64-timer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-x86_64-timer.patch"

--- linux/arch/i386/kernel/setup.c.orig	Fri Feb 18 18:46:55 2005
+++ linux/arch/i386/kernel/setup.c	Mon Feb 21 11:19:45 2005
@@ -354,7 +354,8 @@
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
 	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
+	{ "timer0", 0x40, 0x43, IORESOURCE_BUSY },
+	{ "timer1", 0x50, 0x53, IORESOURCE_BUSY },
 	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
 	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
 	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
--- linux/arch/x86_64/kernel/setup.c.orig	Mon Feb 21 11:56:11 2005
+++ linux/arch/x86_64/kernel/setup.c	Mon Feb 21 11:54:41 2005
@@ -93,7 +93,8 @@
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
 	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
-	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
+	{ "timer0", 0x40, 0x43, IORESOURCE_BUSY },
+	{ "timer1", 0x50, 0x53, IORESOURCE_BUSY },
 	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
 	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
 	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },

--------------020503000707020002010103--
