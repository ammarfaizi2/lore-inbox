Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265884AbUAKOAT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUAKOAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:00:19 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:57927 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265884AbUAKN7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:59:04 -0500
Message-ID: <4001569C.3010700@samwel.tk>
Date: Sun, 11 Jan 2004 14:58:52 +0100
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
References: <Pine.LNX.4.44.0401101243110.2210-100000@bigblue.dev.mdolabs.com> <400097E0.5040900@samwel.tk>
In-Reply-To: <400097E0.5040900@samwel.tk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel wrote:
> Davide Libenzi wrote:
> 
>>>> #define MAXMEM                       (~__PAGE_OFFSET + 1 - 
>>>> __VMALLOC_RESERVE)
>>>
>>>
>>> I tried that first, before I came up with the solution in the patch, 
>>> because I didn't like the dependency of 0xFFFFFFFF being 32-bit. It 
>>> was a nice idea, but it didn't work. Apparently, gas interprets ~ as 
>>> a one's complement negation operator, not a bitwise or. Therefore, 
>>> ~__PAGE_OFFSET is just as negative as -__PAGE_OFFSET as far as gas is 
>>> concerned. It gives me the same warning.
>>
>>
>>
>> That would mean a bug in as. __PAGE_OFFSET is unsigned and ~ is 
>> documented (not a surprise) as "bitwise not". The bitwise not of 
>> __PAGE_OFFSET (unsigned) is still unsigned. BTW 2.14 does not give 
>> warnings with both the original statement and the ~ one. This:
>>                                                                                                                         
>>         
>> PG=0xC0000000                                                                                                   
>>         VM=(128 << 
>> 20)                                                                                                  
>>                                                                                                                         
>>         mov (~PG + 1 - VM), 
>> %eax                                                                                        
>>         mov (-PG - VM), 
>> %eax                                                                                            
>>                                                                                                                         
>> generate this:
>>
>> zzzzzzzz:     file format elf32-i386
>>
>> Disassembly of section .text:
>>
>> 00000000 <.text>:
>>    0:   a1 00 00 00 38          mov    0x38000000,%eax
>>    5:   a1 00 00 00 38          mov    0x38000000,%eax
>>
>>
>> w/out any warnings. And the result is obviously 0x38000000 and not 
>> 0x37ffffff.
> 
> 
> I get the same behaviour. The 0x37ffffff is from the place where MAXMEM 
> is used (the ramdisk_max variable in setup.S); it subtracts one from the 
> value. It turns out that the error only occurs when the value is used in 
> a data definition. Experimentally found first value for which it gives 
> the error is:
> 
> ramdisk_max: .long ~(0x80000000)
> 
> Interestingly, it doesn't occur for 0x7fffffff. I've taken a look at gas 
> to see where it goes wrong, but my newly built version doesn't exhibit 
> this behaviour -- it compiles the above statement without warnings. It 
> might have to do with the differences between the build environment that 
> the Debian binutils package is built in and my own machine -- I'll do 
> some more investigating.

OK, I've done a bit of investigation. It turns out that as generates 
this warning when the following condition is met:

       if ((get & mask) != 0
	  && ((get & mask) != mask
	      || (get & hibit) == 0))

I've modified the warning to give me some more info about the values 
involved:

test.S: Assembler messages:
test.S:3: Warning: value 0xffffffff7fffffff truncated to 0x7fffffff, 
mask = ffffffff00000000, unmask = ffffffff, (get & mask) = 
ffffffff00000000), sizeof(get) = 8, sizeof(mask) = 8

This could be correct if as interpreted ~ as a 64-bit binary not, not a 
32-bit one. Not quite unlogical (it doesn't know the type of the input 
value -- it's a literal), except that it doesn't print the full value 
when it truncates it. I find it strange though that the warning isn't 
given for values under 0x80000000! This turns out to have to do with the 
"hibit", which turns out to be 0x80000000. Basically, their logic is 
that if (get & mask) == mask (all upper bits are 1) and (get & hibit) != 
0 as well, then the number is fits within a 32 bits *signed* integer. 
However, they don't look at the unsignedness of the value. So, I've 
changed this to:


       if ((get & mask) != 0
	  && (exp->X_unsigned
               || (get & mask) != mask
	      || (get & hibit) == 0))

Now it seems to behave correctly: for '~' it always warns, for '-' it 
only warns if the negative value is below -0x80000000. I'll submit a 
patch to this effect (including the format extensions) to the binutils 
people.

What's the effect of this for the linux warning? We don't want to use ~ 
for this, because it's not a 32-bit binary not. So, we need to use 
either my solution or the one supplied by Hans.

-- Bart
