Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVBUSYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVBUSYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVBUSYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:24:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6070 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262063AbVBUSYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:24:37 -0500
Date: Mon, 21 Feb 2005 10:24:31 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Merging fails reading /dev/uba1
Message-ID: <20050221102431.64de6c6c@localhost.localdomain>
In-Reply-To: <20050221075131.GT4056@suse.de>
References: <20050220200059.53db7b1e@localhost.localdomain>
	<20050221075131.GT4056@suse.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 08:51:32 +0100, Jens Axboe <axboe@suse.de> wrote:

> > [root@lembas ~]# time dd if=/dev/uba of=/dev/null bs=10k count=10240
> > real    0m22.731s

> > [root@lembas ~]# time dd if=/dev/uba1 of=/dev/null bs=10k count=10240
> > real    1m42.622s

> > So, reading from a partition of the same device is 5 times slower than
> > reading from the device itself. The question is, why?

> I can't explain why the replugging slows it down, maybe you were lucky
> to get contigious pages in the first case? As far as I can see, ub
> effectively disables merging by setting max hw/phys segment limit of 1.

If you mean physical replugging, it has nothing to do with the issue.
I only mentioned it to show that old pages were purged.

Contiguous pages have nothing to do with it either. I forgot to mention
that in the first case (whole device), all reads are done with length of
4KB, while in the second case (partition), all reads are 512 bytes long.

Basically, the key is reading from a partition or not. It causes the
sub-page sized merging to fail.

This is how paritioning looks:

[root@lembas zaitcev]# fdisk /dev/uba

Command (m for help): p

Disk /dev/uba: 1048 MB, 1048576000 bytes
64 heads, 32 sectors/track, 1000 cylinders
Units = cylinders of 2048 * 512 = 1048576 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/uba1   *           1        1000     1023983+   6  FAT16
Partition 1 has different physical/logical endings:
     phys=(998, 63, 32) logical=(999, 63, 31)

Command (m for help):

It does not look to me as if the partition started from an odd number
of sectors. In fact, it starts from a full number of pages.

The segment number hint was a good one. I can implement a fake s/g
capability easily within the driver, if this is suggested. But before
hacking on that, I'd like to note that I'm surprised how the block
layer is unable to coalesce sector-sized reads within a page. Also,
why does this depend on partitioning? Something is fishy here.

-- Pete
