Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317846AbSGKXjC>; Thu, 11 Jul 2002 19:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317853AbSGKXjB>; Thu, 11 Jul 2002 19:39:01 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:32504 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S317846AbSGKXiy>; Thu, 11 Jul 2002 19:38:54 -0400
Message-Id: <5.1.0.14.2.20020712093649.02581990@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 12 Jul 2002 09:40:30 +1000
To: Jesse Barnes <jbarnes@sgi.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: direct-to-BIO for O_DIRECT
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020711195221.GA709012@sgi.com>
References: <5.1.0.14.2.20020711122101.021a5590@mira-sjcm-3.cisco.com>
 <3D2904C5.53E38ED4@zip.com.au>
 <5.1.0.14.2.20020711122101.021a5590@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:52 PM 11/07/2002 -0700, Jesse Barnes wrote:
>On Thu, Jul 11, 2002 at 12:25:03PM +1000, Lincoln Dale wrote:
> > sorry for the delay.
> > upgrading from 2.4.19 to 2.5.25 took longer than expected, since the
> > QLogic FC 2300 HBA driver isn't part of the standard kernel, and i
> > had to update it to reflect the io_request_lock -> host->host_lock,
> > kdev_t and kbuild changes.  urgh, pain pain pain.  in the process, i
> > discovered some races in their driver, so fixed them also.
>
>So you ported the qla2x00 driver forward to 2.5?  Would it be possible
>to post that driver?  Not having it has held up some testing I'd like
>to do...

these are the changes to the qla2x00 6.1 beta 2 driver, as downloadable 
from the QLogic web-site.

there were also some changes required to the makefiles to get this working 
with linux-2.5 kbuild infrastructure.
the hacks i did there are awful and i'm not prepared to put my name against 
those bad hacks just yet. :-)

===
diff -urN base/listops.h 2.5.25/listops.h
--- base/listops.h      Tue Apr 16 05:15:40 2002
+++ 2.5.25/listops.h    Fri Jul 12 09:29:45 2002
@@ -324,9 +324,9 @@
                  return;
          }

-        spin_lock_irqsave(&io_request_lock, flags);
+        spin_lock_irqsave(ha->host->host_lock, flags);
          qla2x00_callback(ha, sp->cmd);
-        spin_unlock_irqrestore(&io_request_lock, flags);
+        spin_unlock_irqrestore(ha->host->host_lock, flags);
  }

  /**************************************************************************
diff -urN base/qla2x00.c 2.5.25/qla2x00.c
--- base/qla2x00.c      Wed Jul 10 18:32:25 2002
+++ 2.5.25/qla2x00.c    Fri Jul 12 09:29:51 2002
@@ -532,10 +532,11 @@
  static int recoveryTime = MAX_RECOVERYTIME;
  static int failbackTime = MAX_FAILBACKTIME;
  #endif /* end of MPIO_SUPPORT */
-#ifdef MODULE
+
  static char *ql2xopts = NULL;
  static int ql2xmaxqdepth = 0;

+#ifdef MODULE
  /* insmod qla2100 ql2xopts=verbose" */
  MODULE_PARM(ql2xopts, "s");
  MODULE_PARM(ql2xmaxqdepth, "i");
@@ -552,7 +553,6 @@
          MODULE_LICENSE("GPL");
  #endif

-#include "listops.h"
  #include "qla_fo.cfg"


@@ -564,6 +564,7 @@
  static char dummy_buffer[60] = "Please don't add commas in your insmod 
command!!\n";

  #endif
+#include "listops.h"

  #if QLA2100_LIPTEST
  static int qla2x00_lip = 0;
@@ -1459,10 +1460,6 @@

         ENTER("qla2x00_detect");

-#if NEW_EH_CODE
-       spin_unlock_irq(&io_request_lock);
-#endif
-
  #ifdef MODULE
         DEBUG2(printk("DEBUG: qla2x00_set_info starts at address = %p\n",
                         qla2x00_set_info);)
@@ -1497,9 +1494,6 @@

         if (!pci_present()) {
                 printk("scsi: PCI not present\n");
-#if NEW_EH_CODE
-               spin_lock_irq(&io_request_lock);
-#endif
                 return 0;
         } /* end of !pci_present() */

@@ -1542,9 +1536,6 @@
                            continue;
                            }
                          */
