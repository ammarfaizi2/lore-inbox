Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWC0BOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWC0BOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 20:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWC0BOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 20:14:39 -0500
Received: from anubis.pendulus.net ([38.119.36.60]:17582 "EHLO
	anubis.pendulus.net") by vger.kernel.org with ESMTP
	id S1750892AbWC0BOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 20:14:38 -0500
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Date: Sun, 26 Mar 2006 20:14:35 -0500
User-Agent: KMail/1.9.1
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <20060319232317.GA25578@ti64.telemetry-investments.com> <441F56AD.8020001@garzik.org>
In-Reply-To: <441F56AD.8020001@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603262014.35466.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jeff,

Using Bill's original patch I was able to boot up perfectly with adma support 
enabled on my workstation. Even after several stress tests ( 
tar -cf /dev/null . , and dd if=/dev/sda of=/dev/null ), everything seems to 
be a-ok. However when I tried the sata_nv.c file that you sent to Bill, I 
kept on getting hardlocks, and thus was unable to stress test your version. 

Also for note, I heve not received any of the timeout problems reported by 
Bill. Nor have I had any latency problems with adma enabled.

Matt Heler

On Monday 20 March 2006 8:28 pm, Jeff Garzik wrote:
> Bill Rugolsky Jr. wrote:
> > On Sat, Mar 18, 2006 at 03:56:28AM -0500, Jeff Garzik wrote:
> >>OK, can you try the attached sata_nv.c?  Does it perform to the level
> >>that yours does?
> >
> > Yes, the results are approximately the same.  Booting from port 0 (sda)
> > with ADMA enabled still results in timeouts on port 3 (sdc) while
> > running tars on the RAID1 array on ports 2&3.
>
> Thanks a lot for testing.
>
> I've stored the sata_nv updates I sent you in the 'nv-adma' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
> > ata4: command 0x25 timeout, stat 0x50
> > ata4: command 0x25 timeout, stat 0x50
> > (           xterm-3349 |#0): new 355 us maximum-latency wakeup.
> > (      watchdog/0-4    |#0): new 468 us maximum-latency wakeup.
> > ata4: command 0x35 timeout, stat 0x50
> > ata4: command 0x35 timeout, stat 0x50
> > ata4: command 0x35 timeout, stat 0x50
> > ata4: command 0x35 timeout, stat 0x50
> > ata4: command 0x35 timeout, stat 0x50
> > ata4: command 0x35 timeout, stat 0x50
> >
> > After a while, syncing the filesystems hangs the sync process, though
> > the system continues to function, and I can log in on another VC.
>
> hmmm.  Sounds like some attention should be paid to the error handling
> portion of the code.
>
> > The good news: no long latencies from the status inb() during the
> > period that it is functional! :-p
>
> heh :)
>
> Dumb question, to be certain that I understood your first paragraph:
> you do indeed see at least -some- success talking to devices on port 1,
> 2, 3... ?  i.e. not just port 0 works?
>
> > Booting without ADMA gives the usual stable behavior, with the long
> > latencies from the status inb().
>
> Weird.  Well, now that we appear to have narrowed the non-ADMA case down
> to inb(), I'm going to punt this one as not-my-problem ;-)
>
> > I was a little disconcerted when I saw this this in the trace with ADMA
> > disabled,
> >
> >    tar-21466 0dnh. 3979us : nv_check_hotplug_adma (nv_interrupt)
> >
> > until I realized that this
> >
> >         if (!adma_enabled && host_desc->host_type == ADMA)
> >                 host_desc->host_type--;
> >
> > only alters the outcome of the "host_desc->host_type == ADMA" test, but
> > still uses the ADMA-based hotplug functions.
>
> Yep.  That's part of my general plan to eliminate all the
>
> 	if (adma)
> 		foo
> 	else
> 		bar
>
> type code in favor to create separate ADMA and non-ADMA hooks.
> Particularly in the key hot paths, sata_nv should avoid asking "are we
> ADMA?" all the time.
>
> 	Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
