Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUFBNZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUFBNZC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUFBNZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:25:02 -0400
Received: from may.priocom.com ([213.156.65.50]:28039 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S262772AbUFBNYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:24:20 -0400
Subject: [PATCH] 2.6.6 aic79xx_osm.c: memory allocation checks
From: Yury Umanets <torque@ukrpost.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086182657.2898.84.camel@firefly.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 02 Jun 2004 16:24:18 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] 2.6.6 aic79xx_osm.c: adds memory allocation checks to
drivers/scsi/aic7xxx/aic79xx_osm.c

Signed-off-by: Yury Umanets <torque@ukrpost.net>

 aic79xx_osm.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletion(-)

diff -rupN ./linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.c
./linux-2.6.6-modified/drivers/scsi/aic7xxx/aic79xx_osm.c
--- ./linux-2.6.6/drivers/scsi/aic7xxx/aic79xx_osm.c    Mon May 10
05:32:38
2004
+++ ./linux-2.6.6-modified/drivers/scsi/aic7xxx/aic79xx_osm.c   Wed Jun 
2
14:31:01 2004
@@ -1565,6 +1565,8 @@ ahd_linux_dev_reset(Scsi_Cmnd *cmd)
 
        ahd = *(struct ahd_softc **)cmd->device->host->hostdata;
        recovery_cmd = malloc(sizeof(struct scsi_cmnd), M_DEVBUF,
M_WAITOK);
+       if (recovery_cmd == NULL)
+               return (ENOMEM);
        memset(recovery_cmd, 0, sizeof(struct scsi_cmnd));
        recovery_cmd->device = cmd->device;
        recovery_cmd->scsi_done = ahd_linux_dev_reset_complete;
@@ -2758,7 +2760,16 @@ ahd_linux_dv_target(struct ahd_softc *ah
        ahd_unlock(ahd, &s);
 
        cmd = malloc(sizeof(struct scsi_cmnd), M_DEVBUF, M_WAITOK);
+       if (cmd == NULL) {
+               printf("ahd_linux_dv_target(): Allocation of cmd is
failed\n");
+               return;
+        }
        scsi_dev = malloc(sizeof(struct scsi_device), M_DEVBUF,
M_WAITOK);
+       if (scsi_dev == NULL) {
+               printf("ahd_linux_dv_target(): Allocation of scsi_dev
failed\n");
+               free(cmd, M_DEVBUF);
+               return;
+        }
        scsi_dev->host = ahd->platform_data->host;
        scsi_dev->id = devinfo.target;
        scsi_dev->lun = devinfo.lun;
@@ -3416,14 +3427,25 @@ ahd_linux_dv_inq(struct ahd_softc *ahd, 
                printf("Sending INQ\n");
        }
 #endif
-       if (targ->inq_data == NULL)
+       if (targ->inq_data == NULL) {
                targ->inq_data = malloc(AHD_LINUX_DV_INQ_LEN,
                                        M_DEVBUF, M_WAITOK);
+               if (targ->inq_data == NULL) {
+                       printf("ahd_linux_dv_inq(): Allocation of "
+                               "inq_data is failed\n");
+                       return;
+                }
+        }
        if (targ->dv_state > AHD_DV_STATE_INQ_ASYNC) {
                if (targ->dv_buffer != NULL)
                        free(targ->dv_buffer, M_DEVBUF);
                targ->dv_buffer = malloc(AHD_LINUX_DV_INQ_LEN,
                                         M_DEVBUF, M_WAITOK);
+               if (targ->dv_buffer == NULL) {
+                       printf("ahd_linux_dv_inq(): Allocation of "
+                               "dv_buffer is failed\n");
+                       return;
+                }
        }
 
        ahd_linux_dv_fill_cmd(ahd, cmd, devinfo);
@@ -3473,6 +3495,11 @@ ahd_linux_dv_rebd(struct ahd_softc *ahd,
        if (targ->dv_buffer != NULL)
                free(targ->dv_buffer, M_DEVBUF);
        targ->dv_buffer = malloc(AHD_REBD_LEN, M_DEVBUF, M_WAITOK);
+       if (targ->dv_buffer == NULL) {
+               printf("ahd_linux_dv_rebd(): Allocation of "
+                       "dv_buffer is failed.\n");
+               return;
+        }
        ahd_linux_dv_fill_cmd(ahd, cmd, devinfo);
        cmd->sc_data_direction = SCSI_DATA_READ;
        cmd->cmd_len = 10;
@@ -3824,9 +3851,21 @@ ahd_linux_generate_dv_pattern(struct ahd
        if (targ->dv_buffer != NULL)
                free(targ->dv_buffer, M_DEVBUF);
        targ->dv_buffer = malloc(targ->dv_echo_size, M_DEVBUF,
M_WAITOK);
+       if (targ->dv_buffer == NULL) {
+               printf("ahd_linux_generate_dv_pattern(): Allocation of "
+                       "dv_buffer is failed.\n");
+               return;
+        }
+        
        if (targ->dv_buffer1 != NULL)
                free(targ->dv_buffer1, M_DEVBUF);
        targ->dv_buffer1 = malloc(targ->dv_echo_size, M_DEVBUF,
M_WAITOK);
+       if (targ->dv_buffer1 == NULL) {
+               free(targ->dv_buffer, M_DEVBUF);
+               printf("ahd_linux_generate_dv_pattern(): Allocation of "
+                       "dv_buffer1 is failed.\n");
+               return;
+        }
 
        i = 0;
 

-- 
umka

