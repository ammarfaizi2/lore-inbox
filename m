Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262777AbTCVOhI>; Sat, 22 Mar 2003 09:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbTCVOhI>; Sat, 22 Mar 2003 09:37:08 -0500
Received: from verdi.et.tudelft.nl ([130.161.38.158]:22656 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262777AbTCVOhH>; Sat, 22 Mar 2003 09:37:07 -0500
Date: Sat, 22 Mar 2003 15:48:10 +0100
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: linux-kernel@vger.kernel.org
Cc: robn@verdi.et.tudelft.nl
Subject: 2.4 has O_SYNC bug ?
Message-ID: <20030322154810.A2069@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Summary: Linux performs unneccesary (incorrect ?) strange extra writes
	 on partitions opened with O_SYNC after data is written.

I'm using a small SBC with an application that logs certain data
records.  It runs from a CompactFlash.  There are 2 partitions on
the CF: a root fs (which is mounted read-only) and a data partition.
There's no fs on the data partition: I manage the records myself,
they are written sequentially to the raw partition.  The data
partition is opened with the "O_SYNC" flag by the application.

When a record is written (which is always approx 3 sequential disk blocks)
I see the disk-activity led blink at the same moment.  Good: we want
the data physically written to the CF at that moment; that's why the
O_SYNC is used.

But the strange thing is this:  always after 30s the kernel performs
extra writes to the CF.  It seems it's flushing some kind of dirty buffer
from the buffer cache.  But there is not supposed to be any dirty buffer:
all data should have been written already to the CF because the partition
was opened with O_SYNC !

I don't know *what* data is written after the 30s.  Maybe they are blocks
that were written 30s ago too (with the same content).  Then they are
unneccesary and cause a much higher wear on the CF.  Maybe it is something
that should have been written 30s ago but which is delayed by the kernel
despite the O_SYNC flag.  Then it is incorrect and I'll lose data when
a user switches off the system within 30s after logging a record.

Anyone know what's going on ?

	greetings,
	Rob van Nieuwkerk

PS: Yes I know about O_DIRECT,  I'll try that.  But I think there is
    a bug with O_SYNC anyway !


System details:
---------------
Kernel built from RH 2.4.18-27.7.x tree, Geode GX1 CPU.  There are no
other applications accessing the CF besides my own app.  There is nothing
written (or read) on the CF by the app besides the (small) datarecord.
The app even runs from a ramfs, so this even rules out that I'm seeing
paging activity.  I can see the strange writes happening in /proc/stat
too.  When running "sync" after the record was written (and the disk
activity has happened) you see diskactivity.  Running sync again produces
no new diskactivity and the "normal" activity after 30s does not happen.
