Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbTFMNZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 09:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbTFMNZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 09:25:12 -0400
Received: from cc-linux4.ethz.ch ([129.132.19.124]:34792 "HELO lombi.mine.nu")
	by vger.kernel.org with SMTP id S265392AbTFMNZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 09:25:00 -0400
Mime-Version: 1.0
Message-Id: <p04320407bb0f79fd523e@[192.168.3.11]>
Date: Fri, 13 Jun 2003 15:38:44 +0200
To: linux-kernel@vger.kernel.org
From: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Subject: Lockups with loop'ed sparse files on reiserfs?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I've experienced 3 lockups in the last few days, all while using 
sparse files. Could also be problems with UML, SKAS, raid5 over loop 
device, or loop devices with vfat files, but it looks like the only 
common thing is sparse files on reiserfs.

1.) kernel 2.4.20 from debian unstable (= kernel.org kernel with 
quite a few security and other patches), additionally patched with 
kernel-patch-skas 3-1 from debian. Started user-mode-linux using a 
sparse file with an ext2 filesystem on it, using tap0 networking, did 
apt-get upgrade inside this uml (which started to download (and 
already unpack?) quite a bit of stuff), halfway through the whole 
(host) system froze. Still responded to pings, but telnet $host 80 
would not show any activity from running apache. Went to the server 
room, I could change virtual terminals with Alt-<number>, but could 
not log in. Reset.

2.) same kernel:
- created 6 sparse files of 650MB each, on reiserfs filesystems (some 
of them on the same filesystem), and 2 files of 650MB on a vfat 
filesystem.
- Tied them to /dev/loop*,
- mdadm /dev/md0 -C -l 5 -n 7 -x 1 /dev/loop*
- then (while the array was building) mkreiser /dev/md0,
- mount /dev/md0 /mnt/md0
- cd /mnt/md0; netcat -l -p "$port" | multifeed '|' sh -c 'exec 
md5sum >&2' '&' cat | gpg | lzop -d | tar xf -
   (where multifeed is a C program by myself feeding the data to 
multiple processes)
   basically fetch data from tcp and untar it onto the filesystem.
After about 500MB of data has been written onto /mnt/md0, the box 
froze. Still responded to ping, but not to telnet $host 80. Could 
switch vt's, type root and enter password, but didn't get a login.

3.) kernel 2.4.18 from kernel.org (the machine ran without any 
problem (except for sporadically switching off dma on /dev/hda) with 
this kernel for about a year):
Did same thing as mentioned under 2.) (rm -rf /mnt/md0/* before 
starting the write again). This time it happened already after 
filling the md partition with about 200MB. And this time, while still 
responding to pings and being able to switch vt's, it wouldn't react 
to hitting the keys 'root'.

I'd mainly like to know if all of what I did is supported or not.

The machine is a AMD Duron 1Ghz with 256MB RAM, 3 IDE harddisks (but 
only hda and hdd involved in the above), 2 ethernet cards using 
8139too.

Christian.
