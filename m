Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130523AbRCDVdH>; Sun, 4 Mar 2001 16:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130521AbRCDVc6>; Sun, 4 Mar 2001 16:32:58 -0500
Received: from ip167-84.fli-ykh.psinet.ne.jp ([210.129.167.84]:54725 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S130519AbRCDVci>;
	Sun, 4 Mar 2001 16:32:38 -0500
Message-ID: <3AA2B390.12819DD2@yk.rim.or.jp>
Date: Mon, 05 Mar 2001 06:28:49 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Douglas Gilbert <dougg@torque.net>
CC: Mike Black <mblack@csihq.com>, Jeremy Hansen <jeremy@xxedgexx.com>,
        linux-scsi@vger.kernel.org, mysql@lists.mysql.com,
        linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <Pine.LNX.4.33L2.0103021033190.6176-200000@srv2.ecropolis.com> <054201c0a33d$55ee5870$e1de11cc@csihq.com> <3AA2A120.49509A11@torque.net>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:

> There is definitely something strange going on here.
> As the bonnie test below shows, the SCSI disk used
> for my tests should vastly outperform the old IDE one:

First thank you and others with my clueless investigation about
the module loading under Debian GNU/Linux. (I should have known
that Debian uses a very special module setup.)

Anyway, I used to think SCSI is better than IDE in general, and
the post was quite surprising.
So I ran the test on my PC.
On my systems too, the IDE beats SCSI hand down with the test case.

BTW, has anyone noticed that
the elapsed time of SCSI case is TWICE as long if
we let the previous output of the test program stay before
running the second test? (I suspect fdatasync
takes time proportional to the (then current)  file size, but
still why SCSI case is so long is beyond me.)

Eg.

ishikawa@duron$ ls -l /tmp/t.out
ls: /tmp/t.out: No such file or directory
ishikawa@duron$ time ./xlog /tmp/t.out fsync

real    0m38.673s    <=== my scsi disk is slow one to begin with...
user    0m0.050s
sys     0m0.140s
ishikawa@duron$ ls -l /tmp/t.out
-rw-r--r--    1 ishikawa users      112000 Mar  5 06:19 /tmp/t.out
ishikawa@duron$ time ./xlog /tmp/t.out fsync

real    1m16.928s        <=== See TWICE as long!
user    0m0.060s
sys     0m0.160s
ishikawa@duron$ ls -l /tmp/t.out
-rw-r--r--    1 ishikawa users      112000 Mar  5 06:20 /tmp/t.out
ishikawa@duron$ rm /tmp/t.out    <==== REMOVE the file and try again.
ishikawa@duron$ time ./xlog /tmp/t.out fsync

real    0m40.667s       <==== Half as long and back to original.
user    0m0.040s
sys     0m0.120s
iishikawa@duron$ time ./xlog /tmp/t.out xxx

real    0m0.012s          <=== very fast without fdatasync as it should be.
user    0m0.010s
sys     0m0.010s
ishikawa@duron$


