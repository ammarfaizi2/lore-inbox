Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWA0TGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWA0TGp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWA0TGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:06:45 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:63123 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932372AbWA0TGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:06:44 -0500
Message-ID: <43DA6F33.3070101@cs.wisc.edu>
Date: Fri, 27 Jan 2006 13:06:27 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Neil Brown <neilb@suse.de>, Chase Venters <chase.venters@clientec.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       a.titov@host.bg, askernel2615@dsgml.com, jamie@audible.transient.net
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
References: <200601270410.06762.chase.venters@clientec.com> <17369.65530.747867.844964@cse.unsw.edu.au> <20060127112352.GF4311@suse.de> <20060127112837.GG4311@suse.de>
In-Reply-To: <20060127112837.GG4311@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jan 27 2006, Jens Axboe wrote:
> 
>>On Fri, Jan 27 2006, Neil Brown wrote:
>>
>>>On Friday January 27, chase.venters@clientec.com wrote:
>>>
>>>>Greetings,
>>>>	Just a quick recap - there are at least 4 reports of 2.6.15 users 
>>>>experiencing severe slab leaks with scsi_cmd_cache. It seems that a few of us 
>>>>have a board (Asus P5GDC-V Deluxe) in common. We seem to have raid in common. 
>>>>	After dealing with this leak for a while, I decided to do some dancing around 
>>>>with git bisect. I've landed on a possible point of regression:
>>>>
>>>>commit: a9701a30470856408d08657eb1bd7ae29a146190
>>>>[PATCH] md: support BIO_RW_BARRIER for md/raid1
>>>>
>>>>	I spent about an hour and a half reading through the patch, trying to see if 
>>>>I could make sense of what might be wrong. The result (after I dug into the 
>>>>code to make a change I foolishly thought made sense) was a hung kernel.
>>>>	This is important because when I rebooted into the kernel that had been 
>>>>giving me trouble, it started an md resync and I'm now watching (at least 
>>>>during this resync) the slab usage for scsi_cmd_cache stay sane:
>>>>
>>>>turbotaz ~ # cat /proc/slabinfo | grep scsi_cmd_cache
>>>>scsi_cmd_cache        30     30    384   10    1 : tunables   54   27    8 : 
>>>>slabdata      3      3      0
>>>>
>>>
>>>This suggests that the problem happens when a BIO_RW_BARRIER write is
>>>sent to the device.  With this patch, md flags all superblock writes
>>>as BIO_RW_BARRIER However md is not so likely to update the superblock often
>>>during a resync.
>>>
>>>There is a (rough) count of the number of superblock writes in the
>>>"Events" counter which "mdadm -D" will display.
>>>You could try collecting 'Events' counter together with the
>>>'active_objs' count from /proc/slabinfo and graph the pairs - see if
>>>they are linear.
>>>
>>>I believe a BIO_RW_BARRIER is likely to send some sort of 'flush'
>>>command to the device, and the driver for your particular device may
>>>well be losing scsi_cmd_cache allocation when doing that, but I leave
>>>that to someone how knows more about that code.
>>
>>I already checked up on that since I suspected barriers initially. The
>>path there for scsi is sd.c:sd_issue_flush() which looks pretty straight
>>forward. In the end it goes through the block layer and gets back to the
>>SCSI layer as a regular REQ_BLOCK_PC request.
> 
> 
> Sorry, that was for the ->issue_flush() that md also does but did before
> the barrier addition as well. Most of the barrier handling is done in
> the block layer, but it could show leaks in SCSI of course. FWIW, I
> tested barriers with and without md on SCSI here a few days ago and
> didn't see any leaks at all.
> 

It does not have anything to do with this in scsi_io_completion does it?

         if (blk_complete_barrier_rq(q, req, good_bytes >> 9))
                 return;

For that case the scsi_cmnd does not get freed. Does it come back around 
again and get released from a different path?
