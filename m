Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272473AbTHEGaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 02:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272478AbTHEGaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 02:30:24 -0400
Received: from iv.ro ([194.105.28.94]:3194 "HELO iv.ro") by vger.kernel.org
	with SMTP id S272473AbTHEGaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 02:30:22 -0400
Date: Tue, 5 Aug 2003 09:44:44 +0300
From: Jani Monoses <jani@iv.ro>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cs stack_dump
Message-Id: <20030805094444.19cfc9f0.jani@iv.ro>
In-Reply-To: <Pine.SOL.4.30.0308050032490.16314-100000@mion.elka.pw.edu.pl>
References: <20030804174828.08dfc5f4.jani@iv.ro>
	<Pine.SOL.4.30.0308050032490.16314-100000@mion.elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 01:56:01 +0200 (MET DST)
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> 
> On Mon, 4 Aug 2003, Jani Monoses wrote:
> 
> I think I know how this happens:
> 
> register_disk()->blkdev_get()->do_open(), then disk->fops->open()
> (idedisk_open() for ide-disk) calls check_disk_change().
> check_disk_change() calls disk->fops->media_changed().
> idedisk_media_changes() returns drive->removable, so instead of
> returning from check_disk_change() block_device is invalidated
> and bdev->bd_invalidated is set to 1.  Later in do_open(),
> bdev->bd_invalidated flag is checked and since it is 1
> rescan_partitions() is triggered.  Thus partitions are checked and
> added twice: in do_open()->rescan_partitions() and in register_disk().
> 
> [ The same applies to ide-floppy driver and probably some other
> drivers. ]
> 
> Ufff... I hope it is a correct description (I don't have hardware to
> reproduce the problem).

You're probably right in the description. One ugly way I solved this for
2.6.0-test1 was setting bd_invalidated to 0 
 
> Easy way is to fix is to add drive->attach flag, set it in
> idedisk_attach() and check+clear in idedisk_media_changed(),
> but I don't like this solution (patch below, Jani, can you test it?).

I can test is by tomorrow, it's another box that has the PCCard slot.

Jani
