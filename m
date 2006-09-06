Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWIFKjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWIFKjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWIFKjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:39:55 -0400
Received: from main.gmane.org ([80.91.229.2]:18567 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750741AbWIFJjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:39:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Damon LaCrosse <arid@inbox.ru>
Subject: 2.6.17 strange hd slow down
Date: Wed, 06 Sep 2006 11:38:31 +0200
Organization: Julian Assange Memorial Society
Message-ID: <87wt8huyg8.fsf@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 62-101-126-227.ip.fastwebnet.it
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Cancel-Lock: sha1:NzlK6gGYJ2NLbpbr3qb0jmZuykI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
experimenting a little the 2.6 block device layer I detected under some
circumstances a net slowness in the disk throughput. Strangely enough, in fact,
my IDE disk reported a significant performance drop off in correspondence of
certain access patterns.

Following further investigations I was able to simulate this ill behavior in
the following piece of code, clearly showing a non negligible hard-disk slow
down when the step value is set greater than 8. These result in fact far below
the hard-disk real speed (30~70MB/sec), as correctly measured instead in
correspondence of low STEP values (<8). In particular, with step of 512 or
above, the overall performance scored by the disk results below 2MB/sec.

At first I thought to a side-effect of the queue plug/unplug mechanism: the
scattered accesses involve the unplug timeout to each bio. So, I added the
BIO_RW_SYNC flag that - AFAIK - should force the queue
unplugging. Unfortunately nothing changes.

Now, as it is quite possible that I'm missing something, the question is: is
there an effective way of doing scattered disk accesses using bios? In other
words, how can I fix the following program in order to get disk full speed for
steps > 8?

TIA!
Damon

PS: please find below several results corresponding to various steps/scheduler
combinations, along with some configuration specs.

# hdparm -i /dev/hda

ATA device, with non-removable media
        Model Number:       Maxtor 6Y080P0
        Firmware Revision:  YAR41BW0
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  160086528
        device size with M = 1024*1024:       78167 MBytes
        device size with M = 1000*1000:       81964 MBytes (81 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

# uname -a
Linux 2.6.17.1 #2 SMP PREEMPT i686 Intel(R) Xeon(TM) CPU 2.80GHz GNU/Linux

ANTICIPATORY SCHEDULER

STEP (hs)	CYCLES		WRITTEN (MB)	ELAPSED (s)	SPEED (MB/s)
1		61954		242		3		75.432
2		59394		232		3		71.3032
3		16473		64		3		21.843
4		52482		205		3		62.3135
5		14448		56		3		18.1951
6		13617		53		3		17.1732
7		12849		50		3		16.1695
8		47874		187		3		56.2823
9		2569		10		3		3.468
10		2608		10		3		3.716
11		2416		9		3		2.3085
12		2576		10		3		3.468
13		2480		9		3		3.222
14		2424		9		3		2.3084
15		2616		10		3		3.738
16		2288		8		3		2.2619
32		2376		9		3		2.2849
64		2400		9		3		2.3059
128		2408		9		3		2.3098
256		1384		5		3		1.2104
512		1048		4		3		1.761

DEADLINE SCHEDULER

STEP (hs)	CYCLES		WRITTEN (MB)	ELAPSED (s)	SPEED (MB/s)
1		61955		242		3		75.736
2		59907		234		3		72.1307
3		16473		64		3		21.843
4		52994		207		3		63.1816
5		14330		55		3		18.1526
6		13569		53		3		17.1476
7		12817		50		3		16.1618
8		47618		186		3		56.1991
9		2625		10		3		3.734
10		2472		9		3		3.185
11		2512		9		3		3.371
12		2624		10		3		3.764
13		2392		9		3		2.3051
14		2472		9		3		2.3214
15		2664		10		3		3.863
16		2512		9		3		3.305
32		2448		9		3		3.10
64		2520		9		3		3.375
128		2417		9		3		2.3017
256		1305		5		3		1.1776
512		1160		4		3		1.1258

CFQ SCHEDULER

STEP (hs)	CYCLES		WRITTEN (MB)	ELAPSED (s)	SPEED (MB/s)
1		62850		245		3		76.1395
2		60416		236		3		73.940
3		15970		62		3		20.1902
4		53225		207		3		63.2719
5		14945		58		3		19.865
6		14250		55		3		18.1160
7		13682		53		3		17.1986
8		47870		186		3		56.2472
9		2529		9		3		3.170
10		2576		10		3		3.477
11		2472		9		3		3.44
12		2672		10		3		3.933
13		2481		9		3		3.256
14		2592		10		3		3.627
15		2512		9		3		3.386
16		2688		10		3		3.1008
32		2384		9		3		2.2996
64		2320		9		3		2.2734
128		2720		10		3		3.1130
256		1265		4		3		1.1664
512		1088		4		3		1.768

NOOP SCHEDULER

STEP (hs)	CYCLES		WRITTEN (MB)	ELAPSED (s)	SPEED (MB/s)
1		20987		81		3		27.413
2		19974		78		3		25.2373
3		16434		64		3		21.712
4		18541		72		3		23.2482
5		14217		55		3		18.1067
6		13625		53		3		17.1729
7		12489		48		3		16.337
8		48898		191		3		57.3135
9		2560		10		3		3.499
10		2568		10		3		3.332
11		2472		9		3		3.161
12		2568		10		3		3.371
13		2352		9		3		2.2875
14		2584		10		3		3.487
15		2320		9		3		2.2740
16		2544		9		3		3.481
32		2344		9		3		2.2832
64		2416		9		3		2.3069
128		2328		9		3		2.2649
256		1360		5		3		1.2010
512		1440		5		3		1.2190

--- empty       2006-09-05 00:16:24.000000000 +0200
+++ test.c      2006-09-05 00:16:49.000000000 +0200
@@ -0,0 +1,145 @@
+#include <linux/module.h>
+#include <linux/timer.h>
+#include <linux/bio.h>
+
+#define START(t) ({                                            \
+               struct timeval __tv;                            \
+               do_gettimeofday(&__tv);                         \
+               (t) = timeval_to_ns(&__tv);                     \
+       })
+
+#define STOP(t) ({                                             \
+               struct timeval __tv;                            \
+               do_gettimeofday(&__tv);                         \
+               (t) = timeval_to_ns(&__tv) - (t);               \
+       })
+
+DECLARE_WAIT_QUEUE_HEAD(wait);
+atomic_t errors, busy;
+int halt;
+
+void stop_write(unsigned long arg)
+{
+       halt = 1;
+}
+
+int endio(struct bio *bio, unsigned int bytes_done, int error)
+{
+       if (bio->bi_size) {
+               return 1;
+       }
+
+       if (error || !test_bit(BIO_UPTODATE, &bio->bi_flags)) {
+               atomic_inc(&errors);
+       }
+
+       if (atomic_dec_and_test(&busy)) {
+               wake_up(&wait);
+       }
+
+       return 0;
+}
+
+int do_write(struct block_device *bdev,
+            struct page *zero, unsigned long expires, int step)
+{
+       DEFINE_TIMER(timer, stop_write, expires, (unsigned long) NULL);
+       int i;
+
+       add_timer(&timer);
+
+       for (halt = i = 0; !halt; i++) {
+               struct bio *bio = bio_alloc(GFP_NOIO, 1);
+               if (bio) {
+                       atomic_inc(&busy);
+
+                       bio->bi_bdev = bdev;
+                       bio->bi_sector = step * i;
+                       bio_add_page(bio, zero, PAGE_SIZE, 0);
+                       bio->bi_end_io = endio;
+                       submit_bio((1 << BIO_RW) | (1 << BIO_RW_SYNC), bio);
+               } else {
+                       atomic_inc(&errors);
+               }
+       }
+
+       wait_event(wait, !atomic_read(&busy));
+
+       return i;
+}
+
+int write(struct block_device *bdev, int secs, int step)
+{
+       struct page *zero;
+
+       s64 time;
+       unsigned long space;
+       int cycles;
+
+       zero = alloc_page(GFP_KERNEL);
+       if (!zero) {
+               return -ENOMEM;
+       }
+
+       memset(kmap(zero), 0, PAGE_SIZE);
+       kunmap(zero);
+
+       atomic_set(&errors, 0);
+       atomic_set(&busy, 0);
+
+       START(time);
+
+       cycles = do_write(bdev, zero, jiffies + secs * HZ, step);
+
+       STOP(time);
+
+       put_page(zero);
+
+       (void) do_div(time, 1000000);
+
+       space = ((unsigned long) cycles * 1000 * (PAGE_SIZE >> 10)) >> 10;
+
+       printk("%d\t\t%d\t\t%lu\t\t%lu\t\t%lu.%-3lu\n",
+              step, cycles, space / 1000,
+              (unsigned long ) time / 1000,
+              space / (unsigned long) time,
+              space % (unsigned long) time);
+
+       return 0;
+}
+
+static int __init init(void)
+{
+       struct block_device *bdev;
+       int i, err;
+
+       bdev = open_bdev_excl("/dev/hda", 0, THIS_MODULE);
+       if (IS_ERR(bdev)) {
+               printk("device won't open!\n");
+               return PTR_ERR(bdev);
+       }
+
+       printk("STEP (hs)\tCYCLES\t\tWRITTEN (MB)\tELAPSED (s)\tSPEED (MB/s)\n");
+
+       for (i = 1; i < 16; i++) {
+               err = write(bdev, 3, i);
+               if (err < 0) {
+                       printk("%d\t-\t\t-\t\t-\t\t-\n", i);
+               }
+       }
+
+       for (; i < 1024; i <<= 1) {
+               err = write(bdev, 3, i);
+               if (err < 0) {
+                       printk("%d\t-\t\t-\t\t-\t\t-\n", i);
+               }
+       }
+
+       close_bdev_excl(bdev);
+
+       return -EIO;
+}
+
+module_init(init);
+
+MODULE_LICENSE("GPL v2");

