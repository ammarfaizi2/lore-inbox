Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSEYWgj>; Sat, 25 May 2002 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSEYWgj>; Sat, 25 May 2002 18:36:39 -0400
Received: from surf.viawest.net ([216.87.64.26]:16295 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S315429AbSEYWgh>;
	Sat, 25 May 2002 18:36:37 -0400
Date: Sat, 25 May 2002 15:33:15 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: ioctl() still problem w/2.5.18
Message-ID: <20020525223315.GA6029@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 3:26pm  up 13:31,  2 users,  load average: 0.54, 0.20, 0.10
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        I posted this before with 2.5.8 - 2.5.16 before, but the problem still
exists in 2.5.18, so I'll repost.


        In 2.5.16, have any restrictions been placed on ioctl()? With 2.5.16,
a non-root user is unable to use /dev/cdrom with an ide cd, to play audio cds.
An strace of workbone shows this:

open("/dev/cdrom", O_RDONLY)            = 3
ioctl(3, CDROMSUBCHNL, 0xbfffe814)      = -1 EACCES (Permission denied)  
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_START, {B38400 opost isig -icanon -echo ...}) = 0
ioctl(0, TCGETS, {B38400 opost isig -icanon -echo ...}) = 0
write(1, "\n", 1
)                       = 1
ioctl(0, SNDCTL_TMR_START, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_IGN}, 8) = 0
munmap(0x40017000, 4096)                = 0
_exit(0)                                = ?

        Workbone is supposed to access /dev/cdrom, and then wait for user 
input from the number pad, to play the cd. the following strace from workbone 
in 2.5.7 shows this working properly:

write(1, "\33[10m\n", 6
) = 55                                               
open("/dev/cdrom", O_RDONLY)            = 3  "..., 55
ioctl(3, CDROMSUBCHNL, 0xbfffe654)      = 0
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
ioctl(3, CDROMREADTOCHDR, 0xbfffe626)   = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
ioctl(3, CDROMREADTOCENTRY, 0xbfffe628) = 0
rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0

        This worked as root, and with  a kernel <= 2.5.13. I didn't try this 
with 2.5.14 or 2.5.15.

        since open("/dev/cdrom", O_RDONLY) is returning as it should, It would 
be safe to assume that the ioctl() call is causing the problem. /dev/cdrom has 
permissions 0666 applied to it.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

