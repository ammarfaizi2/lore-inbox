Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVIWHU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVIWHU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVIWHU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:20:58 -0400
Received: from h80ad244c.async.vt.edu ([128.173.36.76]:32966 "EHLO
	h80ad244c.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750721AbVIWHU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:20:58 -0400
Message-Id: <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Con Kolivas <kernel@kolivas.org>, Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up 
In-Reply-To: Your message of "Fri, 23 Sep 2005 10:36:16 +1000."
             <200509231036.16921.kernel@kolivas.org> 
From: Valdis.Kletnieks@vt.edu
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
            <200509231036.16921.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127460032_2947P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Sep 2005 03:20:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127460032_2947P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 Sep 2005 10:36:16 +1000, Con Kolivas said:

(Adding Andrea to the To: list...)

> On Fri, 23 Sep 2005 05:59, Valdis.Kletnieks@vt.edu wrote:
> > Am seeing reproducible wedging up when writing large (20M+) files to an
> > ext3 file system.  Oddly enough, if something *else* writes files to the
> > file system as well, it will unwedge for a while and make progress.  Also,
> > a 'sync' command will relieve things temporarily - but after a few
> > megabytes it comes to a halt again.  Looks like a borkage someplace not
> > causing it to actually finish pushing dirty file pages out - gkrellm
> > reports little/no disk activity in progress. File activity on *other*
> > filesystems continues unimpeded.
> 
> 
> Could be the write throttling patches.
> 
> Try backing these out (in this order I think):
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6
.14-rc2-mm1/broken-out/per-task-predictive-write-throttling-1-tweaks.patch
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6
.14-rc2-mm1/broken-out/per-task-predictive-write-throttling-1.patch

Bingo.  I haven't built a kernel with these excluded, but writing 0 to
/proc/sys/vm/dirty_ratio_centisecs fixes the problem, so I'm pretty sure
this is it.

(For the record, I've noticed the starvation issue that Andrea is trying to
address, where one process can lock out others, so I *do* think work is needed
here...)

Tuning/debugging info I gathered:

1) I was seeing 'future_pages' values averaging as high as 7K to 14K - is this
a "reasonable" number when writing a 38M file to a fairly sluggish laptop disk
(gkrellm showing 1M/sec to 3M/sec often, maybe 10M/sec if it's a single fairly
linear write..).  Popular values that were seen on multiple trials included
14364, 13851, and 13338 (though a few times, a wedge would hit 14364, and a few
seconds later would "burp" up a bunch of disk I/O and drop to 7626 and stay there).

The reproducability of the numbers probably says more about the fact that the
system is otherwise basically idle at 3AM than anything else (so the number of
available pages isn't bouncing around due to other processes).

2) 'centiseconds' value of 0 disabled as designed. The default value of '500'
is *waaay* too high on my laptop - even 100 is consistently too much.  40 was
consistently low enough, 50 was usually OK, 75 was usually *not* OK, but would
sometimes "stutter" through and not completely grind to a halt. I'm not sure
exactly where the "knee" is, or if it moves during higher-load (my laptop
works harder during the day in the office than 2AM at home, usually).

The patch includes documentation:

+dirty_ratio_centisecs
+-----------------
+
+Throttle the I/O if the per-task writing bandwidth is high enough for
+the dirty_ratio to be reached in less than dirty_ratio_centisecs. This
+makes the write throttling per-process and avoids making too much
+memory dirty at the same time. Ideally in the future we should add
+some feedback from the backing_dev_info to know the max disk bandwidth.

I'm pretty convinced that for this patch to work, it *will* need feedback from
the actual (not max) disk bandwidth and possibly the actual amount of RAM -
what works on Andrea's 1G workstation with (presumably) a real disk system
is waay too much for 256M and a single laptop-class disk.

For now, I'm leaving centisecs set to 40, and will see how that works - most
of my "problem cases" involve an FTP on a 10/100mbit connection, so that will
get tried tomorrow.....

--==_Exmh_1127460032_2947P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDM6zAcC3lWbTT17ARAhpjAKDE+g7DxWStinMWNe+CbdqFSxsoPwCgzLCu
4Ww/ykDoht2aSMesu21vNzg=
=NhiD
-----END PGP SIGNATURE-----

--==_Exmh_1127460032_2947P--
