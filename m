Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUF2Jhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUF2Jhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 05:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUF2Jhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 05:37:46 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:52490 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP id S265661AbUF2Jho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 05:37:44 -0400
Date: Tue, 29 Jun 2004 11:37:36 +0200 (CEST)
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
Subject: hwscan hangs on USB2 disk - SCSI_IOCTL_SEND_COMMAND
To: linux-kernel@vger.kernel.org
Cc: Kurt Garloff <garloff@etpmod.phys.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20040629093739.40243364C@etpmod.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies if this is not really a kernel issue, but

I've recently upgraded to SUSE9.1,  and now I am having trouble with
automatically hotplugging my USB2 harddisk. This is because the
userspace hotplug magic runs a prog called hwscan. If I disable the
userspace stuff, everything works fine. Also my USB1 pendrive works fine
with the userspace hotplug.

The problem is that both hwscan and usb-storage get stuck in the 'D"
state until I unplug the harddisk.

A strace of hwscan shows:

21141 open("/dev/sda", O_RDONLY|O_NONBLOCK) = 3
21141 ioctl(3, 0x301, 0xbfffeba0)       = 0
21141 ioctl(3, BLKSSZGET, 0xbfffeb9c)   = 0
21141 ioctl(3, 0x80041272, 0xbfffeb90)  = 0
21141 ioctl(3, FIBMAP, 0xbfffec40)      = 0  <--- hwscan gets stuck here

The last ioctl corresponds to this bit of code in
hwinfo-8.38/src/hd/block.c:

#ifndef SCSI_IOCTL_SEND_COMMAND
#define SCSI_IOCTL_SEND_COMMAND 1
#endif

...

      memset(scsi_cmd_buf, 0, sizeof scsi_cmd_buf);
      // ###### FIXME: smaller!
      *((unsigned *) (scsi_cmd_buf + 4)) = sizeof scsi_cmd_buf - 0x100;
      scsi_cmd_buf[8 + 0] = 0x12;
      scsi_cmd_buf[8 + 1] = 0x01;
      scsi_cmd_buf[8 + 2] = 0x80;
      scsi_cmd_buf[8 + 4] = 0xff;

      k = ioctl(fd, SCSI_IOCTL_SEND_COMMAND, scsi_cmd_buf);

So it appears that the driver hangs because of a SCSI command. Is this
kernel bug, and if so, where do I fix it?

TIA,
Bart
-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
