Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262254AbSIZJMH>; Thu, 26 Sep 2002 05:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262257AbSIZJMH>; Thu, 26 Sep 2002 05:12:07 -0400
Received: from [217.167.51.129] ([217.167.51.129]:46333 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S262254AbSIZJMG>;
	Thu, 26 Sep 2002 05:12:06 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH] fix ide-iops for big endian archs
Date: Thu, 26 Sep 2002 00:44:28 +0200
Message-Id: <20020925224428.5676@192.168.4.1>
In-Reply-To: <Pine.LNX.4.33.0209251120590.1817-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0209251120590.1817-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Wed, 25 Sep 2002, Benjamin Herrenschmidt wrote:
>> --- 1.1/drivers/ide/ide-iops.c	Wed Sep 11 08:54:11 2002
>> +++ edited/drivers/ide/ide-iops.c	Wed Sep 25 14:19:58 2002
>> @@ -54,12 +54,20 @@
>>  
>>  static inline void ide_insw (u32 port, void *addr, u32 count)
>>  {
>> +#ifdef __BIG_ENDIAN
>> +	insw(port, addr, count);
>> +#else	
>>  	while (count--) { *(u16 *)addr = IN_WORD(port); addr += 2; }
>> +#endif	
>
>If insw is correct on big-endian, then it sure as hell should be correct 
>on little-endian. I don't understand why we wouldn't use insw on PC's, 
>since it's smaller and much more traditional.

Well, i'm pretty sure it is, though I didn't want to post a patch
affecting what currently work, I prefer letting you or other
x86 addicts figure that out :)

In the case of ide_inswp though, there is a real problem as there
is no equivalent of the "p" functions on non-x86 anyway, and you
can't easily reproduce the "insw" semantics with {in,out}{w,l}
without adding useless double-byteswap on BE. But on the other
hand, the IDE layer doesn't use ide_inswp() callback, and the
case where "p" functions are used is currently broken on BE
as well (see ide_{input,output}_data when drive->slow is true).

I suggest that you get this patch in asap (eventually swithing
to insw unconditionally in ide_insw) so at least 2.5 works again
properly on BE, further cleanup of the iops is pending, I'm waiting
for Alan own experiments before I push again my own that remove
all "p" iops and all of the {IN,OUT}{BYTE,WORD,LONG} macros.

Ben.
 

