Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUANXWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUANXRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:17:50 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55022 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266329AbUANXQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:16:42 -0500
Message-ID: <4005A926.2000902@mvista.com>
Date: Wed, 14 Jan 2004 12:40:06 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: kgdb cleanups
References: <20040109183826.GA795@elf.ucw.cz> <200401121923.27513.amitkale@emsyssoft.com> <40046115.5090700@mvista.com> <200401141850.25650.amitkale@emsyssoft.com>
In-Reply-To: <200401141850.25650.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Wednesday 14 Jan 2004 2:50 am, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>Regarding pluggable iterfaces -
>>>The version I have lets a user to choose the interface by supplying
>>>appropriate command line. (e.g. kgdbwait kgdb8250=... or kgdbwait
>>>kgdbeth=...) It supports an arbitrary number of interfaces. The kgdb core
>>>itself is independent of an interface. All interfaces are defined by a
>>>structure described below. An interface registers itself with kgdb core
>>>by assigning this structure to pointer kgdb_serial.
>>>
>>>struct kgdb_serial {
>>>	int chunksize;
>>
>>Do we really need this?  The only place I saw it used it did not seem to
>>matter where the split occured and there was now endchunck/beginchunck
>>stuff.  I would MUCH rather see the interface code take care of this with
>>out mucking up the core code (as the eth code already does).  Did I miss
>>something here?
> 
> 
> Having an interface recognize a kgdb core record isn't a good design.
> Having kgdb core record know interface limitations isn't good either.
> 
> If kgdb calls flush at end of a packet and an interface splits a packet 
> whenever its length goes above its limit, that'll be the right way of doing 
> it.

I think this is what happens in the current eth code.

> 
>>>	int (*read_char)(void);
>>>	void (*write_char)(int);
>>>	void (*flush)(void);
>>>	int (*hook)(void);
>>>	void (*begin_session)(void);
>>>	void (*end_session)(void);
>>>};
>>>
>>>Where chunksize is maximum chunksize an interface can handle.
>>>
>>>read_char and write_char are derived from getDebugChar and putDebugChar
>>>flush flushes written characters. Flush control is given to kgdb core so
>>>that it can ensure that #checksum doesn't split.
>>
>>Actually, I think it is needed so that gdb knows that the kgdb stub has
>>exited. This could, of course, be done with out the flush, but then the
>>write code would have to recognize an end of record (not hard with the
>>given protocol).  I don't think there is any requirement that a checksum
>>not be split.  My assumption here is that the logical record is reassembled
>>on the gdb end without concern about how many physical records are
>>involved.  Is this not true?
> 
> 
> I guess yes. Splitting of #checksum may not matter.
> 
> 
>>>begin_session and end_session inform an interface about a gdb
>>>communication session. (Haven't decided about console packets to gdb yet)
>>
>>I assume you mean entry to the stub/ exit the stub as a "session".  This
>>eliminates the old hook, right?
> 
> 
> Yes. begin_session and end_session mark entry and exit points into 
> handle_exception. They are required to mark ethernet interface in trap mode.
> 
> What's old hook?

I think it was a function in eth that was called to mark the begin and end just 
as begin_session and end_session do.  Might want to consider one function for 
this, with a parameter.

-g


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

