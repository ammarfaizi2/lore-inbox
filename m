Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUIANjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUIANjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUIANjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:39:51 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:230 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S266740AbUIAN3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:29:30 -0400
Message-ID: <4135CEB4.5020102@softhome.net>
Date: Wed, 01 Sep 2004 15:29:24 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla Thunderbird 0.7.1 (Macintosh/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
References: <courier.41359B53.00007549@softhome.net>            <20040901095229.GA11908@devserv.devel.redhat.com> <courier.4135A19B.00007EA5@softhome.net> <4135B9FC.7050602@hist.no>
In-Reply-To: <4135B9FC.7050602@hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   Well. I given an example of device which doesn't fit into 
read()/write() interface.

   Your imagination is truely appreciated - and you are encouraged to 
try to implement it. With full error handling (every write must be 
checked)  and multithreading support (e.g. one user for movement, 
multiple for monitoring and diagnosis).

   I have tryed to some extent impelementing something like this - 
amount of code doubled for no real gain. (It was in those times when 
"ioctl()s are bad. period." topic poped up on lkml first time. long time 
ago)

   No one will ever design interface for sake of interface. what you are 
proposing - probably will look nice in academical papers, but no one 
will do it, and no one will do it in kernel space.

   And all this stuff - all this funcy xml-like comlications? - for 
what? just call one function of driver with single parameter - void*.
   _*Not more*_. Ridiculous indeed.

P.S. As I have said before, it seems to me that using read()/write() 
instead of ioctl() could be the only choice. I once hacked read(): user 
must pass two structures: first is input, second is output. It worked - 
but no one (including me) liked it. ioctl() even by its name fit better.

P.P.S. Hm. Why not implement ioctl2()? which will be linked directly to 
device by its driver? - numbering will be internal to driver, and 
provide entry point into driver for user space applications. No one 
likes mess with ioctl()s in Linux - no device driver developers, nor 
users. But what is really needed - is just call into driver. Paramenter 
- single pointer have being proved to be sufficient.

Helge Hafting wrote:

> filia@softhome.net wrote:
> 
>> Arjan van de Ven writes:
>>
>>> On Wed, Sep 01, 2004 at 03:50:11AM -0600, filia@softhome.net wrote:
>>>
>>>> Hi! Stop being arrogant.
>>>> Can you please elaborate on how to make Linux kernel support e.g. 
>>>> motion controllers? They do not fit *any* known to me driver 
>>>> interface. They have several axes, they have about twenty parameters 
>>>> (float or integer), and 
>>>
>>>
>>>
>>> parameters nicely fit in sysfs.
>>
>>
>>
>> What about errors?
>> "set di 200000" might fail for lots of reasons.
>>
>>>> they have several commands, a-la start, graceful stop, abrupt stop. 
>>>> Plus obviously diagnostics - about ten another commands with 
>>>> absolutely different parameters. And about ten motion monitoring 
>>>> commands. And this is one example I were need to program. 
>>>
>>>
>>>
>>> a write() interface doesn't work???
>>> Hard to believe, you even call them commands.
>>> fd = open("/dev/funkydevice");
>>> write(fd, "start");
>>> doesn't sound insane to me
>>
>>
>>
>> it doesn't, since you didn't tryed to make error handling. every thing 
>> can fail - this is control of mechanics - and it fails often and for a 
>> lot of reasons. Put here error handling (write(struct whatever)
> 
> 
> Well, how about a read-write interface?
> Write a command to the driver, read back the response. If the response 
> indicate
> an error, read more to get error details.  Keep reading out possibly 
> several errors
> until the driver have nothing more to report.
> 
>> has to return another struct whatever2 filled with error description) 
>> and thread-safeness. Pluss some controllers do support 
>> multi-dimensional movements "start x,y,z,etc" - and you might have 
>> _several_ error structs. Atomicity is important for multi-dimensional 
>> moves too - move on given axes
> 
> 
> The driver can handle atomicity - if it somehow receives a partial 
> command it should
> buffer it and wait for the rest.  If you need several commands for a 
> single movement,
> consider barriers, i.e.:
> write(fd, "barrier start");
> write(fd, "one kind of movement");
> write(fd, "other kind of movement");
> write(fd, "third kind of movement");
> write(fd, "barrier end");  /* Complex movement starts at this point */
> read(fd, &error_buffer, size); /* Did this work? */
> 
>> starts with single command.
>> hu?
>> I do not see much point in renaming ioctl() to write() all over the 
>> place - at least when people see ioctl() they understand that it is 
>> not standard functionality. write() will for sure confuse a lot of 
>> people. 
> 
> 
> Isn't motion "standard functionality" for this device?  If so, a write 
> interface fits
> even if the stuff written to it might be special (structs and such)
> 
> Helge Hafting
> 

