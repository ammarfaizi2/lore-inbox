Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310156AbSCFUOv>; Wed, 6 Mar 2002 15:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310141AbSCFUOo>; Wed, 6 Mar 2002 15:14:44 -0500
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:9265 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S310162AbSCFUOa>; Wed, 6 Mar 2002 15:14:30 -0500
Message-ID: <035101c1c54a$a00b6e40$0501a8c0@Stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Jean-Eric Cuendet" <jean-eric.cuendet@linkvest.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3C86553E.3070608@linkvest.com>
Subject: Re: [PATCH] Rework of /proc/stat
Date: Wed, 6 Mar 2002 20:08:04 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

would a patch like this not make more sense
i picked it up on this list a while ago i cannot remember who wrote it
fixed it a bit and it does much the same except it alows you to have
any number of block devices though it does not work with scsi properly yet.

diff against 2.4.18

>
> Hi,
> I've made a new version of IO statistics in kstat that remove the
> previous limitations of MAX_MAJOR. I've made tests on my machine only, so
could someone test it, please?
> Feedback welcome.
> Bye
> -jec
>
> Patch attached.
>
Index: v2.4/drivers/block/ll_rw_blk.c
diff -u v2.4/drivers/block/ll_rw_blk.c:1.1.1.2
v2.4/drivers/block/ll_rw_blk.c:1.1.1.2.2.1
--- v2.4/drivers/block/ll_rw_blk.c:1.1.1.2 Mon Feb 25 21:54:45 2002
+++ v2.4/drivers/block/ll_rw_blk.c Mon Feb 25 22:53:10 2002
@@ -183,7 +183,11 @@

  if (count)
   printk("blk_cleanup_queue: leaked requests (%d)\n", count);
-
+ /*
+  * free statistics structure
+  */
+ kfree(q->dk_stat);
+
  memset(q, 0, sizeof(*q));
 }

@@ -393,6 +397,8 @@
  **/
 void blk_init_queue(request_queue_t * q, request_fn_proc * rfn)
 {
+ struct disk_stat * new;
+
  INIT_LIST_HEAD(&q->queue_head);
  elevator_init(&q->elevator, ELEVATOR_LINUS);
  blk_init_free_list(q);
@@ -413,6 +419,15 @@
   */
  q->plug_device_fn  = generic_plug_device;
  q->head_active     = 1;
+ /*
+  * At last, allocate and initialize the statistics
+  */
+ new = kmalloc(sizeof(struct disk_stat), GFP_KERNEL);
+ if (new == NULL)
+  printk(KERN_ERR "blk_init_queue:error allocating statisitcs\n");
+ else
+  memset(new, 0, sizeof(struct disk_stat));
+ q->dk_stat = new;
 }

 #define blkdev_free_rq(list) list_entry((list)->next, struct request,
queue);
@@ -497,23 +512,18 @@
  else ro_bits[major][minor >> 5] &= ~(1 << (minor & 31));
 }

