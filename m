Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276919AbRJCIpY>; Wed, 3 Oct 2001 04:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276678AbRJCIpO>; Wed, 3 Oct 2001 04:45:14 -0400
Received: from mail.ahiv.hu ([195.228.168.219]:5139 "EHLO mail.ahiv.hu")
	by vger.kernel.org with ESMTP id <S276667AbRJCIpD>;
	Wed, 3 Oct 2001 04:45:03 -0400
Message-ID: <3BBADF54.C36DAFAB@mail.ahiv.hu>
Date: Wed, 03 Oct 2001 11:50:12 +0200
From: Lorinczy Zsigmond <lzsiga@mail.ahiv.hu>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Size of file /proc/mtrr
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *15ojba-00005g-00*.s9uubSqS.U* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy Folks!

I found a little problem about file /proc/mtrr: it shorter than it is...

zsiga-pc:/usr/src/linux# ls -l /proc/mtrr
-rw-r--r--    1 root     root          132 Oct  3 10:03 /proc/mtrr
                                       ^^^ 

zsiga-pc:/usr/src/linux# cat /proc/mtrr | wc -c
    203
    ^^^
 
zsiga-pc:/usr/src/linux# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
reg01: base=0x08000000 ( 128MB), size=  32MB: write-back, count=1
reg02: base=0xf5000000 (3920MB), size=   4MB: write-combining, count=1
 
zsiga-pc:/usr/src/linux# mc -v /proc/mtrr
File: /proc/mtrr  132 bytes  100%
reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
reg01: base=0x08000000 ( 128MB), size=  32MB: write-back, count=1

I looked into arch/i386/kernel/mtrr.c, I found variable ascii_buf_bytes,
wich contains the real length (203 in this case), and is copied into
'proc_root_mtrr->size' (line 1863) when changes.

The problem is that the procfs do not follow the changing of this value
(caching problem ?), so stat(2) reports the old length (132).

Here is a quick workaround: set proc_root_mtrr->size to zero

--- mtrr.bak    Fri Sep 21 19:55:22 2001
+++ mtrr.c      Wed Oct  3 10:07:45 2001
@@ -1860,7 +1860,7 @@
     devfs_set_file_size (devfs_handle, ascii_buf_bytes);
 #  ifdef CONFIG_PROC_FS
     if (proc_root_mtrr)
-       proc_root_mtrr->size = ascii_buf_bytes;
+       proc_root_mtrr->size = 0;
 #  endif  /*  CONFIG_PROC_FS  */
 }   /*  End Function compute_ascii  */
