Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWA0LMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWA0LMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWA0LMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:12:22 -0500
Received: from ns.suse.de ([195.135.220.2]:48564 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964986AbWA0LMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:12:22 -0500
From: Neil Brown <neilb@suse.de>
To: Chase Venters <chase.venters@clientec.com>
Date: Fri, 27 Jan 2006 22:11:54 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17369.65530.747867.844964@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, axboe@suse.de, askernel2615@dsgml.com,
       jamie@audible.transient.net
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
In-Reply-To: message from Chase Venters on Friday January 27
References: <200601270410.06762.chase.venters@clientec.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday January 27, chase.venters@clientec.com wrote:
> Greetings,
> 	Just a quick recap - there are at least 4 reports of 2.6.15 users 
> experiencing severe slab leaks with scsi_cmd_cache. It seems that a few of us 
> have a board (Asus P5GDC-V Deluxe) in common. We seem to have raid in common. 
> 	After dealing with this leak for a while, I decided to do some dancing around 
> with git bisect. I've landed on a possible point of regression:
> 
> commit: a9701a30470856408d08657eb1bd7ae29a146190
> [PATCH] md: support BIO_RW_BARRIER for md/raid1
> 
> 	I spent about an hour and a half reading through the patch, trying to see if 
> I could make sense of what might be wrong. The result (after I dug into the 
> code to make a change I foolishly thought made sense) was a hung kernel.
> 	This is important because when I rebooted into the kernel that had been 
> giving me trouble, it started an md resync and I'm now watching (at least 
> during this resync) the slab usage for scsi_cmd_cache stay sane:
> 
> turbotaz ~ # cat /proc/slabinfo | grep scsi_cmd_cache
> scsi_cmd_cache        30     30    384   10    1 : tunables   54   27    8 : 
> slabdata      3      3      0
> 

This suggests that the problem happens when a BIO_RW_BARRIER write is
sent to the device.  With this patch, md flags all superblock writes
as BIO_RW_BARRIER However md is not so likely to update the superblock often
during a resync.

There is a (rough) count of the number of superblock writes in the
"Events" counter which "mdadm -D" will display.
You could try collecting 'Events' counter together with the
'active_objs' count from /proc/slabinfo and graph the pairs - see if
they are linear.

I believe a BIO_RW_BARRIER is likely to send some sort of 'flush'
command to the device, and the driver for your particular device may
well be losing scsi_cmd_cache allocation when doing that, but I leave
that to someone how knows more about that code.

Good detective work!

NeilBrown
