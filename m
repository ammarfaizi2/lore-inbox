Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUFYSrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUFYSrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUFYSqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:46:38 -0400
Received: from mout1.freenet.de ([194.97.50.132]:40406 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S266832AbUFYSpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:45:12 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
Date: Fri, 25 Jun 2004 20:44:22 +0200
User-Agent: KMail/1.6.2
References: <200406251840.46577.mbuesch@freenet.de> <40DC56CB.5040907@kolivas.org>
In-Reply-To: <40DC56CB.5040907@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406252044.25843.mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 25 June 2004 18:46, you wrote:
> I haven't seen what is in -bk7 so I don't know if there's an issue with
> applying it to that. Anything's possible, though. See if you can
> reproduce it and isolate it to staircase or not and collect some more
> info about what is happening with the task from top, vmstat and
> /proc/$pid/status

I just catched a stalled process:

mb       11000  0.4  0.6  4604 3180 tty2     S    20:32   0:01 /bin/sh ./configure --enable-debug

mb@lfs:/proc/11000> cat status
Name:   configure
State:  S (sleeping)
Burst:  0
Tgid:   11000
Pid:    11000
PPid:   1858
TracerPid:      0
Uid:    1000    1000    1000    1000
Gid:    100     100     100     100
FDSize: 256
Groups: 9 10 100
VmSize:     4604 kB
VmLck:         0 kB
VmRSS:      3180 kB
VmData:     2356 kB
VmStk:       132 kB
VmExe:       572 kB
VmLib:      1444 kB
Threads:        1
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000010000
SigIgn: 8000000000000004
SigCgt: 0000000043817efb
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000

I don't know what the file wchan is good for, but here is
it's output:
mb@lfs:/proc/11000> cat wchan
sys_wait4

Seems it's killable by SIGKILL only.
mb@lfs:/proc/11000> kill 11000
mb@lfs:/proc/11000> kill 11000
mb@lfs:/proc/11000> kill 11000
mb@lfs:/proc/11000> kill -9 11000
mb@lfs:/proc/11000> kill -9 11000
bash: kill: (11000) - No such process

Now it's some kind of reproducible (maybe because
the machine has a higher uptime, now).
A ./configure run sooner or later stalls for sure, now.

mb@lfs:~> vmstat
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
13  0     92  42520  43696 235384    0    0    33    75 2201  1949 88 12  0  0


- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3HKHFGK1OIvVOP4RAvYoAKDG8rwiNotlMfDA8O1z67LC3NeiTwCgl+GT
ADmS474ofisnFfT7/kq0IeU=
=qvC1
-----END PGP SIGNATURE-----
