Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266650AbSKOUZR>; Fri, 15 Nov 2002 15:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbSKOUZR>; Fri, 15 Nov 2002 15:25:17 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:20932 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S266650AbSKOUZQ>;
	Fri, 15 Nov 2002 15:25:16 -0500
Subject: SCSI I/O performance problems when CONFIG_HIGHIO is off
From: Steve Lord <lord@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1037392310.13531.419.camel@jen.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 15 Nov 2002 14:31:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

As you know, for the last week or so I have been battling some
performance issues in XFS and 2.4.20-rc1. Well, we finally found
the culprit back in 2.4.20-pre2.

When the block highmem patch was included, it added highmem_io to the
scsi controller structure. This can only ever be set to one if
CONFIG_HIGHIO is set. Yet there are several spots in the scsi
code which test based on its value regardless.

        /*
         * we really want to use sg even for a single segment request,
         * however some people just cannot be bothered to write decent
         * driver code so we can't risk to break somebody making the
         * assumption that sg requests will always contain at least 2
         * segments. if the driver is 32-bit dma safe, then use sg for
         * 1 entry anyways. if not, don't rely on the driver handling this
         * case.
         */
        if (count == 1 && !SCpnt->host->highmem_io) {
                this_count = req->current_nr_sectors;
                goto single_segment;
        }

Running with 128M of memory I usually do not turn highmem on. Well
finally I did and my performance went from this:

Version 1.02a       ------Sequential Create------ --------Random Create--------
burst.americas.sgi. -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                  2   156   4 +++++ +++   118   3   149   3 +++++ +++   108   2

which is the worst I ever saw, to this:

Version 1.02a       ------Sequential Create------ --------Random Create--------
burst.americas.sgi. -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                  2  2732  81 +++++ +++  1771  38  2555  86 +++++ +++  1418  30

Jens, can you do something about this please?

Steve

p.s. You now owe me a week's consulting some time ;-)


-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
