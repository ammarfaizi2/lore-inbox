Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbVLKBDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbVLKBDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 20:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbVLKBDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 20:03:41 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:14607 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1161080AbVLKBDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 20:03:41 -0500
Date: Sat, 10 Dec 2005 17:03:39 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, Jens Axboe <axboe@suse.de>
Subject: [DOC PATCH] block/stat.txt
Message-ID: <20051211010339.GA26568@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I couldn't find any docs explaining the contents of
/sys/block/<dev>/stat, so I wrote up the following.  I'm not completely
sure it's accurate - Jens, could you give a yea or nay on this?

In particular, the counts of read/write IOs and read/write sectors are
incremented in different places - it looks like they both increment as
the request is being finished, but I'm not completely sure of that.

-andy

---

# HG changeset patch
# User adi@bobble.hexapodia.org
# Node ID 28202adc17846b087209ce937fa5cd0f2f4ffbbb
# Parent  03055821672a46deb8291db0cf719e39c2f0d48e
Documentation/block/stat.txt: document contents of /sys/block/<dev>/stat

diff -r 03055821672a -r 28202adc1784 Documentation/block/stat.txt
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/Documentation/block/stat.txt	Sat Dec 10 15:19:56 2005 -0800
@@ -0,0 +1,80 @@
+Block layer statistics in /sys/block/<dev>/stat
+===============================================
+
+This file documents the contents of the /sys/block/<dev>/stat file.
+
+The stat file provides several statistics about the state of block
+device <dev>.
+
+Q. Why are there multiple statistics in a single file?  Doesn't sysfs
+   normally contain a single value per file?
+A. By having a single file, the kernel can guarantee that the statistics
+   represent a consistent snapshot of the state of the device.  If the
+   statistics were exported as multiple files containing one statistic
+   each, it would be impossible to guarantee that a set of readings
+   represent a single point in time.
+
+The stat file consists of a single line of text containing 11 decimal
+values separated by whitespace.  The fields are summarized in the
+following table, and described in more detail below.
+
+Name            units         description
+----            -----         -----------
+read I/Os       requests      number of read I/Os processed
+read merges     requests      number of read I/Os merged with in-queue I/O
+read sectors    blocks        number of sectors read
+read ticks      milliseconds  total wait time for read requests
+write I/Os      requests      number of write I/Os processed
+write merges    requests      number of write I/Os merged with in-queue I/O
+write sectors   blocks        number of sectors written
+write ticks     milliseconds  total wait time for write requests
+in_flight       requests      number of I/Os currently in flight
+io_ticks        milliseconds  total time this block device has been active
+time_in_queue   milliseconds  total wait time for all requests
+
+read I/Os, write I/Os
+=====================
+
+These values increment when an I/O request completes.
+
+read merges, write merges
+=========================
+
+These values increment when an I/O request is merged with an
+already-queued I/O request.
+
+read sectors, write sectors
+===========================
+
+These values count the number of blocks read from or written to this
+block device.  The "blocks" in question are the standard UNIX 512-byte
+blocks, not any device-specific block size.  The counters are
+incremented when the I/O completes.
+
+read ticks, write ticks
+=======================
+
+These values count the number of milliseconds that I/O requests have
+waited on this block device.  If there are multiple I/O requests waiting,
+these values will increase at a rate greater than 1000/second; for
+example, if 60 read requests wait for an average of 30 ms, the read_ticks
+field will increase by 60*30 = 1800.
+
+in_flight
+=========
+
+This value counts the number of currently-queued I/O requests.
+
+io_ticks
+========
+
+This value counts the number of milliseconds during which the device has
+had I/O requests queued.
+
+time_in_queue
+=============
+
+This value counts the number of milliseconds that I/O requests have waited
+on this block device.  If there are multiple I/O requests waiting, this
+value will increase as the product of the number of milliseconds times the
+number of requests waiting (see "read ticks" above for an example).
