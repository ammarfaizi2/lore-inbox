Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVLMIlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVLMIlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVLMIlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:41:24 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:37037 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S964778AbVLMIlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:41:22 -0500
Date: Tue, 13 Dec 2005 00:41:21 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [DOC PATCH] block/stat.txt
Message-ID: <20051213084121.GF26568@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212124553.GW26185@suse.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - the below should replace block-stat.txt.diff.  You might want
to use the Mercurial changelog (below) rather than the email body.

On Mon, Dec 12, 2005 at 01:45:53PM +0100, Jens Axboe wrote:
> On Sat, Dec 10 2005, Andy Isaacson wrote:
> > I couldn't find any docs explaining the contents of
> > /sys/block/<dev>/stat, so I wrote up the following.  I'm not completely
> > sure it's accurate - Jens, could you give a yea or nay on this?
> 
> Overall it looks very nice, you basically all of it right. And thanks
> for doing it btw, it's a good addition to the documentation. A few small
> comments follows:

Thank you for your comments.  The easy ones were easy to incorporate,
but let me get one more bit of feedback:

> > +in_flight
> > +=========
> > +
> > +This value counts the number of currently-queued I/O requests.
> 
> A little confusing - it's the number of in flight io at the
> driver/device end, that is after the block layer. One could read the
> above as total in flight (total queued in the queue for the device),
> which is a very different number.

I wrote from misunderstanding, so it's no suprise what I wrote was
wrong. :)  Is "number of requests in the queue" available somewhere?

How does this sound instead of the above?

+in_flight
+=========
+
+This value counts the number of I/O requests that have been issued to
+the device driver but have not yet completed.  It does not include I/O
+requests that are in the queue but not yet issued to the device driver.

Complete patch below.

-andy

# HG changeset patch
# User adi@bobble.hexapodia.org
# Node ID b3b07fba68e5d19602696e88f8ce540ddd6ef384
# Parent  03055821672a46deb8291db0cf719e39c2f0d48e
Documentation/block/stat.txt: document contents of /sys/block/<dev>/stat

diff -r 03055821672a -r b3b07fba68e5 Documentation/block/stat.txt
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/Documentation/block/stat.txt	Mon Dec 12 19:58:37 2005 -0800
@@ -0,0 +1,82 @@
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
+read sectors    sectors       number of sectors read
+read ticks      milliseconds  total wait time for read requests
+write I/Os      requests      number of write I/Os processed
+write merges    requests      number of write I/Os merged with in-queue I/O
+write sectors   sectors       number of sectors written
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
+These values count the number of sectors read from or written to this
+block device.  The "sectors" in question are the standard UNIX 512-byte
+sectors, not any device- or filesystem-specific block size.  The
+counters are incremented when the I/O completes.
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
+This value counts the number of I/O requests that have been issued to
+the device driver but have not yet completed.  It does not include I/O
+requests that are in the queue but not yet issued to the device driver.
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
