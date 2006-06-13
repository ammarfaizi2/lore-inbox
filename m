Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWFMVAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWFMVAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWFMVAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:00:34 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:9153 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932252AbWFMVAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:00:34 -0400
Message-ID: <448F2602.2030402@comcast.net>
Date: Tue, 13 Jun 2006 16:54:26 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Packing data in kernel memory
References: <448F0893.1080706@comcast.net>	<Pine.LNX.4.61.0606132217110.11918@yvahk01.tjqt.qr> <20060613133227.1eee4578.rdunlap@xenotime.net>
In-Reply-To: <20060613133227.1eee4578.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Randy.Dunlap wrote:
> On Tue, 13 Jun 2006 22:18:55 +0200 (MEST) Jan Engelhardt wrote:
> 
>>> Subject: Packing data in kernel memory
>>>
>> Can't you just use mlock(), if you want to keep it in RAM?
>>
>> Or do you need it in kernel memory, because you need it in the lowmem area? 
>> Or for interaction with other kernel code?
>>
>>> Is there a way to pack and store arbitrary data in the kernel, or do I
>>> need to roll my own?
> 
> Sounds a bit like a slab cache to me.
> 

OK cool, can I make that non-swappable?  I'm going to be trying to do
this between where kernel swaps a page out and swapped page actually is
written to disk.  The result will be a "Swap Zone," in-memory storage of
pages that the rest of the kernel thinks have been swapped to disk.
(Code here will use the swap interface, so the rest of the kernel thinks
it's just swapping; I'll handle whether to pull it out of memory or off
disk behind that)

The need for packing pages comes because eventually (using above
infrastructure) I'll be taking sets of 32KiB of data and compressing it;
I don't want to pad up to 4095 excess unused bytes if that stuff
compresses to 28KiB+1 :)  (more likely 16KiB+1 +/-8KiB)

This is all, of course, assuming I ever figure out how the heck to get
in the middle of the swapping process.  I'm looking at mm/page_io.c
swap_writepage() and friends and scratching my head.  I have no idea wtf...


>> Write a device driver, kmalloc some buffer, and copy data via a write 
>> function from userspace to that buffer. Should be trivial.
>>
>>> 1 excess pages, 4 units wasted memory.
>> Of course, kmalloc only works up to some boundary AFIACS.
> 
> 128 KB on some arches.  More on a few IIRC.
> 
> ---
> ~Randy
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRI8mAAs1xW0HCTEFAQJa4w/+Jrhnnp+DyOmuuQPL0A2QbydRlhvyeK6g
mixAd41AJPN8CmMqFZzWTPFbhN65BiM3oaKv+5YX8kvzJiKfhi8BabLlkapUgljx
qlFr2yOSTIBEkPiPaUTjjYSLFfVBqca1kAAcjO7qJGjcrCJK0AkVp11XKvF8xiLI
Hg8kEV1GzQKtMo65s+HQQR8XDTDRPuyTpGgWbVSwHyZnJY1pwFd2gVNpW63y52QM
pJw7WyLBa4NNDLLNRvX8/DbSjvaN3fYy223GItS67QaSOv5G9MNXQnhmUQV8dV0J
k4xiOhPBRoV1tDpIbdFTWajPp5facVZfLklsNv1uPyDUxdsrMDa8ETNsd6Kn3A5V
8Zp6EQWScyqoDa8u7aL2IZ0BCm69aJnaAXLm3miNheW1vUPmKYOZJn3+lmEX1vMh
JuXZzUYjgFgIss3djrpC2GoWqlMYgQ92ZBxecBoMQowPGkLwtcbz4J3qfwBalr1+
q9Ho85mH7eFUyod7ftWS8r6SQ1WtxCGTl9aPnwqlroq2RG1a/3bhJ2NIHyoLc+zt
y4IpzZ7B1JzTpBVKKkksOMv7B3XmxCwNzr4Qc1ilx+cLlqwsChiiAzv0IFXz6cBT
LVeTTHGyQOk7Yd5jO+Wi/s+9XsXEPFQGLDIimxqjqhXitcErAWOodg7tidYgMgFW
snfgQan4PZI=
=B4VW
-----END PGP SIGNATURE-----
