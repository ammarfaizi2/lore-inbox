Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272242AbTG3Uzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272240AbTG3Uzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:55:46 -0400
Received: from mail0.lsil.com ([147.145.40.20]:41918 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S272239AbTG3Uzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:55:33 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570230C550@EXA-ATLANTA.se.lsil.com>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
Subject: [ANNOUNCE] megaraid 2.00.6 driver
Date: Wed, 30 Jul 2003 16:55:09 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing megaraid 2.00.6 driver release. This can be downloaded from the
following location:

ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.6/

Changes in 2.00.6 from 2.00.5 driver:

1. Changes suggested by Tomita Haruo - Wait for valid status in mailbox.
2. Changes suggested by Mark Haverkamp - Move /proc related code fragments
under #ifdef CONFIG_PROC_FS directives.
3. /proc changes required to correctly display logical drive information for
drives on some older controllers. (Eg., Express 200, 466)

Sreenivas Bagalkote
LSI Logic

diff -Naur megaraid_2005/megaraid2.c megaraid_2006/megaraid2.c
--- megaraid_2005/megaraid2.c	2003-07-30 14:43:28.000000000 -0400
+++ megaraid_2006/megaraid2.c	2003-07-30 14:43:36.000000000 -0400
@@ -14,7 +14,7 @@
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)
  *	  - lots of cleanups.
  *
- * Version : v2.00.5 (Apr 24, 2003) - Atul Mukker <Atul.Mukker@lsil.com>
+ * Version : v2.00.6 (July 30, 2003) - Atul Mukker <Atul.Mukker@lsil.com>
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
@@ -392,6 +394,7 @@
 
 		adapter->flag = flag;
 		spin_lock_init(&adapter->lock);
+		host->lock = &adapter->lock;
 
 		host->cmd_per_lun = max_cmd_per_lun;
 		host->max_sectors = max_sectors_per_io;
@@ -1720,6 +1723,9 @@
 
 		mbox->numstatus = 0xFF;
 
+		while((volatile u8)mbox->status == 0xFF)
+			cpu_relax();
+
 		while( (volatile u8)mbox->poll != 0x77 )
 			cpu_relax();
 
@@ -1815,7 +1821,8 @@
 			cpu_relax();
 		adapter->mbox->numstatus = 0xFF;
 
-		status = adapter->mbox->status;
+		while((status = (volatile u8)adapter->mbox->status) == 0xFF)
+			cpu_relax();
 
 		/*
 		 * decrement the pending queue counter
@@ -1894,12 +1901,13 @@
 		}
 		WROUTDOOR(adapter, 0x10001234);
 
-		while((nstatus = adapter->mbox->numstatus) == 0xFF) {
+		while((nstatus = (volatile u8)adapter->mbox->numstatus)
+				== 0xFF)
 			cpu_relax();
-		}
 		adapter->mbox->numstatus = 0xFF;
 
-		status = adapter->mbox->status;
+		while((status = (volatile u8)adapter->mbox->status) == 0xFF)
+			cpu_relax();
 
 		/*
 		 * decrement the pending queue counter
@@ -2406,7 +2414,9 @@
 	adapter_t	*adapter;
 	mbox_t	*mbox;
 	u_char	raw_mbox[16];
+#ifdef CONFIG_PROC_FS
 	char	buf[12] = { 0 };
+#endif
 
 	adapter = (adapter_t *)host->hostdata;
 	mbox = (mbox_t *)raw_mbox;
@@ -3575,6 +3585,7 @@
 	u32	array_sz;
 	int	len = 0;
 	int	i;
+	u8	span8_flag = 1;
 
 	pdev = adapter->ipdev;
 
@@ -3596,6 +3607,7 @@
 	memset(&mc, 0, sizeof(megacmd_t));
 
 	if( adapter->flag & BOARD_40LD ) {
+		
 		array_sz = sizeof(disk_array_40ld);
 
 		rdrv_state = ((mega_inquiry3 *)inquiry)->ldrv_state;
@@ -3603,7 +3615,12 @@
 		num_ldrv = ((mega_inquiry3 *)inquiry)->num_ldrv;
 	}
 	else {
-		array_sz = sizeof(disk_array_8ld);
+		/*
+		 * 'array_sz' is either the size of diskarray_span4_t or the
+		 * size of disk_array_span8_t. We use span8_t's size because
+		 * it is bigger of the two.
+		 */
+		array_sz = sizeof( diskarray_span8_t );
 
 		rdrv_state = ((mraid_ext_inquiry *)inquiry)->
 			raid_inq.logdrv_info.ldrv_state;
