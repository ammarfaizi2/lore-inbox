Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269019AbRHLIRv>; Sun, 12 Aug 2001 04:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269030AbRHLIRm>; Sun, 12 Aug 2001 04:17:42 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:36370 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S269019AbRHLIR0>;
	Sun, 12 Aug 2001 04:17:26 -0400
Date: 12 Aug 2001 08:17:36 -0000
Message-ID: <20010812081736.21563.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico-linux-kernel@patrec.com>
To: linux-kernel@vger.kernel.org
Subject: initrd panic with 2.4.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the included procedure, I can generate this fatal message:

	kernel BUG at inode.c:681!
	...

Bug is present in other 2.4 kernels, and is easily reproduced.

First, configure stock 2.4.8 with ramdisk & initrd.

Then, prepare contents of initrd:

	date >/tmp/initrd

lilo.conf contains an entry like this:

	image = /tmp/bzImage
		read-only
		append = "noinitrd mem=32m init=/bin/bash"
		initrd = /tmp/initrd

The small memory arena (32MB) isn't required, but speeds the failure.
After running `lilo', boot machine, and type

	exec 3</dev/initrd
	cat <&3
	exec 3<&-	# optionally close initrd
	tar cf - . | wc

Crash will occur within seconds.  Root file system should be safe, being
read-only.  Closing /dev/initrd frees memory, and probably corrupts the
kernel -- keeping it open avoids the crash.
