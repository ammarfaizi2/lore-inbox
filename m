Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264341AbTLKBtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTLKBs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:48:56 -0500
Received: from unknown.servercentral.net ([66.225.219.162]:45265 "EHLO
	amsterdam.servershost.net") by vger.kernel.org with ESMTP
	id S264341AbTLKBsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:48:09 -0500
Message-ID: <3FD7CCD2.6010407@campogeral.com.br>
Date: Wed, 10 Dec 2003 23:48:02 -0200
From: Fernando Serboncini - Campo Geral <fserb@campogeral.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031127
X-Accept-Language: en-us, en, pt-br, pt, es, it
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Gabriel Winckler <winckler@campogeral.com.br>
Subject: RAID5 resync blocking on 2.6.0-test11
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - amsterdam.servershost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - campogeral.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LKML,

I've just installed a software-RAID 5 on my Alpha (miata) Workstation 
500au with Kernel 2.6.0-test11. The RAID is made of 4 Western Digital 
250Gb HDs on a promise-ata-133tx2.

The initial raidstart and mke2fs worked fine. After the initial sync, a 
clean boot and a new raidstart, the /proc/mdstat reported that the drive 
was at "resync" (/var/log/messages says that "raid array is not clean").

The problem is, the resync was blocking the /dev/md0. So, when I did a 
'mount /dev/md0', it blocked until the resync was done (and it was a 
looong time for a nearly 1TB RAID).

Looking through driver/md code I've realized that md_do_sync() was the 
real devil. After a few diffs with 2.4.23 code I've realized that at the 
speed limiter part of the function, the old "current->nice = " lines 
were deleted.

After a few more search (and looking through LXR) at 
/fs/jffs2/background.c and /net/bluetooth/bnep/core.c I've realized that 
some people have changed "current->nice =" statements to 
"set_user_nice(current,...)" ones.

Done that. The RAID worked just fine (still resyncing at boot, not fully 
tested yet) but don't block mounts anymore (btw, mount returns a lot 
faster than with 2.4.23).

Since I'm no kernel (nor RAID) expert (first post here, btw), just 
wandering if I did something really stupid or not.

Also, is this an Alpha-only issue? Or a 2.6.0 issue?

Anyway, here follows the patch for what I've done.

thanks for the attention.

Fernando Serboncini



--- linux-2.6.0-test11/drivers/md/md.c  2003-11-26 18:43:29.000000000 -0200
+++ linux/drivers/md/md.c       2003-12-10 23:29:33.000000000 -0200
@@ -3290,6 +3290,8 @@
                 currspeed = 
(j-mddev->resync_mark_cnt)/2/((jiffies-mddev->resync_mark)/HZ +1) +1;

                 if (currspeed > sysctl_speed_limit_min) {
+                       set_user_nice(current,19);
+
                         if ((currspeed > sysctl_speed_limit_max) ||
                                         !is_mddev_idle(mddev)) {
                                 current->state = TASK_INTERRUPTIBLE;
@@ -3297,6 +3299,8 @@
                                 goto repeat;
                         }
                 }
+               else
+                       set_user_nice(current,-20);
         }
         printk(KERN_INFO "md: md%d: sync done.\n",mdidx(mddev));
         /*


