Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318399AbSHEKa3>; Mon, 5 Aug 2002 06:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318401AbSHEKa3>; Mon, 5 Aug 2002 06:30:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26379 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318399AbSHEKa2>; Mon, 5 Aug 2002 06:30:28 -0400
Message-ID: <3D4E536A.9040908@evision.ag>
Date: Mon, 05 Aug 2002 12:28:58 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
References: <1227D1253A2@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Petr Vandrovec napisa?:
> On  5 Aug 02 at 11:33, Marcin Dalecki wrote:
> 
>>Uz.ytkownik Petr Vandrovec napisa?:
>>
>>>   BTW, are there any TRM290 owners using 2.5.30? Old code set length to
>>>((length >> 2) - 1) << 16, while new code does not have special handling
>>>for TRM290. Or do I miss something?
>>
>>The new code is overwriting those values in the host controller driver
>>itself.
> 
> 
> Really? I'm not able to locate such overwrite in trm290.c. Are they hidden
> somewhere else?

This should handle it:

	hwif->seg_boundary_mask = 0xffffffff;
> 
> Also BUG_ON() in udma_new_table is bogus. Change code:
> 
> - u32 cur_len = sg_dma_len(sg) & 0xffff;
> + u32 cur_len = sg_dma_len(sg);
> 
>   /* Delete this ... */
>   BUG_ON(cur_len > ch->max_segment_size);
>   
>   *table++ = cpu_to_le32(cur_addr);
> - *table++ = cpu_to_le32(cur_len);
> + *table++ = cpu_to_le32(cur_len & 0xffff);
> 
> Without first change BUG_ON will not trigger on any transfer: values
> up to 0xFE00 are legal, and values over 0x10000 get cut down to
> 0x0xxxx...
> 
> Second change is needed only if we have some driver setting 
> max_segment_size to value > 0xffff: currently we do not have such driver,
> default is 0xfe00, and value set by cs5530 is 0xfe00 too.

Well trm390 *does* set ->seg_boundary_mask.

>>Hmm... It is very well possible that the Toshiba doesn't like the
>>fact that the intel chipsets cheat and do something like UDMA88 instead 
>>of UDMA100. Could you verify this by checking whatever forcing them to 
>>UDMA66 helps please? Vojtech?
> 
> 
> It happens with UDMA0 too (and I tried slowest possible timming at
> i845, and it still happens).

I'm more and more amanzed, why my system works at all...

> P.S.: Marcin, are you Marcin or Martin? MAINTAINERS says Martin,
> but your replies state Marcin...

It doesn't really matter. Marcin is just the polish spelling of the name
Martin. So choose whatever you want please.