-#if NEW_EH_CODE
-                       spin_lock_irq(&io_request_lock);
-#endif

                         if ((host =
                                 scsi_register(
@@ -1609,9 +1600,6 @@
                                         "scsi%d: [ERROR] Failed to allocate "
                                         "memory for adapter\n",host->host_no);
                                 qla2x00_mem_free(ha);
-#if NEW_EH_CODE
-                               spin_unlock_irq(&io_request_lock);
-#endif
                                 continue;
                         }

@@ -1654,10 +1642,6 @@

                         ha->list_lock = SPIN_LOCK_UNLOCKED;

-#if NEW_EH_CODE
-                       spin_unlock_irq(&io_request_lock);
-#endif
-
                         if (qla2x00_initialize_adapter(ha) &&
                                 !(ha->device_flags & DFLG_NO_CABLE)) {

@@ -1706,8 +1690,7 @@
                         ha->fabricid[SIMPLE_NAME_SERVER].in_use = TRUE;

  #if NEW_EH_CODE
-
-                       spin_lock_irq(&io_request_lock);
+                       spin_lock_irq(host->host_lock);
  #endif

                         /* Register our resources with Linux */
@@ -1719,7 +1702,7 @@
                                 qla2x00_mem_free(ha);
                                 scsi_unregister(host);
  #if NEW_EH_CODE
-                               spin_unlock_irq(&io_request_lock);
+                               spin_unlock_irq(host->host_lock);
  #endif
                                 continue;
                         }
@@ -1741,7 +1724,7 @@
                         spin_unlock_irqrestore(&ha->hardware_lock, flags);

  #if NEW_EH_CODE
-                       spin_unlock_irq(&io_request_lock);
+                       spin_unlock_irq(host->host_lock);
  #endif

  #if MPIO_SUPPORT
@@ -1805,10 +1788,6 @@
                 }
         } /* end of FOR */

-#if NEW_EH_CODE
-       spin_lock_irq(&io_request_lock);
-#endif
-
         LEAVE("qla2x00_detect");

         return num_hosts;
@@ -2217,7 +2196,7 @@
         ha = (scsi_qla_host_t *) host->hostdata;

         cmd->scsi_done = fn;
-       spin_unlock(&io_request_lock);
+       spin_unlock(host->host_lock);

         /* Allocate a command packet from the "sp" pool.
          * If we cant get back one then let scsi layer
@@ -2227,7 +2206,7 @@
                 printk(KERN_WARNING
                         "queuecommand: Couldn't allocate memory "
                         "for sp - retried.\n");
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(host->host_lock);

                 LEAVE("qla2x00_queuecommand");
                 return(1);
@@ -2309,14 +2288,14 @@
                                 (int)ha->host_no,t,l);)

                 CMD_RESULT(cmd) = DID_NO_CONNECT << 16;
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(host->host_lock);
                 __sp_put(ha, sp);
                 return(0);
         }

         if (l >= ha->max_luns) {
                 CMD_RESULT(cmd) = DID_NO_CONNECT << 16;
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(host->host_lock);
                 __sp_put(ha, sp);
                 LEAVE("qla2x00_queuecommand");
                 return(0);
@@ -2379,7 +2358,7 @@
                 tasklet_schedule(&ha->run_qla_task);

                 LEAVE("qla2x00_queuecommand");
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(host->host_lock);
                 return (0);
         }

@@ -2427,7 +2406,7 @@
                 qla2x00_extend_timeout(sp->cmd ,60);

                 LEAVE("qla2x00_queuecommand");
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(host->host_lock);
                 return (0);
         } else {
                 sp->flags &= ~SRB_BUSY;   /* v5.21b16 */
@@ -2449,7 +2428,7 @@
                 add_to_scsi_retry_queue(ha,sp);

                 LEAVE("qla2x00_queuecommand");
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(host->host_lock);
                 return (0);
         }

@@ -2462,7 +2441,7 @@

         COMTRACE('c')
         LEAVE("qla2x00_queuecommand");
-       spin_lock_irq(&io_request_lock);
+       spin_lock_irq(host->host_lock);
         return (0);
  }

@@ -2526,10 +2505,10 @@
                         break;


-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);
                 set_current_state(TASK_INTERRUPTIBLE);
                 schedule_timeout(2*HZ);
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);

         } while (time_before_eq(jiffies, max_wait_time));

@@ -2811,7 +2790,7 @@
                         sp_get(ha,sp);

                         spin_unlock_irqrestore(&ha->hardware_lock, flags);
