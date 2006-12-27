Return-Path: <linux-kernel-owner+w=401wt.eu-S932949AbWL0Pep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949AbWL0Pep (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 10:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbWL0Peo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 10:34:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44262 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932949AbWL0Pen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 10:34:43 -0500
Date: Wed, 27 Dec 2006 21:08:56 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [RFC] Heads up on a series of AIO patchsets
Message-ID: <20061227153855.GA25898@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a quick attempt to summarize where we are heading with a bunch of
AIO patches that I'll be posting over the next few days. Because a few of
these patches have been hanging around for a bit, and have gone through
bursts of iterations from time to time, falling dormant for other phases,
the intent of this note is to help pull things together into some coherent
picture for folks to comment on the patches and arrive at a decision of
some sort.

Native linux aio (i.e using libaio) is properly supported (in the sense of
being asynchronous) only for files opened with O_DIRECT, which actually
suffices for a major (and most visible) user of AIO, i.e. databases.

However, for other types of users, e.g. Samba and other applications which
use POSIX AIO, there have been several issues outstanding for a while:

(1) The filesystem AIO patchset, attempts to address one part of the problem
    which is to make regular file IO, (without O_DIRECT) asynchronous (mainly
    the case of reads of uncached or partially cached files, and O_SYNC writes).

(2) Most of these other applications need the ability to process both
    network events (epoll) and disk file AIO in the same loop. With POSIX AIO
    they could at least sort of do this using signals (yeah, and all associated
    issues). The IO_CMD_EPOLL_WAIT patch (originally from Zach Brown with
    modifications from Jeff Moyer and me) addresses this problem for native
    linux aio in a simple manner. Tridge has written a test harness to 
    try out the Samba4 event library modifications to use this. Jeff Moyer
    has a modified version of pipetest for comparison.

(3) For glibc POSIX AIO to switch to using native AIO (instead of simulation
    with threads) kernel changes are needed to ensure aio sigevent notification
    and efficient listio support. Sebestian Dugue's patches for aio sigevent
    notifications has undergone several review iterations and seems to be
    in good shape now. His patch for lio_listio is pending discussion
    on whether to implement it as a separate syscall rather than an additional
    iocb command. Bharata B Rao has posted a patch with the syscall variation
    for review.

(4) If glibc POSIX AIO switches completely to using native AIO then it
    would need basic AIO support for various file types - including sockets,
    pipes etc. Since it no longer will be simulating asynchronous behaviour
    with threads, it expects the underlying implementation to be asynchronous.
    Which is still an issue with native linux AIO, but I now think the problem
    to be tractable without a lot of additional work. While (1) helps the case
    for regular files, (2) now provides us an alternative infrastructure to
    simulate this in kernel using async epoll and O_NONBLOCK for all pollable
    fds, i.e. sockets, pipes etc. This should be good enough for working
    POSIX AIO.

(5) That leaves just one more todo - implementing aio_fsync() in kernel.

Please note that all of this work is not in conflict with kevent development.
In fact it is my hope that progress made in getting these pieces of the
puzzle in place would also help us along the long term goal of eventual
convergence.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

