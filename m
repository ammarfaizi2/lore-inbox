Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWGMH4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWGMH4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWGMH4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:56:22 -0400
Received: from mailgate1.uni-kl.de ([131.246.120.5]:30854 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP id S964840AbWGMH4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:56:20 -0400
Date: Thu, 13 Jul 2006 09:56:17 +0200
From: Eduard Bloch <edi@gmx.de>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: confusion and case problems: utf8 <-> iocharset
Message-ID: <20060713075617.GA9429@rotes76.wohnheim.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello (to whom it may concern),

I try to understand how the charset mapping with VFAT/Joliet and I found
some inconsistencies between the user expectations, the docs, and the
actuall behaviour.

Users view:

VFAT, NTFS and Joliet use a Unicode charset for storing the names
internaly. That names are mapped to smaller charsets and traditional
encodings like latin1 by the filesystem driver (the iocharset option).
UTF-8 is a Unicode encoding to get the whole charset trough multibyte.

Users expectation:

The way of mapping can be configured with mount options.

The trouble:

First, the terminology in vfat.txt is not consistent with what actually
happens. It says "iocharset" but in fact it is not a charset used for IO
operations, it does not stand for charset at all but for the mapping of
encodings. The better name should be "visible_encoding", IMO.
And in the kernel setup, why do I need a separate "VFAT_IOCHARSET"
option? Why should I not use the systemwide settings, AFAICS that change
is relevant for what the users see and this thing should be consistent
across all mounted filesystems. So why do I need a separate kernel
setting here? Questions over questions.

Second: 
there is the "utf8" option. How does that exactly differ from
iocharset=utf8? There is not clear explanation in vfat.txt. What happens
if you use both options, especially if iocharset!=utf8? Which one is
prefered?

Third:
how can I disable all that funny letter case conversions? They are not
described anywhere properly, nor the way to disable them. IMO there are
two problems:

 - what you write to the FS is not the same what "ls" shows you later.
   Eg. ABW becomes "abw" but "ABWÖ" becomes "ABWÖ". Abcd becomes "Abcd"
   but "ABC" becomes "abc".  Does it make sense? NO.
   I would like to stop the kernel playing such games, I had enough of
   such trouble back in my Windows 98 times.

 - this case conversion can actually break things. When iocharset=utf-8
   and utf8 are used, then you cannot access the data with the same
   name after storing it.

zombie:/tmp# uname -a
Linux zombie 2.6.17.4 #4 Fri Jul 7 12:16:37 CEST 2006 x86_64 GNU/Linux
zombie:/tmp# mount test.img test -o loop,iocharset=utf8,utf8
zombie:/tmp# ls test/test
zombie:/tmp# rm test/test -r
zombie:/tmp# mkdir test/TEST
zombie:/tmp# ls test
test
zombie:/tmp# ls test/test
zombie:/tmp# ls test/TEST
ls: test/TEST: No such file or directory

Full history below.

Thanks,
Eduard.


zombie:/tmp# mkfs.vfat test.img
mkfs.vfat 2.11 (12 Mar 2005)
zombie:/tmp# mount test.img test
mount: test.img is not a block device (maybe try `-o loop'?)
zombie:/tmp# mount test.img test -o loop
zombie:/tmp# grep test /proc/mounts 
/dev/loop/0 /tmp/test vfat rw,fmask=0022,dmask=0022,codepage=cp437,iocharset=iso8859-1 0 0
zombie:/tmp# mkdir test/TEST
zombie:/tmp# ls test/test
zombie:/tmp# ls test/
test
zombie:/tmp# ls test/TEST
zombie:/tmp# umount test.img
zombie:/tmp# mount test.img test -o loop,iocharset=utf-8
mount: wrong fs type, bad option, bad superblock on /dev/loop0,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

zombie:/tmp# mount test.img test -o loop,iocharset=utf8
zombie:/tmp# ls test
test
zombie:/tmp# rm test/test -r
zombie:/tmp# mkdir test/TEST
zombie:/tmp# ls test
test
zombie:/tmp# ls test/test
zombie:/tmp# umount test
(reverse-i-search)`u': umount test
zombie:/tmp# mount test.img test -o loop,iocharset=utf8,utf8
zombie:/tmp# ls test/test
zombie:/tmp# rm test/test -r
zombie:/tmp# mkdir test/TEST
zombie:/tmp# ls test
test
zombie:/tmp# ls test/test
zombie:/tmp# ls test/TEST
ls: test/TEST: No such file or directory
zombie:/tmp# umount test
zombie:/tmp# mount test.img test -o loop,iocharset=utf8
zombie:/tmp# ls test/TEST
ls: test/TEST: No such file or directory
zombie:/tmp# ls test/

