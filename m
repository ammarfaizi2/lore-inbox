Return-Path: <linux-kernel-owner+w=401wt.eu-S964967AbWL1ISs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWL1ISs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWL1ISs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:18:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:45900 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964962AbWL1ISq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:18:46 -0500
Date: Thu, 28 Dec 2006 13:53:08 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20061228082308.GA4476@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227153855.GA25898@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently native linux AIO is properly supported (in the sense of
actually being asynchronous) only for files opened with O_DIRECT.
While this suffices for a major (and most visible) user of AIO, i.e. databases,
other types of users like Samba require AIO support for regular file IO.
Also, for glibc POSIX AIO to be able to switch to using native AIO instead
of the current simulation using threads, it needs/expects asynchronous
behaviour for both O_DIRECT and buffered file AIO.

This patchset implements changes to make filesystem AIO read
and write asynchronous for the non O_DIRECT case. This is mainly
relevant in the case of reads of uncached or partially cached files, and
O_SYNC writes. 

Instead of translating regular IO to [AIO + wait], it translates AIO
to [regular IO - blocking + retries]. The intent of implementing it
this way is to avoid modifying or slowing down normal usage, by keeping
it pretty much the way it is without AIO, while avoiding code duplication.
Instead we make AIO vs regular IO checks inside io_schedule(), i.e. at
the blocking points. The low-level unit of distinction is a wait queue
entry, which in the AIO case is contained in an iocb and in the
synchronous IO case is associated with the calling task.

The core idea is that is we complete as much IO as we can in a non-blocking
fashion, and then continue the remaining part of the transfer again when
woken up asynchronously via a wait queue callback when pages are ready ... 
thus each iteration progresses through more of the request until it is
completed. The interesting part here is that owing largely to the idempotence
in the way radix-tree page cache traveral happens, every iteration is simply
a smaller read/write. Almost all of the iocb manipulation and advancement
in the AIO case happens in the high level AIO code, and rather than in
regular VFS/filesystem paths.

The following is a sampling of comparative aio-stress results with the
patches (each run starts with uncached files):

---------------------------------------------
				
aio-stress throughput comparisons (in MB/s):

file size 1GB, record size 64KB, depth 64, ios per iteration 8
max io_submit 8, buffer alignment set to 4KB
4 way Pentium III SMP box, Adaptec AIC-7896/7 Ultra2 SCSI, 40 MB/s
Filesystem: ext2

----------------------------------------------------------------------------
			Buffered (non O_DIRECT)
			Vanilla		Patched		O_DIRECT
----------------------------------------------------------------------------
						       Vanilla Patched
Random-Read		10.08		23.91		18.91,   18.98
Random-O_SYNC-Write	 8.86		15.84		16.51,   16.53
Sequential-Read		31.49		33.00		31.86,   31.79
Sequential-O_SYNC-Write  8.68		32.60		31.45,   32.44
Random-Write		31.09 (19.65)	30.90 (19.65)	
Sequential-Write	30.84 (28.94)	30.09 (28.39)

----------------------------------------------------------------------------

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