-                       spin_unlock(&io_request_lock);
+                       spin_unlock(host->host_lock);

                         if (qla2x00_abort_command(ha, sp)) {
                                 DEBUG2(printk("qla2xxx_eh_abort: 
abort_command "
@@ -2825,7 +2804,7 @@
                         }

                         sp_put(ha,sp);
-                       spin_lock_irq(&io_request_lock);
+                       spin_lock_irq(host->host_lock);
                         spin_lock_irqsave(&ha->hardware_lock, flags);

                         /*
@@ -2862,15 +2841,15 @@
          */
         if ((which_ha & BIT_0) && (!list_empty(&ha->done_queue))) {
                 DEBUG3(printk("qla2xxx_eh_abort: calling done for ha.\n");)
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(host->host_lock);
                 qla2x00_done(ha);
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(host->host_lock);
         }
         if ((which_ha & BIT_1) && (!list_empty(&vis_ha->done_queue))) {
                 DEBUG3(printk("qla2xxx_eh_abort: calling done for 
vis_ha.\n");)
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(host->host_lock);
                 qla2x00_done(vis_ha);
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(host->host_lock);
         }

         DEBUG(printk("qla2xxx_eh_abort: Exiting. return_status=0x%x.\n",
@@ -2975,22 +2954,22 @@
                 ha->cfg_active || ha->loop_state != LOOP_READY)) {

                 clear_bit(DEVICE_RESET_NEEDED, &ha->dpc_flags);
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);
                 if (qla2x00_device_reset(ha, t) != 0) {
                         return_status = FAILED;
                 }
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);
         } else {
                 /*
                  * Wait a while for the loop to come back. Return SUCCESS
                  * for the kernel to try again.
                  */
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);

                 set_current_state(TASK_INTERRUPTIBLE);
                 schedule_timeout(5 * HZ);

-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);

                 return_status = SUCCESS;
         }
@@ -3010,9 +2989,9 @@
                 DEBUG3(printk("qla2xxx_eh_device_reset: calling "
                                 "done for ha.\n");)

-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);
                 qla2x00_done(ha);
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);
         }

         DRIVER_UNLOCK
@@ -3114,22 +3093,22 @@
                 ha->cfg_active || ha->loop_state != LOOP_READY)) {

                 clear_bit(LOOP_RESET_NEEDED, &ha->dpc_flags);
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);
                 if (qla2x00_loop_reset(ha) != 0) {
                         return_status = FAILED;
                 }
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);
         } else {
                 /*
                  * Wait a while for the loop to come back. Return SUCCESS
                  * for the kernel to try again.
                  */
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);

                 set_current_state(TASK_INTERRUPTIBLE);
                 schedule_timeout(5 * HZ);

-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);

                 return_status = SUCCESS;
         }
@@ -3147,9 +3126,9 @@
         if (!list_empty(&ha->done_queue)) {
                 DEBUG3(printk("qla2xxx_eh_bus_reset: calling done for 
ha.\n");)

-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);
                 qla2x00_done(ha);
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);
         }

         DEBUG2_3(printk("qla2xxx_eh_bus_reset: exiting. status=0x%x.\n",
@@ -3272,7 +3251,7 @@

         if (!(test_bit(ABORT_ISP_ACTIVE, &ha->dpc_flags))) {
                 set_bit(ABORT_ISP_ACTIVE, &ha->dpc_flags);
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);

                 if (qla2x00_abort_isp(ha, 1)) {
                         /* failed. try later */
@@ -3292,27 +3271,27 @@
                         return_status = SUCCESS;
                 }

-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);
                 clear_bit(ABORT_ISP_ACTIVE, &ha->dpc_flags);
         } else {
                 /*
                  * Already active. Sleep a while then return SUCCESS for
                  * kernel to retry the IO.
                  */
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);

                 set_current_state(TASK_INTERRUPTIBLE);
                 schedule_timeout(5 * HZ);

-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);

                 return_status = SUCCESS;
         }

         if (!list_empty(&ha->done_queue)) {
-               spin_unlock_irq(&io_request_lock);
+               spin_unlock_irq(ha->host->host_lock);
                 qla2x00_done(ha);
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);
         }

         DRIVER_UNLOCK
