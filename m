Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129157AbQKARum>; Wed, 1 Nov 2000 12:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQKARub>; Wed, 1 Nov 2000 12:50:31 -0500
Received: from [24.65.192.120] ([24.65.192.120]:43254 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129157AbQKARuQ>;
	Wed, 1 Nov 2000 12:50:16 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011011750.eA1Ho8s06277@webber.adilger.net>
Subject: Re: fork in module?
In-Reply-To: <27525795B28BD311B28D00500481B7601623A0@ftrs1.intranet.FTR.NL>
 "from Heusden, Folkert van at Nov 1, 2000 02:51:38 pm"
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
Date: Wed, 1 Nov 2000 10:50:08 -0700 (MST)
CC: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> what would be the way of starting a sub-process in a module which then would
> run in the background? I guess plain fork() won't work?

We did this in one of our filesystem modules to have our own async cache
flush daemon.  One thing you need to watch out for is that the new thread
is stopped before the module is unloaded.  You can't simply increase the
module reference count, and decrease it when the thread exits, because
you are never allowed to remove a module with a non-zero refcount.

What you need to do is have your module cleanup function stop the thread,
and then wait to be sure it has exited before unloading.  This is a
bit more tricky because you could send the thread a KILL signal and it is
still doing work or is rescheduled before it has completed exiting.

Check out obdfs/flushd.c (pupdated, obdfs_flushd_init, obdfs_flushd_cleanup)
and obdfs/super.c (init_module, init_obdfs, cleanup_module) at:

ftp://ftp.stelias.com/pub/obd/obd-0.004.tgz

This module also does slab-cache initialization and cleanup (properly!),
so that is also worth looking at.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
