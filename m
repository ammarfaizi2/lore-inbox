Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262910AbSJBBfA>; Tue, 1 Oct 2002 21:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbSJBBfA>; Tue, 1 Oct 2002 21:35:00 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:34276 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S262910AbSJBBe4>; Tue, 1 Oct 2002 21:34:56 -0400
Message-ID: <3D9A4F52.70308@easynet.be>
Date: Wed, 02 Oct 2002 03:43:46 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *, testers wanted] remove 614 includes of linux/sched.h
References: <Pine.LNX.4.33.0209292107510.7666-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
 > Thanks to ongoing header file cleanups, many files including linux/sched.h
 > don't need to do so anymore. A patch for 2.5.39 to remove some 600
 > occurences of
 >   #include <linux/sched.h>
 > and (hopefully) fix up resulting breakage because of indirect dependencies
 > can be found at
 >
 >   http://www.physik3.uni-rostock.de/tim/kernel/2.5/sched.h-16.patch.gz
 >
 > Extensive analysis using ctags and grep has been done, but surely cannot
 > detect all problems.
 > So I'd be happy if people compile-tested this for different archs and
 > configurations and reported problems as well as success to me.
 >
 > After obtaining sufficient feedback I'll split up the patch and pass it
 > through maintainers, which however needs to be a three-stage process
 > due to inherent dependencies.
 >
 > Tim
 >

Works for me on 2.5.40 with very few tweaks to pass from 2.5.39 to 2.5.40.
However, to supress all warning I must reverse somes removal:



diff -urP l-2.5.40-sched/drivers/base/interface.c l-2.5.40-sched-1/drivers/base/interface.c
--- l-2.5.40-sched/drivers/base/interface.c     Fri Sep 27 23:49:04 2002
+++ l-2.5.40-sched-1/drivers/base/interface.c   Wed Oct  2 02:58:49 2002
@@ -8,6 +8,7 @@
   #include <linux/device.h>
   #include <linux/err.h>
   #include <linux/stat.h>
+#include <linux/string.h>

   static ssize_t device_read_name(struct device * dev, char * buf, size_t count, loff_t off)
   {
diff -urP l-2.5.40-sched/drivers/input/serio/i8042.c l-2.5.40-sched-1/drivers/input/serio/i8042.c
--- l-2.5.40-sched/drivers/input/serio/i8042.c  Wed Oct  2 03:16:22 2002
+++ l-2.5.40-sched-1/drivers/input/serio/i8042.c        Wed Oct  2 03:01:41 2002
@@ -22,6 +22,7 @@
   #include <asm/ptrace.h>
   #include <linux/timer.h>
   #include <linux/jiffies.h>
+#include <linux/sched.h>       /* request/free_irq */

   #include "i8042.h"

diff -urP l-2.5.40-sched/fs/ext2/balloc.c l-2.5.40-sched-1/fs/ext2/balloc.c
--- l-2.5.40-sched/fs/ext2/balloc.c     Wed Oct  2 03:16:45 2002
+++ l-2.5.40-sched-1/fs/ext2/balloc.c   Wed Oct  2 03:07:53 2002
@@ -16,8 +16,10 @@
   #include <linux/quotaops.h>
   #include <asm/current.h>
   #include <linux/capability.h>
+#include <linux/security.h>            /* capable() */
   #include <linux/task_struct.h>
   #include <linux/buffer_head.h>
+#include <linux/sched.h>               /* in_group_p() */

   /*
    * balloc.c contains the blocks allocation and deallocation routines


