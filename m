Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267195AbTAPSro>; Thu, 16 Jan 2003 13:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267194AbTAPSro>; Thu, 16 Jan 2003 13:47:44 -0500
Received: from port.lamport.ru ([193.111.92.50]:6923 "HELO port.lamport.ru")
	by vger.kernel.org with SMTP id <S267193AbTAPSrm> convert rfc822-to-8bit;
	Thu, 16 Jan 2003 13:47:42 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4] multiple cpqarray controlers with devfs
Date: Thu, 16 Jan 2003 21:56:38 +0300
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301162156.39007.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

Without this patch I can't use more than one cpqarray controllers
at once on devfs enabled system.

Tested with two controllers:
"Smart Array 221" +  "SMART-2/P"

All credits goes to Richard Gooch <rgooch@ras.ucalgary.ca>.
This patch was already in his devfs patchset, but from
what i've seen was never merged in mainline.

Please apply.

===== drivers/block/cpqarray.c 1.27 vs edited =====
--- 1.27/drivers/block/cpqarray.c	Tue Dec 17 02:26:25 2002
+++ edited/drivers/block/cpqarray.c	Thu Jan 16 20:41:39 2003
@@ -32,6 +32,7 @@
 #include <linux/blkpg.h>
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
+#include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
 #include <linux/hdreg.h>
 #include <linux/spinlock.h>
@@ -69,7 +70,7 @@
 
 static ctlr_info_t *hba[MAX_CTLR] = 
 	{ NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };
-
+static devfs_handle_t de_arr[MAX_CTLR][NWD];
 static int eisa[8];
 
 #define NR_PRODUCTS (sizeof(products)/sizeof(struct board_type))
@@ -578,9 +579,10 @@
 	hba[i]->gendisk.max_p = IDA_MAX_PART;
 	hba[i]->gendisk.part = hba[i]->hd;
 	hba[i]->gendisk.sizes = hba[i]->sizes;
-	hba[i]->gendisk.nr_real = hba[i]->highest_lun+1; 
+	hba[i]->gendisk.nr_real = hba[i]->highest_lun+1;
+	hba[i]->gendisk.de_arr = de_arr[i];
 	hba[i]->gendisk.fops = &ida_fops;
-	
+
 		/* Get on the disk list */
 	add_gendisk(&(hba[i]->gendisk));
 
@@ -2439,6 +2441,13 @@
 				}
 				if(log_unit > info_p->highest_lun)
 					info_p->highest_lun = log_unit;
+				if(!de_arr[ctlr][log_unit]) {
+					char txt[16];
+					sprintf(txt, "ida/c%dd%d", ctlr,
+						log_unit);
+					de_arr[ctlr][log_unit] =
+					devfs_mk_dir(NULL,txt, NULL);
+				}
 				info_p->phys_drives =
 				    sense_config_buf->ctlr_phys_drv;
 				info_p->drv_assign_map
@@ -2472,6 +2481,7 @@
                         cpqarray_remove_one_eisa(i);
                 }
         }
+	devfs_unregister(devfs_find_handle(NULL, "ida", 0, 0, 0, 0));
         remove_proc_entry("cpqarray", proc_root_driver);
 }
 

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
