Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269077AbUIHU0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269077AbUIHU0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269078AbUIHU0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:26:38 -0400
Received: from server1.focalimage.com ([69.44.156.16]:157 "EHLO
	server1.focalimage.com") by vger.kernel.org with ESMTP
	id S269077AbUIHU02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:26:28 -0400
X-Qmail-Scanner-Mail-From: raj@linuxense.com via server1.focalimage.com
X-Qmail-Scanner: 1.22 (Clear:RC:0(202.83.33.62):SA:0(1.6/5.0):. Processed in 1.525067 secs)
Message-ID: <413FF085.9030304@linuxense.com>
Date: Thu, 09 Sep 2004 01:56:21 -0400
From: Rajkumar S <raj@linuxense.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IO performance problems when writing to DVD-RAM/ZIP/MO 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am resurrecting an old thread with similar subject (1) as I still face 
problems with performance when I write to my DVD drive. Andrea Arcangeli 
has addressed (2) this subject and basically said that:

<quote>
DVDRAM and ZIP writes are dogslow and for such a slow blkdev allowing
60% of freeable ram to be locked in dirty buffers, is exactly like if
you have to swapout on top of a DVDRAM instead of on top of a 40M/sec hd
while allocating memory.  You will have to wait minutes before such 60%
of freeable ram is flushed to disk.
</quote>

I did some searching to see if I can get the count of dirty buffers on a 
per block device basis, and finally ended up with a patch (3) to 
fs/buffer.c to print them. This patch basically loops through dirty 
buffer list every second and checks bh->b_dev. If it's one of my devices 
I increment a counter. This is my first messing up with kernel code and 
I mostly modeled it according to the kupdate thread.

To test the behavior I did 5 tests, all using dd, and reading from 
/dev/zero and writing to my hard disk (/dev/hdb1) DVD Drive (/dev/scd1) 
and one more hard disk (/dev/hda5) I am using linux-2.4.27

Here are the results:
1. Hard disk and DVD together.  (dvdhdd.png)
    dd if=/dev/zero of=/zero bs=1024 count=1M
       Time taken: 1220.900968 Sec		
    dd if=/dev/zero of=/mnt/dvd/zero bs=1K count=1M
       Time taken: 1190.735165 Sec

2. Next wrote to just DVD  (dvdalone.png)
    dd if=/dev/zero of=/zero bs=1024 count=1M
       Time taken: 1073.287810 Sec

3. Only HDD (hddalone.png)
    dd if=/dev/zero of=/mnt/dvd/zero bs=1K count=1M
       Time taken: 39.118376 Sec

4. Two harddisks together (hda15.png)
    dd if=/dev/zero of=/mnt/hda5/zero bs=1024 count=1M
       Time taken: 148.850476 Sec
    dd if=/dev/zero of=/zero bs=1024 count=1M
       Time taken: 47.318928 Sec

5. Second hard disk alone (hda5.png)
    dd if=/dev/zero of=/mnt/hda5/zero bs=1024 count=1M
       Time taken: 113.288469 Sec

As you can see, when I run dd on both DVD and HDD together even the HDD 
write takes about 1220 seconds while normally it should have taken only 
about 40 seconds. Also the machine freezes when the HDD light blinks up 
and in vmstat  number of processes waiting for run time increases.

In order to further analyze the data I had from my patch I piped it 
through a graphing program to produce some graphs to see how they look, 
and I got some interesting results whose causes elude me. Graphs are at 
http://linuxense.linuxense.com/kernel/

1. dvdalone.png is a sawtooth like graph with a peak of about 27000
buffers and then tapering till zero.

2. When DVD and HDD are written together, most of the time dirty buffers
contain data to DVD and data to HDD are spread across the entire test
time (dvdhdd.png).

3. The graph I have created is a stackable graph, ie if both DVD and HDD
dirty buffers are present it would appear as stacked together. But such
a pattern is absent. At no point in time dirty buffers contain data from
2 different devices. When dirty buffers contain data for DVD device it
is completely written and then data to HDD is filled. This is the time
when machine appears to freeze.

To test this further I brought in a second hard disk and ran the tests
there and found that the dirty buffers only have data from one device.

4. Another interesting observation is that when I write to DVD and HDD
writes to hdd is spread across the whole time, but when it's two hard
disk, write to one hard disk completes first and then writes to second
hard disk starts (hda15.png) This is also reflected in the timings.
Write to hdb1 finishes in about 47 seconds while hda5 takes 148 seconds.
when writing to hda5 alone it takes 113 seconds only.

5. when writing to hda5 the number of dirty buffers goes to about 200000
while other two devices have much lesser numbers.

and finally my testing method and especially the patch could be fatally 
flawed and all these results could be bogus.

If my patch is correct, I have some more questions:

1. Why dirty buffers do not hold data from more than one device?

2. In the dvdhdd.png can the red lines be brought forward ? (ie when we 
have 2 block devices with dissimilar speeds can the faster drive get 
priority, this seems to happen with 2 hard disks [hda15.pmg])

I have put a page with all the graphs and my comments at 
http://linuxense.linuxense.com/kernel/ Raw data I have used along with 
all images and patch is also available at 
http://www.linuxense.com/kernel/data/

Thanks for reading this mail and for any help

regards,

raj

1. IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
2. 
http://groups.google.com/groups?hl=en&lr=lang_en&ie=UTF-8&safe=off&selm=20020416182550.J29747%40dualathlon.random&rnum=3
3.

--- buffer.c.orig       2004-09-08 18:50:46.000000000 -0400
+++ buffer.c    2004-09-08 18:52:42.000000000 -0400
@@ -3129,6 +3129,62 @@
         }
  }

