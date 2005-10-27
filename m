Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVJ0L5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVJ0L5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 07:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVJ0L5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 07:57:37 -0400
Received: from plasma-gate.weizmann.ac.il ([132.77.150.54]:5788 "EHLO
	plasma-gate.weizmann.ac.il") by vger.kernel.org with ESMTP
	id S1750724AbVJ0L5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 07:57:37 -0400
Message-ID: <4360C0A7.4050708@weizmann.ac.il>
Date: Thu, 27 Oct 2005 13:57:27 +0200
From: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Organization: Weizmann Institute of Science
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Weirdness of "mount -o remount,rw" with write-protected floppy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here is what I found the hard way (having lost the configuration of a 
firewall...):

# mount /dev/fd0 /mnt/floppy/
mount: block device /dev/fd0 is write-protected, mounting read-only
# mount -o remount,rw /mnt/floppy
# echo $?
0
# touch /mnt/floppy/blabla
# ls -l  /mnt/floppy/blabla
-rwxr-xr-x  1 root root 0 Oct 27 13:18 /mnt/floppy/blabla*
# umount /mnt/floppy
# echo $?
0
# mount /dev/fd0 /mnt/floppy/
mount: block device /dev/fd0 is write-protected, mounting read-only
# ls -l  /mnt/floppy/blabla
ls: /mnt/floppy/blabla: No such file or directory

The kernel actually tries to write to the floppy - the light is blinking 
(so everything looks nice from outside). Of course, there are kernel 
errors, seen in dmesg like:

 > end_request: I/O error, dev fd0, sector 21
 > Buffer I/O error on device fd0, logical block 21
 > lost page write due to I/O error on fd0

but these don't propagate to the user space in any way.

The bug is present in both 2.4 and 2.6, and is specific to floppy 
devices. Other RO media I tried (CDROM, RO-exported NFS) are partially 
OK, in the sense that a write attempt returns an error; however, "mount 
-o remount,rw" always returns success (this might be a bug in mount).

Regards,

Evgeny
