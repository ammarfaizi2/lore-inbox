Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273532AbRIUN0b>; Fri, 21 Sep 2001 09:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273529AbRIUN0V>; Fri, 21 Sep 2001 09:26:21 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:34308 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S273526AbRIUN0G>; Fri, 21 Sep 2001 09:26:06 -0400
Date: Fri, 21 Sep 2001 15:26:27 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
Cc: linux-kernel@vger.kernel.org, tovarlds@transmeta.com
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems, kupdated bugfixes
Message-ID: <20010921152627.C13862@emma1.emma.line.org>
Mail-Followup-To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
	linux-kernel@vger.kernel.org, tovarlds@transmeta.com
In-Reply-To: <Pine.LNX.4.30.0109201445170.13543-100000@gamma.student.ljbc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109201445170.13543-100000@gamma.student.ljbc>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Beau Kuiper wrote:

> Patch 3
> 
> This patch was generated as I was exploring the buffer cache, wondering
> why reiserfs was so slow on 2.4. I found that kupdated may write buffers
> that are not actually old back to disk. Eg
> 
> Imagine that there are 20 dirty buffers. 16 of them are more that 30
> seconds old (and should be written back), but the other 4 are younger than
> 30 seconds. The current code would force all 20 out to disk, interrupting
> programs still using the young 4 until the disk write was complete.
> 
> I know that it isn't a major problem, but I found it and I have written
> the patch for it :-)

Be careful! MTAs rely on this behaviour on fsync(). The official
consensus on ReiserFS and ext3 on current Linux 2.4.x kernels (x >= 9)
is that "any synchronous operation flushes all pending operations", and
if that is changed, you MUST make sure that the changed ReiserFS/ext3fs
still make all the guarantees that softupdated BSD file systems make,
lest you want people to run their mail queues off "sync" disks.

Note also, if these blocks belong to newly-opened files, you definitely
want kupdated to flush these to disk on its next run so that the files
are still there after a crash.

I'm not exactly sure what your patch 3 does and how the buffers work,
but I'm absolutely sure we want the "fsync on an open file also syncs
all pending rename/link/open operations the corresponding file has
undergone."

Softupdates FFS (BSD) does that, and ReiserFS/ext3fs also do that by
just flushing all pending operations on a synchronous one, and it's not
slow.

This may cause additional writes, but the reliability issues must be
taken into account here. We don't gain anything if files get lost over a
crash just because you want to save 4 writes.
