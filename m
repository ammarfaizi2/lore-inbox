Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWA0LV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWA0LV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWA0LV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:21:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19300 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964995AbWA0LVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:21:55 -0500
Date: Fri, 27 Jan 2006 12:23:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, akpm@osdl.org, a.titov@host.bg,
       askernel2615@dsgml.com, jamie@audible.transient.net
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
Message-ID: <20060127112352.GF4311@suse.de>
References: <200601270410.06762.chase.venters@clientec.com> <17369.65530.747867.844964@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17369.65530.747867.844964@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Neil Brown wrote:
> On Friday January 27, chase.venters@clientec.com wrote:
> > Greetings,
> > 	Just a quick recap - there are at least 4 reports of 2.6.15 users 
> > experiencing severe slab leaks with scsi_cmd_cache. It seems that a few of us 
> > have a board (Asus P5GDC-V Deluxe) in common. We seem to have raid in common. 
> > 	After dealing with this leak for a while, I decided to do some dancing around 
> > with git bisect. I've landed on a possible point of regression:
> > 
> > commit: a9701a30470856408d08657eb1bd7ae29a146190
> > [PATCH] md: support BIO_RW_BARRIER for md/raid1
> > 
> > 	I spent about an hour and a half reading through the patch, trying to see if 
> > I could make sense of what might be wrong. The result (after I dug into the 
> > code to make a change I foolishly thought made sense) was a hung kernel.
> > 	This is important because when I rebooted into the kernel that had been 
> > giving me trouble, it started an md resync and I'm now watching (at least 
> > during this resync) the slab usage for scsi_cmd_cache stay sane:
> > 
> > turbotaz ~ # cat /proc/slabinfo | grep scsi_cmd_cache
> > scsi_cmd_cache        30     30    384   10    1 : tunables   54   27    8 : 
> > slabdata      3      3      0
> > 
> 
> This suggests that the problem happens when a BIO_RW_BARRIER write is
> sent to the device.  With this patch, md flags all superblock writes
> as BIO_RW_BARRIER However md is not so likely to update the superblock often
> during a resync.
> 
> There is a (rough) count of the number of superblock writes in the
> "Events" counter which "mdadm -D" will display.
> You could try collecting 'Events' counter together with the
> 'active_objs' count from /proc/slabinfo and graph the pairs - see if
> they are linear.
> 
> I believe a BIO_RW_BARRIER is likely to send some sort of 'flush'
> command to the device, and the driver for your particular device may
> well be losing scsi_cmd_cache allocation when doing that, but I leave
> that to someone how knows more about that code.

I already checked up on that since I suspected barriers initially. The
path there for scsi is sd.c:sd_issue_flush() which looks pretty straight
forward. In the end it goes through the block layer and gets back to the
SCSI layer as a regular REQ_BLOCK_PC request.

-- 
Jens Axboe

