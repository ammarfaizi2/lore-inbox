Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbULRNQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbULRNQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 08:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbULRNQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 08:16:50 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:47837 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262250AbULRNQp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 08:16:45 -0500
Message-ID: <41C42DD2.9030205@verizon.net>
Date: Sat, 18 Dec 2004 08:17:06 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ip2: fix compile warnings
References: <20041217214735.7127.91238.40236@localhost.localdomain> <41C38BE0.30004@osdl.org>
In-Reply-To: <41C38BE0.30004@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Sat, 18 Dec 2004 07:16:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> james4765@verizon.net wrote:
> 
>> This fixes the following compile errors in the ip2 and ip2main drivers:
>>
>>   CC      drivers/char/ip2main.o
>> drivers/char/ip2main.c:470: warning: initialization from incompatible 
>> pointer type
> 
> 
> 
>> diff -urN --exclude='*~' 
>> linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c 
>> linux-2.6.10-rc3-mm1/drivers/char/ip2main.c
>> --- linux-2.6.10-rc3-mm1-original/drivers/char/ip2main.c    2004-12-03 
>> 16:55:03.000000000 -0500
>> +++ linux-2.6.10-rc3-mm1/drivers/char/ip2main.c    2004-12-17 
>> 16:24:24.094730049 -0500
>> @@ -467,7 +466,7 @@
>>  static struct tty_operations ip2_ops = {
>>      .open            = ip2_open,
>>      .close           = ip2_close,
>> -    .write           = ip2_write,
>> +    .write           = (void *) ip2_write,
>>      .put_char        = ip2_putchar,
>>      .flush_chars     = ip2_flush_chars,
>>      .write_room      = ip2_write_room,
> 
> 
> The write() prototype in tty_operations is:
>     int  (*write)(struct tty_struct * tty,
>               const unsigned char *buf, int count);
> 
> Somehow the cast does eliminate the compiler warning (and give
> a false sense of correctness).
> 
> However, ip2main.c::ip2_write() should be modified like so:
> 
> static int
> ip2_write( PTTY tty, const unsigned char *pData, int count)
> 
> and drop the cast and fix the ip2_write comment (drop old arg 2),
> and fix the ip2_write() prototype.
> But then you (someone) will have to decide how to handle the
> dropped <user> parameter when calling i2Output()...
> I don't know the answer to that.
> I just changed <user> to 0 to get a clean build of ip2main.o,
> but ip2/i2lib.c still needs some work.
> 

Sorry for the constant n00b questions, but:

Is there anything outside the kernel that could call tty_operations.write?

drivers/input/serio/serport.c uses: (as an example)

static int serport_serio_write(struct serio *serio, unsigned char data)
{
	struct serport *serport = serio->port_data;
	return -(serport->tty->driver->write(serport->tty, &data, 1) != 1);
}

I'm guessing that something does copy_from_user() before tty_operations.write is 
called, but I don't know quite what that is.

Can anyone to point me in the direction of where the user/kernel interface for tty 
devices is?

Given the way this is set up -

int  (*write)(struct tty_struct * tty, const unsigned char *buf, int count);

vs.

ip2_write( PTTY tty, int user, const unsigned char *pData, int count)

I don't even know if the driver would work - I think you'd have serious problems 
as it tries to dereference a pointer that is half-integer.

Am I reading this wrong?

Jim
