Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTEaWWk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 18:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTEaWWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 18:22:40 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:9996 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264478AbTEaWWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 18:22:36 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [2.5.70] possible problem with /dev/diskstats
Date: Sun, 1 Jun 2003 00:35:58 +0200
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306010035.58957.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I've just played around with my server (that has actualy no load)
and I recognized something strange in /dev/diskstats.

Documentation/iostats.txt says about diskstats:
[SNIP]
Field  9 -- # of I/Os currently in progress
    The only field that should go to zero. Incremented as requests are
    given to appropriate request_queue_t and decremented as they finish.
[SNIP]

But here is a cat /proc/diskstats:
   1    0 ram0 0 0 0 0 0 0 0 0 0 0 0
   1    1 ram1 0 0 0 0 0 0 0 0 0 0 0
   1    2 ram2 0 0 0 0 0 0 0 0 0 0 0
   1    3 ram3 0 0 0 0 0 0 0 0 0 0 0
   1    4 ram4 0 0 0 0 0 0 0 0 0 0 0
   1    5 ram5 0 0 0 0 0 0 0 0 0 0 0
   1    6 ram6 0 0 0 0 0 0 0 0 0 0 0
   1    7 ram7 0 0 0 0 0 0 0 0 0 0 0
   1    8 ram8 0 0 0 0 0 0 0 0 0 0 0
   1    9 ram9 0 0 0 0 0 0 0 0 0 0 0
   1   10 ram10 0 0 0 0 0 0 0 0 0 0 0
   1   11 ram11 0 0 0 0 0 0 0 0 0 0 0
   1   12 ram12 0 0 0 0 0 0 0 0 0 0 0
   1   13 ram13 0 0 0 0 0 0 0 0 0 0 0
   1   14 ram14 0 0 0 0 0 0 0 0 0 0 0
   1   15 ram15 0 0 0 0 0 0 0 0 0 0 0
   7    0 loop0 0 0 0 0 0 0 0 0 0 0 0
   7    1 loop1 0 0 0 0 0 0 0 0 0 0 0
   7    2 loop2 0 0 0 0 0 0 0 0 0 0 0
   7    3 loop3 0 0 0 0 0 0 0 0 0 0 0
   7    4 loop4 0 0 0 0 0 0 0 0 0 0 0
   7    5 loop5 0 0 0 0 0 0 0 0 0 0 0
   7    6 loop6 0 0 0 0 0 0 0 0 0 0 0
   7    7 loop7 0 0 0 0 0 0 0 0 0 0 0
   3    0 hda 948 317 16216 4294408142 90 333 848 7309 4294967294 7309215 4280372198
                                                       ~~~~~~~~~~
   3    1 hda1 4 8 0 0
   3    2 hda2 1258 16200 424 848
   3   64 hdb 434 0 3456 4294402902 337 261 4808 3174 4294967294 7313591 4280362822
                                                      ~~~~~~~~~~
   3   65 hdb1 0 0 0 0
   3   66 hdb2 431 3448 601 4808

That's definately not zero. 8)

The server seems to run fine and it seems to be only
a displaying-problem.
Kernel is 2.5.70 vanilla with the attached patch by Andrew Morton.
hda and hdb are two small 2GB ide-disks.
If you need more information, please just ask for what you want. :)

UH, I've just recognized, that this value is one
before UNSIGNED_LONG_MAX (4,294,867,295).

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 00:23:28 up  9:55,  5 users,  load average: 1.02, 1.04, 1.00


