Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755235AbWKMTnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbWKMTnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbWKMTnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:43:33 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:34279 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S1755235AbWKMTnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:43:32 -0500
Message-ID: <4558CAE4.1020202@billgatliff.com>
Date: Mon, 13 Nov 2006 13:43:32 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <20061113173800.GA19553@linux-sh.org> <200611131121.23944.david-b@pacbell.net>
In-Reply-To: <200611131121.23944.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Monday 13 November 2006 9:38 am, Paul Mundt wrote:
>
>  
>
>>>Comments?
>>>      
>>>
>>I'm not convinced that exposing the pin number to drivers is the way to
>>go. The pin numbers themselves are rarely portable across "similar" CPUs
>>with identical peripherals, 
>>    
>>
>
>Pin numbers are NOT exposed ... GPIO numbers are.  Drivers just get
>a number and pass it around.  They're cookies with the same kinds of
>portability attributes as IRQ numbers and register addresses.  (None of
>which have particular portability problems when used properly.)
>
>And all those existing ARM GPIO calls work just fine with numbers
>for GPIOs.  The numbers are platform-specific, sometimes with board
>specific additions (like FPGA outputs) ... but they're just numbers.
>
>
>(And FWIW, I'm more familiar with "balls" like AA12 or J15 being relevant,
>than pins like 1 or 332.  Of course one could assign numbers to balls,
>but the mappings for a BGA-256 would be different from ones on a BGA-193
>or a BGA-289.  And yet the same logical GPIO -- accessed through the same
>software registers -- might be available with all of those packages!
>Sometimes on more than one pin.  Such issues are associated with pin
>mux/config, not GPIO numbering.)
>
>  
>

Honestly, I'm forced to go to this mentality more every day as well.  
The AT91RM9200 is available in at least two packages, not all of which 
have the same GPIO mapping (or even available lines!).  And don't get me 
started on PPC...


>>Any API also needs to allow for multiple GPIO controllers, as it's rarely
>>just the CPU that has these or needs to manipulate them.
>>    
>>
>
>This API absolutely allows for multiple GPIO controllers ... all it does
>is say "here are the numbers, handle them".  The platform's implementation
>of the API is allowed to map to the relevant controller.
>  
>

I think what Paul is saying here is that because your reference 
implementation was "arch-omap" instead of "board-<something>", if I add 
a PLD with some MMIO GPIO lines then I have to hack global OMAP code.  
Maybe we should codify an approach for that now, i.e. add to the 
reference implementation some code that hands off out-of-range GPIO 
lines to a function in the machine descriptor:


+static inline int gpio_direction_input(unsigned gpio)
+	{ if (gpio < OMAP_MAX_ARCH_GPIO) return __gpio_set_direction(gpio, 1);
+	  else if(mdesc->platform_gpio_set_direction) platform_gpio_set_direction(gpio, 1); }


... conveniently neglecting the way you find mdesc.  :)


I do have a question now.  Is there any reason to consider shared GPIO 
lines?  If so, then the request_gpio() would need a flag GPIO_SHARED or 
something.



b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

