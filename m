Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVHAAud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVHAAud (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVHAAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:50:33 -0400
Received: from delta.securenet-server.net ([72.9.248.26]:24522 "EHLO
	delta.securenet-server.net") by vger.kernel.org with ESMTP
	id S262280AbVHAAub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:50:31 -0400
Message-ID: <42ED71D0.9000304@machinehasnoagenda.com>
Date: Mon, 01 Aug 2005 10:50:24 +1000
From: "Shayne O'Connor" <forums@machinehasnoagenda.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: spca5xx webcam driver not compiling on 2.6.13-rc4-RT-V0.7.52-07
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: forums@machinehasnoagenda.com,machine@machinehasnoagenda.com,shunichi@machinehasnoagenda.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - delta.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - machinehasnoagenda.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the spca5xx webcam driver module compiles/installs/runs fine (a few 
compilation warnings, but nothing much) on vanilla 2.6.x kernels, but 
won't succeed on one patched with ingo's realtime pre-emption patches.

*********************************************

[root@localhost spca5xx-20050701]# make
    Building SPCA5XX driver for 2.5/2.6 kernel.
    Remember: you must have read/write access to your kernel source tree.
make -C /lib/modules/`uname -r`/build 
SUBDIRS=/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701 
modules
make[1]: Entering directory 
`/home/mrmachine/my_documents/applications/linux/system+admin/linux-2.6.12'
   CC [M] 
/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/spca5xx.o
In file included from 
/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/spca5xx.c:763:
/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/mr97311.h: 
In function `pcam_start':
/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/mr97311.h:391: 
warning: ISO C90 forbids mixed declarations and code
/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/spca5xx.c: 
In function `spca5xx_probe':
/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/spca5xx.c:8663: 
error: `SPIN_LOCK_UNLOCKED' undeclared (first use in this function)
/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/spca5xx.c:8663: 
error: (Each undeclared identifier is reported only once
/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/spca5xx.c:8663: 
error: for each function it appears in.)
make[2]: *** 
[/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701/drivers/usb/spca5xx.o] 
Error 1
make[1]: *** 
[_module_/home/mrmachine/my_documents/applications/linux/video/spca5xx-20050701] 
Error 2
make[1]: Leaving directory 
`/home/mrmachine/my_documents/applications/linux/system+admin/linux-2.6.12'
make: *** [default] Error 2

**********************************************************************

all the warnings up to the error occur on a vanilla kernel compilation, 
but installs anyway ... i know "SPIN_LOCK_UNLOCKED" has something to do 
with ingo's patch, so i emailed the spca5xx author to see if he knew 
what to do:

> Shayne,
> Try to change 'SPIN_LOCK_UNLOCKED'  by some thing to initialize the spin  :) 
> regards

i'm guessing it's these lines in spca5xx.c that i have to change:

*****************************************

if (!spca50x_configure (spca50x))
     {
       spca50x->user = 0;
       init_MUTEX (&spca50x->lock);	/* to 1 == available */
       init_MUTEX (&spca50x->buf_lock);
       spca50x->v4l_lock = SPIN_LOCK_UNLOCKED;
       spca50x->buf_state = BUF_NOT_ALLOCATED;
     }
   else
     {
       err ("Failed to configure camera");
       goto error;
     }

****************************************

i've looked through the archives for some clue as to what to change it 
to, but being a bit on the newbie side, haven't had any luck ...

please CC me on any replies!

thanx

shayne
