Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWICKD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWICKD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 06:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWICKD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 06:03:57 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:36491 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751159AbWICKD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 06:03:56 -0400
Message-ID: <44FAA88C.9040401@drzeus.cx>
Date: Sun, 03 Sep 2006 12:03:56 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060903074101.77116.qmail@web36707.mail.mud.yahoo.com>
In-Reply-To: <20060903074101.77116.qmail@web36707.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
>> tifm_sd_fetch_resp() could be redone as a for loop
>> to make it more
>> obvious what's going on.
>>     
> I'm not sure it's a good idea. The response value is
> returned in 8 16-bit registers, which are mapped over
> 8 32-bit registers (so that only LS part of each
> register is valid). Additionally, the fetch order is
> reversed, so cmd->resp[0] is fetched from offsets 24
> and 28, while cmd->resp[3] is fetched from offsets 0
> and 4. To write this as a loop requires moderately
> complex address calculation that may look even less
> obvious.
>
>   

I suppose it's a matter of taste, but personally I think the mere
mentioning of 'for' allows you to directly see that there is some kind
of looping involved. And it shouldn't be terribly complex:

for (i = 0;i < 8;i++) {
    resp[i] = readw(addr + RESPONSE + (7 - i)*4) << 16;
    resp[i] |= readw(addr + RESPONSE + (6 - i)*4);
}

>> You should probably rename tifm_sd_set_data_to(). It
>> isn't obvious that
>> 'to' stands for 'timeout'. Same thing with other
>> instances of 'to'.
>>     
> I agree, yet I wanted to retain the names of the
> registers as defined in datasheet (so it's easier to
> search for them; for some reason it always abbreviates
> timeout as TO). Apparently TI does the same in their
> drivers.
>
>   

The problem is that it's a big difference between seeing "data TO" and
seeing "data to" in the code. How about using the three letter
abbreviations in those places? I.e. "cto" and "dto"?

>> What I'd like to see from you is to double check
>> that bytes_xfered is
>> set to the number of bytes successfully sent to the
>> _card_, not the
>> controller. This is critical for correct handling of
>> bus errors.
>>     
> The OMAP datasheet is somewhat unclear, but I think
> that block and byte counters truly represent the
> amount of data shifted out to the mmc bus. Whether
> this data really reaches the flash memory I don't know
> to tell.
>
>   

Hmm.... I'm planning on putting together a test module to determine this
(as my specs aren't crystal clear on the subject either). I'll try to
remember to send it to you. :)

Rgds
Pierre


-- 
VGER BF report: U 0.5
