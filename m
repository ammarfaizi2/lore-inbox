Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSL0UuQ>; Fri, 27 Dec 2002 15:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSL0UuQ>; Fri, 27 Dec 2002 15:50:16 -0500
Received: from alb-24-29-45-178.nycap.rr.com ([24.29.45.178]:48133 "EHLO
	ender.tmmz.net") by vger.kernel.org with ESMTP id <S264730AbSL0UuP>;
	Fri, 27 Dec 2002 15:50:15 -0500
Date: Fri, 27 Dec 2002 16:00:52 -0500 (EST)
From: Matthew Zahorik <matt@albany.net>
X-X-Sender: matt@ender.tmmz.net
To: linux-kernel@vger.kernel.org
Subject: Hang on partition check, 2.4 kernels
Message-ID: <Pine.BSF.4.43.0212271544210.3244-100000@ender.tmmz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a sparc SS10 that I recently installed with Debian 3.0r0.

There are two drives in the machine, sda (ID #1) and sdb (ID #3)

sda is dead, sdb is functioning fine.

Rather than awaiting a replacement for sda, I went ahead and installed
Debian on sdb.  Worked fine.  Happy day.

Debian 3.0r0 on sparc32 installs a 2.2.20 kernel.  Obtained and compiled
2.4.20.  Rebooted.

The 2.4.20 kernel hangs forever waiting to read the partitions on sda.

2.2.20 didn't do this.  It printed a message about failing to read the
table, then continued.

Wandered through the 2.2.20 and 2.4.20 code and compared.

In 2.2.20, the partition check for Sun is in
drivers/block/genhd.c:sun_partition()

This code calls bread() directly, immediately handling the error and
skipping a bad drive.

In 2.4.20, the partition check for Sun is in
fs/partitions/sun.c:sun_partition()

This calls read_dev_sector in fs/partitions/check.c, which
calls read_cache_page then calls wait_on_page is there is an error.
This seems to wait forever.

Can someone explain how/why read_cache_page is called, how it's wrong, and
why bread() isn't sufficient in this function?  I don't know how to fix
the code once VM got involved.

I could simply pull the damaged drive and the machine would boot (I'd have
to adjust root to point to sda instead of sdb...)  But I'd like to fix
the behavior now - the machine should boot despite the failure.

Thanks!

- Matt

