Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSFDIne>; Tue, 4 Jun 2002 04:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSFDInd>; Tue, 4 Jun 2002 04:43:33 -0400
Received: from pc2-heck2-0-cust123.hud.cable.ntl.com ([213.105.111.123]:42737
	"HELO fridge.solinno.co.uk") by vger.kernel.org with SMTP
	id <S316569AbSFDInd>; Tue, 4 Jun 2002 04:43:33 -0400
Subject: [PATCH] Further change to change_floppy()
From: Leigh Brown <leigh@solinno.co.uk>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, viro@math.psu.edu,
        Eddie Bindt <eddieb@xs4all.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 09:42:06 +0100
Message-Id: <1023180126.20263.18.camel@kettle.solinno.co.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

The swim3 floppy driver does not let you open the floppy device for
writing (O_RDWR) if the drive contains a write-protected floppy.  Since
the FDEJECT IOCTL works if the device has been opened read only, the
open can safely be changed to use O_RDONLY. 

This patch (against 2.4.19pre9) has been tested on an ANS (swim3), but
has not been tested using the standard floppy driver.  However, there is
a comment in the standard floppy driver code to indicate that it should
work, as shown below: 

/* Allow ioctls if we have write-permissions even if read-only open. 
 * Needed so that programs such as fdrawcmd still can work on write 
 * protected disks */ 
if ((filp->f_mode & 2) || 
    (inode->i_sb && (permission(inode,2) == 0))) 
    filp->private_data = (void*) 8; 

Cheers, 

Leigh. 

diff -ur linux-2.4.19-pre9/init/do_mounts.c linux-2.4.19-pre9-local/init/do_mounts.c
--- linux-2.4.19-pre9/init/do_mounts.c	Fri May 31 09:22:57 2002
+++ linux-2.4.19-pre9-local/init/do_mounts.c	Fri May 31 09:36:00 2002
@@ -388,7 +388,7 @@
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
 	va_end(args);
-	fd = open("/dev/root", O_RDWR | O_NDELAY, 0);
+	fd = open("/dev/root", O_RDONLY | O_NDELAY, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, FDEJECT, 0);
 		close(fd);

