Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVA1Eni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVA1Eni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 23:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVA1Eni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 23:43:38 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:18364 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261452AbVA1En0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 23:43:26 -0500
Message-ID: <41F9C2EC.5070806@acm.org>
Date: Thu, 27 Jan 2005 22:43:24 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Studebaker <mds4@verizon.net>
Cc: Sensors <sensors@Stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Adding an async I2C interface
References: <41F50E9D.3050702@acm.org> <41F984D4.5030306@verizon.net>
In-Reply-To: <41F984D4.5030306@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Studebaker wrote:

> is there a way to do this solely in i2c-core without having to
> add support to all the drivers?

Yes and no.  In order to support this async operation, the driver cannot 
block and do things like msleep() or schedule().  It has to start the 
operation, return, and either let polling or an interrupt drive the 
continued operation.  Thus for async operations the driver has to be 
modified.  However, if async operation is not required, the driver can 
stay as is.

I've been working on this and will probably have a patch tomorrow.  I've 
modified the piix4 and the i801 drivers, I probably won't do any more 
myself unless the need arises, since I can't test any others.  Note that 
this still supports the old driver interface, so no drivers need to be 
rewritten.  That way, they only need to be modified if something needs 
the async interface.  So drivers that have an RTC on them or that 
support IPMI BMCs could be rewritten, but nothing else needs to be done.

I've also noticed a somewhat cavalier attitude in this code with respect 
to return values.  I've cleaned some of that up so return values are not 
just -1 on error, but are proper errno values.  However, I've only fixed 
the core code and the drivers I've worked on.

Thanks,

-Corey

>
> Corey Minyard wrote:
>
>> I have an IPMI interface driver that sits on top of the I2C code.  I'd
>> like to get it into the mainstream kernel, but I have a few problems
>> to solve first before I can do that.  The I2C code is synchronous and
>> must run from a task context.  The IPMI driver has certain
>> operations that occur at panic time, including:
>>
>>   * Storing panic information in IPMI's system event log
>>   * Extending the watchdog timer so it doesn't go off during panic
>>     operations (like kernel coredumps).
>>   * Powering the system off
>>
>> I can't really put the IPMI SMB interface into the kernel until I can
>> do those operations.  Also, I understand that some vendors put RTC
>> chips onto the I2C bus and this must be accessed outside task context,
>> too.  I would really like add asynchronous interface to the I2C bus
>> drivers.  I propose:
>>
>>   * Adding an async send interface to the busses that does a callback
>>     when the operation is complete.
>>   * Adding a poll interface to the busses.  The I2C core code could
>>     call this if a synchronous call is made from task context (much
>>     like all the current drivers do right now).  For asyncronous
>>     operation, the I2C core code would call it from a timer
>>     interrupt.  If the driver supported interrupts, polling from the
>>     timer interrupt would not be necessary.
>>   * Add async operations for the user to call, including access to the
>>     polling code.
>>   * If the driver didn't support an async send, it would work as it
>>     does today and the async calls would return ENOSYS.
>>
>> This way, the bus drivers on I2C could be converted on a
>> driver-by-driver basis.  The IPMI code could query to see if the
>> driver supported async operations.  And the RTC code could use it,
>> too.
>>
>> Is this ok with the I2C community?  I would do the base work and
>> convert over a few drivers.
>>
>> Thanks,
>>
>> -Corey
>>
>>

