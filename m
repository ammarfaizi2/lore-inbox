Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVF0QBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVF0QBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVF0PUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:20:13 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:38484 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261559AbVF0Oqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:46:36 -0400
Message-ID: <42C0114A.2000401@tls.msk.ru>
Date: Mon, 27 Jun 2005 18:46:34 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: getdents, unlink and tmpfs vs otherFS
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a weird problem a while back - my initrd script
does not work when the root is on cciss device.  It turned
out to be a problem with $SUBJ.  /dev/cciss/ is quite large
(alot of disks and partitions), and when initrd is on tmpfs
(initramfs it really is), and run-init is executed, it tries
to remove /dev/cciss, it fails.  And here's why.

uclibc does the following on readdir():

open(.., O_DIRECTORY)                   = 3
getdents(3, /* 197 entries */, 3933)    = 3932
lseek(3, 2728, SEEK_SET)                = 2728
unlink(..)
....
getdents(3, /* 85 entries */, 3933)     = 1700
unlink()
....
getdents(3, /* 196 entries */, 3933)    = 3920
lseek(3, 6816, SEEK_SET)                = 6816
....

and finally rmdir() which fails with "Directory
not empty" error.

And eg glibc, or dietlibc, or klibc - it's all
the same but without all the lseek()s, and with
final rmdir() successeful.

It's on tmpfs.

On ext[23], final rmdir succed on both cases,
ie, with and without lseek.

Is it a bug in tmpfs, or in uclibc?

Thanks.

/mjt
