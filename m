Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTFDT3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTFDT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:29:33 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:8143 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id S263971AbTFDT33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:29:29 -0400
Message-ID: <3EDE4B96.21DBA04B@fy.chalmers.se>
Date: Wed, 04 Jun 2003 21:42:14 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: Re: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
References: <3ED4681A.738DA3C6@fy.chalmers.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... accept ... patch which makes it possible to access the
> sense data returned by IDE CD/DVD units from user-land with SG_IO ioctl.

The originally proposed modifications were indeed sufficient to get
DVD+RW units working, but apparently not DVD-RW ones:-( Note though
that [another] problem discussed here is not specific to DVD-RW
recordings. It's generic bug/deficiency. Once a packet commands is
terminated with an error condition the whole bio should be purged at
once and not only the first chunk as it's currently implemented.

Attached patch should be considered as a "denoting" patch, not
"final." Well, because it was verified with single application,
growisofs of dvd+rw-tools, which uses mmap-ed, in other words 
page-aligned, buffer(s). I mean I'm not 100% sure if hard_nr_sectors
is appropriate even for general case of 4-byte aligned buffers...
Then if-statement should probably be extended even to REQ_PC case...

Cheers. A.
8<--------8<--------8<--------8<--------8<--------8<--------8<--------
--- ./drivers/ide/ide-cd.c.orig Tue Jun  3 12:21:56 2003
+++ ./drivers/ide/ide-cd.c      Wed Jun  4 16:14:41 2003
@@ -657,6 +657,9 @@
        struct request *rq = HWGROUP(drive)->rq;
        int nsectors = rq->hard_cur_sectors;
 
+       if (rq->flags&REQ_BLOCK_PC)
+               nsectors = rq->hard_nr_sectors;	/* purge it all ... */
+       else
        if ((rq->flags & REQ_SENSE) && uptodate) {
                /*
                 * For REQ_SENSE, "rq->buffer" points to the original failed
