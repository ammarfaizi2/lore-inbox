Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289024AbSAIVIG>; Wed, 9 Jan 2002 16:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSAIVHD>; Wed, 9 Jan 2002 16:07:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:60943 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289030AbSAIVGi>; Wed, 9 Jan 2002 16:06:38 -0500
Message-ID: <3C3CAF85.8BD5E2E1@zip.com.au>
Date: Wed, 09 Jan 2002 13:00:53 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Jani Forssell <jani.forssell@viasys.com>, sak@iki.fi
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
In-Reply-To: <20020108215818.J1331@niksula.cs.hut.fi> <E16O2fD-0007Vn-00@the-village.bc.nu> <20020108221315.U1200@niksula.cs.hut.fi> <20020109144549.L1331@niksula.cs.hut.fi>,
		<20020109144549.L1331@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Wed, Jan 09, 2002 at 02:45:49PM +0200 <20020109172604.N1331@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> 
> >>EIP; c0131ce0 <sync_page_buffers+10/b0>   <=====

Looks like a corrupted `next' pointer in the page's buffer_head
ring.  Your report is identical to Todd Eigenschink's repeatable
oops.  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.3/0689.html

In another thread, yesterday, we were discussing the elusive
"end_request: buffer-list destroyed" crash.

I am able to trigger this in around ten minutes on 2.4.13 and
later kernels.  However 2.4.13-pre6 ran the test for nine hours
and did not fail.

I've put the 2.4.13-pre6 -> 2.4.13 diff at http://www.zip.com.au/~akpm/1.gz


 MAINTAINERS                      |    6 ++
 Makefile                         |    2 
 arch/i386/kernel/smp.c           |   58 +++++++++++-----------------
 drivers/message/i2o/i2o_block.c  |   44 ++++++++-------------
 drivers/message/i2o/i2o_config.c |    1 
 drivers/message/i2o/i2o_core.c   |   39 ++++++++++++++++---
 drivers/message/i2o/i2o_lan.c    |    4 +
 drivers/message/i2o/i2o_pci.c    |   14 ++++++
 drivers/message/i2o/i2o_proc.c   |   16 +++----
 drivers/message/i2o/i2o_scsi.c   |   17 ++++++--
 drivers/scsi/dpt_i2o.c           |   14 +++---
 drivers/sound/ymfpci.c           |   52 +++++++++++--------------
 fs/buffer.c                      |   54 ++++++++++++++++----------
 fs/ntfs/fs.c                     |    1 
 include/linux/fs.h               |    3 -
 include/linux/locks.h            |    2 
 include/linux/mm.h               |   17 ++++----
 include/linux/slab.h             |    2 
 include/linux/swap.h             |    4 -
 kernel/exit.c                    |   13 +-----
 mm/highmem.c                     |    4 -
 mm/page_alloc.c                  |   39 +++++++++----------
 mm/swap.c                        |    4 -
 mm/vmscan.c                      |   80 ++++++++++++++++++++++-----------------

There were VM changes, and a messy, complex and undocumented
change to sync_page_buffers(), which was the point at which
I ceased to understand that function.   The patch was never Cc'ed
to the mailing list, was never explained.  This sort of thing
makes it very hard for other developers to hunt down bugs.

Probably, the bug lies elsewhere and perhaps my bug is different
from yours and Todd's.  It is timing-related, and the VM and
buffer changes may just have triggered it.

I have a debug patch from Jens to try tonight.

It could just be some random memory scribbler.  Dunno yet.  It's
awfully repeatable.

-
