Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbVLJS1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbVLJS1H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 13:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbVLJS1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 13:27:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60302 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161022AbVLJS1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 13:27:04 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <439B1D99.1020507@s5r6.in-berlin.de>
Date: Sat, 10 Dec 2005 19:25:29 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jody McIntyre <scjody@modernduck.com>
CC: stable@kernel.org, torvalds@osdl.org,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       adq@lidskialf.net, linux-kernel@vger.kernel.org
Subject: Re:  [PATCH] sbp2: fix panic when ejecting an ipod
References: <20051210173233.GG19441@conscoop.ottawa.on.ca>
In-Reply-To: <20051210173233.GG19441@conscoop.ottawa.on.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.518) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre wrote:
> On Sat, Dec 10, 2005 at 12:24:59PM +0100, Stefan Richter wrote:
> 
>>sbp2: fix panic when ejecting an ipod
>>
>>Sbp2 did not catch some bogus transfer directions in requests from upper
>>layers.  Problem became apparent when iPods were to be ejected:
>>http://marc.theaimsgroup.com/?l=linux1394-devel&m=113399994920181
>>http://marc.theaimsgroup.com/?l=linux1394-user&m=112152701817435
>>Debugging and original variant of the patch by Andrew de Quincey.
> 
> 
> NAK.  James has a patch to fix this in the SCSI layer, which is his
> preference.

The fix for SCSI mid/high layer is to send the proper transfer 
direction. (BTW, note that there are _many_ places where the transfer 
direction is generated, not just where Jeff's and James' patches correct 
things. The code which generates transfer directions will keep changing. 
Userspace can set transfer directions.)

The fix for sbp2 is to not cause a kernel panic should an improper 
transfer direction be send. All SCSI low level drivers have to handle 
the transfer direction one way or another. Most chose not to panic.

My patch is not the fix for the wrong direction. It is solely meant not 
to crash the whole machine after a minor mistake. Also, my patch is not 
meant to hide mistakes that occurred in higer levels --- and it doesn't 
do so.

I absolutely agree with you et al that bugs must be fixed in the layer 
where they occur. However I also strongly believe that a bug in one 
layer should not trickle down two or more layers and increase the damage 
up to a catastrophe --- *if this can be avoided by simple means*, i.e. 
without bloat. (Note the diffstat. I am basically moving existing code 
up in an if/else cascade. Also, another cleanup for 
sbp2_create_command_orb will follow next week.)

Please apply.

>>Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
>>Cc: Andrew de Quincey <adq@lidskialf.net>
>>
>>---
>>
>>Corresponding fix of the places where transfer direction is actually set and
>>how to clean sbp2_create_command_orb() up after this fix is being discussed.
>>A patch for SCSI mid and high level has been submitted.
>>http://marc.theaimsgroup.com/?t=113400010000001
>>Please apply the following patch to prevent kernel panics as the first step.
>>
>> drivers/ieee1394/sbp2.c |   16 ++++++----------
>> 1 files changed, 6 insertions(+), 10 deletions(-)
>>
>>--- linux/drivers/ieee1394.orig/sbp2.c	2005-11-24 23:10:21.000000000 +0100
>>+++ linux/drivers/ieee1394/sbp2.c	2005-12-10 11:57:41.000000000 +0100
>>@@ -1784,6 +1784,12 @@ static int sbp2_create_command_orb(struc
>> 			break;
>> 	}
>> 
>>+	if (orb_direction != ORB_DIRECTION_NO_DATA_TRANSFER &&
>>+	    scsi_request_bufflen == 0) {
>>+		SBP2_WARN("Enforcing transfer direction DMA_NONE");
>>+		orb_direction = ORB_DIRECTION_NO_DATA_TRANSFER;
>>+	}
>>+
>> 	/*
>> 	 * Set-up our pagetable stuff... unfortunately, this has become
>> 	 * messier than I'd like. Need to clean this up a bit.   ;-)
>>@@ -1900,16 +1906,6 @@ static int sbp2_create_command_orb(struc
>> 			command_orb->misc |= ORB_SET_DATA_SIZE(scsi_request_bufflen);
>> 			command_orb->misc |= ORB_SET_DIRECTION(orb_direction);
>> 
>>-			/*
>>-			 * Sanity, in case our direction table is not
>>-			 * up-to-date
>>-			 */
>>-			if (!scsi_request_bufflen) {
>>-				command_orb->data_descriptor_hi = 0x0;
>>-				command_orb->data_descriptor_lo = 0x0;
>>-				command_orb->misc |= ORB_SET_DIRECTION(1);
>>-			}
>>-
>> 		} else {
>> 			/*
>> 			 * Need to turn this into page tables, since the
>>
> 
> 


-- 
Stefan Richter
-=====-=-=-= ==-- -=-=-
http://arcgraph.de/sr/