@@ -3643,10 +3660,17 @@
 
 	}
 	else {
+		/*
+		 * Try 8-Span "read config" command
+		 */
 		mc.cmd = NEW_READ_CONFIG_8LD;
 
 		if( mega_internal_command(adapter, LOCK_INT, &mc, NULL) ) {
 
+			/*
+			 * 8-Span command failed; try 4-Span command
+			 */
+			span8_flag = 0;
 			mc.cmd = READ_CONFIG_8LD;
 
 			if( mega_internal_command(adapter, LOCK_INT, &mc,
@@ -3673,8 +3697,14 @@
 			&((disk_array_40ld *)disk_array)->ldrv[i].lparam;
 		}
 		else {
-			lparam =
-			&((disk_array_8ld *)disk_array)->ldrv[i].lparam;
+			if( span8_flag ) {
+				lparam = (logdrv_param*)
&((diskarray_span8_t*)
+						(disk_array))->log_drv[i];
+			}
+			else {
+				lparam = (logdrv_param*)
&((diskarray_span4_t*)
+						(disk_array))->log_drv[i];
+			}	
 		}
 
 		/*
@@ -5329,6 +5359,7 @@
 
 
 
+#ifdef CONFIG_PROC_FS
 /**
  * mega_adapinq()
  * @adapter - pointer to our soft state
@@ -5451,6 +5482,7 @@
 
 	return rval;
 }
+#endif	// #ifdef CONFIG_PROC_FS
 
 
 /**
diff -Naur megaraid_2005/megaraid2.h megaraid_2006/megaraid2.h
--- megaraid_2005/megaraid2.h	2003-07-30 14:43:28.000000000 -0400
+++ megaraid_2006/megaraid2.h	2003-07-30 14:48:03.000000000 -0400
@@ -6,7 +6,7 @@
 
 
 #define MEGARAID_VERSION	\
-	"v2.00.5 (Release Date: Thu Apr 24 14:06:55 EDT 2003)\n"
+	"v2.00.6 (Release Date: Wed Jul 30 11:35:31 EDT 2003)\n"
 
 /*
  * Driver features - change the values to enable or disable features in the
@@ -510,6 +510,70 @@
 	phys_drv	pdrv[MAX_PHYSICAL_DRIVES];
 }__attribute__ ((packed)) disk_array_8ld;
 
+/*
+ *    FW Definitions & Data Structures for 8LD 4-Span and 8-Span
Controllers
+ */
+#define	MAX_STRIPES	8
+#define SPAN4_DEPTH	4
+#define SPAN8_DEPTH	8
+#define MAX_PHYDRVS	5 * 16	/* 5 Channels * 16 Targets */
+
+typedef struct  {
+	unsigned char	channel;
+	unsigned char	target; 
+}__attribute__ ((packed)) device_t;
+
+typedef struct { 
+	unsigned long	start_blk;
+	unsigned long	total_blks;
+	device_t	device[ MAX_STRIPES ];
+}__attribute__ ((packed)) span_t;
+
+typedef struct {
+	unsigned char	type;
+	unsigned char	curr_status;
+	unsigned char	tag_depth;
+	unsigned char	resvd1;
+	unsigned long	size;
+}__attribute__ ((packed)) phydrv_t;
+
+typedef struct { 
+	unsigned char	span_depth;
+	unsigned char	raid;
+	unsigned char	read_ahead;	/* 0=No rdahead,1=RDAHEAD,2=adaptive
*/ 
+	unsigned char	stripe_sz;
+	unsigned char	status;
+	unsigned char	write_policy;	/* 0=wrthru,1=wrbak */ 
+	unsigned char	direct_io;   	/* 1=directio,0=cached */ 
+	unsigned char	no_stripes;
+	span_t		span[ SPAN4_DEPTH ];
+}__attribute__ ((packed)) ld_span4_t;
+
+typedef struct { 
+	unsigned char	span_depth;
+	unsigned char	raid;
+	unsigned char	read_ahead;	/* 0=No rdahead,1=RDAHEAD,2=adaptive
*/ 
+	unsigned char	stripe_sz;
+	unsigned char	status;
+	unsigned char	write_policy;	/* 0=wrthru,1=wrbak */ 
+	unsigned char	direct_io;   	/* 1=directio,0=cached */ 
+	unsigned char	no_stripes;
+	span_t		span[ SPAN8_DEPTH ];
+}__attribute__ ((packed)) ld_span8_t;
+
+typedef struct { 
+	unsigned char	no_log_drives;
+	unsigned char	pad[3];
+	ld_span4_t	log_drv[ MAX_LOGICAL_DRIVES_8LD ];
+	phydrv_t	phys_drv[ MAX_PHYDRVS ];
+}__attribute__ ((packed)) diskarray_span4_t;
+
+typedef struct { 
+	unsigned char	no_log_drives;
+	unsigned char	pad[3];
+	ld_span8_t	log_drv[ MAX_LOGICAL_DRIVES_8LD ];
+	phydrv_t	phys_drv[ MAX_PHYDRVS ];
+}__attribute__ ((packed)) diskarray_span8_t;
 
 /*
  * User ioctl structure.
@@ -1050,7 +1114,6 @@
 static int megaraid_abort(Scsi_Cmnd *);
 static int megaraid_reset(Scsi_Cmnd *);
 static int megaraid_biosparam (Disk *, kdev_t, int *);
-static int mega_print_inquiry(char *, char *);
 
 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
 			      u32 *buffer, u32 *length);
@@ -1093,12 +1156,13 @@
 static int proc_rdrv_30(char *, char **, off_t, int, int *, void *);
 static int proc_rdrv_40(char *, char **, off_t, int, int *, void *);
 static int proc_rdrv(adapter_t *, char *, int, int);
-#endif
 
 static int mega_adapinq(adapter_t *, dma_addr_t);
 static int mega_internal_dev_inquiry(adapter_t *, u8, u8, dma_addr_t);
 static inline caddr_t mega_allocate_inquiry(dma_addr_t *, struct pci_dev
*);
 static inline void mega_free_inquiry(caddr_t, dma_addr_t, struct pci_dev
*);
+static int mega_print_inquiry(char *, char *);
+#endif
 
 static int mega_support_ext_cdb(adapter_t *);
 static mega_passthru* mega_prepare_passthru(adapter_t *, scb_t *,
