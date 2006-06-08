Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWFHIE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWFHIE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWFHIE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:04:56 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:24813 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S964792AbWFHIEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:04:55 -0400
Date: Thu, 8 Jun 2006 10:04:44 +0200
From: Voluspa <lista1@comhem.se>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: Valdis.Kletnieks@vt.edu, diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-Id: <20060608100444.5212162d.lista1@comhem.se>
In-Reply-To: <349141076.14929@ustc.edu.cn>
References: <20060530053631.57899084.lista1@comhem.se>
	<200605301649.k4UGnooZ004266@turing-police.cc.vt.edu>
	<20060531235021.41a58425.lista1@comhem.se>
	<349141076.14929@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My patching was borked as can be seen in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114956084026066&w=2

I've therefore benchmarked two corrected patches from Wu:
http://web.comhem.se/~u46139355/storetmp/adaptive-readahead-2.6.17-rc5-wu-v1.patch
http://web.comhem.se/~u46139355/storetmp/adaptive-readahead-2.6.17-rc5-wu-v2.patch

Revised Conclusion: On _this_ machine, with _these_ operations, Adaptive
Readahead in its current incarnation and default settings is a slight
_loss_. However, if the readahead size is lowered from 2048 to 256, it
becomes a slight _gain_ or at least stays in parity with normal readahead.

I suggest others to test multi-thread, multi-cpu, more than/less than my
2GB memory, sata-disks, different disk speeds etc etc.

Kernels:
root:sleipner:~# ls -l /boot/kernel-2.6.17-rc5-git10*
1440 -rw-r--r--  1 root root 1469326 Jun  6 22:27 /boot/kernel-2.6.17-rc5-git10
1440 -rw-r--r--  1 root root 1470122 Jun  6 22:36 /boot/kernel-2.6.17-rc5-git10-ar1
1440 -rw-r--r--  1 root root 1470128 Jun  6 22:44 /boot/kernel-2.6.17-rc5-git10-ar2

_Massive READ_

[/usr had some 195000 files]

"cd /usr; time find . -type f -exec md5sum {} \; >/dev/null"

[/sbin/blockdev --setra 256 /dev/hda]  * [/sbin/blockdev --setra 2048 /dev/hda]

6.17-rc5-git10 - git10-ar1 - git10-ar2 * 6.17-rc5-git10 - git10-ar1 - git10-ar2

real 8m18.241s - 8m19.053s - 8m16.639s * real 8m24.042s - 8m22.652s - 8m20.812s
user 1m23.556s - 1m24.526s - 1m23.725s * user 1m23.788s - 1m23.741s - 1m24.023s
sys  2m8.514s  - 2m5.989s  - 2m3.540s  * sys  2m7.369s  - 2m6.914s  - 2m5.317s

real 8m19.171s - 8m17.993s - 8m17.062s * real 8m23.110s - 8m20.409s - 8m19.278s
user 1m23.863s - 1m23.692s - 1m23.980s * user 1m23.770s - 1m23.715s - 1m23.525s
sys  2m9.332s  - 2m4.133s  - 2m3.602s  * sys  2m6.463s  - 2m5.735s  - 2m3.801s

real 8m17.111s - 8m17.102s - 8m16.859s * real 8m21.891s - 8m19.129s - 8m17.321s
user 1m24.071s - 1m24.126s - 1m24.430s * user 1m23.876s - 1m23.592s - 1m23.024s
sys  2m6.292s  - 2m3.543s  - 2m3.142s  * sys  2m4.768s  - 2m4.012s  - 2m3.110s

real 8m20.427s - 8m16.972s - 8m17.847s * real 8m25.359s - 8m21.261s - 8m20.365s
user 1m23.730s - 1m23.260s - 1m23.227s * user 1m24.242s - 1m23.825s - 1m23.895s
sys  2m9.524s  - 2m3.708s  - 2m5.244s  * sys  2m7.894s  - 2m5.366s  - 2m3.971s


_READ/WRITE_

