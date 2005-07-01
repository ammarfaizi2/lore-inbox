Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263371AbVGAPbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbVGAPbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 11:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbVGAPbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 11:31:00 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:24780 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263371AbVGAPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 11:30:03 -0400
MIME-Version: 1.0
Date: Fri,  1 Jul 2005 17:29:38 +0200
To: paul@paulbristow.net
X-UMS: email
X-Mailer: TOI Kommunikationscenter V5-1
Subject: PATCH for ide_floppy
Cc: linux-kernel@vger.kernel.org, manfred.scherer@siemens.com
From: "Manfred.Scherer.Mhm@t-online.de" <Manfred.Scherer.Mhm@t-online.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1DoNSU-0kLq880@fwd18.aul.t-online.de>
X-ID: XK04-sZewefz4TpSz4f-Xyk7S6mqe4WbCf1cX-1ASly9n4asizGhkG@t-dialin.net
X-TOI-MSGID: 9cc43594-e406-467e-8369-a59cba17fddf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

The runtime for copy of two 50MB files to a IOMEGA-100-Zip-IDE-device
seems to be not
deterministic since Linux Kernel 2.6.x. 

A lot of runtime will be spent to waiting for IO. 'top -i' will show
this:

top - 03:54:23 up 37 min,  9 users,  load average: 1.28, 1.52, 0.99
Tasks:  90 total,   1 running,  89 sleeping,   0 stopped,   0 zombie
Cpu(s):  3.6% us,  1.0% sy,  0.0% ni,  0.0% id, 95.0% wa,  0.3% hi, 
0.0% si
Mem:    190836k total,   189416k used,     1420k free,    10796k buffers
Swap:   529912k total,     4288k used,   525624k free,    99364k cached


  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5649 root      17   0  1968  944 1764 R  0.3  0.5   0:01.47 top
 5672 root      24   0  1648  524 1492 D  0.0  0.3   0:00.18 umount

... umount is pending with "95.0% wa"


The tests will be done with a small shell script cpzip.sh similar to
this:

mount /dev/hdd4 /dzip 
rm /dzip/*.cgz
cp -p $* /dzip
umount /dzip 
eject /dzip

__________________________________
files:
-rw-r--r--  1 root root 50167808 Jun 19 19:17 0_LW_1_ux.cgz
-rw-r--r--  1 root root 50167808 Jun 19 19:18 0_LW_2_ux.cgz


measured runtimes:

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    9m18.486s
user    0m0.042s
sys     0m2.450s
pc1:/scm/save_a/wcb #      

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    4m24.953s
user    0m0.036s
sys     0m2.584s
pc1:/scm/save_a/wcb #        

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    22m50.351s
user    0m0.047s
sys     0m2.789s
pc1:/scm/save_a/wcb #  

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    17m44.786s
user    0m0.048s
sys     0m2.758s
pc1:/scm/save_a/wcb #  

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    5m11.958s
user    0m0.051s
sys     0m2.558s
pc1:/scm/save_a/wcb #      

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    19m37.694s
user    0m0.043s
sys     0m2.821s
pc1:/scm/save_a/wcb #  

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    32m9.964s
user    0m0.047s
sys     0m2.766s
pc1:/scm/save_a/wcb #   

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    6m26.194s
user    0m0.041s
sys     0m2.517s
pc1:/scm/save_a/wcb #            

______________________
runtimes after applying my patch:

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    6m15.780s
user    0m0.057s
sys     0m2.212s
pc1:/scm/save_a/wcb # 

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    5m54.664s
user    0m0.035s
sys     0m2.287s
pc1:/scm/save_a/wcb # 

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    5m55.325s
user    0m0.041s
sys     0m2.330s
pc1:/scm/save_a/wcb #    

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    6m9.513s
user    0m0.040s
sys     0m2.352s
pc1:/scm/save_a/wcb #  

pc1:/scm/save_a/wcb # time ./cpzip.sh 0_LW_1_ux.cgz 0_LW_2_ux.cgz
real    6m24.069s
user    0m0.052s
sys     0m2.322s
pc1:/scm/save_a/wcb # 

_________________________________________________________________

Patch:

--- linux-2.6.12/drivers/ide/ide.c.ORIG 2005-06-17 21:48:29.000000000
+0200
+++ linux-2.6.12/drivers/ide/ide.c      2005-06-25 03:55:28.000000000
+0200
@@ -240,6 +240,7 @@
                drive->name[0]                  = 'h';
                drive->name[1]                  = 'd';
                drive->name[2]                  = 'a' + (index *
MAX_DRIVES) + unit;
+               drive->failures                 = 0;    /* --ms
2004/12/29 */
                drive->max_failures             =
IDE_DEFAULT_MAX_FAILURES;
                drive->using_dma                = 0;
                drive->is_flash                 = 0;


--- linux-2.6.12/drivers/ide/ide-floppy.c.ORIG  2005-06-17
21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/ide/ide-floppy.c       2005-06-25
03:29:45.000000000 +0200
@@ -125,7 +125,14 @@
 /*
  *     Some drives require a longer irq timeout.
  */
