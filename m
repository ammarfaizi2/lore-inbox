Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSGPLk0>; Tue, 16 Jul 2002 07:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSGPLkZ>; Tue, 16 Jul 2002 07:40:25 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15366 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315805AbSGPLkX> convert rfc822-to-8bit; Tue, 16 Jul 2002 07:40:23 -0400
Message-ID: <3D3406D4.8010403@evision-ventures.com>
Date: Tue, 16 Jul 2002 13:43:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.gmd.de>
CC: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <200207161128.g6GBSJPE021316@burner.fokus.gmd.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Joerg Schilling napisa³:
>>From James.Bottomley@steeleye.com Mon Jul 15 18:09:52 2002
> 
> 
>>Actually, the diagram is very similar to what we possess internally today.
> 
> 
>>This represents where I think the SCSI stack is going:
> 
> 
>>                  User Level
>>--------------------------------------------------------------
> 
> 
>>+----------------+   +---------------------+
>>| Block Interface|   | Character Interface |
>>+----------------+   +---------------------+
>>        |                        |
>>        |   +--------------------+
> 
> 
> Why should the character interface be connected to the block layer?
> This would contradict UNIX rules.

Bullshit. UNIX sees even every single block device as both: char and block
even under the same major number. The reason above is - tape devices.

> Why should the error handlers interface with the block layer?
> This is not true for UNIX and it would not help. However, it would
> be nice to have a way to make the blocklayer find out that e.g. 
> only the last sector  of a multi sector read ahead instruction 
> did fail.

You answer yourself.

>>The driving vision for this is to move into the generic block layer as much of 
>>the individual transport stack as makes sense (i.e. if other transports can 
>>make use of the functions), so, for example, Tag command queueing is already 
>>in there and shared between IDE and SCSI.
> 
> 
> AFAIK, tagged command queuing is a SCSI specific property, why should this
> be part of a generif block layer?

Becouse it is not SCSI specific. SerialATA will *nearly* require it.
And there are ATA disks out there which do it *right now* too.

>>The ultimate end point will be when the correct balance between what belongs 
>>in the generic block layer and what belongs in the transport helpers is 
>>achieved.  I speculate that, for CDROMS, this will lead to two small request 
>>prep modules sharing quite a large helper library (The helper library would do 
>>SCSI command translation, and probably the IDE prep module would fix up the 
>>transport command for the specific device).  However, I don't rule out that it 
>>would lead to a single prep module for both IDE and SCSI.
> 
> 
> With my proposal, anything that speaks SCSI is used via SCSI commands and a 
> generic SCSI driver like scg.c could access the SCSI transport aware drives
> of any type. An important (communication baesed) feature of my SCSI glue layer 
> would be to make it possible to insert SCSI commands from scg.c without making 
> sd.c believe that something strange and unexpected happened to one of it's drives.

Your proposal has one flaw - it thinks that SCSI is the mother of
all block devices and thinks that the kernel should have a SCSI driver
with some kind of direct translation for any other devices. This is
wrong becouse you go:

1. abstract access.
2. SCSI access.
3. back to abstract access.
4. ATA access.

This is at least not fine. The proposal by James takes in to
account that dealing with ATAPI ver. SCSI MMC shouldn't be done
on any kind of "layer" it fits better in the abstraction
of an utility library supposed to help unify code. But not an
additional layer between the generic one and the device transfer.
You have to have an independant transport layer for IDE attached
devices becouse the whole handling of the transfer works significantly
different from SCSI.

The proposal for pushing much of the SCSI-midlayer is simple
due to the realization that the generic BIO layer became more
intelligent in the time between. See recent SCSI TCQ handling changes.

