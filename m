Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVG3B4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVG3B4e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVG3ByO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:54:14 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:58548 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262913AbVG3Bxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 21:53:46 -0400
X-ORBL: [67.125.168.38]
Message-ID: <42EADDA8.3080604@pacbell.net>
Date: Fri, 29 Jul 2005 18:53:44 -0700
From: Mickey Stein <yekkim@pacbell.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cal Peake <cp@absolutedigital.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.13-rc4
References: <42EA1C8D.8080708@pacbell.net> <Pine.LNX.4.61.0507291456550.2566@lancer.cnet.absolutedigital.net>
In-Reply-To: <Pine.LNX.4.61.0507291456550.2566@lancer.cnet.absolutedigital.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake wrote:

>On Fri, 29 Jul 2005, Mickey Stein wrote:
>
>  
>
>>This is regarding *-rc4 and *-rc4-git1:  I slapped together my favorite config
>>and gave it a test run. It had a bit of a problem and ground to a halt after
>>spewing these into the log.
>>
>>If I can find the time tomorrow morning, I'll leave parport_pc commented out
>>of modprobe.conf and see if something else pops loose. I don't use the
>>parallel port, but I try to keep a fairly robust config for noticing bugs.
>>    
>>
>
>Hi Mick,
>
>Can you please try the patch below from Linus (or -git2 tomorrow) and 
>confirm that it fixes it for you?
>
>thx,
>-cp
>
>--- a/include/asm-i386/bitops.h
>+++ b/include/asm-i386/bitops.h
>@@ -335,14 +335,13 @@ static inline unsigned long __ffs(unsign
> static inline int find_first_bit(const unsigned long *addr, unsigned size)
> {
> 	int x = 0;
>-	do {
>-		if (*addr)
>-			return __ffs(*addr) + x;
>-		addr++;
>-		if (x >= size)
>-			break;
>+
>+	while (x < size) {
>+		unsigned long val = *addr++;
>+		if (val)
>+			return __ffs(val) + x;
> 		x += (sizeof(*addr)<<3);
>-	} while (1);
>+	}
> 	return x;
> }
> 
>  
>
Linus Torvalds wrote:

>On Fri, 29 Jul 2005, Mickey Stein wrote:
>  
>
>>I've been quite low on time lately, so perhaps I missed something 
>>obvious in the notes. When I did the "$make xconfig" , there were no 
>>warnings about changes or new config params.
>>    
>>
>
>Does this fix it for you? (Already in the current git tree)
>
>		Linus
>---
>diff --git a/include/asm-i386/bitops.h b/include/asm-i386/bitops.h
>--- a/include/asm-i386/bitops.h
>+++ b/include/asm-i386/bitops.h
>@@ -335,14 +335,13 @@ static inline unsigned long __ffs(unsign
> static inline int find_first_bit(const unsigned long *addr, unsigned size)
> {
> 	int x = 0;
>-	do {
>-		if (*addr)
>-			return __ffs(*addr) + x;
>-		addr++;
>-		if (x >= size)
>-			break;
>+
>+	while (x < size) {
>+		unsigned long val = *addr++;
>+		if (val)
>+			return __ffs(val) + x;
> 		x += (sizeof(*addr)<<3);
>-	} while (1);
>+	}
> 	return x;
> }
> 
>
>  
>
I'm running on *-rc4 at the moment, so thanks very much for the patch.

I think there were ~3 of my modules producing similar output, but after 
I followed someone's advice about enabling most of the CONFIG_DEBUG_* 
switches, I experienced quite a bit more trouble getting anything to log 
(or do anything but freeze). Now, all the modules are loading fine.

If I get time I'll probably be asking which of the 9 or 10 CONFIG_DEB* 
switches are compatible with one another, but actually it may have just 
been the same bug that would hang me up when they were on. I'll test 
with the full CONFIG_DEBUG .config later on.

Appreciate it,

Mick
