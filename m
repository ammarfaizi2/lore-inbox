Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274986AbTHBFAm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 01:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274985AbTHBFAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 01:00:42 -0400
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:64681 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S273024AbTHBE77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 00:59:59 -0400
X-Lotus-FromDomain: TOSHIBA
From: "haruo tomita" <haruo.tomita@toshiba.co.jp>
To: atulm@lsil.com
cc: linux-megaraid-devel@dell.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Manojj@lsil.com, sreenib@lsil.com,
       Peterj@lsil.com, hdoelfel@lsil.com, haruo.tomita@toshiba.co.jp
Message-Id: <200308020459.NAA06295@toshiba.co.jp>
Date: Sat, 2 Aug 2003 13:59:32 +0900
Subject: RE: [ANNOUNCE] megaraid linux driver version 2.00.7
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atul,

Atul wrote;

Atul>
Atul> MegaRAID driver version 2.00.7 is released and can be download from
Atul>
Atul> ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.7/
Atul>

Thanks!! I created the patch for kernel 2.4.22-pre10-ac1.
Here is patch.


diff -Nru linux-2.4.22-pre10-ac1/drivers/scsi/megaraid2.c linux-2.4.22-pre10-ac1-mr7/drivers/scsi/megaraid2.c
--- linux-2.4.22-pre10-ac1/drivers/scsi/megaraid2.c     2003-08-02 10:20:33.000000000 +0900
+++ linux-2.4.22-pre10-ac1-mr7/drivers/scsi/megaraid2.c      2003-08-02 10:50:57.000000000 +0900
@@ -14,7 +14,7 @@
  *    - speed-ups (list handling fixes, issued_list, optimizations.)
  *    - lots of cleanups.
  *
- * Version : v2.00.5 (Apr 24, 2003) - Atul Mukker <Atul.Mukker@lsil.com>
+ * Version : v2.00.7 (Aug 01, 2003) - Atul Mukker <Atul.Mukker@lsil.com>
  *
  * Description: Linux device driver for LSI Logic MegaRAID controller
  *
@@ -73,7 +73,9 @@

 static int hba_count;
 static adapter_t *hba_soft_state[MAX_CONTROLLERS];
+#ifdef CONFIG_PROC_FS
 static struct proc_dir_entry *mega_proc_dir_entry;
+#endif

 static struct notifier_block mega_notifier = {
     .notifier_call = megaraid_reboot_notify
@@ -255,6 +257,16 @@

     while((pdev = pci_find_device(pci_vendor, pci_device, pdev))) {

+         // reset flags for all controllers in this class
+         did_ioremap_f = 0;
+         did_req_region_f = 0;
+         did_scsi_reg_f = 0;
+         got_ipdev_f = 0;
+         alloc_int_buf_f = 0;
+         alloc_scb_f = 0;
+         got_irq_f = 0;
+         did_setup_mbox_f = 0;
+
          if(pci_enable_device (pdev)) continue;

          pci_bus = pdev->bus->number;
@@ -290,6 +302,7 @@
          if( subsysvid && (subsysvid != AMI_SUBSYS_VID) &&
                    (subsysvid != DELL_SUBSYS_VID) &&
                    (subsysvid != HP_SUBSYS_VID) &&
+                   (subsysvid != INTEL_SUBSYS_VID) &&
                    (subsysvid != LSI_SUBSYS_VID) ) continue;


@@ -382,6 +395,8 @@
          adapter->flag = flag;
          spin_lock_init(&adapter->lock);

+         adapter->host_lock = &io_request_lock;
+
          host->cmd_per_lun = max_cmd_per_lun;
          host->max_sectors = max_sectors_per_io;

@@ -1624,7 +1639,7 @@
     /*
      * Increment the pending queue counter
      */
-    atomic_inc(&adapter->pend_cmds);
+    atomic_inc((atomic_t *)&adapter->pend_cmds);

     switch (mbox->cmd) {
     case MEGA_MBOXCMD_LREAD64:
@@ -1709,6 +1724,9 @@

          mbox->numstatus = 0xFF;

+         while((volatile u8)mbox->status == 0xFF)
+              cpu_relax();
+
          while( (volatile u8)mbox->poll != 0x77 )
               cpu_relax();

@@ -1758,7 +1776,7 @@
     unsigned long  flags;


-    spin_lock_irqsave(&adapter->lock, flags);
+    spin_lock_irqsave(adapter->host_lock, flags);

     megaraid_iombox_ack_sequence(adapter);

@@ -1767,7 +1785,7 @@
          mega_runpendq(adapter);
     }

-    spin_unlock_irqrestore(&adapter->lock, flags);
+    spin_unlock_irqrestore(adapter->host_lock, flags);

     return;
 }
@@ -1804,12 +1822,13 @@
               cpu_relax();
          adapter->mbox->numstatus = 0xFF;

-         status = adapter->mbox->status;
+         while((status = (volatile u8)adapter->mbox->status) == 0xFF)
+              cpu_relax();

          /*
           * decrement the pending queue counter
           */
-         atomic_sub(nstatus, &adapter->pend_cmds);
+         atomic_sub(nstatus, (atomic_t *)&adapter->pend_cmds);

          memcpy(completed, (void *)adapter->mbox->completed, nstatus);

@@ -1839,7 +1858,7 @@
     unsigned long  flags;


-    spin_lock_irqsave(&adapter->lock, flags);
+    spin_lock_irqsave(adapter->host_lock, flags);

     megaraid_memmbox_ack_sequence(adapter);

@@ -1848,7 +1867,7 @@
          mega_runpendq(adapter);
     }

