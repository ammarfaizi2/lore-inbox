Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUKGUYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUKGUYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 15:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUKGUYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 15:24:37 -0500
Received: from imap1.nextra.sk ([195.168.1.91]:7439 "EHLO mailhub1.nextra.sk")
	by vger.kernel.org with ESMTP id S261609AbUKGUYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 15:24:32 -0500
Message-ID: <418E849E.8070907@rainbow-software.org>
Date: Sun, 07 Nov 2004 21:25:02 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: cdu31a - anyone has this ancient drive for testing?
References: <418E4A27.2060104@rainbow-software.org> <418E7CD7.408@keyaccess.nl>
In-Reply-To: <418E7CD7.408@keyaccess.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Ondrej Zary wrote:
> 
>> I've got a Sony CDU33A drive with COR334 controller. The Linux cdu31a 
>> driver was not updated for 2.6 kernel so it does not work.
> 
> 
> Well, modular it still /pretended/ to work. That is, it could (most of 
> the time) mount CD-ROMs but yes, most any actual activity made it blow 
> up...

The original driver assumed that the request is at most 2048 bytes. If 
the request is longer, the readahead code oopses. Now that code is gone, 
readahead is handled by higher layers in the kernel. The driver 
performance might be increased by reading more than one CD-ROM sector at 
a time. I've tried to do that but got hard lockups.

>> Here are two patches that try to make the driver working with 2.6 
>> kernel. The cdu31a-timeouts-fix.patch fixes the timeout values in 
>> header file and the cdu31a-make-working.patch does the rest:
>>  - Make the driver work in 2.6.X
>>  - Added workaround to fix hard lockups on eject
>>  - Fixed door locking problem after mounting empty drive
>>  - Set double-speed drives to double speed by default
>>  - Removed all readahead things - not needed anymore
>>
>> It does work on my system. I also know that it's still broken - it 
>> uses cli(), MODULE_PARM and it's also not very fast (I _never_ reached 
>> full 300KB/s with it, but I know that it's possible in Windows) and 
>> probably many other things (I'm new to Linux kernel) - so I'm waiting 
>> for comments.
>>
>> If someone has these ancient drives (CDU31A or CDU33A), please test :-)
> 
> 
> Verified to do useful things here as well. I Have a CDU33A connected 
> through a MediaVision PAS16 soundcard:
> 
> Pro Audio Spectrum driver Copyright (C) by Hannu Savolainen 1993-1996
> <Pro AudioSpectrum 16D rev 127> at 0x388 irq 10 dma 5
> Leaving handle_sony_cd_attention at 1004
> Sony I/F CDROM : SONY     CD-ROM CDU33A    Rev 1.0c
>   Capabilities: tray, audio, eject, LED, elec. Vol, sep. Vol, double speed
> Entering sony_get_toc
> [ a great many leaving/entering and other debug printks ]

I've left the debugging enabled because I feel that it might be needed. 
My drive is rev 1.0d. I wonder if there's anyone who still has (working) 
single-speed CDU31A drive.
Also I have tested only polled mode - interrupts and DMA disabled on the 
controller (the driver does not support DMA anyway and the comments say 
that it is not good for double speed drives).

> and I could actually mount CD-ROMs and copy stuff from them. One thing, 
> a full 'dd' does not work:
> 
> root@5vd5:~# dd if=/dev/sonycd of=test.iso
> 0+0 records in
> 0+0 records out
> root@5vd5:~# ls -l test.iso
> -rw-r--r--  1 root root 0 2004-11-07 20:41 test.iso

I'll try to fix this problem.

> no oopses, nor specific complaints in dmesg.

It (sometimes?) does bad things for me when I use "eject -x 1" (or 2) to 
change the speed while copying files. I think that it's because of 
bad/no locking.

> Good job though, as far as I'm concerned. Once you have a final version, 
> you may want to submit this directly to Linus or maybe to Al Viro. He 
> sometimes looks at these drivers. I added him to the CC...

-- 
Ondrej Zary
