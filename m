Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVKKTit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVKKTit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVKKTit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:38:49 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:48862 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750820AbVKKTis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:38:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/1] cciss: scsi error handling
Date: Fri, 11 Nov 2005 13:38:47 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E10640A7A540D@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] cciss: scsi error handling
Thread-Index: AcXmtDK2/Fap0ijTQk+j4Xy566e0swAPyDzk
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 11 Nov 2005 19:38:47.0385 (UTC) FILETIME=[88A67C90:01C5E6F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Two comments:
>
> 1) CONFIG_CISS_SCSI_TAPE should be CONFIG_CCISS_SCSI_TAPE, IMO
>
> 2) is any locking needed in your scsi eh reset handlers?  recent 
> kernels eliminate the lock that's been traditionally held around 
> the handlers.

About the locking first,

So, there's one part that I was a little worried about, where
it does this in a couple places:

        c = (ctlr_info_t **) &scsicmd->device->host->hostdata[0];

(gets our adapter structure by following pointers in the scsi
command)

So, if that pointer chain can change suddenly, then my code is bad.

Can doing "echo scsi remove-single-device . . . > /proc/scsi/scsi"
cause that pointer chain to break?  I noticed I can yank a disk
out from under a mounted filesystem with 
"echo scsi remove-single-device"  It wasn't obvious to me whether
doing that would affect that pointer chain though, though I could
imagine it might.

Or am I barking up the wrong tree worrying about 
the scsicmd->device->host->hostdata pointer chain
getting yanked out from under me?

Apart from possibly the two places where I do that, 
I think it's ok.

About the CONFIG_CISS_SCSI_TAPE, we can change that, although
it's been that way for years, and was following the 
BLK_CPQ_CISS_DA which was there since the drivers inception.
Does it unnecessarily break people's existing .config files?
(not badly of course.)

-- steve

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Fri 11/11/2005 5:36 AM
To: Miller, Mike (OS Dev)
Cc: axboe@suse.de; linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Cameron, Steve
Subject: Re: [PATCH 1/1] cciss: scsi error handling
 
mike.miller@hp.com wrote:
> PATCH 1 of 1
> 
> This patch adds SCSI error handling code to the SCSI portion 
> of the cciss driver.
> 
> Signed-off-by: Stephen M. Cameron <steve.cameron@hp.com>
> Acked-by: Mike Miller <mike.miller@hp.com>

> +#ifdef CONFIG_CISS_SCSI_TAPE

Two comments:

1) CONFIG_CISS_SCSI_TAPE should be CONFIG_CCISS_SCSI_TAPE, IMO

2) is any locking needed in your scsi eh reset handlers?  recent kernels 
eliminate the lock that's been traditionally held around the handlers.

	Jeff



