Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVLZT6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVLZT6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVLZT6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:58:12 -0500
Received: from [85.8.13.51] ([85.8.13.51]:30391 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932128AbVLZT6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:58:11 -0500
Message-ID: <43B04B43.5080705@drzeus.cx>
Date: Mon, 26 Dec 2005 20:57:55 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][MMC] Buggy cards need to leave programming state
References: <43AFEDF8.2060404@drzeus.cx> <20051226191307.GA17191@flint.arm.linux.org.uk>
In-Reply-To: <20051226191307.GA17191@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Dec 26, 2005 at 02:19:52PM +0100, Pierre Ossman wrote:
>   
>> I've gotten two reports for cards that just crap out during write
>> transfers. The solution I've given them is to make the mmc block layer
>> wait for the card to leave programming state.
>>     
>
> This is interesting.  In the specs I have, they indicate that the
> correct behaviour of a MMC card for CMD24 (write block) is that
> when its write buffer is full, it will hold the DAT signal low to
> indicate "busy" to the host controller.
>
> Now, the ARM MMCI holds the data path in the "BUSY" state while
> the MMC card asserts this indication, so we don't complete the
> data transfer until the card says it's not busy.
>
> For PXAMCI, it looks like we aren't waiting for the indication
> from the host which tells us that the "BUSY" has cleared.
>
> Does wbsd wait for the DAT busy signal to de-assert?
>   

I don't think so. We wait for the controller to leave 'block mode', but
the spec isn't clear if this includes waiting for the busy signal. There
is another bit for explicitly checking the busy bit. I can see if I can
get the bug reporters to try it out.

Doesn't the busy status map directly to the programming state anyhow?

> However, I do note that from the October dump, the card is
> reporting that it is ready for more data (bit 8):
>
>   

That's what got me thinking that waiting for it to leave programming
state is the way to go.

> MMC: req done (0d): 0: 00000f00 4b000000 00000000 00000000
>
> whereas it's impossible to tell with the November dump because
> the useful information has been edited out.  Hence the November
> dump is rather useless.
>
>   

What seems to be missing?

Rgds
Pierre

