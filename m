Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUAMB5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUAMB5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:57:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35261 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263646AbUAMB5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:57:35 -0500
Message-Id: <200401130155.i0D1tYZ06053@owlet.beaverton.ibm.com>
To: marcello.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: New entry for Documentation for 2.4.25 (iostats.txt)
Date: Mon, 12 Jan 2004 17:55:32 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is similar to the iostats.txt I created for 2.6.

Rick

diff -rupN linux-2.4.24/Documentation/iostats.txt linux-2.4.24-rl/Documentation/iostats.txt
--- linux-2.4.24/Documentation/iostats.txt	Wed Dec 31 16:00:00 1969
+++ linux-2.4.24-rl/Documentation/iostats.txt	Mon Jan 12 17:49:18 2004
@@ -0,0 +1,85 @@
+I/O statistics fields
+---------------
+
+Last modified Jan 12, 2004
+
+Since 2.4.20 (and some versions before, with patches), more extensive
+disk statistics have been introduced to help measure disk activity. Tools
+such as sar and iostat typically interpret these and do the work for you,
+but in case you are interested in creating your own tools, the fields
+are explained here.
+
+The information is found as additional fields in /proc/partitions.
+Here's an example of the format
+
+   3     0   39082680 hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160
+   3     1    9221278 hda1 35486 0 35496 38030 0 0 0 0 0 38030 38030
+
+The statistics fields are those after the device name. In the above
+example, the first field of statistics would be 446216.  All fields
+except field 9 are cumulative since boot.  Field 9 should go to zero
+as I/Os complete; all others only increase.  Yes, these are 32 bit
+unsigned numbers, and on a very busy or long-lived system they may
+wrap. Applications should be prepared to deal with that; unless your
+observations are measured in large numbers of minutes or hours, they
+should not wrap twice before you notice them.
+
+Each set of stats only applies to the indicated device; if you want
+system-wide stats you'll have to find all the devices and sum them all up.
+
+Field  1 -- # of reads issued
+    This is the total number of reads completed successfully.
+Field  2 -- # of reads merged, field 6 -- # of writes merged
+    Reads and writes which are adjacent to each other may be merged for
+    efficiency.  Thus two 4K reads may become one 8K read before it is
+    ultimately handed to the disk, and so it will be counted (and queued)
+    as only one I/O.  This field lets you know how often this was done.
+Field  3 -- # of sectors read
+    This is the total number of sectors read successfully.
+Field  4 -- # of milliseconds spent reading
+    This is the total number of milliseconds spent by all reads (as
+    measured from __make_request() to end_that_request_last()).
+Field  5 -- # of writes completed
+    This is the total number of writes completed successfully.
+Field  7 -- # of sectors written
+    This is the total number of sectors written successfully.
+Field  8 -- # of milliseconds spent writing
+    This is the total number of milliseconds spent by all writes (as
+    measured from __make_request() to end_that_request_last()).
+Field  9 -- # of I/Os currently in progress
+    The only field that should go to zero. Incremented as requests are
+    given to appropriate request_queue_t and decremented as they finish.
+Field 10 -- # of milliseconds spent doing I/Os
+    This field is increases so long as field 9 is nonzero.
+Field 11 -- weighted # of milliseconds spent doing I/Os
+    This field is incremented at each I/O start, I/O completion, I/O
+    merge, or read of these stats by the number of I/Os in progress
+    (field 9) times the number of milliseconds spent doing I/O since the
+    last update of this field.  This can provide an easy measure of both
+    I/O completion time and the backlog that may be accumulating.
+
+To avoid introducing performance bottlenecks, no locks are held while
+modifying these counters.  This implies that minor inaccuracies may be
+introduced when changes collide, so (for instance) adding up all the
+read I/Os issued per partition should equal those made to the disks ...
+but due to the lack of locking it may only be very close.
+
+
+Disks vs Partitions
+-------------------
+In 2.4, the same statistics are collected about partitions as about whole
+disks.  In theory, the fields in the partitions should sum up to the
+fields in the corresponding whole disk, but in practice since grabbing
+locks is purposely avoided during both stat collection and stat reporting
+in favor of speed, there may be minor inconsistencies.
+
+
+Additional notes
+----------------
+As an artifact, less comprehensive disk statistics also appear in
+/proc/stat for whole disks.  These were removed in 2.6 but are unlikely
+to disappear in 2.4's lifetime.  If you are writing a new application,
+you would do well, however, to consider them deprecated so that your
+application is more easily ported to 2.6 and beyond.
+
+-- ricklind@us.ibm.com