+/*
+ * My barebones kernel thread
+ *
+ */
+int usbupdate(void *startup)
+{
+       struct task_struct *tsk = current;
+       int interval = 1*HZ;
+
+       struct buffer_head *next;
+       /*struct buffer_head *array[NRSYNC];*/
+       int nr;
+
+       /*
+        *      We have a bare-bones task_struct, and really should fill
+        *      in a few more things so "top" and /proc/2/{exe,root,cwd}
+        *      display semi-sane things. Not real crucial though...
+        */
+
+       tsk->session = 1;
+       tsk->pgrp = 1;
+       strcpy(tsk->comm, "usbupdate");
+
+       /* avoid getting signals */
+       spin_lock_irq(&tsk->sigmask_lock);
+       flush_signals(tsk);
+       sigfillset(&tsk->blocked);
+       recalc_sigpending(tsk);
+       spin_unlock_irq(&tsk->sigmask_lock);
+
+       complete((struct completion *)startup);
+
+       for (;;) {
+       tsk->state = TASK_INTERRUPTIBLE;
+       schedule_timeout(interval);
+
+       /* Start of buffer traverse */
+       spin_lock(&lru_list_lock);
+       next = lru_list[BUF_DIRTY];      /* Addr of first element    */
+       nr = nr_buffers_type[BUF_DIRTY]; /* No of BUF_DIRTY elements */
+       struct buffer_head * bh = next;
+       unsigned int counthd, countdvd, countother, countdefault;
+       counthd = 0; countdvd = 0; countother = 0; countdefault = 0;
+       while (next && --nr >= 0) {
+               next = bh->b_next_free;
+               switch (bh->b_dev) {
+               case 0x0B01: countdvd++;break; /* /dev/scd1 */
+               case 0x0341:  counthd++;break; /* /dev/hdb1 */
+               }
+       }
+       printk(KERN_DEBUG "hd count = %u, dvd count = %u\n", counthd, 
countdvd)
;
+       spin_unlock(&lru_list_lock);
+       /* End of buffer traverse */
+       }
+}
+
  static int __init bdflush_init(void)
  {
         static struct completion startup __initdata = 
COMPLETION_INITIALIZER(startup);
@@ -3137,6 +3193,8 @@
         wait_for_completion(&startup);
         kernel_thread(kupdate, &startup, CLONE_FS | CLONE_FILES | 
CLONE_SIGNAL);
         wait_for_completion(&startup);
+       kernel_thread(usbupdate, &startup, CLONE_FS | CLONE_FILES | 
CLONE_SIGNAL);
+       wait_for_completion(&startup);
         return 0;
  }
