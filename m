Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbULBH50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbULBH50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbULBH5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:57:25 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:17619
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S261237AbULBH5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:57:03 -0500
Message-ID: <41AECACD.6030308@bio.ifi.lmu.de>
Date: Thu, 02 Dec 2004 08:57:01 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cd burning, capabilities and available modes
References: <1101908433l.8423l.0l@werewolf.able.es>
In-Reply-To: <1101908433l.8423l.0l@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote

> werewolf:/store/tmp> cdrecord -dummy dev=ATAPI:1,0,0 *.iso

Why not use "dev=ATAPI:/dev/hdd" or whatever device in /dev/ is
your burner...?

> ...
> cdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).
> cdrecord: WARNING: This causes a high risk for buffer underruns.
> cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
> cdrecord: Permission denied. WARNING: Cannot set priority using setpriority().
> cdrecord: WARNING: This causes a high risk for buffer underruns.
> scsidev: 'ATAPI:1,0,0'
> devname: 'ATAPI'
> scsibus: 1 target: 0 lun: 0
> Warning: Using ATA Packet interface.
> Warning: The related Linux kernel interface code seems to be unmaintained..
> Warning: There is absolutely NO DMA, operations thus are slow.
> WARNING ! Cannot gain SYS_RAWIO capability ! 
> : Operation not permitted

Sth. seems to be wrong here. When I do this as user I get
...
Use of ATA is preferred over ATAPI.
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.8'.
...

so it seems that your kernel is still blocking some command in the userland.
This might cause your problems, because I get the same write modes as user
that I get as root. I use 2.6.9 but have allowed some more commands for
users. You can add this in linux/drivers/block/scsi_ioctl.c to see if
some commands are blocked as user:

--- linux/drivers/block/scsi_ioctl.c.orig       2004-08-18 16:11:01.000000000 +0200
+++ linux/drivers/block/scsi_ioctl.c    2004-08-18 16:11:55.000000000 +0200
@@ -172,6 +228,12 @@
         /* And root can do any command.. */
         if (capable(CAP_SYS_RAWIO))
                 return 0;
+        /* Added for debugging*/
+
+       if(file->f_mode & FMODE_WRITE)
+         printk(KERN_WARNING "SCSI-CMD Filter: 0x%x not allowed with write-mode\n",cmd[0]);
+       else
+         printk(KERN_WARNING "SCSI-CMD Filter: 0x%x not allowed with read-mode\n",cmd[0]);

         /* Otherwise fail it with an "Operation not permitted" */
         return -EPERM;

cu,
Frank


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *

