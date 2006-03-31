Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWCaTQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWCaTQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCaTQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:16:56 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:45597 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751427AbWCaTQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:16:56 -0500
In-Reply-To: <29F33C89-519A-412B-9615-1944ED29FD9C@kernel.crashing.org>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org> <200603311011.00981.david-b@pacbell.net> <29F33C89-519A-412B-9615-1944ED29FD9C@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F1378860-AAEB-4587-B357-A9B78AD49073@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: question on spi_bitbang
Date: Fri, 31 Mar 2006 13:17:07 -0600
To: Kumar Gala <galak@kernel.crashing.org>
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


On Mar 31, 2006, at 1:07 PM, Kumar Gala wrote:

>
> On Mar 31, 2006, at 12:11 PM, David Brownell wrote:
>
>> On Friday 31 March 2006 9:31 am, Kumar Gala wrote:
>>> I'm looking at using spi_bitbang for a SPI driver and was trying to
>>> understand were the right point is to handle MODE switches.
>>>
>>> There are 4 function pointers provided for each mode.
>>
>> That's if you are indeed "bit banging", or your controller is the
>> type that's basically a wrapper around a shift register:  each
>> txrx_word() function transfers (or bitbangs) a 1-32 bit word in
>> the relevant SPI mode (0-3).
>>
>> There's also a higher level txrx_bufs() routine for buffer-at-a-time
>> access, better suited to DMA, FIFOs, and half-duplex hardware.
>
> My controller is just a shift register that I can set the  
> characteristics of (bit length for example, reverse data).
>
>>> My controller
>>> HW has a mode register which allows setting clock polarity and clock
>>> phase.  I assume what I want is in my chipselect() function is to  
>>> set
>>> my mode register and have the four function pointers set to the same
>>> function.
>>
>> I don't know how your particular hardware works, but if you have a
>> real SPI controller it would probably be more natural to have your
>> setup() function handle that mode register earlier, out of the main
>> transfer loop ... unless that mode register is shared among all
>> chipselects, in which case you'd use the setup_transfer() call for
>> that, inside the transfer loop.  (That call hasn't yet been merged
>> into the mainline kernel yet; it's in the MM tree.)
>
> The mode register is shared between chipselects so I'll go pull the  
> patches from -mm for setup_transfer().  That sounds like the right  
> place for setting my mode register.

Now that I look at setup_transfer() more I dont think its what I  
want.  It's only going to get called if the transfer is different  
from the spi_device() settings.  I would seem I would want to  
configure all of my settings in chipselect().

>> The chipselect() call should only affect the chipselect signal and,
>> when you're activating a chip, its initial clock polarity.  Though
>> if you're not using the latest from the MM tree, that's also your
>> hook for ensuring that the SPI mode is set up right.
>
> Why deal with just clock polarity and not clock phase as well in  
> chipselect()?
>
> It sounds like with the new patch, I'll end up setting txrx_word[]  
> to the same function for all modes.
>
> - kumar
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