-inline void drive_stat_acct (kdev_t dev, int rw,
+inline void drive_stat_acct (struct disk_stat * ds, int rw,
     unsigned long nr_sectors, int new_io)
 {
- unsigned int major = MAJOR(dev);
- unsigned int index;
-
- index = disk_index(dev);
- if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
+ if (ds == NULL)
   return;

- kstat.dk_drive[major][index] += new_io;
  if (rw == READ) {
-  kstat.dk_drive_rio[major][index] += new_io;
-  kstat.dk_drive_rblk[major][index] += nr_sectors;
+  ds->dk_drive_rio += new_io;
+  ds->dk_drive_rblk += nr_sectors;
  } else if (rw == WRITE) {
-  kstat.dk_drive_wio[major][index] += new_io;
-  kstat.dk_drive_wblk[major][index] += nr_sectors;
+  ds->dk_drive_wio += new_io;
+  ds->dk_drive_wblk += nr_sectors;
  } else
   printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
 }
@@ -529,7 +539,7 @@
 static inline void add_request(request_queue_t * q, struct request * req,
           struct list_head *insert_here)
 {
- drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
+ drive_stat_acct(q->dk_stat, req->cmd, req->nr_sectors, 1);

  if (!q->plugged && q->head_active && insert_here == &q->queue_head) {
   spin_unlock_irq(&io_request_lock);
@@ -703,7 +713,7 @@
    req->bhtail = bh;
    req->nr_sectors = req->hard_nr_sectors += count;
    blk_started_io(count);
-   drive_stat_acct(req->rq_dev, req->cmd, count, 0);
+   drive_stat_acct(q->dk_stat, req->cmd, count, 0);
    attempt_back_merge(q, req, max_sectors, max_segments);
    goto out;

@@ -720,7 +730,7 @@
    req->sector = req->hard_sector = sector;
    req->nr_sectors = req->hard_nr_sectors += count;
    blk_started_io(count);
-   drive_stat_acct(req->rq_dev, req->cmd, count, 0);
+   drive_stat_acct(q->dk_stat, req->cmd, count, 0);
    attempt_front_merge(q, head, req, max_sectors, max_segments);
    goto out;

Index: v2.4/drivers/ide/ide.c
diff -u v2.4/drivers/ide/ide.c:1.1.1.2 v2.4/drivers/ide/ide.c:1.1.1.2.2.1
--- v2.4/drivers/ide/ide.c:1.1.1.2 Mon Feb 25 21:55:52 2002
+++ v2.4/drivers/ide/ide.c Mon Feb 25 22:53:10 2002
@@ -1454,8 +1454,10 @@
 request_queue_t *ide_get_queue (kdev_t dev)
 {
  ide_hwif_t *hwif = (ide_hwif_t *)blk_dev[MAJOR(dev)].data;
-
- return &hwif->drives[DEVICE_NR(dev) & 1].queue;
+ if (DEVICE_NR(dev) >= MAX_DRIVES)
+   return NULL;
+ else
+  return &hwif->drives[DEVICE_NR(dev)].queue;
 }

 /*
Index: v2.4/drivers/md/md.c
diff -u v2.4/drivers/md/md.c:1.1.1.2 v2.4/drivers/md/md.c:1.1.1.2.2.1
--- v2.4/drivers/md/md.c:1.1.1.2 Mon Feb 25 21:55:55 2002
+++ v2.4/drivers/md/md.c Mon Feb 25 22:53:10 2002
@@ -3308,12 +3308,15 @@
  ITERATE_RDEV(mddev,rdev,tmp) {
   int major = MAJOR(rdev->dev);
   int idx = disk_index(rdev->dev);
-
+  request_queue_t * rq = blk_get_queue(rdev->dev);
+
   if ((idx >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
    continue;
-
-  curr_events = kstat.dk_drive_rblk[major][idx] +
-      kstat.dk_drive_wblk[major][idx] ;
+
+  if (rq == NULL || (rq->dk_stat == NULL))
+   continue;
+  curr_events = rq->dk_stat->dk_drive_rblk +
+   rq->dk_stat->dk_drive_wblk ;
   curr_events -= sync_io[major][idx];
   if ((curr_events - rdev->last_events) > 32) {
    rdev->last_events = curr_events;
Index: v2.4/fs/proc/proc_misc.c
diff -u v2.4/fs/proc/proc_misc.c:1.1.1.1
v2.4/fs/proc/proc_misc.c:1.1.1.1.4.1
--- v2.4/fs/proc/proc_misc.c:1.1.1.1 Sun Jan 13 15:50:20 2002
+++ v2.4/fs/proc/proc_misc.c Mon Feb 25 22:53:10 2002
@@ -36,12 +36,12 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/blkdev.h>

 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>

-
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 /*
@@ -234,7 +234,23 @@
  release: seq_release,
 };
 #endif
-
+static int show_disk_stat(char * page, int len, struct disk_stat * ds,
+     int major, int disk)
+{
+ int active = ds->dk_drive_rio + ds->dk_drive_wio +
+   ds->dk_drive_rblk + ds->dk_drive_wblk;
+ if (active)
+  len += sprintf(page + len,
+   "(%u,%u):(%u,%u,%u,%u,%u) ",
+   major, disk,
+   ds->dk_drive_rio + ds->dk_drive_wio,
+   ds->dk_drive_rio,
+   ds->dk_drive_rblk,
+   ds->dk_drive_wio,
+   ds->dk_drive_wblk
+  );
+ return len;
+}
 static int kstat_read_proc(char *page, char **start, off_t off,
      int count, int *eof, void *data)
 {
@@ -284,21 +300,30 @@

  len += sprintf(page + len, "\ndisk_io: ");

- for (major = 0; major < DK_MAX_MAJOR; major++) {
-  for (disk = 0; disk < DK_MAX_DISK; disk++) {
-   int active = kstat.dk_drive[major][disk] +
-    kstat.dk_drive_rblk[major][disk] +
-    kstat.dk_drive_wblk[major][disk];
-   if (active)
-    len += sprintf(page + len,
-     "(%u,%u):(%u,%u,%u,%u,%u) ",
-     major, disk,
-     kstat.dk_drive[major][disk],
-     kstat.dk_drive_rio[major][disk],
-     kstat.dk_drive_rblk[major][disk],
-     kstat.dk_drive_wio[major][disk],
-     kstat.dk_drive_wblk[major][disk]
-   );
+ for (major = 0; major < MAX_BLKDEV; major++) {
+  struct disk_stat * ds;
+
+  if (!(blk_dev[major].queue)){
+   ds = (BLK_DEFAULT_QUEUE(major))->dk_stat;
+   if (ds)
+    len = show_disk_stat(page, len, ds, major, 0);
+  }else {
+   request_queue_t * q;
+   struct gendisk * hd = get_gendisk(MKDEV(major,0));
+   int max_disk;
+   if (!hd)
+    continue;
+   max_disk = MINORMASK>>hd->minor_shift;
+
+   for (disk = 0; disk <= max_disk; disk++) {
+    q = blk_get_queue(MKDEV(major,disk<<hd->minor_shift));
+    if (!q)
+     continue;
+    ds = q->dk_stat;
+    if (!ds)
+     continue;
+    len = show_disk_stat(page, len, ds, major,disk);
+   }
   }
  }

Index: v2.4/include/linux/blkdev.h
diff -u v2.4/include/linux/blkdev.h:1.1.1.1
v2.4/include/linux/blkdev.h:1.1.1.1.4.1
--- v2.4/include/linux/blkdev.h:1.1.1.1 Sun Jan 13 15:50:24 2002
+++ v2.4/include/linux/blkdev.h Mon Feb 25 22:53:10 2002
@@ -71,6 +71,13 @@
  struct list_head free;
 };

+struct disk_stat{
+ unsigned int dk_drive_rio;
+ unsigned int dk_drive_wio;
+ unsigned int dk_drive_rblk;
+ unsigned int dk_drive_wblk;
+};
+
 struct request_queue
 {
  /*
@@ -122,6 +129,10 @@
   * Tasks wait here for free request
   */
  wait_queue_head_t wait_for_request;
+ /*
+  * statistics
+  */
+ struct disk_stat * dk_stat;
 };

 struct blk_dev_struct {
@@ -186,7 +197,7 @@
 #define blkdev_next_request(req) blkdev_entry_to_request((req)->queue.next)
 #define blkdev_prev_request(req) blkdev_entry_to_request((req)->queue.prev)

-extern void drive_stat_acct (kdev_t dev, int rw,
+extern void drive_stat_acct (struct disk_stat *, int rw,
      unsigned long nr_sectors, int new_io);

 static inline int get_hardsect_size(kdev_t dev)
Index: v2.4/include/linux/kernel_stat.h
diff -u v2.4/include/linux/kernel_stat.h:1.1.1.1
v2.4/include/linux/kernel_stat.h:1.1.1.1.4.1
--- v2.4/include/linux/kernel_stat.h:1.1.1.1 Sun Jan 13 15:50:24 2002
+++ v2.4/include/linux/kernel_stat.h Mon Feb 25 22:53:10 2002
@@ -19,11 +19,6 @@
  unsigned int per_cpu_user[NR_CPUS],
               per_cpu_nice[NR_CPUS],
               per_cpu_system[NR_CPUS];
- unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
- unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
- unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
- unsigned int dk_drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
- unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
  unsigned int pgpgin, pgpgout;
  unsigned int pswpin, pswpout;
 #if !defined(CONFIG_ARCH_S390)




begin 666 disk_io-stats.dat
M26YD97@Z('8R+C0O9')I=F5R<R]B;&]C:R]L;%]R=U]B;&LN8PID:69F("UU
M('8R+C0O9')I=F5R<R]B;&]C:R]L;%]R=U]B;&LN8SHQ+C$N,2XR('8R+C0O
M9')I=F5R<R]B;&]C:R]L;%]R=U]B;&LN8SHQ+C$N,2XR+C(N,0HM+2T@=C(N
M-"]D<FEV97)S+V)L;V-K+VQL7W)W7V)L:RYC.C$N,2XQ+C()36]N($9E8B R
M-2 R,3HU-#HT-2 R,# R"BLK*R!V,BXT+V1R:79E<G,O8FQO8VLO;&Q?<G=?
M8FQK+F,)36]N($9E8B R-2 R,CHU,SHQ," R,# R"D! ("TQ.#,L-R K,3@S
M+#$Q($! "B *( EI9B H8V]U;G0I"B )"7!R:6YT:R@B8FQK7V-L96%N=7!?
M<75E=64Z(&QE86ME9"!R97%U97-T<R H)60I7&XB+"!C;W5N="D["BT**PDO
M*@HK"2 J(&9R964@<W1A=&ES=&EC<R!S=')U8W1U<F4**PD@*B\**PEK9G)E
M92AQ+3YD:U]S=&%T*3L**PD*( EM96US970H<2P@,"P@<VEZ96]F*"IQ*2D[
M"B!]"B *0$ @+3,Y,RPV("LS.3<L."! 0 H@("HJ+PH@=F]I9"!B;&M?:6YI
M=%]Q=65U92AR97%U97-T7W%U975E7W0@*B!Q+"!R97%U97-T7V9N7W!R;V,@
M*B!R9FXI"B!["BL)<W1R=6-T(&1I<VM?<W1A=" J(&YE=SL)"BL*( E)3DE4
M7TQ)4U1?2$5!1"@F<2T^<75E=65?:&5A9"D["B )96QE=F%T;W)?:6YI="@F
M<2T^96QE=F%T;W(L($5,159!5$]27TQ)3E53*3L*( EB;&M?:6YI=%]F<F5E
M7VQI<W0H<2D["D! ("TT,3,L-B K-#$Y+#$U($! "B )("HO"B )<2T^<&QU
M9U]D979I8V5?9FX@"3T@9V5N97)I8U]P;'5G7V1E=FEC93L*( EQ+3YH96%D
M7V%C=&EV92 @(" )/2 Q.PHK"2\J( HK"2 J($%T(&QA<W0L(&%L;&]C871E
M(&%N9"!I;FET:6%L:7IE('1H92!S=&%T:7-T:6-S( HK"2 J+PHK"6YE=R ]
M(&MM86QL;V,H<VEZ96]F*'-T<G5C="!D:7-K7W-T870I+"!'1E!?2T523D5,
M*3L**PEI9B H;F5W(#T]($Y53$PI"BL)"7!R:6YT:RA+15).7T524B B8FQK
M7VEN:71?<75E=64Z97)R;W(@86QL;V-A=&EN9R!S=&%T:7-I=&-S7&XB*3L*
M*PEE;'-E"BL)"6UE;7-E="AN97<L(# L('-I>F5O9BAS=')U8W0@9&ES:U]S
M=&%T*2D["BL)<2T^9&M?<W1A=" ](&YE=SL*('T*( H@(V1E9FEN92!B;&MD
M979?9G)E95]R<2AL:7-T*2!L:7-T7V5N=')Y*"AL:7-T*2T^;F5X="P@<W1R
M=6-T(')E<75E<W0L('%U975E*3L*0$ @+30Y-RPR,R K-3$R+#$X($! "B )
M96QS92!R;U]B:71S6VUA:F]R75MM:6YO<B ^/B U72 F/2!^*#$@/#P@*&UI
M;F]R("8@,S$I*3L*('T*( HM:6YL:6YE('9O:60@9')I=F5?<W1A=%]A8V-T
M("AK9&5V7W0@9&5V+"!I;G0@<G<L"BMI;FQI;F4@=F]I9"!D<FEV95]S=&%T
M7V%C8W0@*'-T<G5C="!D:7-K7W-T870@*B!D<RP@:6YT(')W+ H@"0D)"75N
M<VEG;F5D(&QO;F<@;G)?<V5C=&]R<RP@:6YT(&YE=U]I;RD*('L*+0EU;G-I
M9VYE9"!I;G0@;6%J;W(@/2!-04I/4BAD978I.PHM"75N<VEG;F5D(&EN="!I
M;F1E>#L*+0HM"6EN9&5X(#T@9&ES:U]I;F1E>"AD978I.PHM"6EF("@H:6YD
M97@@/CT@1$M?34%87T1)4TLI('Q\("AM86IO<B ^/2!$2U]-05A?34%*3U(I
M*0HK"6EF("AD<R ]/2!.54Q,*0H@"0ER971U<FX["B *+0EK<W1A="YD:U]D
M<FEV95MM86IO<EU;:6YD97A=("L](&YE=U]I;SL*( EI9B H<G<@/3T@4D5!
M1"D@>PHM"0EK<W1A="YD:U]D<FEV95]R:6];;6%J;W)=6VEN9&5X72 K/2!N
M97=?:6\["BT)"6MS=&%T+F1K7V1R:79E7W)B;&M;;6%J;W)=6VEN9&5X72 K
M/2!N<E]S96-T;W)S.PHK"0ED<RT^9&M?9')I=F5?<FEO("L](&YE=U]I;SL*
M*PD)9',M/F1K7V1R:79E7W)B;&L@*ST@;G)?<V5C=&]R<SL*( E](&5L<V4@
M:68@*')W(#T](%=2251%*2!["BT)"6MS=&%T+F1K7V1R:79E7W=I;UMM86IO
M<EU;:6YD97A=("L](&YE=U]I;SL*+0D):W-T870N9&M?9')I=F5?=V)L:UMM
M86IO<EU;:6YD97A=("L](&YR7W-E8W1O<G,["BL)"61S+3YD:U]D<FEV95]W
M:6\@*ST@;F5W7VEO.PHK"0ED<RT^9&M?9')I=F5?=V)L:R K/2!N<E]S96-T
M;W)S.PH@"7T@96QS90H@"0EP<FEN=&LH2T523E]%4E(@(F1R:79E7W-T871?
M86-C=#H@8VUD(&YO="!2+U<_7&XB*3L*('T*0$ @+34R.2PW("LU,SDL-R! 
M0 H@<W1A=&EC(&EN;&EN92!V;VED(&%D9%]R97%U97-T*')E<75E<W1?<75E
M=65?=" J('$L('-T<G5C="!R97%U97-T("H@<F5Q+ H@"0D)(" @(" @('-T
M<G5C="!L:7-T7VAE860@*FEN<V5R=%]H97)E*0H@>PHM"61R:79E7W-T871?
M86-C="AR97$M/G)Q7V1E=BP@<F5Q+3YC;60L(')E<2T^;G)?<V5C=&]R<RP@
M,2D["BL)9')I=F5?<W1A=%]A8V-T*'$M/F1K7W-T870L(')E<2T^8VUD+"!R
M97$M/FYR7W-E8W1O<G,L(#$I.PH@"B ):68@*"%Q+3YP;'5G9V5D("8F('$M
M/FAE861?86-T:79E("8F(&EN<V5R=%]H97)E(#T]("9Q+3YQ=65U95]H96%D
M*2!["B )"7-P:6Y?=6YL;V-K7VER<2@F:6]?<F5Q=65S=%]L;V-K*3L*0$ @
M+3<P,RPW("LW,3,L-R! 0 H@"0D)<F5Q+3YB:'1A:6P@/2!B:#L*( D)"7)E
M<2T^;G)?<V5C=&]R<R ](')E<2T^:&%R9%]N<E]S96-T;W)S("L](&-O=6YT
M.PH@"0D)8FQK7W-T87)T961?:6\H8V]U;G0I.PHM"0D)9')I=F5?<W1A=%]A
M8V-T*')E<2T^<G%?9&5V+"!R97$M/F-M9"P@8V]U;G0L(# I.PHK"0D)9')I
M=F5?<W1A=%]A8V-T*'$M/F1K7W-T870L(')E<2T^8VUD+"!C;W5N="P@,"D[
M"B )"0EA='1E;7!T7V)A8VM?;65R9V4H<2P@<F5Q+"!M87A?<V5C=&]R<RP@
M;6%X7W-E9VUE;G1S*3L*( D)"6=O=&\@;W5T.PH@"D! ("TW,C L-R K-S,P
M+#<@0$ *( D)"7)E<2T^<V5C=&]R(#T@<F5Q+3YH87)D7W-E8W1O<B ]('-E
M8W1O<CL*( D)"7)E<2T^;G)?<V5C=&]R<R ](')E<2T^:&%R9%]N<E]S96-T
M;W)S("L](&-O=6YT.PH@"0D)8FQK7W-T87)T961?:6\H8V]U;G0I.PHM"0D)
M9')I=F5?<W1A=%]A8V-T*')E<2T^<G%?9&5V+"!R97$M/F-M9"P@8V]U;G0L
M(# I.PHK"0D)9')I=F5?<W1A=%]A8V-T*'$M/F1K7W-T870L(')E<2T^8VUD
M+"!C;W5N="P@,"D["B )"0EA='1E;7!T7V9R;VYT7VUE<F=E*'$L(&AE860L
M(')E<2P@;6%X7W-E8W1O<G,L(&UA>%]S96=M96YT<RD["B )"0EG;W1O(&]U
M=#L*( I);F1E>#H@=C(N-"]D<FEV97)S+VED92]I9&4N8PID:69F("UU('8R
M+C0O9')I=F5R<R]I9&4O:61E+F,Z,2XQ+C$N,B!V,BXT+V1R:79E<G,O:61E
M+VED92YC.C$N,2XQ+C(N,BXQ"BTM+2!V,BXT+V1R:79E<G,O:61E+VED92YC
M.C$N,2XQ+C()36]N($9E8B R-2 R,3HU-3HU,B R,# R"BLK*R!V,BXT+V1R
M:79E<G,O:61E+VED92YC"4UO;B!&96(@,C4@,C(Z-3,Z,3 @,C P,@I 0" M
M,30U-"PX("LQ-#4T+#$P($! "B!R97%U97-T7W%U975E7W0@*FED95]G971?
M<75E=64@*&MD979?="!D978I"B!["B ):61E7VAW:69?=" J:'=I9B ]("AI
M9&5?:'=I9E]T("HI8FQK7V1E=EM-04I/4BAD978I72YD871A.PHM"BT)<F5T
M=7)N("9H=VEF+3YD<FEV97-;1$5624-%7TY2*&1E=BD@)B Q72YQ=65U93L*
M*PEI9B H1$5624-%7TY2*&1E=BD@/CT@34%87T12259%4RD**PD)(')E='5R
M;B!.54Q,.PHK"65L<V4@"BL)"7)E='5R;B F:'=I9BT^9')I=F5S6T1%5DE#
M15].4BAD978I72YQ=65U93L*('T*( H@+RH*26YD97@Z('8R+C0O9')I=F5R
M<R]M9"]M9"YC"F1I9F8@+74@=C(N-"]D<FEV97)S+VUD+VUD+F,Z,2XQ+C$N
M,B!V,BXT+V1R:79E<G,O;60O;60N8SHQ+C$N,2XR+C(N,0HM+2T@=C(N-"]D
M<FEV97)S+VUD+VUD+F,Z,2XQ+C$N,@E-;VX@1F5B(#(U(#(Q.C4U.C4U(#(P
M,#(**RLK('8R+C0O9')I=F5R<R]M9"]M9"YC"4UO;B!&96(@,C4@,C(Z-3,Z
M,3 @,C P,@I 0" M,S,P."PQ,B K,S,P."PQ-2! 0 H@"4E415)!5$5?4D1%
M5BAM9&1E=BQR9&5V+'1M<"D@>PH@"0EI;G0@;6%J;W(@/2!-04I/4BAR9&5V
M+3YD978I.PH@"0EI;G0@:61X(#T@9&ES:U]I;F1E>"AR9&5V+3YD978I.PHM
M"BL)"7)E<75E<W1?<75E=65?=" J(')Q(#T@8FQK7V=E=%]Q=65U92AR9&5V
M+3YD978I.PHK"0D*( D):68@*"AI9'@@/CT@1$M?34%87T1)4TLI('Q\("AM
M86IO<B ^/2!$2U]-05A?34%*3U(I*0H@"0D)8V]N=&EN=64["BT*+0D)8W5R
M<E]E=F5N=',@/2!K<W1A="YD:U]D<FEV95]R8FQK6VUA:F]R75MI9'A=("L*
M+0D)"0D)"6MS=&%T+F1K7V1R:79E7W=B;&M;;6%J;W)=6VED>%T@.PHK"0D*
M*PD):68@*')Q(#T]($Y53$P@?'P@*')Q+3YD:U]S=&%T(#T]($Y53$PI*0HK
M"0D)8V]N=&EN=64["BL)"6-U<G)?979E;G1S(#T@<G$M/F1K7W-T870M/F1K
M7V1R:79E7W)B;&L@*R **PD)"7)Q+3YD:U]S=&%T+3YD:U]D<FEV95]W8FQK
M(#L*( D)8W5R<E]E=F5N=',@+3T@<WEN8U]I;UMM86IO<EU;:61X73L*( D)
M:68@*"AC=7)R7V5V96YT<R M(')D978M/FQA<W1?979E;G1S*2 ^(#,R*2![
M"B )"0ER9&5V+3YL87-T7V5V96YT<R ](&-U<G)?979E;G1S.PI);F1E>#H@
M=C(N-"]F<R]P<F]C+W!R;V-?;6ES8RYC"F1I9F8@+74@=C(N-"]F<R]P<F]C
M+W!R;V-?;6ES8RYC.C$N,2XQ+C$@=C(N-"]F<R]P<F]C+W!R;V-?;6ES8RYC
M.C$N,2XQ+C$N-"XQ"BTM+2!V,BXT+V9S+W!R;V,O<')O8U]M:7-C+F,Z,2XQ
M+C$N,0E3=6X@2F%N(#$S(#$U.C4P.C(P(#(P,#(**RLK('8R+C0O9G,O<')O
M8R]P<F]C7VUI<V,N8PE-;VX@1F5B(#(U(#(R.C4S.C$P(#(P,#(*0$ @+3,V
M+#$R("LS-BPQ,B! 0 H@(VEN8VQU9&4@/&QI;G5X+VEN:70N:#X*("-I;F-L
M=61E(#QL:6YU>"]S;7!?;&]C:RYH/@H@(VEN8VQU9&4@/&QI;G5X+W-E<5]F
M:6QE+F@^"BLC:6YC;'5D92 \;&EN=7@O8FQK9&5V+F@^"B *("-I;F-L=61E
M(#QA<VTO=6%C8V5S<RYH/@H@(VEN8VQU9&4@/&%S;2]P9W1A8FQE+F@^"B C
M:6YC;'5D92 \87-M+VEO+F@^"B *+0H@(V1E9FEN92!,3T%$7TE.5"AX*2 H
M*'@I(#X^($932$E&5"D*("-D969I;F4@3$]!1%]&4D%#*'@I($Q/041?24Y4
M*"@H>"D@)B H1DE8141?,2TQ*2D@*B Q,# I"B O*@I 0" M,C,T+#<@*S(S
M-"PR,R! 0 H@"7)E;&5A<V4Z"7-E<5]R96QE87-E+ H@?3L*("-E;F1I9@HM
M"BMS=&%T:6,@:6YT('-H;W=?9&ES:U]S=&%T*&-H87(@*B!P86=E+"!I;G0@
M;&5N+"!S=')U8W0@9&ES:U]S=&%T("H@9',L"BL)"0D)"6EN="!M86IO<BP@
M:6YT(&1I<VLI"BM["BL):6YT(&%C=&EV92 ](&1S+3YD:U]D<FEV95]R:6\@
M*R!D<RT^9&M?9')I=F5?=VEO("L**PD)(&1S+3YD:U]D<FEV95]R8FQK("L@
M9',M/F1K7V1R:79E7W=B;&L["BL):68@*&%C=&EV92D**PD);&5N("L]('-P
M<FEN=&8H<&%G92 K(&QE;BP**PD)"2(H)74L)74I.B@E=2PE=2PE=2PE=2PE
M=2D@(BP**PD)"6UA:F]R+"!D:7-K+ HK"0D)9',M/F1K7V1R:79E7W)I;R K
M(&1S+3YD:U]D<FEV95]W:6\L"BL)"0ED<RT^9&M?9')I=F5?<FEO+ HK"0D)
M9',M/F1K7V1R:79E7W)B;&LL"BL)"0ED<RT^9&M?9')I=F5?=VEO+ HK"0D)
M9',M/F1K7V1R:79E7W=B;&L**PD)*3L**PER971U<FX@;&5N.PHK?0H@<W1A
M=&EC(&EN="!K<W1A=%]R96%D7W!R;V,H8VAA<B J<&%G92P@8VAA<B J*G-T
M87)T+"!O9F9?="!O9F8L"B )"0D)(&EN="!C;W5N="P@:6YT("IE;V8L('9O
M:60@*F1A=&$I"B!["D! ("TR.#0L,C$@*S,P,"PS,"! 0 H@"B );&5N("L]
M('-P<FEN=&8H<&%G92 K(&QE;BP@(EQN9&ES:U]I;SH@(BD["B *+0EF;W(@
M*&UA:F]R(#T@,#L@;6%J;W(@/"!$2U]-05A?34%*3U([(&UA:F]R*RLI('L*
M+0D)9F]R("AD:7-K(#T@,#L@9&ES:R \($1+7TU!6%]$25-+.R!D:7-K*RLI
M('L*+0D)"6EN="!A8W1I=F4@/2!K<W1A="YD:U]D<FEV95MM86IO<EU;9&ES
M:UT@*PHM"0D)"6MS=&%T+F1K7V1R:79E7W)B;&M;;6%J;W)=6V1I<VM=("L*
M+0D)"0EK<W1A="YD:U]D<FEV95]W8FQK6VUA:F]R75MD:7-K73L*+0D)"6EF
M("AA8W1I=F4I"BT)"0D);&5N("L]('-P<FEN=&8H<&%G92 K(&QE;BP*+0D)
M"0D)(B@E=2PE=2DZ*"5U+"5U+"5U+"5U+"5U*2 B+ HM"0D)"0EM86IO<BP@
M9&ES:RP*+0D)"0D):W-T870N9&M?9')I=F5;;6%J;W)=6V1I<VM=+ HM"0D)
M"0EK<W1A="YD:U]D<FEV95]R:6];;6%J;W)=6V1I<VM=+ HM"0D)"0EK<W1A
M="YD:U]D<FEV95]R8FQK6VUA:F]R75MD:7-K72P*+0D)"0D):W-T870N9&M?
M9')I=F5?=VEO6VUA:F]R75MD:7-K72P*+0D)"0D):W-T870N9&M?9')I=F5?
M=V)L:UMM86IO<EU;9&ES:UT*+0D)"2D["BL)9F]R("AM86IO<B ](# [(&UA
M:F]R(#P@34%87T),2T1%5CL@;6%J;W(K*RD@>PHK"0ES=')U8W0@9&ES:U]S
M=&%T("H@9',["BL)"0HK"0EI9B H(2AB;&M?9&5V6VUA:F]R72YQ=65U92DI
M>PHK"0D)9',@/2 H0DQ+7T1%1D%53%1?455%544H;6%J;W(I*2T^9&M?<W1A
M=#L**PD)"6EF("AD<RD**PD)"0EL96X@/2!S:&]W7V1I<VM?<W1A="AP86=E
M+"!L96XL(&1S+"!M86IO<BP@,"D["BL)"7UE;'-E('L**PD)"7)E<75E<W1?
M<75E=65?=" J('$["BL)"0ES=')U8W0@9V5N9&ES:R J(&AD(#T@9V5T7V=E
M;F1I<VLH34M$158H;6%J;W(L,"DI.PHK"0D):6YT(&UA>%]D:7-K.PHK"0D)
M:68@*"%H9"D**PD)"0EC;VYT:6YU93L**PD)"6UA>%]D:7-K(#T@34E.3U)-
M05-+/CYH9"T^;6EN;W)?<VAI9G0["BL**PD)"69O<B H9&ES:R ](# [(&1I
M<VL@/#T@;6%X7V1I<VL[(&1I<VLK*RD@>PHK"0D)"7$@/2!B;&M?9V5T7W%U
M975E*$U+1$56*&UA:F]R+&1I<VL\/&AD+3YM:6YO<E]S:&EF="DI.PHK"0D)
M"6EF("@A<2D@"BL)"0D)"6-O;G1I;G5E.PHK"0D)"61S(#T@<2T^9&M?<W1A
M=#L**PD)"0EI9B H(61S*0HK"0D)"0EC;VYT:6YU93L**PD)"0EL96X@/2!S
M:&]W7V1I<VM?<W1A="AP86=E+"!L96XL(&1S+"!M86IO<BQD:7-K*3L**PD)
M"7T*( D)?0H@"7T*( I);F1E>#H@=C(N-"]I;F-L=61E+VQI;G5X+V)L:V1E
M=BYH"F1I9F8@+74@=C(N-"]I;F-L=61E+VQI;G5X+V)L:V1E=BYH.C$N,2XQ
M+C$@=C(N-"]I;F-L=61E+VQI;G5X+V)L:V1E=BYH.C$N,2XQ+C$N-"XQ"BTM
M+2!V,BXT+VEN8VQU9&4O;&EN=7@O8FQK9&5V+F@Z,2XQ+C$N,0E3=6X@2F%N
M(#$S(#$U.C4P.C(T(#(P,#(**RLK('8R+C0O:6YC;'5D92]L:6YU>"]B;&MD
M978N: E-;VX@1F5B(#(U(#(R.C4S.C$P(#(P,#(*0$ @+3<Q+#8@*S<Q+#$S
M($! "B )<W1R=6-T(&QI<W1?:&5A9"!F<F5E.PH@?3L*( HK<W1R=6-T(&1I
M<VM?<W1A='L**PEU;G-I9VYE9"!I;G0@9&M?9')I=F5?<FEO.PHK"75N<VEG
M;F5D(&EN="!D:U]D<FEV95]W:6\["BL)=6YS:6=N960@:6YT(&1K7V1R:79E
M7W)B;&L["BL)=6YS:6=N960@:6YT(&1K7V1R:79E7W=B;&L["BM].PHK"B!S
M=')U8W0@<F5Q=65S=%]Q=65U90H@>PH@"2\J"D! ("TQ,C(L-B K,3(Y+#$P
M($! "B )("H@5&%S:W,@=V%I="!H97)E(&9O<B!F<F5E(')E<75E<W0*( D@
M*B\*( EW86ET7W%U975E7VAE861?= EW86ET7V9O<E]R97%U97-T.PHK"2\J
M"BL)("H@<W1A=&ES=&EC<PHK"2 J+PHK"7-T<G5C="!D:7-K7W-T870@*B!D
M:U]S=&%T.PH@?3L*( H@<W1R=6-T(&)L:U]D979?<W1R=6-T('L*0$ @+3$X
M-BPW("LQ.3<L-R! 0 H@(V1E9FEN92!B;&MD979?;F5X=%]R97%U97-T*')E
M<2D@8FQK9&5V7V5N=')Y7W1O7W)E<75E<W0H*')E<2DM/G%U975E+FYE>'0I
M"B C9&5F:6YE(&)L:V1E=E]P<F5V7W)E<75E<W0H<F5Q*2!B;&MD979?96YT
M<GE?=&]?<F5Q=65S="@H<F5Q*2T^<75E=64N<')E=BD*( HM97AT97)N('9O
M:60@9')I=F5?<W1A=%]A8V-T("AK9&5V7W0@9&5V+"!I;G0@<G<L"BME>'1E
M<FX@=F]I9"!D<FEV95]S=&%T7V%C8W0@*'-T<G5C="!D:7-K7W-T870@*BP@
M:6YT(')W+ H@"0D)"0EU;G-I9VYE9"!L;VYG(&YR7W-E8W1O<G,L(&EN="!N
M97=?:6\I.PH@"B!S=&%T:6,@:6YL:6YE(&EN="!G971?:&%R9'-E8W1?<VEZ
M92AK9&5V7W0@9&5V*0I);F1E>#H@=C(N-"]I;F-L=61E+VQI;G5X+VME<FYE
M;%]S=&%T+F@*9&EF9B M=2!V,BXT+VEN8VQU9&4O;&EN=7@O:V5R;F5L7W-T
M870N:#HQ+C$N,2XQ('8R+C0O:6YC;'5D92]L:6YU>"]K97)N96Q?<W1A="YH
M.C$N,2XQ+C$N-"XQ"BTM+2!V,BXT+VEN8VQU9&4O;&EN=7@O:V5R;F5L7W-T
M870N:#HQ+C$N,2XQ"5-U;B!*86X@,3,@,34Z-3 Z,C0@,C P,@HK*RL@=C(N
M-"]I;F-L=61E+VQI;G5X+VME<FYE;%]S=&%T+F@)36]N($9E8B R-2 R,CHU
M,SHQ," R,# R"D! ("TQ.2PQ,2 K,3DL-B! 0 H@"75N<VEG;F5D(&EN="!P
M97)?8W!U7W5S97);3E)?0U!54UTL"B )(" @(" @(" @(" @('!E<E]C<'5?
M;FEC95M.4E]#4%5372P*( D@(" @(" @(" @(" @<&5R7V-P=5]S>7-T96U;
M3E)?0U!54UT["BT)=6YS:6=N960@:6YT(&1K7V1R:79E6T1+7TU!6%]-04I/
M4EU;1$M?34%87T1)4TM=.PHM"75N<VEG;F5D(&EN="!D:U]D<FEV95]R:6];
M1$M?34%87TU!2D]275M$2U]-05A?1$E32UT["BT)=6YS:6=N960@:6YT(&1K
M7V1R:79E7W=I;UM$2U]-05A?34%*3U)=6T1+7TU!6%]$25-+73L*+0EU;G-I
M9VYE9"!I;G0@9&M?9')I=F5?<F)L:UM$2U]-05A?34%*3U)=6T1+7TU!6%]$
M25-+73L*+0EU;G-I9VYE9"!I;G0@9&M?9')I=F5?=V)L:UM$2U]-05A?34%*
M3U)=6T1+7TU!6%]$25-+73L*( EU;G-I9VYE9"!I;G0@<&=P9VEN+"!P9W!G
M;W5T.PH@"75N<VEG;F5D(&EN="!P<W=P:6XL('!S=W!O=70["B C:68@(61E
89FEN960H0T].1DE'7T%20TA?4S,Y,"D*
`
end

