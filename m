Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVI2FVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVI2FVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 01:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVI2FVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 01:21:35 -0400
Received: from mail.dvmed.net ([216.237.124.58]:32488 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751233AbVI2FVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 01:21:34 -0400
Message-ID: <433B79D8.9080305@pobox.com>
Date: Thu, 29 Sep 2005 01:21:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, axboe@suse.de, torvalds@osdl.org,
       randy_dunlap <rdunlap@xenotime.net>
Subject: SATA suspend/resume (was Re: [PATCH] updated version of Jens' SATA
 suspend-to-ram patch)
References: <20050923163334.GA13567@triplehelix.org>
In-Reply-To: <20050923163334.GA13567@triplehelix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> Hello,
> 
> I had some time yesterday and decided to help Jens out by rediffing the
> now-infamous SATA suspend-to-ram patch [1] against current git and
> test-building it.
> 
> For posterity,
> 
> This patch adds the ata_scsi_device_resume and ata_scsi_device_suspend
> functions (along with helpers) to put to sleep and wake up Serial ATA
> controllers when entering sleep states, and hooks the functions into
> each SATA controller driver so that suspend-to-RAM is possible.
> 
> Note that this patch is a holdover patch until it is possible to
> generalize this concept for all SCSI devices, which requires more data
> on which devices need to be put to sleep and which don't.
> 
> Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

Ah hah!  I found the other SCSI suspend patch:

	http://lwn.net/Articles/97453/

Anybody (Joshua?) up for reconciling and testing the two?

The main change from Jens/Joshua's patch is that we use SCSI's 
sd_shutdown() to call sync cache, eliminating the need for 
ata_flush_cache(), since the SCSI layer would now perform that.

For bonus points,

1) sd should call START STOP UNIT on suspend, which eliminates the need 
for ata_standby_drive(), and completely encompasses the suspend process 
in the SCSI layer.

2) sd should call START STOP UNIT on resume -- and as a SUPER BONUS, the 
combination of these two changes ensures that there are no queue 
synchronization issues, the likes of which would require hacks like 
Jens' while-loop patch.

None of these are huge changes requiring a lot of thinking/planning...

Finally, ideally, we should be issuing a hardware or software reset on 
suspend.

	Jeff


