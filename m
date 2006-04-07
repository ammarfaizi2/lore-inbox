Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWDGQom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWDGQom (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWDGQol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:44:41 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:21045 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932458AbWDGQok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:44:40 -0400
In-Reply-To: <200604070854.41383.david-b@pacbell.net>
References: <Pine.LNX.4.44.0604061329550.20620-100000@gate.crashing.org> <200604062222.05661.david-b@pacbell.net> <CE7ECCE7-ADF7-40B7-8B37-5046D9505F1C@kernel.crashing.org> <200604070854.41383.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <432A7C6D-6AA8-4D7A-92D7-156FD24908E3@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] spi: Added spi master driver for Freescale MPC83xx SPI controller
Date: Fri, 7 Apr 2006 11:44:36 -0500
To: David Brownell <david-b@pacbell.net>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 7, 2006, at 10:54 AM, David Brownell wrote:

>
>>> Hmm, it will of course be overridden as soon as needed, but  
>>> shouldn't
>>> that default be "inactive low" clock?  SPI mode 0 that is.  That
>>> stands
>>> out mostly because you were interpreting CPOL=0 as inactive high,  
>>> and
>>> that's not my understanding of how that signal works...
>>
>> I'll change it, not sure what I was thinking but SPI mode 0 being the
>> default makes sense.
>
> The default doesn't really matter, since it will be overridden ...  
> I was
> more concerned about CPOL=0 being misinterpreted ...

Gotcha, I see that I am misinterpreting CPOL/CPHA so I'll fix that up.

>>> ... here you use "__be32" not "u32", and no "__iomem"  
>>> annotation.  So
>>> this is inconsistent with the declaration above.  Note that if you
>>> just made this "&bank->regname" you'd be having the compiler do any
>>> offset calculation magic, and the source code will be more obvious.
>>
>> Yep, I know what you mean.
>
> Good rule of thumb:  run "sparse -Wbitwise" on your drivers, and  
> have it
> tell you about goofed up things.  (Assuming the asm-ppc headers are  
> safe
> to run that on!)  It's nice having tools tell you about bugs before  
> you
> run into them "live", and GCC only goes so far.

Yeah, forgot to run sparse the first time.

>>>> +static
>>>> +int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct
>>>> spi_transfer *t)
>>>> +{
>>>> +	struct mpc83xx_spi *mpc83xx_spi;
>>>> +	u32 regval;
>>>> +	u32 len = t->bits_per_word - 1;
>>>> +
>>>> +	if (len == 32)
>>>> +		len = 0;
>>>
>>> So the hardware handles 1-33 bit words?  It'd be good to filter
>>> the spi_setup() path directly then, returning EINVAL for illegal
>>> word lengths (and clock speeds).
>>
>> Uhh, no.  The HW supports 4-bit to 32-bit words.  However the
>> encoding of 32-bit is 0 in the register field, and 8-bit is a value
>> of 7, etc.. (bit encodings 1 & 2 are invalid).
>
> So that test should be "len == 31" too ...

Good catch, I had it testing bits_per_word directly before.   
Actually, we support 4-bit to 16-bit, and 32-bit transfers.

>> I'm not following you on spi_setup(), but I think you mean to error
>> change bits_per_word there and return EINVAL if its not one we  
>> support.
>
> Yes, but do it early:  provide your own code to implement spi_setup 
> (), which
> makes a range test and then either fails immediately or else  
> delegates the
> rest of the work to spi_bitbang_setup() ... rather than only using  
> that as
> the default.
>
> Your current code would claim to accept transfers with 64 bit words,
> but it wouldn't actually handle them correctly...

Right.  However, do you think its really necessary to implement my  
own spi_setup(), spi_bitbang_setup() is going to call my  
setup_transfer() which will do the range checking for me (and I'll  
need range checking in transfer_setup() anyways).

>>> I guess I'm surprised you're not using txrx_buffers() and having
>>> that whole thing be IRQ driven, so the per-word cost eliminates
>>> the task scheduling.  You already paid for IRQ handling ... why
>>> not have it store the rx byte into the buffer, and write the tx
>>> byte froom the other buffer?  That'd be cheaper than what you're
>>> doing now ... in both time and code.  Only wake up a task at
>>> the end of a given spi_transfer().
>>
>> I dont follow you at all here.  What are you suggesting I do?
>
> Don't do word-at-a-time I/O with spi_bitbang; you're using IRQs, and
> that's oriented towards polling.  Don't fill bitbang->txrx_word[];  
> don't
> use the default spi_bitbang_setup().
>
> Instead, provide your own setup(), and provide bitbang->txrx_buffers.
>
> Then when the generic not-really-bitbang core calls your  
> txrx_buffers(),
> your code would record the "current" spi_transfer buffer pair and  
> length
> then kickstart the I/O by writing the first byte from the TX buffer
> (or maybe zero if there is none).  Wait on some completion event;  
> return
> when the whole transfer has completed (or stopped after an error).
>
> Then the rest will be IRQ driven; you'll care only about "rx word  
> ready"
> or whatever.  When you get that IRQ, read the word ... and if there's
> an RX buffer, store it in the next location (else discard it).   
> Decrement
> the length (by 1, 2, or 4 bytes).  If length is nonzero, kickstart the
> next step by writing the next word from the TX buffer (or zero).  When
> length is zero, trigger txrx_buffers() completion.  Return from IRQ  
> handler.
>
> See for example how bitbang_txrx_8() works; you'd basically be  
> doing that
> as an irq-driven copy, instead of polling txrx_word().  The first  
> version
> of your IRQ handler might be easier if it only handles 4-8 bit words,
> leaving 9-16 bits (and 17-32 bits) till later.

Maybe I'm missing where the polling is occurring now, but I felt like  
I was effectively doing what you are describing.



