Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDSN2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDSN2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWDSN2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:28:32 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:26795 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750715AbWDSN2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:28:31 -0400
Date: Wed, 19 Apr 2006 18:59:18 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] Patch to fix cdrom being confused on using kdump
Message-ID: <20060419132918.GA31705@in.ibm.com>
Reply-To: rachita@in.ibm.com
References: <20060407135714.GA25569@in.ibm.com> <20060409102942.GI3859@suse.de> <20060411153114.GA5255@in.ibm.com> <20060411170357.GR4791@suse.de> <20060412112933.GA6204@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060412112933.GA6204@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 04:59:33PM +0530, Rachita Kothiyal wrote:
> 
> I actually tried just reading the status register and then returning
> ide_stopped. It seemed to be working fine, just that there appears 
> a 'status error' message while booting:
> 
> <snippet>
> ide0: start_request: current=0xffff8100035cba68
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hda: drive not ready for command
> </snippet>

Hi Jens,

Instead of reading the status register and returning ide_stopped
from the handler, which was resulting in the 'status error', I 
tried ending the request and returning ide_stopped when the drive
is in a confused state. Using this I dont see the status error.

Following is the patch, kindly review.

Thanks
Rachita

Signed-off-by: Rachita Kothiyal <rachita@in.ibm.com>
---

 drivers/ide/ide-cd.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN drivers/ide/ide-cd.c~fix-confused-cdrom-with-kdump-end-req-ret drivers/ide/ide-cd.c
--- linux-2.6.17-rc1/drivers/ide/ide-cd.c~fix-confused-cdrom-with-kdump-end-req-ret	2006-04-19 18:01:44.000000000 +0530
+++ linux-2.6.17-rc1-rachita/drivers/ide/ide-cd.c	2006-04-19 18:55:06.000000000 +0530
@@ -1451,9 +1451,12 @@ static ide_startstop_t cdrom_pc_intr (id
 	} else {
 confused:
 		printk (KERN_ERR "%s: cdrom_pc_intr: The drive "
-			"appears confused (ireason = 0x%02x)\n",
+			"appears confused (ireason = 0x%02x). "
+			"Trying to recover by ending request.\n",
 			drive->name, ireason);
 		rq->flags |= REQ_FAILED;
+		cdrom_end_request(drive, 0);
+		return ide_stopped;
 	}
 
 	/* Now we wait for another interrupt. */
_
