Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVA1HJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVA1HJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 02:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVA1HJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 02:09:24 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:502 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261496AbVA1HH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 02:07:58 -0500
Message-ID: <41F9E854.A4D5765D@gte.net>
Date: Thu, 27 Jan 2005 23:23:00 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Adding an async I2C interface
References: <41F50E9D.3050702@acm.org> <41F984D4.5030306@verizon.net> <41F9C2EC.5070806@acm.org> <41F9E183.5A9B1BA2@gte.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [66.199.68.159] at Fri, 28 Jan 2005 01:07:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I will be glad to work with on this,  I have some exposure to the BMC. See text below in blue.
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
>
> The Interface driver must be a user space driver.
>
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
>> >> I have an IPMI interface driver that sits on top of the I2C code.  I'd
>> >> like to get it into the mainstream kernel, but I have a few problems
>> >> to solve first before I can do that.  The I2C code is synchronous and
>> >> must run from a task context.
>
> I am not sure what you mean that the I2C code is synchronous. I2C bus is Asynchronous which means that the data clock is not included in the data. The Sender and Receiver agrees on the timing parameters prior to the bus transaction.
>
>> The IPMI driver has certain
>> >> operations that occur at panic time, including:
>> >>
>> >>   * Storing panic information in IPMI's system event log
>> >>   * Extending the watchdog timer so it doesn't go off during panic
>> >>     operations (like kernel coredumps).
>> >>   * Powering the system off
>> >>
>
> Is this driver compliant with the IPMI spec? Because the above should be a sensor that must be enable or disable. A driver should not make sure a decision by itself.
>
>>
>> >> I can't really put the IPMI SMB interface into the kernel until I can
>> >> do those operations.  Also, I understand that some vendors put RTC
>> >> chips onto the I2C bus and this must be accessed outside task context,
>> >> too.
>
> What the vendor put on the board doesn't matter with respect to IPMI. What matter is that you have access to the Master where the slave you talking to is connect on the I2C bus.
>
>> I would really like add asynchronous interface to the I2C bus
>> >> drivers.
>
> Do you mean a  blocking and non blocking I/O?
>
>> I propose:
>> >>
>> >>   * Adding an async send interface to the busses that does a callback
>> >>     when the operation is complete.
>
> Okay, you are doing a non-blocking I/O. So what happens when another process tries to access the I2C bus before the bus transaction is completed. Some thing (mainly the app) needs to tell the driver not to share the resource while a transaction is in progress.
>
>>
>> >>   * Adding a poll interface to the busses.  The I2C core code could
>> >>     call this if a synchronous call is made from task context (much
>> >>     like all the current drivers do right now).  For asyncronous
>> >>     operation, the I2C core code would call it from a timer
>> >>     interrupt.  If the driver supported interrupts, polling from the
>> >>     timer interrupt would not be necessary.
>
> I think this should be done in the Interface code because the Interface code will be running in the user space and have access to the operating system facility.
>
>>
>> >>   * Add async operations for the user to call, including access to the
>> >>     polling code.
>
> The driver can make itself blocking  and non blocking
>
>>
>> >>   * If the driver didn't support an async send, it would work as it
>> >>     does today and the async calls would return ENOSYS.
>
> Not needed, it will be addressed by the blocking and non-block implementation of the driver.
>
>>
>> >>
>> >> This way, the bus drivers on I2C could be converted on a
>> >> driver-by-driver basis.  The IPMI code could query to see if the
>> >> driver supported async operations.  And the RTC code could use it,
>> >> too.
>> >>
>> >> Is this ok with the I2C community?  I would do the base work and
>> >> convert over a few drivers.
>> >>
>> >> Thanks,
>> >>
>> >> -Corey
>> >>
>> >>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
