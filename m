Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbULMFnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbULMFnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 00:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbULMFnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 00:43:22 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:28811 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262020AbULMFnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 00:43:15 -0500
Subject: cifs large write performance improvements to Samba
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org,
       samba-technical@lists.samba.org
Content-Type: text/plain
Message-Id: <1102916738.5937.48.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 12 Dec 2004 23:45:38 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some informal results evaluating the results of new cifs directio mount
option and effects of changing the SMB network buffer size.  All tests
were run at least four times on each configuration and averaged.

Command executed: time dd if=/dev/zero of=/mnt/ofile bs=1M count=400 
(400MB copy to server with large writes)

MemTotal on system: 905148kB (from /proc/meminfo)

Kernel: current 2.6.10-rc3 from linux.bkbits.net/linux-2.5 bk
SLES9 JFS (and EXT3 on one test). Intel Pentium M, relatively slower IDE
drives (laptop). Kernel compiled for debug memory allocations.

CIFS filesystem version: 1.28

Samba version 3.0.10pre (current svn)

mount over loopback interface to samba server on the same box (to
maximize network transfer speed)


CIFS mount (default): 1 minute 46 seconds (constrained largely by the 4K
writes, due to no implementation of page coalescing and no
implementation of cifs_writepages)

CIFS mount (directio): 35.9 seconds (huge improvement due to now being
able to do up to 16K size writes to server, and reducing double caching
effects since page cache not used on client side). Running with a faster
processor (otherwise the same) this dropped to 20.8 second average.

CIFS mount (directio, insmod specifying larger CIFSMaxBufSize of 65024):
24.0 seconds  The larger buffer size (almost 4 times larger) led to
significant improvements (going beyond this to 120K network write size
did not improve performance on this test, actually got a bit worse).
Running with a faster processor (otherwise the same) this improved to
19.3 seconds average (and using the even larger 120K write size
performance dropped slightly to 20.6 seconds)

Additional comparison points - 
The older smbfs filesystem: 1 minute 7.04 seconds (note that smbfs read
performance is much worse than cifs in part due to lack of readpages
implementation in smbfs, but the writepage performances differ less
significantly)

Local performance: 
JFS  3.5 seconds
EXT3 12.8 seconds

EXT3 was somewhat slower than I expected.  

The does show that cifs directio mounts help a lot for large file copy -
and also that cifs badly needs an asyn writepages implementation (which
has obviously helped NFS on this kind of test). In addition CIFS needs
to reduce some of the CPU (one of the large buf allocs and memcpys in
the write path can be eliminated with some reasonably obvious changes). 
I doubt that enough analysis on the Samba server side has been done for
this particular case on 2.6 and that might yield some easy improvements
as well.  Also note that there was one case in which cifs to Samba ran
into the expected memory contention deadlock (client writes dirty page
to server, server blocked on memory allocation which is blocked on
client's write).


