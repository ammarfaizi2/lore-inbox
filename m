Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVKPDTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVKPDTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVKPDTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:19:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:9648 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965200AbVKPDTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:19:03 -0500
Message-ID: <437AA51A.6000709@pobox.com>
Date: Tue, 15 Nov 2005 22:18:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379E5F7.6000107@gmail.com> <4379EC82.1030509@pobox.com> <437AA1A0.6080409@gmail.com>
In-Reply-To: <437AA1A0.6080409@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>>
>> The port stops, when any error occurs.  For device errors, set 
>> PORT_CS_INIT bit in PORT_CTRL_STAT, then wait for Port Ready (bit 31, 
>> see above).
>>
> 
> Yeap, this did the trick.  I'm working on SRST/init stuff and I think I 
> can post patches later today.  What workload do you use for testing a 
> ATAPI device?  I'm currently thinking of the following...
> 
> * mounting & tarr'ing cdrom & unmount
> * repeat above with eject/load
> * burning a cdrom
> * ripping a music cd with cdparanoia
> 
> Any other thing I can try?

I burn Fedora Core CDs and DVDs, and then run
	/usr/lib/anaconda-runtime/checkisomd5 --verbose /dev/scd0

FC ISOs, and probably many others as well, appear to contain embedded 
checksums.  This is a really good test, I've found.  I'll burn CDs/DVDs, 
then use that to validate them on another machine.  Or I'll use 
checkisomd5 simply as a test of libata ATAPI itself.

On a side note:

As a scan through tons of operating system code and vendor drivers 
shows, as well as behavior I'm seeing on my AHCI + Plextor setup, it is 
probably helpful for the OS driver to issue internal retries, if the 
command returns NOT READY.

My setup works without it, successfully burning CDs and DVDs, but has 
problems with really long commands, and such those which occur when 
cdrecord(1) finishes a CD burn, and performs its "fixating" step.

It may also be helpful to issue TUR until NOT READY goes away, in 
ata_bus_probe() after ata_set_mode() completes.

	Jeff


