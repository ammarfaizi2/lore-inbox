Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263120AbUJ2HQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbUJ2HQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 03:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUJ2HQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 03:16:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38344 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263129AbUJ2HQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 03:16:20 -0400
Date: Fri, 29 Oct 2004 17:14:29 +1000
From: Nathan Scott <nathans@sgi.com>
To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: best linux kernel with memory management
Message-ID: <20041029071429.GF1246@frodo>
References: <412C87F3.2030602@ribosome.natur.cuni.cz> <20040825114005.GB13285@logos.cnet> <412C94F5.4010902@ribosome.natur.cuni.cz> <20040825120450.GA22509@logos.cnet> <412C9D9C.6060703@ribosome.natur.cuni.cz> <20040827121905.GG32707@logos.cnet> <417F6258.7010209@ribosome.natur.cuni.cz> <20041028105108.GB5741@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20041028105108.GB5741@logos.cnet>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Martin,

Sorry about the slow reply, been away for a bit...

On Thu, Oct 28, 2004 at 08:51:08AM -0200, Marcelo Tosatti wrote:
> On Wed, Oct 27, 2004 at 10:54:48AM +0200, Martin MOKREJ? wrote:
> > Hi,
> >  I have hit again memory problem on the same host with 2.4.28-pre3.
> > I went to test raid5 filesystem and wanted to evaluate speed

Was that software (md) or hardware RAID5?

> > of different filesystems while studying different combinations
> > of their mkfs options or mount options. I did test reiserfs3,
> > ext3, xfs, ext2.
> > 
> >   With a subset of xfs test I run on the server out of memory,
> > reproducibly. Those are tests on a filesystem which was created
> > with "mkfs.xfs -f -b log=9 -d sunit=64,swidth=64 /dev/sdb2"

With that blocksize (-blog=9 is 512 byte blocksize) you will have
many more buffer_heads per page than the default (4k; i.e. 1-per-
page) which may cause a different kind of memory pressure to what
you'd otherwise see.

Are you tweaking all the filesystems to use that blocksize?  I'm
not sure they all support that small, actually, for ext2/3 I think
they stop at 1k as the smallest blocksize.

You should find the ideal MD RAID5 XFS geometry to be a 4k sector
size (-s size=4k) and 4K blocksize (-b size=4k) to mkfs.xfs.

> > and other sizes of swidth parameter. Omitting those parameters
> > makes no trouble and tests finish properly.

Thats interesting, I expect this may be a buffer_head reclaim
issue then, if the larger blocksize runs are completing fine.
In that case, I wonder if the attached patch helps at all?

Can you send me your /proc/meminfo and /proc/slabinfo at the time
you see the failure?  Also the console messages (I guess you sent
to Marcelo earlier too) with these failing allocation messages...

> >  I have noticed that maxfiles was reached and also the 
> > 0 allocation failed messages.
> > although from I forgot if I have again the 0 allocation pages
> > ...

(oh, and also which kernel versions are associated with which
sets of messages - looks like you've tried a few here).

> > >>>>kernel worked fine. Also 2.4.25 had problems which was on Gentoo 
> > >>>>install CDROM. I don't remember exact their exact revisions, but I 
> > >>>>shouldn't have used xfs also for /. I thought better xfs everywhere 
> > >>>>than combined with reiserfs. Of course, /boot is ext3.

There should be no problems using XFS for everything, including
/boot - I do that on all my systems (for a few years now).

> > >>on teh internal raid using gdth controller. After mkfs.xfs on internal 
> > >>disks I had to reboot often.

Hmm, that sounds like a device driver bug (if mkfs causes hangs..?).
Could you get sysrq-t or kdb stacktraces for the hung processes?

cheers.

-- 
Nathan

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=free_more_memory

Index: 2.4.x-xfs/fs/buffer.c
===================================================================
--- 2.4.x-xfs.orig/fs/buffer.c	Fri May 28 13:32:47 2004
+++ 2.4.x-xfs/fs/buffer.c	Fri May 28 13:33:58 2004
@@ -789,9 +789,9 @@
 {
 	balance_dirty();
 	wakeup_bdflush();
+	yield();
 	try_to_free_pages(GFP_NOIO);
 	run_task_queue(&tq_disk);
-	yield();
 }
 
 void init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)

--ReaqsoxgOBHFXBhH--
