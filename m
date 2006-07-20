Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWGTV10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWGTV10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWGTV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 17:27:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:38582 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030380AbWGTV1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 17:27:24 -0400
Message-ID: <44BFF539.4000700@garzik.org>
Date: Thu, 20 Jul 2006 17:27:21 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ed Lin <ed.lin@promise.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       "James.Bottomley" <James.Bottomley@SteelEye.com>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
References: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com>
In-Reply-To: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Lin wrote:
> Please review following patch based on the 'stex' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
> 
> Jeff Garzik already finished some changes, and these are the rest.
> 
>>From Christoph Hellwig's comments:
> 	use scsi_kmap_atomic_sg/scsi_kunmap_atomic_sg
>     callback argument to ->queuecommand changed to 'done'
> 	merge init functions into .probe
> 
>>From Alexey Dobriyan's comments:
> 	__le32 *time
> 
> Promise code changes:
> 	add hard reset function
> 	extend reset wait time
> 	add new device ids
> 	white space/ minor fix(INQUIRY, max_channel)
> 
> Block layer tag: 
> 	It is not implemented because here tag is adapter wide,
> 	not for single device.
> Non-sg codepath:
> 	It can be eliminated when Christoph Hellwig's patch
> 	upstream.
> Firmware lun issue:
> 	Firmware uses an id/lun pair for a logical drive. But
> 	lun could be always 0 in Linux(when you do not config
> 	CONFIG_SCSI_MULTI_LUN).I use channel to map lun,
> 	otherwise max_id will be 256.
> INQUIRY, passthru command:
> 	Needed by management software. The special handling of
> 	INQUIRY is for management software to have a sg device
> 	to issue commands.

Overall, the patch looks good.  My quick review finds a couple nits, though:

1) [major] The Intel bridge code ("pci_get_device(0x8086, 0x0370, bus0),
...") is not the type of thing we normally put into a driver.  If there
is a problem with a specific bridge, we would prefer to patch
drivers/pci/quirks.c.

Touching _another_ piece of hardware, other than your own, is a big deal
and generally unwise.

2) [minor] Adding "magic numbers" in stex_hard_reset().  Easy to fix:
convert "0x3e", "0x84", "1 << 5" etc. to named constants.  The named
constants should have sufficiently good names to understand their
purpose, without being overly long C symbols.

3) [minor] For sleeping longer than one second, ssleep() is preferred to
msleep().

4) [minor] 'void *scratch' in struct st_hba tells us nothing about its
usage.  At the very least, a comment, if not a better name, would be good.

5) [agreement/correction]  The block tagging API supports adapter-wide
tags just fine.  HOWEVER, I nonetheless feel that block tagging API use
should be considered post-merge.  The 'stex' driver is working and
tested today.  Since _no individual SCSI driver_ uses the block layer
tagging, it is likely that some instability and core kernel development
will occur, in order to make that work.

All your other changes look good to me.

	Jeff


