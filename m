Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVA1OEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVA1OEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVA1OEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:04:31 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:26358 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261380AbVA1OCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:02:22 -0500
Message-ID: <41FA45EC.10900@acm.org>
Date: Fri, 28 Jan 2005 08:02:20 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bukie Mabayoje <bukiemab@gte.net>
Cc: Mark Studebaker <mds4@verizon.net>, Sensors <sensors@Stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Adding an async I2C interface
References: <41F50E9D.3050702@acm.org> <41F984D4.5030306@verizon.net> <41F9C2EC.5070806@acm.org> <41F9E183.5A9B1BA2@gte.net>
In-Reply-To: <41F9E183.5A9B1BA2@gte.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bukie Mabayoje wrote:

> I will be glad to work with on this,  I have some exposure to the BMC. 
> See text below in blue.
>
> bukie
>
> Corey Minyard wrote:
>
>> Mark Studebaker wrote:
>>
>> > is there a way to do this solely in i2c-core without having to
>> > add support to all the drivers?
>>
>> Yes and no.  In order to support this async operation, the driver cannot
>> block and do things like msleep() or schedule().
>>
> The Interface driver must be a user space driver.

That is precisely the problem.  What happens if you need to get to the 
i2c bus but you are not running from a task context?

>> It has to start the
>> operation, return, and either let polling or an interrupt drive the
>> continued operation.  Thus for async operations the driver has to be
>> modified.  However, if async operation is not required, the driver can
>> stay as is.
>>
>> I've been working on this and will probably have a patch tomorrow.  I've
>> modified the piix4 and the i801 drivers, I probably won't do any more
>> myself unless the need arises, since I can't test any others.  Note that
>> this still supports the old driver interface, so no drivers need to be
>> rewritten.  That way, they only need to be modified if something needs
>> the async interface.  So drivers that have an RTC on them or that
>> support IPMI BMCs could be rewritten, but nothing else needs to be done.
>>
>> I've also noticed a somewhat cavalier attitude in this code with respect
>> to return values.  I've cleaned some of that up so return values are not
>> just -1 on error, but are proper errno values.  However, I've only fixed
>> the core code and the drivers I've worked on.
>>
>> Thanks,
>>
>> -Corey
>>
>> >
>> > Corey Minyard wrote:
>> >
>> >> I have an IPMI interface driver that sits on top of the I2C code.  
>> I'd
>> >> like to get it into the mainstream kernel, but I have a few problems
>> >> to solve first before I can do that.  The I2C code is synchronous and
>> >> must run from a task context.
>>
> I am not sure what you mean that the I2C code is synchronous. I2C bus 
> is Asynchronous which means that the data clock is not included in the 
> data. The Sender and Receiver agrees on the timing parameters prior to 
> the bus transaction.

I mean the driver, not the hardware.  By the I2C driver being 
synchronous, I mean that you call a function, the whole operation occurs 
in the function, and then the function returns the result.  By 
asynchronous, I mean that you tell the driver to start an operation and 
the driver starts it and immediately returns.  It then uses interrupts, 
timers, or polling calls to drive the operation of the interface.  When 
the operation is done, the results are reported back through a callback 
function provided when the driver started.

Plus there are SMB alerts which the hardware can generate 
asynchronously.  The I2C driver has no concept of that right now.

>> The IPMI driver has certain
>> >> operations that occur at panic time, including:
>> >>
>> >>   * Storing panic information in IPMI's system event log
>> >>   * Extending the watchdog timer so it doesn't go off during panic
>> >>     operations (like kernel coredumps).
>> >>   * Powering the system off
>> >>
>
> Is this driver compliant with the IPMI spec? Because the above should 
> be a sensor that must be enable or disable. A driver should not make 
> sure a decision by itself.

There are two parts here.  There is the I2C driver and the IPMI driver 
that sits on top of it.  I'm really only taking about the I2C driver 
here, I need asynchronous operation from the I2C driver to do those 
things in the IPMI driver.

>>  
>> >> I can't really put the IPMI SMB interface into the kernel until I can
>> >> do those operations.  Also, I understand that some vendors put RTC
>> >> chips onto the I2C bus and this must be accessed outside task 
>> context,
>> >> too.
>
> What the vendor put on the board doesn't matter with respect to IPMI. 
> What matter is that you have access to the Master where the slave you 
> talking to is connect on the I2C bus.
>
>> I would really like add asynchronous interface to the I2C bus
>> >> drivers.
>
> Do you mean a  blocking and non blocking I/O?

Yes, that is a better term.  I'll switch to using that.

-Corey

