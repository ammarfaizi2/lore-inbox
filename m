Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316461AbSEUAZO>; Mon, 20 May 2002 20:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316462AbSEUAZN>; Mon, 20 May 2002 20:25:13 -0400
Received: from emory.viawest.net ([216.87.64.6]:62369 "EHLO emory.viawest.net")
	by vger.kernel.org with ESMTP id <S316461AbSEUAZM>;
	Mon, 20 May 2002 20:25:12 -0400
Date: Mon, 20 May 2002 17:25:05 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: Two problems with 2.5.x, part 1
Message-ID: <20020521002505.GA7477@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 5:17pm  up 16:35,  2 users,  load average: 0.92, 0.27, 0.08
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        I've just spotted two small, but major problems with the 2.5 series, 
in which I wonder if anyone is working on.

        1) in 2.5.16, have any restrictions been placed on ioctl() ? with 
2.5.16, a non-root user is unable to use /dev/cdrom with an ide cd, to play 
audio cds. An strace of workbone shows this:

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

