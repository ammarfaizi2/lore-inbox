Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVCRQKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVCRQKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVCRQJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:09:55 -0500
Received: from alog0363.analogic.com ([208.224.222.139]:27875 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261675AbVCRQHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:07:10 -0500
Date: Fri, 18 Mar 2005 11:04:40 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: lsorense@csclub.uwaterloo.ca
cc: Hong Kong Phoey <hongkongphoey@gmail.com>,
       Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DM9000 network driver
In-Reply-To: <20050318152554.GH17865@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0503181046020.26420@chaos.analogic.com>
References: <20050318133143.GA20838@metis.extern.pengutronix.de>
 <4f6c1bdf0503180711148b8f02@mail.gmail.com> <20050318152554.GH17865@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 lsorense@csclub.uwaterloo.ca wrote:

> On Fri, Mar 18, 2005 at 08:41:52PM +0530, Hong Kong Phoey wrote:
>> Sacrificing readibility a little bit, you could do something useful.
>> Instead of those ugly switch statements you could define function
>> pointer arrays and call appropriate function
>>
>> switch(foo) {
>>
>>   case 1:
>>              f1();
>>   case2 :
>>              f2();
>> };
>>
>> could well become
>>
>> void (*func)[] = { f1, f2 };
>>
>> func(i);
>
> Ewww!
>
> How about sticking with obvious readable code rather than trying to save
> a couple of conditional branches.  If it is an obvious good
> optimization, let the compiler do it.  of course if you ever needed to
> pass different parameters to f1 and/or f2 it would have to be rewritten
> back to the original again.
>
> Len Sorensen

Also, those "ugly" switch-statements are not ugly and are
most efficient if the case(s) are enumerated types in
automatically-generated incrementing order. I see a lot
of values assigned to enumerated types which destroys their
usefulness. They might just as well be "#defined" values
if you do this.

Code that does:

enum {
    one,
    two,
    three };

    switch(val)
    {
    case one:
    case two:
    case three:
    ....
    }
... calculates the offset of each of those case(s) and branches
directly.
 	movl	(val), %ebx
 	shll	$2, %ebx	# Size of table entries
 	jmp	*table(%ebx)	# Table contains a list of switch offsets

If somebody does:
enum {
    one = 1234,
    two = 4321,
    three = 8765
    };

.. no such calculation is possible and the compiler output must
devolve to:

 	movl	(val), %eax
         cmpl    $1235, %eax
         jz      one
         cmpl    $4321, %eax
         jz      two
         cmpl    $8765, %eax
         jz      three
         jmp     none
one:

.... a bunch of comparisons. So, you make switches efficient
by using enumerated types without fixed values. Of course
some switches, such as found in ioctl() function numbers
must be hard-coded because they must correspond to whatever
the 'C' runtime library and its headers expect. In this
case, you can make them efficient by having no holes
in the allocated numbers and putting the cases in sorted
order. This gives the 'C' compiler a chance to optimize.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
