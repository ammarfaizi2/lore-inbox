Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271331AbTGQCLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271332AbTGQCLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:11:55 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:32907 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S271331AbTGQCLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:11:53 -0400
Message-ID: <3F160965.7060403@comcast.net>
Date: Wed, 16 Jul 2003 19:26:45 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] pdcraid and weird IDE geometry
X-Enigmail-Version: 0.76.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050608000009070307090203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050608000009070307090203
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all,

I ran into a weird problem when I received my latest replacement
DeskStar drive from Hitachi. It was the same size as the GXP60 it
replaced, but had much different geometry. I use these two 40GB drives
with a Promise FastTrak 20276 controller as a raid0 array. The
controller finds the drives and sets up the raid no problem. The pdcraid
module from vanilla 2.4.21 only found 1 drive however, and it was the
original existing drive. Testing with Promise's partial opensource
driver shows that the array does indeed work correctly with their driver.

A few printk's later, I determined the problem. The geometry of the two
drives are as follows:

cat /proc/ide/hde/geometry   (Old Drive)
physical     79780/16/63
logical      79780/16/63

cat /proc/ide/hdg/geometry (New Drive)
physical     5005/255/63
logical      5005/255/63


The calc_pdcblock_offset function calculates lba by taking the capacity
of the drive and dividing it by (head * sector), multiplying the result
times (head * sector) and subtracting the sector (SPT) count.
Unfortunately, with the strange geometry reported by the new drive,
using INTs to store these values will fail. The capacity of each drive
is exactly the same of 80418240 as reported by procfs and
ideinfo->capacity. In order to return the superblock offset correctly I
had to use non-integer vars. I've tested the resulting module and it now
correctly locates both drives, read and writes as expected and is
compatible with the binary FastTrak.o module. I'm not much of a coder,
so if this could be done more efficiently than my attached patch, please
let me know. Please CC any replies. Thanks,

-Walt Holman



--------------050608000009070307090203
Content-Type: text/plain;
 name="pdcraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdcraid.patch"

--- /usr/src/temp/linux-2.4.21/drivers/ide/raid/pdcraid.c       2003-06-13 07:51:34.000000000 -0700
+++ pdcraid.c   2003-07-16 19:03:15.000000000 -0700
@@ -361,8 +361,14 @@
        if (ideinfo->sect==0)
                return 0;
-       lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
-       lba = lba * (ideinfo->head*ideinfo->sect);
-       lba = lba - ideinfo->sect;
+
+       float lbatemp = 0;
+       float head = ideinfo->head;
+       float sect = ideinfo->sect;
+       float capacity = ideinfo->capacity;
+       lbatemp = (capacity / (head*sect));
+       lbatemp = lbatemp * (head*sect);
+       lbatemp = lbatemp - sect;

+       lba = lbatemp;
        return lba;
 }

--------------050608000009070307090203--

