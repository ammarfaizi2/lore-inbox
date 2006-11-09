Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424080AbWKIPuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424080AbWKIPuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424078AbWKIPuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:50:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41430 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1424070AbWKIPuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:50:08 -0500
Message-ID: <45534E2B.10303@torque.net>
Date: Thu, 09 Nov 2006 10:50:03 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Jens Axboe <jens.axboe@oracle.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       monty@xiph.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com> <20061030114503.GW4563@kernel.dk> <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com> <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org> <45533468.1060400@gmail.com>
In-Reply-To: <45533468.1060400@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> [CC'ing Monty and Douglas.]
> 
> Hello, the original thread can be read from the following URL.
> 
> http://thread.gmane.org/gmane.linux.ide/13708/focus=13708
> 
> Brice Goglin wrote:
>> ens Axboe wrote:
>>> On Mon, Oct 30 2006, Gregor Jasny wrote:
>>>  
>>>> 2006/10/30, Jens Axboe <jens.axboe@oracle.com>:
>>>>    
>>>>> Can you confirm that 2.6.18 works?
>>>>>       
>>>> The reporter of [1] states that his SATA Thinkpad freezes with 2.6.17
>>>> and 2.6.18, too.
>>>>
>>>> Gregor
>>>>
>>>> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=391901
>>>>     
>>> Ok, mainly just checking if this was a potential dupe of another bug.
>>>
>>>   
>>
>> Jens (or anybody else who has any idea of how to debug this),
>>
>> Did you have a chance to reproduce the problem? I guess we "only" need a
>> machine with SATA/ata_piix and cdparanoia 3.10. If you want me to debug
>> some stuff, feel free to tell me what. But, since it freezes the machine
>> and sysrq doesn't even work, I don't really know what to try...
>>
>> I just tried on rc5 and rc5-mm1, both have the problem (as 2.6.16, .17
>> and .18 do, don't know about earlier kernels). I didn't have a audio CD
>> here, so I tried abcde on a DVD on purpose. With cdparanoia 3.10-pre0
>> (from Debian testing), it reports nothing during about 5 seconds and
>> then the machine freezes. With cdparanoia 3a9.8-11 (from Debian stable),
>> it reports an error very quickly, and dmesg gets a couple line like
>> these:
>>     sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing
>> data in;
>>        program cdparanoia not setting count and/or reply_len properly
> 
> Okay, here's the story.
> 
> In interface/scan_devices.c::cdda_identify_scsi(), cdparanoia calls
> scsi_inquiry() to identify the device and determine interface type. This
> seems to be the first time to actually issue commands to the device.  As
> interface type isn't completely determined, for sg devices, it first
> issues the command w/ d->interface set to SGIO_SCSI.  If that fails, it
> falls back to SGIO_SCSI_BUGGY1.
> 
> For to-device request, both SGIO_SCSI and SGIO_SCSI_BUGGY1 set
> sg_io_hdr.dxfer_direction to SG_DXFER_TO_DEV.  But for from-device
> request, SGIO_SCSI uses SG_DXFER_TO_FROM_DEV while SGIO_SCSI_BUGGY1 uses
> SG_DXFER_FROM_DEV.  So, cdparanoia first issues inquiry w/
> SG_DXFER_TO_FROM_DEV and if that fails falls back to SG_DXFER_FROM_DEV.
> 
> drivers/scsi/sg.c interprets SG_DXFER_TO_FROM_DEV as read while
> block/scsi_ioctl.c interprets it as write.  I guess this is historic
> thing (scsi/sg.c updated but block/scsi_ioctl.c is forgotten).  As
> written above, cdparanoia can handle both cases as long as the kernel
> promptly fails command issued with the wrong direction.
> 
> This works for most PATA ATAPI devices.  Most devices detect reversed
> transfer and terminate the command promptly.  But this doesn't seem to
> be true for SATA device.  Many just hang and time out commands with the
> wrong transfer direction.  If you consider that most early SATA ATAPI
> devices are actually PATA + bridge, this is sorta inevitable.  The
> PATA-SATA bridge cannot issue D2H FIS to abort the command by itself.
> It's just mirroring the status of PATA side and PATA side doesn't know
> SATA protocol mismatch has occurred.
> 
> So, IDENTIFY w/ write-DMA protocol times out after quite some seconds.
> This is where things go worse from bad.  SATA controllers which have
> shadow TF registers don't handle timeout conditions very well,
> especially when they're waiting for data transfer.  They basically hold
> the PCI bus and hang till the transfer completes (which never happens).
>  That's where the hard lock up comes from.
> 
> Jens, I think we need to match block sg's behavior to SCSI's.  Monty,
> the timeout and hard lock up are due to hardware restrictions.  Kernel
> and libata can't do much about it.  So, please find other way to detect
> interface.

Tejun,
Your SG_DXFER_TO_FROM_DEV analysis is correct.

The stupid ~!@# who wrote the code, and the documentation
for it, defined SG_DXFER_TO_FROM_DEV to mean a "transfer
from device" operation where the kernel buffer receiving
the DMA transfer was prefilled with data that the application
provided. That certainly isn't a bidirectional transfer to/from
the device, but it is a bidirectional transfer to kernel
buffers when indirect IO is used.

Why do this? Because the 'resid' field indicating how much
less data was transferred in a "from_device" transfer than
was requested, was not added to SCSI infrastructure till much
later. There are still LLDs out there that don't implement it.
It also reflected a similar technique used with the sg_header
structure (circa 1992) for precisely the same reason. And
application writers wanted that functionality. Joerg was the
first name of one such application writer.


Coincidentally I am sitting on a patch from Luben Tuikov
to cause the same breakage in the sg driver itself.
Nobody has proposed a patch to the documentation for
the explanation of SG_DXFER_TO_FROM_DEV :-)
    http://www.torque.net/sg/p/sg_v3_ho.html


As I am currently proposing a SCSI pass through version 4
interface with twin scatter gather lists for independent
bidirectional transfers for SCSI commands, I'm not sure
what setting DMA_BIDIRECTIONAL in the existing interface
buys us.


When you maintain and document a pass through interface you
sit between two groups of people that have conflicting goals
and don't have a particularly high opinion of each other.

Doug Gilbert