@@ -3595,9 +3574,9 @@
                 tasklet_schedule(&ha->run_qla_task);

         if (found) {
-               spin_unlock(&io_request_lock);
+               spin_unlock(ha->host->host_lock);
                 qla2x00_restart_queues(vis_ha, TRUE);
-               spin_lock_irq(&io_request_lock);
+               spin_lock_irq(ha->host->host_lock);
         } else {
                 printk(KERN_INFO
                         "qla2x00_abort: Couldn't Abort command = %p\n", cmd);
@@ -3851,12 +3830,12 @@
                          * mid-level code can expect completions 
momentitarily.
                          */
  #if NEW_EH_CODE
-                       spin_unlock(&io_request_lock);
+                       spin_unlock(ha->host->host_lock);
                         if (qla2x00_abort_isp(ha, 0)) {
                                 /* failed. try later */
                                 set_bit(ISP_ABORT_NEEDED, &ha->dpc_flags);
                         }
-                       spin_lock_irq(&io_request_lock);
+                       spin_lock_irq(ha->host->host_lock);
  #else
                         set_bit(ISP_ABORT_NEEDED, &ha->dpc_flags);

@@ -3874,9 +3853,9 @@
         DEBUG3(printk("qla2x00_reset: going to call restart_queues. "
                         "jiffies=%lx.\n", jiffies);)

-       spin_unlock(&io_request_lock);
+       spin_unlock(ha->host->host_lock);
         qla2x00_restart_queues(ha,TRUE);
-       spin_lock_irq(&io_request_lock);
+       spin_lock_irq(ha->host->host_lock);
         DRIVER_UNLOCK

         COMTRACE('r')
@@ -3946,7 +3925,7 @@
         qla2x00_stats.irqhba = ha;

         /* Prevent concurrent access to adapters register */
-       /* spin_lock_irqsave(&io_request_lock, cpu_flags);*/
+       /* spin_lock_irqsave(host->host_lock, cpu_flags);*/

         reg = ha->iobase;

@@ -3998,7 +3977,7 @@
         if (!list_empty(&ha->done_queue))
                 tasklet_schedule(&ha->run_qla_task);

-       /* spin_unlock_irqrestore(&io_request_lock, cpu_flags);*/
+       /* spin_unlock_irqrestore(host->host_lock, cpu_flags);*/

         /* Wakeup the DPC routine */
         if ((!ha->flags.mbox_busy &&
@@ -4179,7 +4158,7 @@

                 QLA2100_DPC_LOCK(ha);

-               /* spin_lock_irqsave(&io_request_lock, ha->cpu_flags);*/
+               /* spin_lock_irqsave(host->host_lock, ha->cpu_flags);*/
                 ha->dpc_active = 1;

                 /* Determine what action is necessary */
@@ -4477,7 +4456,7 @@
                 if (!list_empty(&ha->done_queue))
                         tasklet_schedule(&ha->run_qla_task);

-               /* spin_unlock_irqrestore(&io_request_lock, ha->cpu_flags);*/
+               /* spin_unlock_irqrestore(host->host_lock, ha->cpu_flags);*/

                 ha->dpc_active = 0;

@@ -4778,9 +4757,9 @@

                 /* Call the mid-level driver interrupt handler */
  #if 0
-               spin_lock_irqsave(&io_request_lock, flags);
+               spin_lock_irqsave(host->host_lock, flags);
                 qla2x00_callback(ha,cmd);
-               spin_unlock_irqrestore(&io_request_lock, flags);
+               spin_unlock_irqrestore(host->host_lock, flags);
  #else

                 sp_put(ha, sp);
@@ -15846,7 +15825,7 @@
         printk(KERN_INFO
                 "qla2x00_apidev: open MAJOR number = %d, "
                 "MINOR number = %d\n",
-               MAJOR(inode->i_rdev), MINOR(inode->i_rdev));
+               major(inode->i_rdev), minor(inode->i_rdev));

         return 0;
  }
@@ -15902,7 +15881,8 @@
                         APIDEV_NODE, apidev_major);)

         proc_mknod(APIDEV_NODE, 0777+S_IFCHR, host->hostt->proc_dir,
-                       (kdev_t)MKDEV(apidev_major,0));
+                       (kdev_t)mk_kdev(apidev_major,0));
+

         return 0;
  }
diff -urN base/qla2x00.h 2.5.25/qla2x00.h
--- base/qla2x00.h      Tue Apr 16 05:15:40 2002
+++ 2.5.25/qla2x00.h    Fri Jul 12 09:29:51 2002
@@ -2682,10 +2682,8 @@
         present: 0,             /* number of 7xxx's present   */\
         unchecked_isa_dma: 0,   /* no memory DMA restrictions */\
         use_clustering: ENABLE_CLUSTERING,                      \
-       use_new_eh_code: 1,                                     \
         max_sectors: 512,                                       \
-       highmem_io: 1,                                          \
-       emulated: 0                                             \
+       highmem_io: 1                                           \
  }
  #else /* KERNEL_VERSION < 2.5.7 */
  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,8)
diff -urN base/qla2x00_ioctl.c 2.5.25/qla2x00_ioctl.c
--- base/qla2x00_ioctl.c        Tue Apr 16 05:15:40 2002
+++ 2.5.25/qla2x00_ioctl.c      Fri Jul 12 09:29:51 2002
@@ -2509,14 +2509,14 @@
                                 ha->host_no);)

                 /* get spin lock for this operation */
-       spin_lock_irqsave(&io_request_lock, ha->cpu_flags);
+       spin_lock_irqsave(ha->host->host_lock, ha->cpu_flags);

         qla2x00_queuecommand(pscsi_cmd, (void *) qla2x00_scsi_pt_done);

         ha->ioctl->cmpl_timer.expires = jiffies + ha->ioctl->ioctl_tov * HZ;
         add_timer(&ha->ioctl->cmpl_timer);

-       spin_unlock_irqrestore(&io_request_lock, ha->cpu_flags);
+       spin_unlock_irqrestore(ha->host->host_lock, ha->cpu_flags);
         down(&ha->ioctl->cmpl_sem);

         del_timer(&ha->ioctl->cmpl_timer);
===


cheers,

lincoln.

