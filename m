Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbULTHte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbULTHte (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbULTHpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:45:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:32980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261460AbULTGZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:25:00 -0500
Message-ID: <41C66F18.1000505@osdl.org>
Date: Sun, 19 Dec 2004 22:20:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Nelson <james4765@verizon.net>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ip2: fix compile warnings
References: <20041217214735.7127.91238.40236@localhost.localdomain> <41C38BE0.30004@osdl.org> <41C42DD2.9030205@verizon.net>
In-Reply-To: <41C42DD2.9030205@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Nelson wrote:
> Randy.Dunlap wrote:
> 
>> james4765@verizon.net wrote:
>>
>>> This fixes the following compile errors in the ip2 and ip2main drivers:
>>>
>>>   CC      drivers/char/ip2main.o
>>> drivers/char/ip2main.c:470: warning: initialization from incompatible 
>>> pointer type
>>
>>
>>> diff -urN --exclude='*~' 
>>> linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c 
>>> linux-2.6.10-rc3-mm1/drivers/char/ip2main.c
>>> --- linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c    
>>> 2004-12-03 16:55:03.000000000 -0500
>>> +++ linux-2.6.10-rc3-mm1/drivers/char/ip2main.c    2004-12-17 
>>> 16:24:24.094730049 -0500
>>> @@ -467,7 +466,7 @@
>>>  static struct tty_operations ip2_ops = {
>>>      .open            = ip2_open,
>>>      .close           = ip2_close,
>>> -    .write           = ip2_write,
>>> +    .write           = (void *) ip2_write,
>>>      .put_char        = ip2_putchar,
>>>      .flush_chars     = ip2_flush_chars,
>>>      .write_room      = ip2_write_room,
>>
>>
>> The write() prototype in tty_operations is:
>>     int  (*write)(struct tty_struct * tty,
>>               const unsigned char *buf, int count);
>>
>> Somehow the cast does eliminate the compiler warning (and give
>> a false sense of correctness).
>>
>> However, ip2main.c::ip2_write() should be modified like so:
>>
>> static int
>> ip2_write( PTTY tty, const unsigned char *pData, int count)
>>
>> and drop the cast and fix the ip2_write comment (drop old arg 2),
>> and fix the ip2_write() prototype.
>> But then you (someone) will have to decide how to handle the
>> dropped <user> parameter when calling i2Output()...
>> I don't know the answer to that.
>> I just changed <user> to 0 to get a clean build of ip2main.o,
>> but ip2/i2lib.c still needs some work.
>>
> 
> Sorry for the constant n00b questions, but:
> 
> Is there anything outside the kernel that could call tty_operations.write?

Sorry, I don't know the path to get to that code.

> drivers/input/serio/serport.c uses: (as an example)
> 
> static int serport_serio_write(struct serio *serio, unsigned char data)
> {
>     struct serport *serport = serio->port_data;
>     return -(serport->tty->driver->write(serport->tty, &data, 1) != 1);
> }
> 
> I'm guessing that something does copy_from_user() before 
> tty_operations.write is called, but I don't know quite what that is.
> 
> Can anyone to point me in the direction of where the user/kernel 
> interface for tty devices is?
> 
> Given the way this is set up -
> 
> int  (*write)(struct tty_struct * tty, const unsigned char *buf, int 
> count);
> 
> vs.
> 
> ip2_write( PTTY tty, int user, const unsigned char *pData, int count)
> 
> I don't even know if the driver would work - I think you'd have serious 
> problems as it tries to dereference a pointer that is half-integer.

I didn't quite get the "half-integer" part...
Unless you mean that the function interface is just broken.
Yes, it is.

> Am I reading this wrong?

It looks to me like the Kconfig entry for CONFIG_COMPUTONE
should just use BROKEN instead of BROKEN_ON_SMP since its
.write function interface hasn't been updated.

-- 
~Randy
