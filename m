Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUH1MMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUH1MMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 08:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUH1MMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 08:12:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50633 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266473AbUH1MMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 08:12:33 -0400
Date: Sat, 28 Aug 2004 14:14:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
Message-ID: <20040828121413.GB17908@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <1093556379.5678.109.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093556379.5678.109.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> 
> Hmm, it seems that those strange ~1ms latencies are back.  This was
> triggered by mounting an NTFS volume:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8.1-P9#/var/www/2.6.8.1-P9/trace5.txt

this is genuine NTFS overhead.

the 1 msec events you get because the timer fires once every 1 msec, but
this is not irregular. There is a single NTFS function running, which is
profiled nicely by the timer IRQ:

 00010001 0.372ms (+0.372ms): do_IRQ (load_and_init_upcase)
 ...
 00010001 1.374ms (+0.981ms): do_IRQ (load_and_init_upcase)
 ...
 00010001 2.376ms (+0.978ms): do_IRQ (load_and_init_upcase)
 ...
 00000001 2.615ms (+0.216ms): vfree (load_and_init_upcase)

to be able to debug such latencies is one reason why i changed the
do_IRQ() trace-entry to show the interrupted function's name. (it
wouldnt normally, mcount() doesnt reach across IRQ frames.)

load_and_init_upcase() is called by ntfs_fill_super() which is called by
the mount code, which runs under lock_kernel(). It seems NTFS does not
rely on the BKL - could you try the patch below, does it solve the
latency?

	Ingo

--- linux/fs/ntfs/super.c.orig
+++ linux/fs/ntfs/super.c
@@ -2288,6 +2288,8 @@ static int ntfs_fill_super(struct super_
 	vol->fmask = 0177;
 	vol->dmask = 0077;
 
+	unlock_kernel();
+
 	/* Important to get the mount options dealt with now. */
 	if (!parse_options(vol, (char*)opt))
 		goto err_out_now;
@@ -2424,6 +2426,7 @@ static int ntfs_fill_super(struct super_
 		}
 		up(&ntfs_lock);
 		sb->s_export_op = &ntfs_export_ops;
+		lock_kernel();
 		return 0;
 	}
 	ntfs_error(sb, "Failed to allocate root directory.");
@@ -2527,6 +2530,7 @@ iput_tmp_ino_err_out_now:
 	}
 	/* Errors at this stage are irrelevant. */
 err_out_now:
+	lock_kernel();
 	sb->s_fs_info = NULL;
 	kfree(vol);
 	ntfs_debug("Failed, returning -EINVAL.");
