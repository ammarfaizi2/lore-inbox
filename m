Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVJYN2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVJYN2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 09:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVJYN2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 09:28:15 -0400
Received: from cyborg.cybernetics.com ([206.246.200.18]:33553 "EHLO
	cyborg.cybernetics.com") by vger.kernel.org with ESMTP
	id S1751218AbVJYN2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 09:28:15 -0400
Reply-To: <tonyb@cybernetics.com>
From: "Tony Battersby" <tonyb@cybernetics.com>
To: <linux-kernel@vger.kernel.org>
Cc: <axboe@suse.de>
Subject: Problem: running lilo corrupts filesystem on first partition
Date: Tue, 25 Oct 2005 09:28:11 -0400
Message-ID: <007e01c5d967$f297a310$e0019d89@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem kernels: vanilla 2.6.14-rc5 and Ubuntu kernel 2.6.12-9-686
(2.6.12.16)
Known good kernels: 2.4.X

I am using a script that executes a sequence of commands similar to the
following to install Linux on a disk:

sfdisk /dev/hda
dd if=filesystem.img of=/dev/hda1
lilo

The problem is that running lilo causes the first few sectors of the
filesystem image on /dev/hda1 to be overwritten.  If I change the
sequence of commands to be similar to the following:

sfdisk /dev/hda
dd if=filesystem.img of=/dev/hda1
blockdev --flushbufs /dev/hda
lilo

Then there is no corruption and everything works.  This used to work on
2.4 kernels without blockdev --flushbufs.  I am no block layer expert,
but this behavior seems wrong to me.

Note that sfdisk will create the first partition starting at sector 1,
which is adjacent to the MBR on sector 0.  It is common practice to skip
a few more sectors for use by some bootloaders, but LILO doesn't need
that.  I have condensed the test to the following script, which removes
LILO from the test entirely:

---------------------------------------------

*********************************************
WARNING: this script will wipe out the disk!
*********************************************

#!/bin/sh

DISK=/dev/hda
PARTITION=${DISK}1

set -e
rm -f data.in data.out

# format the disk with one big partition
sfdisk $DISK << EOF
,
EOF

# simulate writing a filesystem image to the disk partition
dd if=/dev/urandom of=data.in bs=512 count=128
dd if=data.in of=$PARTITION bs=512 count=128

# if this is commented out, the test will fail
# if this is uncommented, the test will pass
#blockdev --flushbufs $DISK

# simulate running lilo
sync
dd if=$DISK of=mbr bs=512 count=1
dd if=mbr of=$DISK bs=512 count=1
sync

# check for filesystem corruption
dd if=$PARTITION of=data.out  bs=512 count=128
cmp data.in data.out

echo The test passed.

---------------------------------------------

Let me know if I can help out with any further testing/debugging.

Anthony J. Battersby
Cybernetics

