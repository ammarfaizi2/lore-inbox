Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbRFHMvy>; Fri, 8 Jun 2001 08:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbRFHMvp>; Fri, 8 Jun 2001 08:51:45 -0400
Received: from www.wen-online.de ([212.223.88.39]:6674 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263979AbRFHMv3>;
	Fri, 8 Jun 2001 08:51:29 -0400
Date: Fri, 8 Jun 2001 14:50:22 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Shane Nay <shane@minirl.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <l03130324b745d584d0c9@[192.168.239.105]>
Message-ID: <Pine.LNX.4.33.0106081440300.389-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Jonathan Morton wrote:

> http://www.chromatix.uklinux.net/linux-patches/vm-update-2.patch
>
> Try this.  I can't guarantee it's SMP-safe yet (I'm leaving the gurus to
> that, but they haven't told me about any errors in the past hour so I'm
> assuming they aren't going to find anything glaringly wrong...), but you
> might like to see if your performance improves with it.  It also fixes the
> OOM-killer bug, which you refer to above.
>
> Some measurements, from my own box (1GHz Athlon, 256Mb RAM):
>
> For the following benchmarks, physical memory availability was reduced
> according to the parameter in the left column.  The benchmark is the
> wall-clock time taken to compile MySQL.
>
> mem=	2.4.5		earlier tweaks	now
> 48M	8m30s		6m30s		5m58s
> 32M	unknown		2h15m		12m34s
>
> The following was performed with all 256Mb RAM available.  This is
> compilation of MySQL using make -j 15.
>
> kernel:		2.4.5		now
> time:		6m30s		6m15s
> peak swap:	190M		70M
>
> For the following test, the 256Mb swap partition on my IDE drive was
> disabled and replaced with a 1Gb swapfile on my Ultra160 SCSI drive.  This
> is compilation of MySQL using make -j 20.
>
> kernel:		2.4.5		now
> time:		7m20s		6m30s
> peak swap:	370M		254M
>
> Draw your own conclusions.  :)

(ok;)

Hi,

I gave this a shot at my favorite vm beater test (make -j30 bzImage)
while testing some other stuff today.

seven identical runs, six slightly different kernels plus yours.

real    11m23.522s  2.4.5.vm-update-2
user    7m59.170s
sys     0m37.030s
user  :       0:08:07.06  65.6%  page in :   642402
nice  :       0:00:00.00   0.0%  page out:   676820
system:       0:02:09.44  17.4%  swap in :   105965
idle  :       0:02:05.66  16.9%  swap out:   162603

real    10m9.512s  2.4.5.virgin
user    7m55.520s
sys     0m35.460s
user  :       0:08:02.66  72.2%  page in :   535186
nice  :       0:00:00.00   0.0%  page out:   377992
system:       0:01:37.78  14.6%  swap in :    99445
idle  :       0:01:28.14  13.2%  swap out:    81926

real    10m48.939s 2.4.5.virgin+reclaim.marcelo
user    7m54.960s
sys     0m36.240s
user  :       0:08:02.33  68.0%  page in :   566239
nice  :       0:00:00.00   0.0%  page out:   431874
system:       0:01:56.02  16.4%  swap in :   108633
idle  :       0:01:50.61  15.6%  swap out:    96415

real    9m54.466s 2.4.5.virgin+reclaim.mike (icky 'bleeder valve')
user    7m57.370s
sys     0m35.890s
user  :       0:08:04.74  74.1%  page in :   527678
nice  :       0:00:00.00   0.0%  page out:   405259
system:       0:01:12.01  11.0%  swap in :    98616
idle  :       0:01:37.47  14.9%  swap out:    91492

real    9m12.198s  2.4.5.tweak
user    7m41.290s
sys     0m34.840s
user  :       0:07:47.69  76.8%  page in :   452632
nice  :       0:00:00.00   0.0%  page out:   399847
system:       0:01:17.08  12.7%  swap in :    75338
idle  :       0:01:03.97  10.5%  swap out:    88291

real    9m41.563s  2.4.5.tweak+reclaim.marcelo
user    7m59.880s
sys     0m34.690s
user  :       0:08:07.22  73.4%  page in :   515433
nice  :       0:00:00.00   0.0%  page out:   545762
system:       0:01:35.34  14.4%  swap in :    88425
idle  :       0:01:21.11  12.2%  swap out:   125967

real    9m47.682s  2.4.5.tweak+reclaim.mike
user    8m2.190s
sys     0m34.550s
user  :       0:08:09.57  75.7%  page in :   513166
nice  :       0:00:00.00   0.0%  page out:   473539
system:       0:01:20.27  12.4%  swap in :    83127
idle  :       0:01:16.89  11.9%  swap out:   108886

Conclusion:

Your patch hits the cache too hard and pays through the nose for
doing so.. at least under this hefty weight load it does.

