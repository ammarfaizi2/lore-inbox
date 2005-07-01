Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263348AbVGAN7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbVGAN7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbVGAN7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:59:46 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:57260 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S263348AbVGAN7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:59:00 -0400
Message-ID: <42C54BDC.6000206@emc.com>
Date: Fri, 01 Jul 2005 09:57:48 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
CC: linux-kernel@vger.kernel.org, Brett Russ <russb@emc.com>,
       linux-fsdevel@vger.kernel.org
Subject: Re: XFS corruption during power-blackout
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org> <42C4FC14.7070402@slaphack.com> <20050701092412.GD2243@suse.de> <20050701131950.GA15180@ime.usp.br>
In-Reply-To: <20050701131950.GA15180@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.1.12
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__C230066_P3_4 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:

>On Jul 01 2005, Jens Axboe wrote:
>  
>
>>On Fri, Jul 01 2005, David Masover wrote:
>>    
>>
>>>Not always possible.  Some disks lie and leave caching on anyway.
>>>      
>>>
>>And the same (and others) disks will not honor a flush anyways.
>>Moral of that story - avoid bad hardware.
>>    
>>
>
>But how does the end-user know what hardware is "good hardware"? Which
>vendors don't lie (or, at least, lie less than others) regarding HDs?
>
>
>Thanks, Rogério Brito.
>
>  
>
The only real way is to test the drive (and retest when you get a new 
versions of firmware) and the whole fsync -> write barrier code path.

We use a bus analyzer to make sure that when you fsync() a file, you 
will see a cache flush command coming across the bus. Of course, that is 
the easy step ;-)

The second step is to test your system across power failures.  We have a 
"wbtest" code that we have used to catch bugs. The basic idea is to 
write a file to a disk with the cache turned off, write the same file to 
the disk with the write barrier (and working cache flush command) and 
then randomly drop power to the box.  It is important to really drop 
power to the whole box since a "reset button" push often does not drop 
power to the drives and will give you false passes.

Our wbtest used to be good at finding holes in the write barrier code 
using 2.4 kernels and PATA drives, but we have had no luck yet in 
catching known bugs with this test on 2.6 with S-ATA drives.

Ideas on how to get a more effective test are welcome - it is a very 
small window that you need to hit to catch a misbehaving drive (i.e., 
your write cache flush command has returned, you want to drop power and 
on reboot, validate that the platter contains that last IO correctly).  
If you had enough NVRAM in a test system, you might be able to 
substitute a NVRAM backed file system for the write-cache disabled drive 
and get closer to catching the window.

The alternative is to either run with the write cache disabled (again, 
you will need to validate that the drive really disabled the cache) or 
to buy a mid-range or better storage array that provides a non-volatile 
(battery backed) write cache.