+#if 0
 #define IDEFLOPPY_WAIT_CMD             (5 * WAIT_CMD)
+#endif
+#if 0
+#define IDEFLOPPY_WAIT_CMD             200     /* --ms  */
+#endif
+#define IDEFLOPPY_WAIT_CMD             WAIT_CMD        /* 2004/12/31
--ms */
+

 /*
  *     After each failed packet command we issue a request sense
command
@@ -317,7 +324,13 @@
        unsigned long flags;
 } idefloppy_floppy_t;

+#if 0
 #define IDEFLOPPY_TICKS_DELAY  3       /* default delay for ZIP 100 */
+#define IDEFLOPPY_TICKS_DELAY  6       /* default delay for ZIP 100
--ms 2005/01/01 */
+#define IDEFLOPPY_TICKS_DELAY  12      /* default delay for ZIP 100
--ms 2005/01/01 */
+#endif
+#define IDEFLOPPY_TICKS_DELAY  60      /* default delay for ZIP 100
--ms 2005/01/07 */
+

 /*
  *     Floppy flag bits values.
@@ -774,6 +787,35 @@
        pc->callback = &idefloppy_pc_callback;
 }

+/*
+ *     Similar to ide-cd.c     2004/12/31 --ms
+ */
+static int idefloppy_timer_expiry(ide_drive_t *drive)
+{
+       struct request *rq = HWGROUP(drive)->rq;
+       unsigned long wait = 0;
+
+       /*
+        * Some commands are *slow* and normally take a long time to
+        * complete. Usually we can use the ATAPI "disconnect" to bypass
+        * this, but not all commands/drives support that. Let
+        * ide_timer_expiry keep polling us for these.
+        */
+       switch (rq->cmd[0]) {
+               case GPCMD_BLANK:
+               case GPCMD_FORMAT_UNIT:
+               case GPCMD_FLUSH_CACHE:
+                       wait = IDEFLOPPY_WAIT_CMD;
+                       break;
+               default:
+                       if (!(rq->flags & REQ_QUIET))
+                               printk(KERN_INFO "ide-floppy: cmd 0x%x
timed out\n", rq->cmd[0]);
+                       wait = 0;
+                       break;
+       }
+       return wait;
+}
+
 static void idefloppy_create_request_sense_cmd (idefloppy_pc_t *pc)
 {
        idefloppy_init_pc(pc);
@@ -900,7 +942,7 @@
                                ide_set_handler(drive,
                                                &idefloppy_pc_intr,
                                                IDEFLOPPY_WAIT_CMD,
-                                               NULL);
+                                               idefloppy_timer_expiry
/* NULL --ms */);
                                return ide_started;
                        }
                        debug_log(KERN_NOTICE "ide-floppy: The floppy
wants to "
@@ -931,7 +973,10 @@

        if (HWGROUP(drive)->handler != NULL)
                BUG();
-       ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD,
NULL);           /* And set the interrupt handler again */
+       /* And set the interrupt handler again */
+       ide_set_handler(drive, &idefloppy_pc_intr,
+                               IDEFLOPPY_WAIT_CMD,
+                               idefloppy_timer_expiry /* NULL --ms */);
        return ide_started;
 }

@@ -960,7 +1005,9 @@
        if (HWGROUP(drive)->handler != NULL)
                BUG();
        /* Set the interrupt routine */
-       ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD,
NULL);
+       ide_set_handler(drive, &idefloppy_pc_intr,
+                               IDEFLOPPY_WAIT_CMD,
+                               idefloppy_timer_expiry /* NULL --ms */);
        /* Send the actual packet */
        HWIF(drive)->atapi_output_bytes(drive, floppy->pc->c, 12);
        return ide_started;
@@ -1116,6 +1163,7 @@
        }

        /* Can we transfer the packet when we get the interrupt or wait?
*/
+/* 2005/01/01 --ms, this is really necessary! */
        if (test_bit(IDEFLOPPY_ZIP_DRIVE, &floppy->flags)) {
                /* wait */
                pkt_xfer_routine = &idefloppy_transfer_pc1;
@@ -1129,7 +1177,7 @@
                ide_execute_command(drive, WIN_PACKETCMD,
                                pkt_xfer_routine,
                                IDEFLOPPY_WAIT_CMD,
-                               NULL);
+                               idefloppy_timer_expiry /* NULL --ms */);
                return ide_started;
        } else {
                /* Issue the packet command */



Signed-off-by: Manfred Scherer <manfred.scherer.mhm@t-online.de>
___________________________________________________________________
My system is:

pc1:~ # uname -a
Linux pc1 2.6.12 #2 Sat Jun 25 04:02:24 CEST 2005 i686 athlon i386
GNU/Linux
pc1:~ #

pc1:~ # grep -i iomega /var/log/boot.msg
<4>hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive


pc1:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 2
cpu MHz         : 1000.250


	

EOF



