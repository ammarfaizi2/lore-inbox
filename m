Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbUAABcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 20:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbUAABcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 20:32:25 -0500
Received: from shawmail.shawcable.com ([64.59.128.220]:11705 "EHLO
	bpd2mo2no.prod.shawcable.com") by vger.kernel.org with ESMTP
	id S265321AbUAABcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 20:32:21 -0500
Date: Wed, 31 Dec 2003 18:36:50 -0700
From: Matthew Mastracci <mmastrac@canada.com>
Subject: Removable USB device contents cached after removal? [Part 2]
To: linux-kernel@vger.kernel.org
Message-id: <3FF379B2.3010301@canada.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6a)
 Gecko/20031030
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a note in regards to my previous post: I'm mostly looking for a 
way to determine that the device was improperly mounted and use this 
information to display an error.  I know it's not a good idea to be 
removing mounted devices without a umount first.  :)

To investigate further, as an experiment, I tried the same thing with 
fd0.  It turns out that the floppy driver is able to detect the media 
change and doesn't return any cached data when accessing the raw device. 
  Accessing the memory device's raw device rather than the partition 
device (ie: sdd vs. sdd1) also detected the change.

Here's an example:

[root@matt mnt]# mount floppy
[root@matt mnt]# dd if=/dev/fd0 of=/dev/null count=10 bs=1024
10+0 records in
10+0 records out
     (manually ejecting floppy while still mounted)
[root@matt mnt]# dd if=/dev/fd0 of=/dev/null count=10 bs=1024
dd: opening `/dev/fd0': No such device or address
[root@matt mnt]# umount floppy/
[root@matt mnt]# cat /dev/fd0
cat: /dev/fd0: No such device or address

And the memory device as a comparison:

[root@matt mnt]# mount /dev/sdd1
[root@matt mnt]# dd if=/dev/sdd1 of=/dev/null count=10 bs=1024
10+0 records in
10+0 records out
     (manually removing memory card)
[root@matt mnt]# dd if=/dev/sdd1 of=/dev/null count=10 bs=1024
10+0 records in
10+0 records out
[root@matt mnt]# umount /dev/sdd1
[root@matt mnt]# dd if=/dev/sdd1 of=/dev/null count=10 bs=1024
dd: opening `/dev/sdd1': No medium found

And interestingly, accessing the root of the memory device works like 
the floppy does (note that atech2 = /dev/sdd1):

[root@matt mnt]# mount atech2
mount: No medium found
[root@matt mnt]# mount atech2
[root@matt mnt]# dd if=/dev/sdd of=/dev/null count=10 bs=1024
10+0 records in
10+0 records out
     (manually removing memory card)
[root@matt mnt]# dd if=/dev/sdd of=/dev/null count=10 bs=1024
dd: opening `/dev/sdd': No medium found
[root@matt mnt]# umount atech2
[root@matt mnt]# dd if=/dev/sdd of=/dev/null count=10 bs=1024
dd: opening `/dev/sdd': No medium found

An interesting observation is that the floppy will also cache the 
directory contents, even when the floppy is removed.  As soon as an 
error occurs, the cached contents are tossed.  I'm not certain of the 
correct behaviour in this situation, however, but it's here for comparison:

[root@matt mnt]# mount floppy
[root@matt mnt]# ls -l floppy
total 388
-rwxr-xr-x    1 root     root           14 Mar 20  2002 autoexec.bat
-rwxr-xr-x    1 root     root        66785 Sep 21  1999 command.com
-rwxr-xr-x    1 root     root           18 Feb 13  2002 config.sys
-rwxr-xr-x    1 root     root         2563 Nov 13 20:30 drvinf.txt
-rwxr-xr-x    1 root     root        14766 Jan  7  1999 himem.sys
-rwxr-xr-x    1 root     root        24810 Sep 21  1999 ibmbio.com
-rwxr-xr-x    1 root     root        30880 Sep 21  1999 ibmdos.com
-rwxr-xr-x    1 root     root       244264 May 20  2003 powermax.exe
-rwxr-xr-x    1 root     root        10041 May  8  2003 PWMXReadme.txt
     (manually ejecting floppy)
[root@matt mnt]# ls -l floppy
total 388
-rwxr-xr-x    1 root     root           14 Mar 20  2002 autoexec.bat
-rwxr-xr-x    1 root     root        66785 Sep 21  1999 command.com
-rwxr-xr-x    1 root     root           18 Feb 13  2002 config.sys
-rwxr-xr-x    1 root     root         2563 Nov 13 20:30 drvinf.txt
-rwxr-xr-x    1 root     root        14766 Jan  7  1999 himem.sys
-rwxr-xr-x    1 root     root        24810 Sep 21  1999 ibmbio.com
-rwxr-xr-x    1 root     root        30880 Sep 21  1999 ibmdos.com
-rwxr-xr-x    1 root     root       244264 May 20  2003 powermax.exe
-rwxr-xr-x    1 root     root        10041 May  8  2003 PWMXReadme.txt
[root@matt mnt]# cat /dev/fd0
cat: /dev/fd0: No such device or address
[root@matt mnt]# ls -l floppy
total 0

Matt.