-    spin_unlock_irqrestore(&adapter->lock, flags);
+    spin_unlock_irqrestore(adapter->host_lock, flags);

     return;
 }
@@ -1883,17 +1902,18 @@
          }
          WROUTDOOR(adapter, 0x10001234);

-         while((nstatus = adapter->mbox->numstatus) == 0xFF) {
+         while((nstatus = (volatile u8)adapter->mbox->numstatus)
+                   == 0xFF)
               cpu_relax();
-         }
          adapter->mbox->numstatus = 0xFF;

-         status = adapter->mbox->status;
+         while((status = (volatile u8)adapter->mbox->status) == 0xFF)
+              cpu_relax();

          /*
           * decrement the pending queue counter
           */
-         atomic_sub(nstatus, &adapter->pend_cmds);
+         atomic_sub(nstatus, (atomic_t *)&adapter->pend_cmds);

          memcpy(completed, (void *)adapter->mbox->completed, nstatus);

@@ -2395,7 +2415,9 @@
     adapter_t *adapter;
     mbox_t    *mbox;
     u_char    raw_mbox[16];
+#ifdef CONFIG_PROC_FS
     char buf[12] = { 0 };
+#endif

     adapter = (adapter_t *)host->hostdata;
     mbox = (mbox_t *)raw_mbox;
@@ -2597,7 +2619,7 @@

     adapter = (adapter_t *)scp->host->hostdata;

