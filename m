Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVEXKq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVEXKq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVEXJ1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:27:02 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:3778 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261985AbVEXJRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:17:44 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091743.57515FA3F@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:17:43 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 7FFC0FA56

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 06:39:37 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261359AbVEXDaf (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 23:30:35 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVEXDaf

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 23:30:35 -0400

Received: from mail.dvmed.net ([216.237.124.58]:20684 "EHLO mail.dvmed.net")

	by vger.kernel.org with ESMTP id S261338AbVEXDaL (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 23:30:11 -0400

Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])

	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))

	id 1DaQ7L-0001CU-2J; Tue, 24 May 2005 03:30:07 +0000

Message-ID: <42929FBB.3060707@pobox.com>

Date:	Mon, 23 May 2005 23:30:03 -0400

From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5

X-Accept-Language: en-us, en

MIME-Version: 1.0

To: Andy Stewart <andystewart@comcast.net>
Cc: akpm@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: enable-reads-on-plextor-712-sa-on-26115.patch added to -mm tree

References: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net> <4292628E.4090209@pobox.com> <4292743C.4040409@comcast.net>

In-Reply-To: <4292743C.4040409@comcast.net>

Content-Type: text/plain; charset=us-ascii; format=flowed

Content-Transfer-Encoding: 7bit

X-Spam-Score: 0.0 (/)

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



Andy Stewart wrote:
> Jeff Garzik wrote:
>>By hardcoding so much of the inquiry data, this patch -overwrites- valid
>>inquiry data provided by the device, with generic data.  This patch
>>makes generic the probe data that the SCSI layer -depends on to be
>>different-.

> The SCSI inquiry command does not work on this device for reasons
> unknown to me.  I saw in the code where the SCSI inquiry command was
> "emulated", or handled in software, for ATA devices.  I simply copied
> that method for ATAPI devices.  At least that was my intent.  I cloned
> one function, modified it slightly, and (I thought) called it in a
> reasonable place.

All of SCSI is emulated for ATA; for ATAPI, 99% of SCSI is passed 
through to the underlying device.  The two must be treated very differently.

The SCSI layer needs to see the per-device data returned by passing the 
INQUIRY command to the device via the ATA PACKET command.


>>Effectively you made one CD-ROM device work, killed all the others, and
>>enabled an oops generator.
> 
> 
> I fail to see how other devices would have been killed by this patch.

The SCSI layer discovers, and interprets devices based on the data 
returned by the INQUIRY command.  Your patch causes the kernel to act as 
if all ATAPI devices behave just like your Plextor, which is very very 
wrong.

It's a good thing nobody tried to use an ATAPI tape drive with your 
patch, for example.  The kernel would have thought it was a CD-ROM, and 
tried to talk to it as such.


> I tested this patch on my system with many different reads, mounts, and
> unmounts and never generated an oops.  Would you tell me what you did
> that caused an oops?  That would help me to improve my testing before
> attempting to submit future patches.

Any use of ATAPI in certain drivers (like AHCI) will cause an oops, 
because those drivers are not yet fully ATAPI aware.


>>Good show.
> 
> 
> Aw, come on, Jeff.  I gave it a shot, I'm trying to give back to the
> community rather than simply complain.  OK, so my work isn't perfect,
> and you've pointed ont valid technical reasons why.  At least *I tried*
> to contribute code rather than just offering complaints, and I'm willing
> to admit that I'll need to try harder in the future.

There's nothing wrong with contributing to ATAPI debugging and development!

We just don't need to be merging such a broken patch into -mm, where it 
will cause more headaches than it will solve.

Thou Shalt Not Turn On ATAPI Before Its Time.  It's still in the realm 
of debugging patches.

	Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

