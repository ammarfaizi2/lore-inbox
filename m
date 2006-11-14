Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933370AbWKNKIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370AbWKNKIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 05:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933373AbWKNKIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 05:08:53 -0500
Received: from s1.mailresponder.info ([193.24.237.10]:62472 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S933370AbWKNKIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 05:08:52 -0500
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
From: Mathieu Fluhr <mfluhr@nero.com>
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <455923B5.3030608@gmail.com>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
	 <455923B5.3030608@gmail.com>
Content-Type: text/plain
Organization: Nero AG
Date: Tue, 14 Nov 2006 11:08:11 +0100
Message-Id: <1163498891.3005.11.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 11:02 +0900, Tejun Heo wrote:
> Hello, Mattieu Fluhr.
> 
> Mathieu Fluhr wrote:
> > The problem is that, on SATA devices controlled by libata, on some big
> > files (like for example a 600 MB file) the READ command seems to fail
> > and outputs garbage (not 1 or 2 bytes diff, but the whole buffer).
> >  -> This problem does not come out everytime, and each time on    
> >     different sectors.
> > 
> > Please note that:
> > - it is not chipset dependant (tested on nforce4 and sii3114)
> > - it is not medium or device dependant
> 
> Hmmm... Interesting.  So, you're reading the media by directly issuing 
> commands through the sg interface, right?  Can you please try the 
> followings?
> 
> * Try using /dev/srX or /dev/scdX device instead of /dev/sgX.  You can 
> use the command SG_IO but the code path is different, so it will help us 
> rule out sg bug.
> 
> * Perform rounds of read-verify test using standard block interface (ie. 
> simply opening /dev/srX and reading it).
I will try this and report the results.

> 
> [--snip--]
> > - When I force the bus type to be IDE, our software will then send ATA
> > commands. In this case, everything works like a charm. No errors at all.
> 
> What do you mean by 'sending ATA commands'?  libata exports all devices 
> as SCSI devices.  For ATA devices, you can use ATA passthrough but you 
> send CDBs to ATAPI devices anyway.
Inside our code, we first guess which the bus type of every device using
an INQUIRY cmd (0x12). 
- If the device appears to be a SCSI one, then we send "pure" SCSI CDBs
- For an IDE device, we do, as described in the Annex A of the MMC-5
spec, and pad each CDBs to 12 bytes.

So in the case of a READ CDB, we send 10 bytes if the device is a SCSI
one and 12 for IDE one.


> 
> Thanks.
> 

