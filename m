Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968384AbWLEGYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968384AbWLEGYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968385AbWLEGYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:24:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56024 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968384AbWLEGYQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:24:16 -0500
Message-ID: <45750FB6.8000304@redhat.com>
Date: Tue, 05 Dec 2006 01:20:38 -0500
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <1165297363.29784.54.camel@localhost.localdomain>
In-Reply-To: <1165297363.29784.54.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Tue, 2006-12-05 at 00:22 -0500, Kristian Høgsberg wrote:
>> Hi,
>>
>> I'm announcing an alternative firewire stack that I've been working on
>> the last few weeks.  I'm aiming to implement feature parity with the
>> current firewire stack, but not necessarily interface compatibility.
>> For now, I have the low-level OHCI driver done, the mid-level
>> transaction logic done, and the SBP-2 (storage) driver is basically
>> done.  What's missing is a streaming interface (in progress) to allow
>> reception and transmission of isochronous data and a userspace
>> interface for controlling devices (much like raw1394 or libusb for
>> usb).  I'm working out of this git repository:
> 
> A very very very quick look at the code shows that:
> 
>  - It looks nice / clear

Great, good to hear.

>  - It's horribly broken in at least two area :
> 
>  DO NOT USE BITFIELDS FOR DATA ON THE WIRE !!!
> 
>  and
> 
>  Where do you handle endianness ? (no need to shout for
>  that one).

Well, the code isn't big-endian safe yet, but the only place where I expect to 
have to fix this is in fw-ohci.c.  I need to figure out how I want to set up 
the OHCI controller to this - it has a couple of bits to control this.  All 
data outside the low-level driver is cpu-endian, with the exception of payload 
data.  IEEE1394 doesn't specify an endianness for the payload data, even 
though most protocols use big-endian.    Some protocols have a mix of 
byte-arrays and be32 words (eg SBP-2) so it's up to the protocol to byteswap 
its data as appropriate.

> (Or in general, do not use bitfields period ....)
> 
> bitfields format is not guaranteed, and is not endian consistent. 

Ok... I was planning to make big-endian versions of the structs so that the 
endian issue would be solved.  But if the bit layout is not consistent, I 
guess bitfields are useless for wire formats.  I didn't know that though, I 
thought the C standard specified that the compiler should allocate bits out of 
a word using the lower bits first.  Is the problem that it allocates them out 
of a 64-bit word on 64-bit platforms?

cheers,
Kristian

