Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbRCBRnI>; Fri, 2 Mar 2001 12:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129354AbRCBRm6>; Fri, 2 Mar 2001 12:42:58 -0500
Received: from [38.204.212.32] ([38.204.212.32]:22216 "HELO srv2.ecropolis.com")
	by vger.kernel.org with SMTP id <S129351AbRCBRmt>;
	Fri, 2 Mar 2001 12:42:49 -0500
Date: Fri, 2 Mar 2001 12:42:48 -0500 (EST)
From: Jeremy Hansen <jeremy@xxedgexx.com>
X-X-Sender: <jeremy@srv2.ecropolis.com>
To: <linux-kernel@vger.kernel.org>
Subject: scsi vs ide performance on fsync's
Message-ID: <Pine.LNX.4.33L2.0103021241550.14586-200000@srv2.ecropolis.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-869916460-366262872-983550462=:8157"
Content-ID: <Pine.LNX.4.33L2.0103021241551.14586@srv2.ecropolis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---869916460-366262872-983550462=:8157
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33L2.0103021241552.14586@srv2.ecropolis.com>


We're doing some mysql benchmarking.  For some reason it seems that ide
drives are currently beating a scsi raid array and it seems to be related
to fsync's.  Bonnie stats show the scsi array to blow away ide as
expected, but mysql tests still have the idea beating on plain insert
speeds.  Can anyone explain how this is possible, or perhaps explain how
our testing may be flawed?

Here's the bonnie stats:

IDE Drive:

Version 1.00g       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
jeremy         300M  9026  94 17524  12  8173   9  7269  83 23678   7 102.9   0
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   469  98  1476  98 16855  89   459  98  7132  99   688  25


SCSI Array:

Version 1.00g       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
orville        300M  8433 100 134143  99 127982  99  8016 100 374457  99 1583.4   6
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16   503  13 +++++ +++   538  13   490  13 +++++ +++   428  11

So...obviously from bonnie stats, the scsi array blows away the ide...but
using the attached c program, here's what we get for fsync stats using the
little c program I've attached:

IDE Drive:

jeremy:~# time ./xlog file.out fsync

real    0m1.850s
user    0m0.000s
sys     0m0.220s

SCSI Array:

[root@orville mysql_data]# time /root/xlog file.out fsync

real    0m23.586s
user    0m0.010s
sys     0m0.110s


I would appreciate any help understand what I'm seeing here and any
suggestions on how to improve the performance.

The SCSI adapter on the raid array is an Adaptec 39160, the raid
controller is a CMD-7040.  Kernel 2.4.0 using XFS for the filesystem on
the raid array, kernel 2.2.18 on ext2 on the IDE drive.  The filesystem is
not the problem, as I get almost the exact same results running this on
ext2 on the raid array.

Thanks
-jeremy

-- 
this is my sig.







---869916460-366262872-983550462=:8157
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="xlog.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33L2.0103021127420.8157@srv2.ecropolis.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="xlog.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+DQojaW5j
bHVkZSA8c3RkbGliLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVk
ZSA8ZmNudGwuaD4NCg0Kc3RydWN0IEVudHJ5DQp7DQoJaW50IGNvdW50Ow0K
CWNoYXIgc3RyaW5nWzUwXTsNCn07DQoNCg0KaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KQ0Kew0KCWludCBmZDsNCglzdHJ1Y3QgRW50cnkgKnRy
YW5zOw0KCWludCB4Ow0KDQoJaWYoKGZkID0gY3JlYXQoYXJndlsxXSwgMDY2
NikpID09IC0xKQ0KCXsNCgkJcHJpbnRmKCJDb3VsZCBub3Qgb3BlbiBmaWxl
ICVzXG4iLCBhcmd2WzFdKTsNCgkJcmV0dXJuIDE7DQoJfQ0KCQ0KDQoJZm9y
KHg9MDsgeCA8IDIwMDA7ICsreCkNCgl7DQoJCXRyYW5zID0gbWFsbG9jKHNp
emVvZihzdHJ1Y3QgRW50cnkpKTsNCgkJdHJhbnMtPmNvdW50ID0geDsNCgkJ
c3RyY3B5KHRyYW5zLT5zdHJpbmcsICJCbGFoIEJsYWggQmxhaCBCbGFoIEJs
YWggQmxhaCBCbGFoIik7DQoNCgkJaWYoc3RyY21wKGFyZ3ZbMl0sImZzeW5j
Iik9PSAwKQ0KCQl7DQoJCQl3cml0ZShmZCwgKGNoYXIgKil0cmFucywgc2l6
ZW9mKHN0cnVjdCBFbnRyeSkpOw0KCQkJDQoJCQlpZihmZGF0YXN5bmMoZmQp
ICE9IDApDQoJCQl7DQoJCQkJcGVycm9yKCJFcnJvciIpOw0KCQkJfQ0KDQoJ
CX0NCgkJZWxzZQ0KCQl7DQoJCQl3cml0ZShmZCwgKGNoYXIgKil0cmFucywg
c2l6ZW9mKHN0cnVjdCBFbnRyeSkpOw0KCQl9DQoJDQoJCWZyZWUodHJhbnMp
Ow0KDQoJfQ0KCWNsb3NlKGZkKTsNCg0KfQ0K
---869916460-366262872-983550462=:8157--
