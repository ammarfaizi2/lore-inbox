Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130800AbRCFASd>; Mon, 5 Mar 2001 19:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130797AbRCFASY>; Mon, 5 Mar 2001 19:18:24 -0500
Received: from gear.torque.net ([204.138.244.1]:12552 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S130793AbRCFASM>;
	Mon, 5 Mar 2001 19:18:12 -0500
Message-ID: <3AA42B45.C315FACB@torque.net>
Date: Mon, 05 Mar 2001 19:11:49 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mysql@lists.mysql.com
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <Pine.LNX.4.33L2.0103021033190.6176-200000@srv2.ecropolis.com> <054201c0a33d$55ee5870$e1de11cc@csihq.com> <3AA2A120.49509A11@torque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the intention of fsync and fdatasync seems to be
to write dirty fs buffers to persistent storage (i.e.
the "oxide") then the best time is not necessarily
the objective. Given the IDE times that people have 
been reporting, it is very unlikely that any of those
IDE disks were really doing 2000 discrete IO operations
involving waiting for the those buffers to be written
to the "oxide". [Reason: it should take at least 2000 
revolutions of the disk to do it, since most of the
4KB writes are going to the same disk address as the
prior write.]

As it stands, the Linux SCSI subsystem has no mechanism 
to force a disk cache write through. The SCSI WRITE(10)
command has a Force Unit Access bit (FUA) to do exactly
that, but we don't use it. Do the fs/block layers flag
they wish buffers written to the oxide?? 
The measurements that showed SCSI disks were taking a lot 
longer with the "xlog" test were more luck than good 
management.

Here are some tests that show an IDE versus SCSI "xlog"
comparison are very similar between FreeBSD 4.2 and
lk 2.4.2 on the same hardware: 

# IBM DCHS04U SCSI disk 7200 rpm  <<FreeBSD 4.2>>
[root@free /var]# time /root/xlog tst.txt
real    0m0.043s
[root@free /var]# time /root/xlog tst.txt fsync
real    0m33.131s

# Quantum Fireball ST3.2A IDE disk 3600 rpm  <<FreeBSD 4.2>>
[root@free dos]# time /root/xlog tst.txt
real    0m0.034s
[root@free dos]# time /root/xlog tst.txt fsync
real    0m5.737s


# IBM DCHS04U SCSI disk 7200 rpm  <<lk 2.4.2>>
[root@tvilling extra]# time /root/xlog tst.txt
0:00.00elapsed 125%CPU
[root@tvilling spare]# time /root/xlog tst.txt fsync
0:33.15elapsed 0%CPU

# Quantum Fireball ST3.2A IDE disk 3600 rpm  <<lk 2.4.2>>
[root@tvilling /root]# time /root/xlog tst.txt
0:00.02elapsed 43%CPU
[root@tvilling /root]# time /root/xlog tst.txt fsync
0:05.99elapsed 69%CPU


Notes: FreeBSD doesn't have fdatasync() so I changed xlog 
to use fsync(). Linux timings were the same with fsync() 
and fdatasync(). The xlog program crashed immediately in
FreeBSD; it needed some sanity checks on its arguments.

One further note: I wrote:
> [snip] 
> So writing more data to the SCSI disk speeds it up!
> I suspect the critical point in the "20*200" test is
> that the same sequence of 8 512 byte sectors are being
> written to disk 200 times. BTW That disk spins at
> 15K rpm so one rotation takes 4 ms and it has a
> 4 MB cache.

A clarification: by "same sequence" I meant written
to the same disk address. If the 4 KB lies on the same
track, then a delay of one disk revolution would be
expected before you could write the next 4 KB to the 
"oxide" at the same address.

Doug Gilbert
