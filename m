Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTDRW74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 18:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTDRW74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 18:59:56 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29199 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263286AbTDRW7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 18:59:55 -0400
Date: Sat, 19 Apr 2003 01:11:47 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christian Staudenmayer <eggdropfan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting 2.5.67-ac1 makes the kernel panic
Message-ID: <20030418231147.GA19622@win.tue.nl>
References: <20030418223423.66409.qmail@web41811.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030418223423.66409.qmail@web41811.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 03:34:23PM -0700, Christian Staudenmayer wrote:

> (sorry for posting this again, but the kind solution given
> by Patrick Mansfield turn out to be no solution at all.
> Thanks anyways :)
> 
> i recently compiled 2.5.67-ac1 on my machine which uses the
> aic7xxx driver for an old adaptec 2940 scsi controller.
> When booting, the kernel panics after loading the scsi driver
> with the following message:
> 
> Process swapper (pid: 1, threadinfo=dbf8e000 task=dbf8c040)
> Stack: c15259a8 c15259a8 00000001 00000002 dbf8fe48 c022cd1a c15259a8 000000ff
>        dbf8fe3c dbf8fe40
> Call Trace:
>  [<c022cd1a>] ide_xlate_1024+0x106/0x18c
>  [<c01654aa>] handle_ide_mess+0x14e/0x1e8

You have a SCSI disk, read its partitions, look whether
special disk manager or geometry translations are required
and crash.

Why? Of course Alan should have removed this ide_mess :-),
but I suppose Al is the culprit that broke ide_xlate_1024
converting it to bdev.

The code

int ide_xlate_1024 (struct block_device *bdev, int xparm, int ptheads, const char *msg)
{
        ide_drive_t *drive = bdev->bd_disk->private_data;

is just broken - there is no guarantee that bdev is an IDE disk,
and casting some private pointer to ide_drive_t and then
accessing fields must be unhealthy.

Try replacing the body of ide_xlate_1024 by just

	return 0;

Andries

