Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUAKAZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUAKAZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:25:26 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:41286 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265493AbUAKAZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:25:19 -0500
Message-ID: <400097E0.5040900@samwel.tk>
Date: Sun, 11 Jan 2004 01:25:04 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Tim Cambrant <tim@cambrant.com>, Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
References: <Pine.LNX.4.44.0401101243110.2210-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0401101243110.2210-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
>>>#define MAXMEM                       (~__PAGE_OFFSET + 1 - __VMALLOC_RESERVE)
>>
>>I tried that first, before I came up with the solution in the patch, 
>>because I didn't like the dependency of 0xFFFFFFFF being 32-bit. It was 
>>a nice idea, but it didn't work. Apparently, gas interprets ~ as a one's 
>>complement negation operator, not a bitwise or. Therefore, 
>>~__PAGE_OFFSET is just as negative as -__PAGE_OFFSET as far as gas is 
>>concerned. It gives me the same warning.
> 
> 
> That would mean a bug in as. __PAGE_OFFSET is unsigned and ~ is documented 
> (not a surprise) as "bitwise not". The bitwise not of __PAGE_OFFSET 
> (unsigned) is still unsigned. BTW 2.14 does not give warnings with both 
> the original statement and the ~ one. This:
> 
>                                                                                                                         
>         PG=0xC0000000                                                                                                   
>         VM=(128 << 20)                                                                                                  
>                                                                                                                         
>         mov (~PG + 1 - VM), %eax                                                                                        
>         mov (-PG - VM), %eax                                                                                            
>                                                                                                                         
> generate this:
> 
> zzzzzzzz:     file format elf32-i386
> 
> Disassembly of section .text:
> 
> 00000000 <.text>:
>    0:   a1 00 00 00 38          mov    0x38000000,%eax
>    5:   a1 00 00 00 38          mov    0x38000000,%eax
> 
> 
> w/out any warnings. And the result is obviously 0x38000000 and 
> not 0x37ffffff.

I get the same behaviour. The 0x37ffffff is from the place where MAXMEM 
is used (the ramdisk_max variable in setup.S); it subtracts one from the 
value. It turns out that the error only occurs when the value is used in 
a data definition. Experimentally found first value for which it gives 
the error is:

ramdisk_max: .long ~(0x80000000)

Interestingly, it doesn't occur for 0x7fffffff. I've taken a look at gas 
to see where it goes wrong, but my newly built version doesn't exhibit 
this behaviour -- it compiles the above statement without warnings. It 
might have to do with the differences between the build environment that 
the Debian binutils package is built in and my own machine -- I'll do 
some more investigating.

-- Bart