[255 .tga files, each is 1244178 bytes]
[1 .wav file which is 1587644 bytes]
[movie becomes 573298 bytes ~9s long]

"time mencoder -ovc lavc -lavcopts aspect=16/9 mf://picsave/kreation/03-logo-joined/*.tga -oac lavc -audiofile kreation-files/kreation-logo-final.wav -o logo-final-widescreen-speedtest.avi"

[/sbin/blockdev --setra 256 /dev/hda]  * [/sbin/blockdev --setra 2048 /dev/hda]

6.17-rc5-git10 - git10-ar1 - git10-ar2 * 6.17-rc5-git10 - git10-ar1 - git10-ar2

real 0m12.961s - 0m12.864s - 0m12.811s * real 0m16.628s - 0m15.862s - 0m16.754s
user 0m3.315s  - 0m3.319s  - 0m3.316s  * user 0m3.335s  - 0m3.301s  - 0m3.308s
sys  0m1.082s  - 0m1.077s  - 0m1.086s  * sys  0m1.084s  - 0m1.122s  - 0m1.093s

real 0m12.908s - 0m12.793s - 0m12.813s * real 0m16.601s - 0m15.893s - 0m16.736s
user 0m3.323s  - 0m3.305s  - 0m3.312s  * user 0m3.311s  - 0m3.316s  - 0m3.308s
sys  0m1.051s  - 0m1.079s  - 0m1.145s  * sys  0m1.046s  - 0m1.109s  - 0m1.091s


_cp bigfile between different partitions_

[Elephants_Dream_HD.avi 854537054 bytes]

"time cp /home/downloads/Elephants_Dream_HD.avi /root"

[/sbin/blockdev --setra 256 /dev/hda]  * [/sbin/blockdev --setra 2048 /dev/hda]

6.17-rc5-git10 - git10-ar1 - git10-ar2 * 6.17-rc5-git10 - git10-ar1 - git10-ar2

real 0m46.463s - 0m46.909s - 0m45.865s * real 0m50.232s - 0m50.863s - 0m50.549s
user 0m0.081s  - 0m0.073s  - 0m0.068s  * user 0m0.069s  - 0m0.063s  - 0m0.088s
sys  0m6.304s  - 0m7.204s  - 0m5.949s  * sys  0m5.902s  - 0m7.174s  - 0m6.822s

real 0m46.126s - 0m47.305s - 0m47.174s * real 0m50.875s - 0m50.066s - 0m50.862s
user 0m0.091s  - 0m0.095s  - 0m0.070s  * user 0m0.099s  - 0m0.091s  - 0m0.071s
sys  0m5.751s  - 0m7.159s  - 0m6.707s  * sys  0m6.271s  - 0m6.740s  - 0m7.318s


_cp filetree between different partitions_

[compiled kerneltree ~339M]

"time cp -a /usr/src/testing/linux-2.6.17-rc5-git10 /root"

[/sbin/blockdev --setra 256 /dev/hda]  * [/sbin/blockdev --setra 2048 /dev/hda]

6.17-rc5-git10 - git10-ar1 - git10-ar2 * 6.17-rc5-git10 - git10-ar1 - git10-ar2

real 0m51.344s - 0m51.886s - 0m51.077s * real 0m52.502s - 0m52.757s - 0m54.794s
user 0m0.193s  - 0m0.220s  - 0m0.231s  * user 0m0.210s  - 0m0.198s  - 0m0.177s
sys  0m5.508s  - 0m6.003s  - 0m5.205s  * sys  0m5.980s  - 0m5.800s  - 0m6.372s

real 0m51.148s - 0m51.212s - 0m51.768s * real 0m51.488s - 0m52.098s - 0m51.719s
user 0m0.170s  - 0m0.209s  - 0m0.184s  * user 0m0.198s  - 0m0.210s  - 0m0.179s
sys  0m5.697s  - 0m5.604s  - 0m6.438s  * sys  0m5.527s  - 0m5.918s  - 0m5.544s

Mvh
Mats Johannesson
--
