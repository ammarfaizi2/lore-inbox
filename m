Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288761AbSBDIPo>; Mon, 4 Feb 2002 03:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288765AbSBDIPf>; Mon, 4 Feb 2002 03:15:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:773 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288761AbSBDIPX>;
	Mon, 4 Feb 2002 03:15:23 -0500
Date: Mon, 4 Feb 2002 09:15:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Bristow <paul@paulbristow.net>
Cc: linux-kernel@vger.kernel.org, Taco IJsselmuiden <taco@wep.tudelft.nl>
Subject: Re: [OOPS] Oops with ide-floppy in 2.5.2 / 2.5.3
Message-ID: <20020204091509.Q29553@suse.de>
In-Reply-To: <Pine.LNX.4.21.0202040023410.15910-100000@banaan.taco.dhs.org> <3C5E2C08.1080105@paulbristow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5E2C08.1080105@paulbristow.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04 2002, Paul Bristow wrote:
> I'll take a look at it.

One hint is that this bug is triggered when you attempt to add a request
in from of one that has already been started. In case of ide,
ide_do_drive_cmd with ide_preempt would trigger this. That may or may
not be a bug, depends on if the driver knows what it is doing or not.

If the driver knows what it is doing, then this patch should cure your
problem.

--- drivers/ide/ide.c~	Mon Feb  4 09:12:10 2002
+++ drivers/ide/ide.c	Mon Feb  4 09:14:39 2002
@@ -1784,6 +1784,8 @@
 	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
 		if (action == ide_preempt)
 			hwgroup->rq = NULL;
+		if (!blk_queue_empty(&drive->queue))
+			list_entry_rq(queue_head)->flags &= ~REQ_STARTED;
 	} else {
 		if (action == ide_wait || action == ide_end) {
 			queue_head = queue_head->prev;

-- 
Jens Axboe

