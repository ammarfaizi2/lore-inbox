Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSKRAg3>; Sun, 17 Nov 2002 19:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSKRAg3>; Sun, 17 Nov 2002 19:36:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6608 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261286AbSKRAg2>;
	Sun, 17 Nov 2002 19:36:28 -0500
Date: Sun, 17 Nov 2002 19:43:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Doug Ledford <dledford@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Failure to reread partition tables on non-busy devices
In-Reply-To: <20021118000505.GM3280@redhat.com>
Message-ID: <Pine.GSO.4.21.0211171939580.23400-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Nov 2002, Doug Ledford wrote:

> This patch (almost certainly wrong BTW) makes it work.  Obviously, 
> somewhere there should be a call to invalidate_bdev(); that doesn't exist.  
> I'm not sure A) where that call should be and B) what checks there should 
> be to avoid calling invalidate_bdev() on a device that is busy.


Not really.  Correct fix is:
	a) in fs/block_dev.c::full_check_disk_change() replace

	if (check_disk_change(bdev)) {
with
	if (check_disk_change(bdev) && bdev->bd_invalidated) {

	b) lost the check in rescan_partitions().

Other callers either do that check themselves or don't want that check to
happen at all (BLKRRPART).

