Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTHSThh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbTHSTfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:35:53 -0400
Received: from corky.net ([212.150.53.130]:44694 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S261305AbTHSTeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:34:46 -0400
Date: Tue, 19 Aug 2003 22:34:42 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: linux-kernel@vger.kernel.org
Subject: disk stalls - request disappears until kicked
Message-ID: <Pine.LNX.4.44.0308192140520.12291-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While researching stalls of a cloop device under recent 2.4.x kernels,
I ran across what seems to be a bug in the request handling initiated by
do_generic_file_read().

The cloop (compressed loop) code I'm debugging is this one:

http://developer.linuxtag.net/knoppix/sources/cloop_1.0-2.tar.gz

I'm testing with kernel 2.4.22-rc2.

The code uses do_generic_file_read() in a similar manner to loop.o.
Under stress-testing, reading processes stall on TASK_UNINTERRUPTIBLE and
remain in that state until another process accesses some non-cached file
on the underlying filesystem.  As soon as such access occurs, the stalled
processes resume.

The stalled process waits on a page in mm/filemap.c:1505:

/* Again, try some read-ahead while waiting for the page to finish.. */
	generic_file_readahead(reada_ok, filp, inode, page);
------> wait_on_page(page);


I found who wakes it up in calls that don't stall:
unlock_page(), called from
drivers/block/ll_rw_blk.c:end_that_request_first().
bh->b_end_io(bh, uptodate) seems to do it.

Tracking end_that_request_first()'s callers leads all the way back to the
IDE code, and none of it seem to be called on the stalled request until
its kicked by having another process perform some access that causes a
wakeup of the stalled request.

Seems like some request queue doesn't get fully consumed under stress but
so far I've been unable to find what causes it.  I'm not even sure if the
request hasn't been passed to the hardware or the hardware handled it and
the BH somehow mishandled it.

Having traced this to the IDE code, I tried the same with a USB disk
instead.  It withstood the same stress-testing much longer than the IDE
did, although eventually it stalled in a similar manner.  I'm not sure
whether the problem is in ll_rw_blk.c/filemap.c or happens to be shared by
ide and usb-storage/sd.

Curiously, the problem seems to happen when the underlying filesystem is
ext3, but doesn't happen when its vfat as far as I can tell.  Could be
related to the fact that ext3 uses generic_file_read and vfat doesn't.

Anyone else experiencing similar stalls ?  Suggestions ?

	Yoav Weiss

