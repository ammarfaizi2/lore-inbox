Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281357AbRKLMmI>; Mon, 12 Nov 2001 07:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281381AbRKLMls>; Mon, 12 Nov 2001 07:41:48 -0500
Received: from 10fwd.cistron-office.nl ([195.64.65.197]:35591 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S281357AbRKLMlj>; Mon, 12 Nov 2001 07:41:39 -0500
Date: Mon, 12 Nov 2001 13:41:37 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: disk write cache and poweroff
Message-ID: <20011112134137.A17482@cistron.nl>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andre,

A few users of the debian sysvinit package have complained that on
their laptop, shutdown + poweroff is too fast. The disk is turned
off before the write-cache on the disk is completely written,
resulting in some filesystem corruption.

After some experimentation with turning off the write cache before
shutdown etc, I found out that a side-effect of putting the IDE
disk in standby mode is that the write cache is flushed. So now
halt(8) has an extra option to put all IDE disks it can find
(through /proc/ide/hd*) in standby mode just before it calls
reboot(LINUX_REBOOT_CMD_POWER_OFF). Thus flag is used in the
/etc/rc0.d/S90halt script, and appears to fix the problem. I think
windows does the same :|

Anyway this should probably be done in the kernel. Perhaps the
IDE driver should register a reboot notifier with
register_reboot_notifier() that puts all IDE disks on the
system in standby mode on SYS_HALT and SYS_POWER_OFF ?

Many other drivers do this too, grep for SYS_HALT in linux/drivers/*/*.c

Hmm I just noticed that a lot of driver check for SYS_DOWN (which
is the same as SYS_RESTART: reboot) and SYS_HALT but not for
SYS_POWEROFF, which is a bug in those drivers. Ugh.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.
