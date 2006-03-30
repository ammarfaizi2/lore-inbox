Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWC3MSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWC3MSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWC3MSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:18:53 -0500
Received: from javad.com ([216.122.176.236]:29459 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932149AbWC3MSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:18:52 -0500
From: Sergei Organov <osv@javad.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <20060330112349.11324.qmail@science.horizon.com>
Date: Thu, 30 Mar 2006 16:18:40 +0400
In-Reply-To: <20060330112349.11324.qmail@science.horizon.com>
	(linux@horizon.com's message of "30 Mar 2006 06:23:49 -0500")
Message-ID: <87r74k3z33.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:

>>>>> Due to the multiplexing scheme used in high-density NAND flash devices,
>>>>> even the non-programmed cells are exposed to a fraction of the programming
>>>>> voltage and there are very low limits on the number of write cycles to
>>>>> a page before it has to be erased again.  Exceeding that can cause some
>>>>> unwanted bits to change from 1 to 0.  Typically, however, it is enough
>>>>> to write each 512-byte portion of a page independently.
>>>>
>>>> Well, I'm not sure. The Toshiba and Samsung NANDs I've read manuals for
>>>> seem to limit number of writes to a single page before block erase, --
>>>> is 512-byte portion some implementation detail I'm not aware of?
>>>
>>> No.  I just meant that I generally see "you may program each 2K page a
>>> maximum of 4 times before performing an erase cycle", and I assume the
>>> spec came from 2048/512 = 4, so you can program each 512-byte sector
>>> separately.
>>
>> I've a file system implementation that writes up to 3 times to the first
>> 3 bytes of the first page of a block (clearing more and more bits every
>> time), and it seems to work in practice, so maybe this number (4) came
>> from another source? Alternatively, it works by accident and then I need
>> to reconsider the design.
>
> No, I'm sorry, I was still unclear.  The spec is 4 writes per page.
> I believe that the REASON for this spec was so that people could write
> 512+16 bytes at a time just like they did with small-block devices and
> it would work.

Ah, now (due to your explanation below) I see! But then how do you
explain that those old "small page" devices do support multiple writes
to a single page?

> But I do not believe there is any limitation on the pattern you may use,
> so your system should work fine.
>
> What confuses me is that I thought I said (quoted above; paraphrasing
> here) "there is a very low limit on the number of times you may write
> to a page.  That limit is large enough that you can do pagesize/512 =
> 2048/512 = 4 separate 512-byte writes."  I didn't intend to imply that
> that was the ONLY legal pattern.
>
> But from your comments, I'm getting the impression that you think I did
> say that was the only legal pattern.  If that impression is correct,
> I'm not sure how you read that into my statements.

Well, after your last explanation I'm not sure myself how I've read that
into your statements ;)

> (I wonder if the actual limit is the number of writes per BLOCK, and
> they just expressed it as writes per page.  I don't know enough about
> the programming circuitry to know what's exposed to what voltages.
> If the physics implied it, it would be useful flexibility for file system
> design.)

I doubt block is relevant here, otherwise there seems to be no reason to
introduce "page" as a write unit in the first place. It seems that write
voltage is applied to entire page, and bit 1 in the data indeed leaks
some charge (less than 1/4 of those bit 0 leaks). I think block in this
context is mentioned only because it's impossible to erase single page.

-- Sergei.