-    ASSERT( spin_is_locked(&adapter->lock) );
+    ASSERT( spin_is_locked(adapter->host_lock) );

     printk("megaraid: aborting-%ld cmd=%x <c=%d t=%d l=%d>\n",
          scp->serial_number, scp->cmnd[0], scp->channel, scp->target,
@@ -2640,8 +2662,7 @@
      * completed by the firmware
      */
     iter = 0;
-    while( !list_empty(&adapter->pending_list) ) {
-
+    while( atomic_read(&adapter->pend_cmds) > 0 ) {
          /*
           * Perform the ack sequence, since interrupts are not
           * available right now!
@@ -2694,7 +2715,7 @@

     adapter = (adapter_t *)cmd->host->hostdata;

-    ASSERT( spin_is_locked(&adapter->lock) );
+    ASSERT( spin_is_locked(adapter->host_lock) );

     printk("megaraid: reset-%ld cmd=%x <c=%d t=%d l=%d>\n",
          cmd->serial_number, cmd->cmnd[0], cmd->channel, cmd->target,
@@ -2705,7 +2726,7 @@
     mc.cmd = MEGA_CLUSTER_CMD;
     mc.opcode = MEGA_RESET_RESERVATIONS;

-    spin_unlock_irq(&adapter->lock);
+    spin_unlock_irq(adapter->host_lock);
     if( mega_internal_command(adapter, LOCK_INT, &mc, NULL) != 0 ) {
          printk(KERN_WARNING
                    "megaraid: reservation reset failed.\n");
@@ -2713,7 +2734,7 @@
     else {
          printk(KERN_INFO "megaraid: reservation reset.\n");
     }
-    spin_lock_irq(&adapter->lock);
+    spin_lock_irq(adapter->host_lock);
 #endif

     /*
@@ -2721,8 +2742,7 @@
      * firmware
      */
     iter = 0;
-    while( !list_empty(&adapter->pending_list) ) {
-
+    while( atomic_read(&adapter->pend_cmds) > 0 ) {
          /*
           * Perform the ack sequence, since interrupts are not
           * available right now!
@@ -3564,6 +3584,7 @@
     u32  array_sz;
     int  len = 0;
     int  i;
+    u8   span8_flag = 1;

     pdev = adapter->ipdev;

@@ -3585,6 +3606,7 @@
     memset(&mc, 0, sizeof(megacmd_t));

     if( adapter->flag & BOARD_40LD ) {
+
          array_sz = sizeof(disk_array_40ld);

          rdrv_state = ((mega_inquiry3 *)inquiry)->ldrv_state;
@@ -3592,7 +3614,12 @@
          num_ldrv = ((mega_inquiry3 *)inquiry)->num_ldrv;
     }
     else {
-         array_sz = sizeof(disk_array_8ld);
+         /*
+          * 'array_sz' is either the size of diskarray_span4_t or the
+          * size of disk_array_span8_t. We use span8_t's size because
+          * it is bigger of the two.
+          */
+         array_sz = sizeof( diskarray_span8_t );

          rdrv_state = ((mraid_ext_inquiry *)inquiry)->
               raid_inq.logdrv_info.ldrv_state;
@@ -3632,10 +3659,17 @@

     }
     else {
+         /*
+          * Try 8-Span "read config" command
+          */
          mc.cmd = NEW_READ_CONFIG_8LD;

          if( mega_internal_command(adapter, LOCK_INT, &mc, NULL) ) {

+              /*
+               * 8-Span command failed; try 4-Span command
+               */
+              span8_flag = 0;
               mc.cmd = READ_CONFIG_8LD;

               if( mega_internal_command(adapter, LOCK_INT, &mc,
@@ -3662,8 +3696,14 @@
               &((disk_array_40ld *)disk_array)->ldrv[i].lparam;
          }
          else {
-              lparam =
-              &((disk_array_8ld *)disk_array)->ldrv[i].lparam;
+              if( span8_flag ) {
+                   lparam = (logdrv_param*) &((diskarray_span8_t*)
+                             (disk_array))->log_drv[i];
+              }
+              else {
+                   lparam = (logdrv_param*) &((diskarray_span4_t*)
+                             (disk_array))->log_drv[i];
+              }
          }

          /*
@@ -4705,7 +4745,7 @@

     mbox = (mbox_t *)raw_mbox;

-    memset(mbox, 0, sizeof(mbox));
+    memset(mbox, 0, 16);

     memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);

@@ -4738,7 +4778,7 @@

     mbox = (mbox_t *)raw_mbox;

-    memset(mbox, 0, sizeof(mbox));
+    memset(mbox, 0, 16);

     /*
      * issue command to find out what channels are raid/scsi
@@ -4859,7 +4899,7 @@

     mbox = (mbox_t *)raw_mbox;

-    memset(mbox, 0, sizeof(mbox));
+    memset(mbox, 0, 16);

     /*
      * issue command
@@ -4888,7 +4928,7 @@

     mbox = (mbox_t *)raw_mbox;

-    memset(mbox, 0, sizeof (mbox));
+    memset(mbox, 0, 16);
     /*
      * issue command to find out if controller supports extended CDBs.
      */
@@ -4917,7 +4957,7 @@
     scb_t *scb;
     int rval;

-    ASSERT( !spin_is_locked(&adapter->lock) );
+    ASSERT( !spin_is_locked(adapter->host_lock) );

     /*
      * Stop sending commands to the controller, queue them internally.
@@ -4937,7 +4977,7 @@
     rval = mega_do_del_logdrv(adapter, logdrv);


-    spin_lock_irqsave(&adapter->lock, flags);
+    spin_lock_irqsave(adapter->host_lock, flags);

     /*
      * If delete operation was successful, add 0x80 to the logical drive
@@ -4956,7 +4996,7 @@

     mega_runpendq(adapter);

-    spin_unlock_irqrestore(&adapter->lock, flags);
+    spin_unlock_irqrestore(adapter->host_lock, flags);

     return rval;
 }
@@ -5318,6 +5358,7 @@



+#ifdef CONFIG_PROC_FS
 /**
  * mega_adapinq()
  * @adapter - pointer to our soft state
@@ -5440,6 +5481,7 @@

     return rval;
 }
+#endif   // #ifdef CONFIG_PROC_FS


 /**
@@ -5504,11 +5546,11 @@
     /*
      * Get the lock only if the caller has not acquired it already
      */
-    if( ls == LOCK_INT ) spin_lock_irqsave(&adapter->lock, flags);
+    if( ls == LOCK_INT ) spin_lock_irqsave(adapter->host_lock, flags);

     megaraid_queue(scmd, mega_internal_done);

-    if( ls == LOCK_INT ) spin_unlock_irqrestore(&adapter->lock, flags);
+    if( ls == LOCK_INT ) spin_unlock_irqrestore(adapter->host_lock, flags);

     /*
      * Wait till this command finishes. Do not use
diff -Nru linux-2.4.22-pre10-ac1/drivers/scsi/megaraid2.h linux-2.4.22-pre10-ac1-mr7/drivers/scsi/megaraid2.h
--- linux-2.4.22-pre10-ac1/drivers/scsi/megaraid2.h     2003-08-02 10:20:33.000000000 +0900
+++ linux-2.4.22-pre10-ac1-mr7/drivers/scsi/megaraid2.h      2003-08-02 10:52:39.000000000 +0900
@@ -6,7 +6,7 @@


 #define MEGARAID_VERSION     \
-    "v2.00.5 (Release Date: Thu Apr 24 14:06:55 EDT 2003)\n"
+    "v2.00.7 (Release Date: Fri Aug  1 11:01:11 EDT 2003)\n"

 /*
  * Driver features - change the values to enable or disable features in the
@@ -83,6 +83,7 @@
 #define DELL_SUBSYS_VID           0x1028
 #define  HP_SUBSYS_VID            0x103C
 #define LSI_SUBSYS_VID            0x1000
+#define INTEL_SUBSYS_VID          0x8086

 #define HBA_SIGNATURE                   0x3344
 #define HBA_SIGNATURE_471         0xCCCC
@@ -509,6 +510,70 @@
     phys_drv  pdrv[MAX_PHYSICAL_DRIVES];
 }__attribute__ ((packed)) disk_array_8ld;

+/*
+ *    FW Definitions & Data Structures for 8LD 4-Span and 8-Span Controllers
+ */
+#define  MAX_STRIPES    8
+#define SPAN4_DEPTH     4
+#define SPAN8_DEPTH     8
+#define MAX_PHYDRVS     5 * 16    /* 5 Channels * 16 Targets */
+
+typedef struct  {
+    unsigned char  channel;
+    unsigned char  target;
+}__attribute__ ((packed)) device_t;
+
+typedef struct {
+    unsigned long  start_blk;
+    unsigned long  total_blks;
+    device_t  device[ MAX_STRIPES ];
+}__attribute__ ((packed)) span_t;
+
+typedef struct {
+    unsigned char  type;
+    unsigned char  curr_status;
+    unsigned char  tag_depth;
+    unsigned char  resvd1;
+    unsigned long  size;
+}__attribute__ ((packed)) phydrv_t;
+
+typedef struct {
+    unsigned char  span_depth;
+    unsigned char  raid;
+    unsigned char  read_ahead;    /* 0=No rdahead,1=RDAHEAD,2=adaptive */
+    unsigned char  stripe_sz;
+    unsigned char  status;
+    unsigned char  write_policy;  /* 0=wrthru,1=wrbak */
+    unsigned char  direct_io;     /* 1=directio,0=cached */
+    unsigned char  no_stripes;
+    span_t         span[ SPAN4_DEPTH ];
+}__attribute__ ((packed)) ld_span4_t;
+
+typedef struct {
+    unsigned char  span_depth;
+    unsigned char  raid;
+    unsigned char  read_ahead;    /* 0=No rdahead,1=RDAHEAD,2=adaptive */
+    unsigned char  stripe_sz;
+    unsigned char  status;
+    unsigned char  write_policy;  /* 0=wrthru,1=wrbak */
+    unsigned char  direct_io;     /* 1=directio,0=cached */
+    unsigned char  no_stripes;
+    span_t         span[ SPAN8_DEPTH ];
+}__attribute__ ((packed)) ld_span8_t;
+
+typedef struct {
+    unsigned char  no_log_drives;
+    unsigned char  pad[3];
+    ld_span4_t     log_drv[ MAX_LOGICAL_DRIVES_8LD ];
+    phydrv_t  phys_drv[ MAX_PHYDRVS ];
+}__attribute__ ((packed)) diskarray_span4_t;
+
+typedef struct {
+    unsigned char  no_log_drives;
+    unsigned char  pad[3];
+    ld_span8_t     log_drv[ MAX_LOGICAL_DRIVES_8LD ];
+    phydrv_t  phys_drv[ MAX_PHYDRVS ];
+}__attribute__ ((packed)) diskarray_span8_t;

 /*
  * User ioctl structure.
@@ -847,8 +912,8 @@
     u8        max_cmds;
     scb_t          *scb_list;

-    atomic_t  pend_cmds;     /* maintain a counter for pending
-                           commands in firmware */
+    volatile atomic_t   pend_cmds;      /* maintain a counter for
+                             pending commands in firmware */

 #if MEGA_HAVE_STATS
     u32  nreads[MAX_LOGICAL_DRIVES_40LD];
@@ -899,6 +964,7 @@
                            sending requests to the hba till
                            delete operation is completed */
     spinlock_t     lock;
+    spinlock_t     *host_lock;    // pointer to appropriate lock

     u8   logdrv_chan[MAX_CHANNELS+NVIRT_CHAN]; /* logical drive are on
                                   what channels. */
@@ -1049,7 +1115,6 @@
 static int megaraid_abort(Scsi_Cmnd *);
 static int megaraid_reset(Scsi_Cmnd *);
 static int megaraid_biosparam (Disk *, kdev_t, int *);
-static int mega_print_inquiry(char *, char *);

 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
                     u32 *buffer, u32 *length);
@@ -1092,12 +1157,13 @@
 static int proc_rdrv_30(char *, char **, off_t, int, int *, void *);
 static int proc_rdrv_40(char *, char **, off_t, int, int *, void *);
 static int proc_rdrv(adapter_t *, char *, int, int);
-#endif

 static int mega_adapinq(adapter_t *, dma_addr_t);
 static int mega_internal_dev_inquiry(adapter_t *, u8, u8, dma_addr_t);
 static inline caddr_t mega_allocate_inquiry(dma_addr_t *, struct pci_dev *);
 static inline void mega_free_inquiry(caddr_t, dma_addr_t, struct pci_dev *);
+static int mega_print_inquiry(char *, char *);
+#endif

 static int mega_support_ext_cdb(adapter_t *);
 static mega_passthru* mega_prepare_passthru(adapter_t *, scb_t *,


