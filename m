Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWCaUvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWCaUvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWCaUvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:51:51 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:45602 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932223AbWCaUvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:51:50 -0500
In-Reply-To: <200603311236.02665.david-b@pacbell.net>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311132.06819.david-b@pacbell.net> <3E572FEF-093B-4359-9FC4-45D00B33C993@kernel.crashing.org> <200603311236.02665.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A164CF6D-0330-46A7-ABF2-87127753E048@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 14:52:02 -0600
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


On Mar 31, 2006, at 2:36 PM, David Brownell wrote:

> On Friday 31 March 2006 12:00 pm, Kumar Gala wrote:
>
>> My confusion is about the order of which various things occur.  setup
>> (), chipselect() and transfer() vs what's happening in bitbang_work
>> ().  I don't see how we handle the fact that two different devices
>> may require setup() to be called when we switch between them.
>
> In your case, it sounds like setup() will just store data, and you'll
> want a different method to actually grab that data and use it to stuff
> your controller registers before actually transferring data.  The
> transfer() method just queues transfers (and maybe kicks them off).
>
> Remember that setup() is generally a one-time thing.  Fancier hardware
> will use it to store clock, mode, wordsize, and other parameters into
> a hardware register so that starting a transfer is very quick.  In  
> your
> case, there's no such register, so starting transfers is slower.
>
> One thing to keep in mind is that while I believe the spi_bitbang code
> ought to support controllers like the one you're working with, I don't
> know that anyone has done that yet.  So patches might be necessary.

What I'm looking at is the following:

* use spi_bitbang_setup() as is
* have my chipselect do:
	if (BITBANG_CS_INACTIVE)
		deassert GPIO pin for CS
	else
		set HW mode register (polarity, phase, bit length)
		assert GPIO pin for CS
* setup_transfer()
	* set HW mode register (bit length)
	* call bitbang_setup_transfer()

> At the top of <linux/spi/spi_bitbang.h> are verbal sketches of three
> types of "bitbang" drivers.  Implementations of two of them now seem
> to be working (word-at-a-time with GPIO bitbanging, "spi_butterfly"
> being one of a few examples; and transfer-at-a-time, "omap_uwire").
> Your hardware would be of the third type.
>
>
>
>>>> It sounds like with the new patch, I'll end up setting txrx_word 
>>>> [] to
>>>> the same function for all modes.
>>>
>>> Yes, it does sound like that.  If that works for you, I'd like to  
>>> see
>>> that go into 2.6.17 kernels.
>>
>> I'm not sure I understand what you'd like to see go into 2.6.17.
>
> The patch allowing the per-transfer overrides, which you were going to
> grab from the MM tree.
>
> That would support SPI drivers for things like bitmapped displays,  
> some
> of which need oddball things like 9-bit commands followed by 8-bit  
> data.

Right, I dont think I need the support of setup_transfer() for my  
devices aren't
changing their settings mid message.  However, I do think some  
changes are needed to the patch

- kumar
