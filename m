Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVAOXft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVAOXft (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVAOXft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:35:49 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:59377 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S262362AbVAOXfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:35:34 -0500
Date: Sun, 16 Jan 2005 00:35:30 +0100
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Subject: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050115233530.GA2803@darkside.22.kls.lan>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

mounting an ext2 (ext3 as well) filesystem seems to modify the
block device's EOF behaviour: before the mount the device returned
EOF, after the mount it doesn't anymore:

[on a fresh booted system]
root@darkside:~# uname -a
Linux darkside 2.4.27 #1 Sat Jan 15 17:07:20 CET 2005 i686 GNU/Linux
root@darkside:~# dd if=/dev/hdg7 of=/dev/null
9992366+0 records in
9992366+0 records out
5116091392 bytes transferred in 87,157394 seconds (58699453 bytes/sec)
root@darkside:~# mke2fs /dev/hdg7
...
Block size=4096 (log=2)
Fragment size=4096 (log=2)
625248 inodes, 1249045 blocks
...
root@darkside:~# dd if=/dev/hdg7 of=/dev/null
9992366+0 records in
9992366+0 records out
5116091392 bytes transferred in 87,439332 seconds (58510184 bytes/sec)
root@darkside:~# mount -t ext2 -o ro /dev/hdg7 /mnt
root@darkside:~# umount /dev/hdg7
root@darkside:~# dd if=/dev/hdg7 of=/dev/null
attempt to access beyond end of device
22:07: rw=0, want=4996184, limit=4996183
dd: reading `/dev/hdg7': Input/output error
9992360+0 records in
9992360+0 records out
5116088320 bytes transferred in 87,145443 seconds (58707468 bytes/sec)
root@darkside:~# bc
1249045 * 4
4996180
1249045 * 4 * 2
9992360

Could somebody please explain this to me? Is this intentional?
I could partly imagine the ext2 mount shrinking the block device's
boundaries to the filesystem boundaries - for security reasons perhaps,
even if I personally think this isn't the best idea at all, since it
would violate layers encapsulation.
However, I have no idea why a) if so, this is not reverted at least
on umount and why b) the EOF behaviour of the block device changes -
before there were an EOF sent to the application (dd) while after there
isn't, but an I/O error instead.

Kernel is Debian's kernel-source-2.4.27 + kernel-patch-2.4-i2c +
kernel-patch-2.4-lm-sensors.

It seems there were already some mails regarding this issue suggesting
this could have shown up between 2.4.24 and 2.4.25, but it seems they
were misunderstood, for example:

From: "ProNIC Solutions" <mot@pronicsolutions.com>
Subject: 2.4.25: attempt to access beyond end of device
Date: Tue, 16 Mar 2004 09:06:31 -0500
Message-ID: <005201c40b5f$e21d34a0$0600a8c0@p17>

From: "Peter S. Mazinger" <ps.m@gmx.net>
Subject: BUG in 2.4.25-rc1: attempt to access beyond end of device
Date: Fri, 6 Feb 2004 13:53:40 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0402061347160.27376-100000@lnx.bridge.intra>


regards
   Mario
-- 
Independence Day: Fortunately, the alien computer operating system works just
fine with the laptop. This proves an important point which Apple enthusiasts
have known for years. While the evil empire of Microsoft may dominate the
computers of Earth people, more advanced life forms clearly prefer Mac's.
