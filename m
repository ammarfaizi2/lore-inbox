Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272125AbTG2U7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272128AbTG2U7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:59:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42759 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272125AbTG2U7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:59:24 -0400
Date: Tue, 29 Jul 2003 22:59:23 +0200
From: Jan Kara <jack@ucw.cz>
To: Herbert =?iso-8859-2?Q?P=F6tzl?= <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quota in 2.6.0-test2 broken ...
Message-ID: <20030729205923.GA19179@atrey.karlin.mff.cuni.cz>
References: <20030729160458.GA31881@www.13thfloor.at> <20030729164936.GD20290@atrey.karlin.mff.cuni.cz> <20030729203106.GB11552@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20030729203106.GB11552@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> > > Quota is definitely broken in 2.6.0-test2 because the
> > > code tries to acquire dqio_sem in *_read_file_info, while
> > > already holding the same sem in vfs_quota_on, which
> > > simply deadlocks ...
> >   Huh I see. Actually only old quota format is affected by this bug
> > (that may be a reason why it went unnoticed for a while).
> 
> yes, but the 'new' quota format doesn't work either ...
> 
> quotacheck -vaugm
> quotacheck: Scanning /dev/discs/disc1/part2 [/mnt/part2] ...
> quotacheck: Checked 4 directories and 0 files
> quotacheck: Old file not found.
> quotacheck: Old file not found.
> 
> quotaon /dev/discs/disc1/part2
> quotaon: using /mnt/part2/quota.user on /dev/discs/disc1/part2 [/mnt/part2]: Invalid argument
> quotaon: Maybe create new quota files with quotacheck(8)?
  Are you sure you compiled old quota format support into the kernel?

> > > it seems this stuff hasn't been tested since the last
> > > update? doesn't anybody use quota anymore?
> >   When you have test machine you usually don't run a quota on it and
> > when you have machine with lots of users on it you won't use unstable
> > kernels. So I guess this is not a big wonder (I suppose the bugreports
> > for 2.6 quota code will start to appear soon ;).
> 
> yeah, but I would expect, that you at least
> once tested the stuff yourself ... well no such luck,
  Of course I did. I don't know how this thing could get into the
kernel...

> when will it be fixed? any plans?
  I've attached possible fix (untested because first I have to update
binutils to be able to compile the kernel and it will take some time
because I have only modem line).

								Honza

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quotafix.diff"

diff -ruNX /home/jack/.kerndiffexclude linux-2.6.0-test2/fs/quota_v1.c linux-2.6.0-test2-quotafix/fs/quota_v1.c
--- linux-2.6.0-test2/fs/quota_v1.c	Sun Jul 27 19:06:18 2003
+++ linux-2.6.0-test2-quotafix/fs/quota_v1.c	Tue Jul 29 21:19:39 2003
@@ -164,7 +164,6 @@
 	struct v1_disk_dqblk dqblk;
 	int ret;
 
-	down(&dqopt->dqio_sem);
 	offset = v1_dqoff(0);
 	fs = get_fs();
 	set_fs(KERNEL_DS);
@@ -177,7 +176,6 @@
 	dqopt->info[type].dqi_igrace = dqblk.dqb_itime ? dqblk.dqb_itime : MAX_IQ_TIME;
 	dqopt->info[type].dqi_bgrace = dqblk.dqb_btime ? dqblk.dqb_btime : MAX_DQ_TIME;
 out:
-	up(&dqopt->dqio_sem);
 	set_fs(fs);
 	return ret;
 }
@@ -191,7 +189,6 @@
 	loff_t offset;
 	int ret;
 
-	down(&dqopt->dqio_sem);
 	dqopt->info[type].dqi_flags &= ~DQF_INFO_DIRTY;
 	offset = v1_dqoff(0);
 	fs = get_fs();
@@ -210,7 +207,6 @@
 	else if (ret > 0)
 		ret = -EIO;
 out:
-	up(&dqopt->dqio_sem);
 	set_fs(fs);
 	return ret;
 }

--UugvWAfsgieZRqgk--
