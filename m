Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWCUB2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWCUB2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWCUB2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:28:17 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47333 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964928AbWCUB2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:28:16 -0500
Message-ID: <441F56AD.8020001@garzik.org>
Date: Mon, 20 Mar 2006 20:28:13 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <441B5AD5.5020809@garzik.org> <20060318080618.GA19929@ti64.telemetry-investments.com> <441BCB3C.6060202@garzik.org> <20060319232317.GA25578@ti64.telemetry-investments.com>
In-Reply-To: <20060319232317.GA25578@ti64.telemetry-investments.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.3 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Rugolsky Jr. wrote:
> On Sat, Mar 18, 2006 at 03:56:28AM -0500, Jeff Garzik wrote:
> 
>>OK, can you try the attached sata_nv.c?  Does it perform to the level 
>>that yours does?
> 
>  
> Yes, the results are approximately the same.  Booting from port 0 (sda)
> with ADMA enabled still results in timeouts on port 3 (sdc) while
> running tars on the RAID1 array on ports 2&3.

Thanks a lot for testing.

I've stored the sata_nv updates I sent you in the 'nv-adma' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git


> ata4: command 0x25 timeout, stat 0x50
> ata4: command 0x25 timeout, stat 0x50
> (           xterm-3349 |#0): new 355 us maximum-latency wakeup.
> (      watchdog/0-4    |#0): new 468 us maximum-latency wakeup.
> ata4: command 0x35 timeout, stat 0x50
> ata4: command 0x35 timeout, stat 0x50
> ata4: command 0x35 timeout, stat 0x50
> ata4: command 0x35 timeout, stat 0x50
> ata4: command 0x35 timeout, stat 0x50
> ata4: command 0x35 timeout, stat 0x50
> 
> After a while, syncing the filesystems hangs the sync process, though
> the system continues to function, and I can log in on another VC.

hmmm.  Sounds like some attention should be paid to the error handling 
portion of the code.


> The good news: no long latencies from the status inb() during the
> period that it is functional! :-p

heh :)

Dumb question, to be certain that I understood your first paragraph: 
you do indeed see at least -some- success talking to devices on port 1, 
2, 3... ?  i.e. not just port 0 works?


> Booting without ADMA gives the usual stable behavior, with the long
> latencies from the status inb().

Weird.  Well, now that we appear to have narrowed the non-ADMA case down 
to inb(), I'm going to punt this one as not-my-problem ;-)


> I was a little disconcerted when I saw this this in the trace with ADMA
> disabled,
> 
>    tar-21466 0dnh. 3979us : nv_check_hotplug_adma (nv_interrupt)
> 
> until I realized that this
> 
>         if (!adma_enabled && host_desc->host_type == ADMA)
>                 host_desc->host_type--;
> 
> only alters the outcome of the "host_desc->host_type == ADMA" test, but
> still uses the ADMA-based hotplug functions.

Yep.  That's part of my general plan to eliminate all the

	if (adma)
		foo
	else
		bar

type code in favor to create separate ADMA and non-ADMA hooks. 
Particularly in the key hot paths, sata_nv should avoid asking "are we 
ADMA?" all the time.

	Jeff


