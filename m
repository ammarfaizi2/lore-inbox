Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbTDOVdj (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTDOVdj 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:33:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:50607 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264105AbTDOVda 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:33:30 -0400
Date: Tue, 15 Apr 2003 14:40:51 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Gert Vervoort <gert.vervoort@hccnet.nl>
Cc: tconnors@astro.swin.edu.au, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
Message-ID: <20030415144051.A31514@beaverton.ibm.com>
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl> <20030415120000.A30422@beaverton.ibm.com> <3E9C6F10.10001@hccnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E9C6F10.10001@hccnet.nl>; from gert.vervoort@hccnet.nl on Tue, Apr 15, 2003 at 10:44:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 10:44:00PM +0200, Gert Vervoort wrote:

> The patch compiles and the warning messages are gone now.
> But, I still can't mount a zip disk.
> 
> Kernel messages after mounting a zip disk (mount -t ext2 /dev/sda1 
> /mnt/zip):
> 
> SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
> sda: Write Protect is off
> sda: Mode Sense: 25 00 00 08
> sda: cache data unavailable
> sda: assuming drive cache: write through
> SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
> sda: Write Protect is off
> sda: Mode Sense: 25 00 00 08
> sda: cache data unavailable
> sda: assuming drive cache: write through
>  sda:
> 
> The kernel messages are showing twice, does it try to mount the zip disk 
> two times?

It opens sd twice (AFAIK) - I think mount scans the block devices (an open
of sd) and then mounts (internal open). The code path in question is
probably via sd.c functions sd_media_changed and sd_revalidate_disk, and
the block_dev.c check_disk_change. sd_open calls check_disk_change.

This could be the same problem others are seeing with removable media
accessed via USB mass storage.

Can you dd to and from the media OK?

Can you capture output for the mount with scsi logging on?

It may or may not help track down what is happening.

If you haven't done much scsi, some scsi logging info:

Check that your .config has CONFIG_SCSI_LOGGING on.

Then do something like:

sync
sync
echo scsi log all > /proc/scsi/scsi 
mount /dev/sdw1 /mnt/sdw1
echo scsi log none > /proc/scsi/scsi
umount /mnt/sdw1

Turn off syslogd if you are logging to a scsi disk (and then you need a
serial line to capture output, and all printk's have to go to the
console), and sync if you are booted off scsi before turning on logging.
In either case, you could get a flood of messages.

-- Patrick Mansfield