[ANDREW'S PATCH]

This /proc tunable sets the kupdate interval.  It has a couple of problems:

- - No way to turn it off completely (userspace dirty memory management
  solutions require this).

- - If it has been set to one hour and then the user resets it to five
  seconds, that resetting will not take effect for up to an hour.

Fix that up by providing a sysctl handler.  Setting the tunable to zero now
disables the kupdate function.


 Documentation/filesystems/proc.txt |    2 ++
 include/linux/writeback.h          |    4 ++++
 kernel/sysctl.c                    |   16 +---------------
 mm/page-writeback.c                |   20 +++++++++++++++++++-
 4 files changed, 26 insertions(+), 16 deletions(-)

diff -puN Documentation/filesystems/proc.txt~writeback-interval-restart Documentation/filesystems/proc.txt
- --- 25/Documentation/filesystems/proc.txt~writeback-interval-restart    2003-05-31 12:22:37.000000000 -0700
+++ 25-akpm/Documentation/filesystems/proc.txt  2003-05-31 12:22:37.000000000 -0700
@@ -1068,6 +1068,8 @@ The pdflush writeback daemons will perio
 out to disk.  This tunable expresses the interval between those wakeups, in
 100'ths of a second.
 
+Setting this to zero disables periodic writeback altogether.
+
 dirty_expire_centisecs
 ----------------------
 
diff -puN include/linux/writeback.h~writeback-interval-restart include/linux/writeback.h
- --- 25/include/linux/writeback.h~writeback-interval-restart     2003-05-31 12:22:37.000000000 -0700
+++ 25-akpm/include/linux/writeback.h   2003-05-31 12:22:37.000000000 -0700
@@ -78,6 +78,10 @@ extern int vm_dirty_ratio;
 extern int dirty_writeback_centisecs;
 extern int dirty_expire_centisecs;
 
+struct ctl_table;
+struct file;
+int dirty_writeback_centisecs_handler(struct ctl_table *, int, struct file *, 
+                                         void *, size_t *);
 
 void page_writeback_init(void);
 void balance_dirty_pages(struct address_space *mapping);
diff -puN kernel/sysctl.c~writeback-interval-restart kernel/sysctl.c
- --- 25/kernel/sysctl.c~writeback-interval-restart       2003-05-31 12:22:37.000000000 -0700
+++ 25-akpm/kernel/sysctl.c     2003-05-31 12:22:37.000000000 -0700
@@ -276,7 +276,6 @@ static ctl_table kern_table[] = {
 /* Constants for minimum and maximum testing in vm_table.
    We use these as one-element integer vectors. */
 static int zero = 0;
- -static int one = 1;
 static int one_hundred = 100;
 
 
@@ -297,20 +296,7 @@ static ctl_table vm_table[] = {
         &sysctl_intvec, NULL, &zero, &one_hundred },
        {VM_DIRTY_WB_CS, "dirty_writeback_centisecs",
         &dirty_writeback_centisecs, sizeof(dirty_writeback_centisecs), 0644,
- -        NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL,
- -        /* Here, we define the range of possible values for
- -           dirty_writeback_centisecs.
- -
- -           The default value is 5 seconds (500 centisec).  We will use 1
- -           centisec, the smallest possible value that could make any sort of
- -           sense.  If we allowed the user to set the interval to 0 seconds
- -           (which would presumably mean to chew up all of the CPU looking for
- -           dirty pages and writing them out, without taking a break), the
- -           interval would effectively become 1 second (100 centisecs), due to
- -           some nicely documented throttling code in wb_kupdate().
- -
- -           There is no maximum legal value for dirty_writeback. */
- -        &one , NULL},
+        NULL, dirty_writeback_centisecs_handler },
        {VM_DIRTY_EXPIRE_CS, "dirty_expire_centisecs",
         &dirty_expire_centisecs, sizeof(dirty_expire_centisecs), 0644,
         NULL, &proc_dointvec},
diff -puN mm/page-writeback.c~writeback-interval-restart mm/page-writeback.c
- --- 25/mm/page-writeback.c~writeback-interval-restart   2003-05-31 12:22:37.000000000 -0700
+++ 25-akpm/mm/page-writeback.c 2003-05-31 12:22:37.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/sysctl.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -329,7 +330,24 @@ static void wb_kupdate(unsigned long arg
        }
        if (time_before(next_jif, jiffies + HZ))
                next_jif = jiffies + HZ;
- -       mod_timer(&wb_timer, next_jif);
+       if (dirty_writeback_centisecs)
+               mod_timer(&wb_timer, next_jif);
+}
+
+/*
+ * sysctl handler for /proc/sys/vm/dirty_writeback_centisecs
+ */
+int dirty_writeback_centisecs_handler(ctl_table *table, int write,
+               struct file *file, void *buffer, size_t *length)
+{
+       proc_dointvec(table, write, file, buffer, length);
+       if (dirty_writeback_centisecs) {
+               mod_timer(&wb_timer,
+                       jiffies + (dirty_writeback_centisecs * HZ) / 100);
+       } else {
+               del_timer(&wb_timer);
+       }
+       return 0;
 }
 
 static void wb_timer_fn(unsigned long unused)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2S5OoxoigfggmSgRAlavAKCNTA7U3afJJKdZHLHYbytludY1/wCfWrv+
PVN2W38sdFQ7MqQLfk01nY4=
=1pjP
-----END PGP SIGNATURE-----

