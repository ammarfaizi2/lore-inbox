Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUIOTOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUIOTOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUIOTOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:14:21 -0400
Received: from fep06-0.kolumbus.fi ([193.229.0.57]:53831 "EHLO
	fep06-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S266519AbUIOTOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:14:19 -0400
Date: Wed, 15 Sep 2004 22:14:17 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Peter Jones <pjones@redhat.com>
cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow root to modify raw scsi command permissions list
In-Reply-To: <1095173470.5728.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0409152151190.1972@kai.makisara.local>
References: <1095173470.5728.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, Peter Jones wrote:

> diff -urpN linux-2.5-export/drivers/block/Makefile pjones-2.5-export/drivers/block/Makefile
> --- linux-2.5-export/drivers/block/Makefile	2004-09-10 11:54:01 -04:00
> +++ pjones-2.5-export/drivers/block/Makefile	2004-09-10 12:11:50 -04:00
> @@ -13,7 +13,7 @@
>  # kblockd threads
>  #
[Patch snipped]

Your patch allows updating the filters for each device. This is one aspect 
of the problem. Another problem is that the command filter appropriate for 
CD/DVD writers is _forced on all devices_. In your patch this is in the 
defaults. In the current scsi_ioctl filter it applies to everything.

I have already commented on MODE SELECT. I still think it is dangerous. 
Looking at the command list reveals a couple of other problems:
- The command GPCMD_READ_DISC_INFO is "safe_for_read". The command 0x51
  has also another use: XPWRITE(10), i.e., a write command. Clearly a
  problem.
- The "safe_for_read" command GPCMD_REPORT_KEY, 0xa4, has aliases 
  CHANGE ALIAS, SET DEVICE IDENTIFIER and SET TARGET PORT.
- The "safe_for_write" command GPCMD_SEND_DVD_STRUCTURE has alias
  VOLUME SET OUT (raid configuration).

There are other aliases but they return information and don't look too 
dangerous. The command code is only 8 bits and there probably will be more 
aliasing in future.

My conclusion is that the filter _necessary_ for burning CD/DVDs is _not 
safe for all devices_.

How to solve this problem? One idea I had was to add a sysfs-changable 
attribute accessible to the filter (disk or queue) that would have a few 
possible states: allow only root, allow filtered, allow all? The default 
would be to "allow only root". The cdrom registering could set this to 
"allow filtered". This would allow the current behaviour for CD/DVD drives 
but would be safe for others. Other devices could be selectively allowed 
passthrough access if necessary.

This could also be done in your approach. One possibility would be to 
start with empty filter and call from CD/DVD registering a function that 
sets the filter you currently have as default. This would be both flexible 
and safe.

Opinions?

-- 
Kai
