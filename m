Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282453AbRLLWGZ>; Wed, 12 Dec 2001 17:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282491AbRLLWGJ>; Wed, 12 Dec 2001 17:06:09 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:19950 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S282392AbRLLWEw>; Wed, 12 Dec 2001 17:04:52 -0500
Subject: [BUG/PATCH] 2.4.17-pre8 crash/FS corruption
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Dec 2001 14:04:52 -0800 (PST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011212220452.2EB458A598@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This might be short on details, but it does have a patch that perhaps
should be reverted, or its ill effects fixed, before 2.4.17 final, and I
want to get this mail through before Marcelo releases 2.4.17-rc1 :)

One of my computers runs a Red Hat 7.1 "partitionless" install, with the
root filesystem mounted using the loop device. I have another file
also mounted using the loop device. Both are approx. 2GB, formatted with
ext2, stored on two separate FAT32 partitions. The computer in question
is a Dell Inspiron 5000e, 30-32GB IBM hard drive, BX chipset (I believe),
256MB RAM.

With 2.4.17-pre2 through -pre8, on one of my loop files (my non-root
one, I didn't try this on my root one yet) the following command locks up
the computer after maybe 3 or 4 seconds of I/O:

dd if=/dev/zero bs=1024k of=tzero.zro
bs=2048k causes the crash/corruption too, I didn't try other sizes yet

(This isn't just a test command -- the idea here was to zero out the
empty blocks on one of the loop files before I back up the entire FAT32
partition it's on using Ghost.)

Keystrokes still appear on the screen, but control-C won't stop the dd
command, and pressing ontrol-alt-delete will have two effects:

-printing a single blank line to the console

-corrupting the filesystem that tzero.zro is being written to, to the
point that fsck has to be run manually (I have to use the power switch
to reboot either with or without the CAD keypress, and there's FS
corruption either way, but without the CAD keypress fsck is able to fix the
corruption automatically on the next boot)

With 2.4.17-pre1 or earlier, the command works as intended.

*Reverting* the following patch (from 2.4.17-pre2) fixes the problem. I
don't know enough about this part of the kernel to have any idea why
it's crashing my machine.

diff -urN linux-2.4.17-pre1/fs/buffer.c linux/fs/buffer.c
--- linux-2.4.17-pre1/fs/buffer.c	Wed Nov 21 14:40:17 2001
+++ linux/fs/buffer.c	Sat Dec  1 00:35:16 2001
@@ -1036,6 +1036,7 @@
 	unsigned long dirty, tot, hard_dirty_limit, soft_dirty_limit;
 
 	dirty = size_buffers_type[BUF_DIRTY] >> PAGE_SHIFT;
+	dirty += size_buffers_type[BUF_LOCKED] >> PAGE_SHIFT;
 	tot = nr_free_buffer_pages();
 
 	dirty *= 100;

-Barry K. Nathan <barryn@pobox.com>
