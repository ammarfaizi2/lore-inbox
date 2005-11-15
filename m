Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVKOOLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVKOOLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVKOOLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:11:19 -0500
Received: from mail.dvmed.net ([216.237.124.58]:39080 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932389AbVKOOLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:11:19 -0500
Message-ID: <4379EC82.1030509@pobox.com>
Date: Tue, 15 Nov 2005 09:11:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379E5F7.6000107@gmail.com>
In-Reply-To: <4379E5F7.6000107@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> * prb->fis doesn't contain proper signature after phy reset.  I just 

This makes sense.  Each PRB slot in the card's RAM only contains 
something useful after you have submitted a PRB, and had some results 
returned.


> * As all commands hang after failed TUR, which BTW fails rightfully with 
> 06h (UNIT ATTENTION due to prior reset) and then 02h's (NOT READY), I 
> avoided TUR failures by issuing REQUEST SENSE first, which returns NO 
> SENSE but does clear UA condition, and then waiting for more than 10secs 
> to give the drive time to become ready.

10 seconds is certainly a long time.

grep for msleep(150) in libata code, though.


> * With above two changes, no command fails and I can mount the cdrom.
> 
> ------------------
> 
> And here are things that I've found out so far....
> 
> * ATAPI commands without data (TEST_UNIT_READY, ALLOW_MEDIUM_REMOVAL...) 
> work happily with any prb->ctrl flag (no flag, PRB_CTRL_PACKET_READ or 
> PRB_CTRL_PACKET_WRITE).

I suppose no-flag is the right answer, then...


> * Currently, sil24_reset_controller() is called on every error interrupt 
> to make sure the controller is ready for further operation. 
> Unfortunately, the current reset_controller() seems to reset PHY too. 
> The drive becomes NOT READY after reset_controller().  So, when TUR 
> fails, it falls into TUR, fail with NOT READY, reset which makes the 
> drive NOT READY again cycle.

Standard init sequence includes checking SStatus, then if a device is 
present, waiting until Port Ready (bit 31) of PORT_CTRL_STAT is set.  It 
doesn't look like sata_sil24 does that.


> * Wihtout sil24_reset_controller(), no further command can be issued. 
> The controller doesn't seem to be operating normally after DEV_ERR.

The port stops, when any error occurs.  For device errors, set 
PORT_CS_INIT bit in PORT_CTRL_STAT, then wait for Port Ready (bit 31, 
see above).


> So, what we need to know to make sil24 work happily with ATAPI devices.
> 
> * How to get device signature on initialization.

AFAICS, you _must_ send a soft reset PRB.  This will be needed anyway, 
for port multiplier support.


> * How to make the controller operational again after a DEV_ERR without 
> affecting the attached device.

Assert PORT_CS_INIT, then wait for Port Ready.  __ONLY__ do this for 
errors PORT_CERR_DEV and PORT_CERR_SDB.

	Jeff


