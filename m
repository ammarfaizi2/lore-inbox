Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWCSXXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWCSXXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 18:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWCSXXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 18:23:19 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:49860 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751224AbWCSXXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 18:23:19 -0500
Date: Sun, 19 Mar 2006 18:23:17 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Message-ID: <20060319232317.GA25578@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <441B5AD5.5020809@garzik.org> <20060318080618.GA19929@ti64.telemetry-investments.com> <441BCB3C.6060202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441BCB3C.6060202@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 03:56:28AM -0500, Jeff Garzik wrote:
> OK, can you try the attached sata_nv.c?  Does it perform to the level 
> that yours does?
 
Yes, the results are approximately the same.  Booting from port 0 (sda)
with ADMA enabled still results in timeouts on port 3 (sdc) while
running tars on the RAID1 array on ports 2&3.

ata4: command 0x25 timeout, stat 0x50
ata4: command 0x25 timeout, stat 0x50
(           xterm-3349 |#0): new 355 us maximum-latency wakeup.
(      watchdog/0-4    |#0): new 468 us maximum-latency wakeup.
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50
ata4: command 0x35 timeout, stat 0x50

After a while, syncing the filesystems hangs the sync process, though
the system continues to function, and I can log in on another VC.

The good news: no long latencies from the status inb() during the
period that it is functional! :-p

Booting without ADMA gives the usual stable behavior, with the long
latencies from the status inb().

I was a little disconcerted when I saw this this in the trace with ADMA
disabled,

   tar-21466 0dnh. 3979us : nv_check_hotplug_adma (nv_interrupt)

until I realized that this

        if (!adma_enabled && host_desc->host_type == ADMA)
                host_desc->host_type--;

only alters the outcome of the "host_desc->host_type == ADMA" test, but
still uses the ADMA-based hotplug functions.

   -Bill

