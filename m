Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbSJKBjx>; Thu, 10 Oct 2002 21:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262318AbSJKBjx>; Thu, 10 Oct 2002 21:39:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:13757 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262302AbSJKBje>;
	Thu, 10 Oct 2002 21:39:34 -0400
Message-ID: <3DA62D22.4020606@us.ibm.com>
Date: Thu, 10 Oct 2002 18:45:06 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Degraded I/O performance, since 2.5.41
References: <Pine.LNX.4.44.0210092015170.9790-100000@home.transmeta.com> <3DA61041.9080808@us.ibm.com> <20021011004227.GA27073@redhat.com> <3DA62120.9070609@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050305040100060105090500"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050305040100060105090500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Hansen wrote:
> Doug Ledford wrote:
> 
>> I  try to keep the drivers working
>> at a basic level, but until I'm done, benchmarking is pretty much a waste
>> of time I think)
> 
> 
> Benchmarking is integral in what we're doing right now.  We need to make 
> quick decisions about what is good or bad before the freeze. This patch 
> makes my machine unusable for anything that isn't in the pagecache.  A 
> simple "make oldconfig" on a cold tree takes minutes to complete.  My 
> grep test got an order of magnitude worse.  If we have to keep this 
> code, can we just make the default queue HUGE for now? Will that work 
> around it?
> 
> A bunch of the AIO people use QLogic cards, which I'm sure are broken by 
> this as well.  I'm going to back this patch out for all the testing 
> trees I do, and I suggest anyone who cares about I/O on SCSI (excluding 
> aic7xxx) after 2.5.41 do the same.

BTW, here's the cset in issue.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------050305040100060105090500
Content-Type: text/plain;
 name="cset-1.704.1.2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cset-1.704.1.2.txt"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.704.1.1 -> 1.704.1.2
#	drivers/scsi/aic7xxx_old/aic7xxx.h	1.4     -> 1.5    
#	 drivers/scsi/scsi.h	1.21    -> 1.22   
#	drivers/scsi/hosts.h	1.15    -> 1.16   
#	drivers/scsi/aic7xxx_old.c	1.24    -> 1.25   
#	 drivers/scsi/scsi.c	1.40    -> 1.41   
#	drivers/scsi/scsi_scan.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/08	dledford@redhat.com	1.704.1.2
# [PATCH] make SCSI queue depth adjustable
# 
# Linus, this has been tested by some people in the field to not break
# things, and it's the start of some other changes I'm making, so please put
# this in your tree so I'm not merging huge patches but instead am merging a
# little as I go.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/aic7xxx_old/aic7xxx.h b/drivers/scsi/aic7xxx_old/aic7xxx.h
--- a/drivers/scsi/aic7xxx_old/aic7xxx.h	Wed Oct  9 05:38:48 2002
+++ b/drivers/scsi/aic7xxx_old/aic7xxx.h	Wed Oct  9 05:38:48 2002
@@ -46,7 +46,9 @@
 	eh_host_reset_handler: NULL,				\
 	abort: aic7xxx_abort,					\
 	reset: aic7xxx_reset,					\
-	slave_attach: NULL,					\
+	select_queue_depths: NULL,				\
+	slave_attach: aic7xxx_slave_attach,			\
+	slave_detach: aic7xxx_slave_detach,			\
 	bios_param: aic7xxx_biosparam,				\
 	can_queue: 255,		/* max simultaneous cmds      */\
 	this_id: -1,		/* scsi id of host adapter    */\
@@ -64,6 +66,8 @@
 extern int aic7xxx_reset(Scsi_Cmnd *, unsigned int);
 extern int aic7xxx_abort(Scsi_Cmnd *);
 extern int aic7xxx_release(struct Scsi_Host *);
+extern int aic7xxx_slave_attach(Scsi_Device *);
+extern void aic7xxx_slave_detach(Scsi_Device *);
 
 extern const char *aic7xxx_info(struct Scsi_Host *);
 
diff -Nru a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
--- a/drivers/scsi/aic7xxx_old.c	Wed Oct  9 05:38:48 2002
+++ b/drivers/scsi/aic7xxx_old.c	Wed Oct  9 05:38:48 2002
@@ -976,7 +976,7 @@
 #define  DEVICE_DTR_SCANNED             0x40
   volatile unsigned char   dev_flags[MAX_TARGETS];
   volatile unsigned char   dev_active_cmds[MAX_TARGETS];
-  volatile unsigned char   dev_temp_queue_depth[MAX_TARGETS];
+  volatile unsigned short  dev_temp_queue_depth[MAX_TARGETS];
   unsigned char            dev_commands_sent[MAX_TARGETS];
 
   unsigned int             dev_timer_active; /* Which devs have a timer set */
@@ -988,7 +988,9 @@
 
   unsigned char            dev_last_queue_full[MAX_TARGETS];
   unsigned char            dev_last_queue_full_count[MAX_TARGETS];
-  unsigned char            dev_max_queue_depth[MAX_TARGETS];
+  unsigned char            dev_lun_queue_depth[MAX_TARGETS];
+  unsigned short           dev_scbs_needed[MAX_TARGETS];
+  unsigned short           dev_max_queue_depth[MAX_TARGETS];
 
   volatile scb_queue_type  delayed_scbs[MAX_TARGETS];
 
@@ -1035,6 +1037,7 @@
   ahc_chip                 chip;             /* chip type */
   ahc_bugs                 bugs;
   dma_addr_t		   fifo_dma;	     /* DMA handle for fifo arrays */
+  Scsi_Device		  *Scsi_Dev[MAX_TARGETS][MAX_LUNS];
 
   /*
    * Statistics Kept:
@@ -2820,94 +2823,6 @@
     cmd->result |= (DID_RESET << 16);
   }
 
-  if (!(p->dev_flags[tindex] & DEVICE_PRESENT))
-  {
-    if ( (cmd->cmnd[0] == INQUIRY) && (cmd->result == DID_OK) )
-    {
-    
-      p->dev_flags[tindex] |= DEVICE_PRESENT;
-#define WIDE_INQUIRY_BITS 0x60
-#define SYNC_INQUIRY_BITS 0x10
-#define SCSI_VERSION_BITS 0x07
-#define SCSI_DT_BIT       0x04
-      if(!(p->dev_flags[tindex] & DEVICE_DTR_SCANNED)) {
-        char *buffer;
-
-        if(cmd->use_sg)
-          BUG();
-
-        buffer = (char *)cmd->request_buffer;
-
-        if ( (buffer[7] & WIDE_INQUIRY_BITS) &&
-             (p->features & AHC_WIDE) )
-        {
-          p->needwdtr |= (1<<tindex);
-          p->needwdtr_copy |= (1<<tindex);
-          p->transinfo[tindex].goal_width = p->transinfo[tindex].user_width;
-        }
-        else
-        {
-          p->needwdtr &= ~(1<<tindex);
-          p->needwdtr_copy &= ~(1<<tindex);
-          pause_sequencer(p);
-          aic7xxx_set_width(p, cmd->target, cmd->channel, cmd->lun,
-                            MSG_EXT_WDTR_BUS_8_BIT, (AHC_TRANS_ACTIVE |
-                                                     AHC_TRANS_GOAL |
-                                                     AHC_TRANS_CUR) );
-          unpause_sequencer(p, FALSE);
-        }
-        if ( (buffer[7] & SYNC_INQUIRY_BITS) &&
-              p->transinfo[tindex].user_offset )
-        {
-          p->transinfo[tindex].goal_period = p->transinfo[tindex].user_period;
-          p->transinfo[tindex].goal_options = p->transinfo[tindex].user_options;
-          if (p->features & AHC_ULTRA2)
-            p->transinfo[tindex].goal_offset = MAX_OFFSET_ULTRA2;
-          else if (p->transinfo[tindex].goal_width == MSG_EXT_WDTR_BUS_16_BIT)
-            p->transinfo[tindex].goal_offset = MAX_OFFSET_16BIT;
-          else
-            p->transinfo[tindex].goal_offset = MAX_OFFSET_8BIT;
-          if ( (((buffer[2] & SCSI_VERSION_BITS) >= 3) ||
-                 (buffer[56] & SCSI_DT_BIT) ||
-                 (p->dev_flags[tindex] & DEVICE_SCSI_3) ) &&
-                 (p->transinfo[tindex].user_period <= 9) &&
-                 (p->transinfo[tindex].user_options) )
-          {
-            p->needppr |= (1<<tindex);
-            p->needppr_copy |= (1<<tindex);
-            p->needsdtr &= ~(1<<tindex);
-            p->needsdtr_copy &= ~(1<<tindex);
-            p->needwdtr &= ~(1<<tindex);
-            p->needwdtr_copy &= ~(1<<tindex);
-            p->dev_flags[tindex] |= DEVICE_SCSI_3;
-          }
-          else
-          {
-            p->needsdtr |= (1<<tindex);
-            p->needsdtr_copy |= (1<<tindex);
-            p->transinfo[tindex].goal_period = 
-              MAX(10, p->transinfo[tindex].goal_period);
-            p->transinfo[tindex].goal_options = 0;
-          }
-        }
-        else
-        {
-          p->needsdtr &= ~(1<<tindex);
-          p->needsdtr_copy &= ~(1<<tindex);
-          p->transinfo[tindex].goal_period = 255;
-          p->transinfo[tindex].goal_offset = 0;
-          p->transinfo[tindex].goal_options = 0;
-        }
-        p->dev_flags[tindex] |= DEVICE_DTR_SCANNED;
-        p->dev_flags[tindex] |= DEVICE_PRINT_DTR;
-      }
-#undef WIDE_INQUIRY_BITS
-#undef SYNC_INQUIRY_BITS
-#undef SCSI_VERSION_BITS
-#undef SCSI_DT_BIT
-    }
-  }
-
   if ((scb->flags & SCB_MSGOUT_BITS) != 0)
   {
     unsigned short mask;
@@ -4919,15 +4834,29 @@
                 if ( (p->dev_last_queue_full_count[tindex] > 14) &&
                      (p->dev_active_cmds[tindex] > 4) )
                 {
+		  int diff, lun;
+		  if (p->dev_active_cmds[tindex] > p->dev_lun_queue_depth[tindex])
+		    /* We don't know what to do here, so bail. */
+		    break;
                   if (aic7xxx_verbose & VERBOSE_NEGOTIATION2)
                     printk(INFO_LEAD "Queue depth reduced to %d\n", p->host_no,
                       CTL_OF_SCB(scb), p->dev_active_cmds[tindex]);
-                  p->dev_max_queue_depth[tindex] = 
-                      p->dev_active_cmds[tindex];
+		  diff = p->dev_lun_queue_depth[tindex] -
+			 p->dev_active_cmds[tindex];
+		  p->dev_lun_queue_depth[tindex] -= diff;
+		  for(lun = 0; lun < p->host->max_lun; lun++)
+		  {
+		    if(p->Scsi_Dev[tindex][lun] != NULL)
+		    {
+		      p->dev_max_queue_depth[tindex] -= diff;
+		      scsi_adjust_queue_depth(p->Scsi_Dev[tindex][lun], 1,
+				              p->dev_lun_queue_depth[tindex]);
+		      if(p->dev_temp_queue_depth[tindex] > p->dev_max_queue_depth[tindex])
+		        p->dev_temp_queue_depth[tindex] = p->dev_max_queue_depth[tindex];
+		    }
+		  }
                   p->dev_last_queue_full[tindex] = 0;
                   p->dev_last_queue_full_count[tindex] = 0;
-                  p->dev_temp_queue_depth[tindex] = 
-                    p->dev_active_cmds[tindex];
                 }
                 else if (p->dev_active_cmds[tindex] == 0)
                 {
@@ -7023,10 +6952,10 @@
  *   with queue depths for individual devices.  It also allows tagged
  *   queueing to be [en|dis]abled for a specific adapter.
  *-F*************************************************************************/
-static int
+static void
 aic7xxx_device_queue_depth(struct aic7xxx_host *p, Scsi_Device *device)
 {
-  int default_depth = 3;
+  int default_depth = p->host->hostt->cmd_per_lun;
   unsigned char tindex;
   unsigned short target_mask;
 
@@ -7036,12 +6965,69 @@
   if (p->dev_max_queue_depth[tindex] > 1)
   {
     /*
-     * We've already scanned this device, leave it alone
+     * We've already scanned some lun on this device and enabled tagged
+     * queueing on it.  So, as long as this lun also supports tagged
+     * queueing, enable it here with the same depth.  Call SCSI mid layer
+     * to adjust depth on this device, and add enough to the max_queue_depth
+     * to cover the commands for this lun.
+     *
+     * Note: there is a shortcoming here.  The aic7xxx driver really assumes
+     * that if any lun on a device supports tagged queueing, then they *all*
+     * do.  Our p->tagenable field is on a per target id basis and doesn't
+     * differentiate for different luns.  If we end up with one lun that
+     * doesn't support tagged queueing, it's going to disable tagged queueing
+     * on *all* the luns on that target ID :-(
      */
-    return(p->dev_max_queue_depth[tindex]);
+    if(device->tagged_supported) {
+      if (aic7xxx_verbose & VERBOSE_NEGOTIATION2)
+      {
+        printk(INFO_LEAD "Enabled tagged queuing, queue depth %d.\n",
+               p->host_no, device->channel, device->id,
+               device->lun, device->queue_depth);
+      }
+      p->dev_max_queue_depth[tindex] += p->dev_lun_queue_depth[tindex];
+      p->dev_temp_queue_depth[tindex] += p->dev_lun_queue_depth[tindex];
+      scsi_adjust_queue_depth(device, 1, p->dev_lun_queue_depth[tindex]);
+    }
+    else
+    {
+      int lun;
+      /*
+       * Uh ohh, this is what I was talking about.  All the other devices on
+       * this target ID that support tagged queueing are going to end up
+       * getting tagged queueing turned off because of this device.  Print
+       * out a message to this effect for the user, then disable tagged
+       * queueing on all the devices on this ID.
+       */
+      printk(WARN_LEAD "does not support tagged queuing while other luns on\n"
+             "          the same target ID do!!  Tagged queueing will be disabled for\n"
+             "          all luns on this target ID!!\n", p->host_no,
+	     device->channel, device->id, device->lun);
+      
+      p->dev_lun_queue_depth[tindex] = default_depth;
+      p->dev_scbs_needed[tindex] = 0;
+      p->dev_temp_queue_depth[tindex] = 1;
+      p->dev_max_queue_depth[tindex] = 1;
+      p->tagenable &= ~target_mask;
+
+      for(lun=0; lun < p->host->max_lun; lun++)
+      {
+        if(p->Scsi_Dev[tindex][lun] != NULL)
+	{
+          printk(WARN_LEAD "disabling tagged queuing.\n", p->host_no,
+                 p->Scsi_Dev[tindex][lun]->channel,
+		 p->Scsi_Dev[tindex][lun]->id,
+		 p->Scsi_Dev[tindex][lun]->lun);
+          scsi_adjust_queue_depth(p->Scsi_Dev[tindex][lun], 0, default_depth);
+	  p->dev_scbs_needed[tindex] += default_depth;
+	}
+      }
+    }
+    return;
   }
 
-  device->queue_depth = default_depth;
+  p->dev_lun_queue_depth[tindex] = default_depth;
+  p->dev_scbs_needed[tindex] = default_depth;
   p->dev_temp_queue_depth[tindex] = 1;
   p->dev_max_queue_depth[tindex] = 1;
   p->tagenable &= ~target_mask;
@@ -7051,7 +7037,7 @@
     int tag_enabled = TRUE;
 
     default_depth = AIC7XXX_CMDS_PER_DEVICE;
- 
+
     if (!(p->discenable & target_mask))
     {
       if (aic7xxx_verbose & VERBOSE_NEGOTIATION2)
@@ -7072,7 +7058,7 @@
                            " the aic7xxx.c source file.\n");
           print_warning = FALSE;
         }
-        device->queue_depth = default_depth;
+        p->dev_lun_queue_depth[tindex] = default_depth;
       }
       else
       {
@@ -7080,19 +7066,18 @@
         if (aic7xxx_tag_info[p->instance].tag_commands[tindex] == 255)
         {
           tag_enabled = FALSE;
-          device->queue_depth = 3;  /* Tagged queueing is disabled. */
         }
         else if (aic7xxx_tag_info[p->instance].tag_commands[tindex] == 0)
         {
-          device->queue_depth = default_depth;
+          p->dev_lun_queue_depth[tindex] = default_depth;
         }
         else
         {
-          device->queue_depth =
+          p->dev_lun_queue_depth[tindex] =
             aic7xxx_tag_info[p->instance].tag_commands[tindex];
         }
       }
-      if ((device->tagged_queue == 0) && tag_enabled)
+      if (tag_enabled)
       {
         if (aic7xxx_verbose & VERBOSE_NEGOTIATION2)
         {
@@ -7100,46 +7085,70 @@
                 p->host_no, device->channel, device->id,
                 device->lun, device->queue_depth);
         }
-        p->dev_max_queue_depth[tindex] = device->queue_depth;
-        p->dev_temp_queue_depth[tindex] = device->queue_depth;
+        p->dev_max_queue_depth[tindex] = p->dev_lun_queue_depth[tindex];
+        p->dev_temp_queue_depth[tindex] = p->dev_lun_queue_depth[tindex];
+        p->dev_scbs_needed[tindex] = p->dev_lun_queue_depth[tindex];
         p->tagenable |= target_mask;
         p->orderedtag |= target_mask;
-        device->tagged_queue = 1;
-        device->current_tag = SCB_LIST_NULL;
+	scsi_adjust_queue_depth(device, 1, p->dev_lun_queue_depth[tindex]);
       }
     }
   }
-  return(p->dev_max_queue_depth[tindex]);
+  return;
 }
 
 /*+F*************************************************************************
  * Function:
- *   aic7xxx_select_queue_depth
+ *   aic7xxx_slave_detach
  *
  * Description:
- *   Sets the queue depth for each SCSI device hanging off the input
- *   host adapter.  We use a queue depth of 2 for devices that do not
- *   support tagged queueing.  If AIC7XXX_CMDS_PER_LUN is defined, we
- *   use that for tagged queueing devices; otherwise we use our own
- *   algorithm for determining the queue depth based on the maximum
- *   SCBs for the controller.
+ *   prepare for this device to go away
  *-F*************************************************************************/
-static void
-aic7xxx_select_queue_depth(struct Scsi_Host *host,
-    Scsi_Device *scsi_devs)
+void
+aic7xxx_slave_detach(Scsi_Device *sdpnt)
 {
-  Scsi_Device *device;
-  struct aic7xxx_host *p = (struct aic7xxx_host *) host->hostdata;
-  int scbnum;
+  struct aic7xxx_host *p = (struct aic7xxx_host *) sdpnt->host->hostdata;
+  int lun, tindex;
 
-  scbnum = 0;
-  for (device = scsi_devs; device != NULL; device = device->next)
+  tindex = sdpnt->id | (sdpnt->channel << 3);
+  lun = sdpnt->lun;
+  if(p->Scsi_Dev[tindex][lun] == NULL)
+    return;
+
+  if(p->tagenable & (1 << tindex))
   {
-    if (device->host == host)
-    {
-      scbnum += aic7xxx_device_queue_depth(p, device);
-    }
+    p->dev_max_queue_depth[tindex] -= p->dev_lun_queue_depth[tindex];
+    if(p->dev_temp_queue_depth[tindex] > p->dev_max_queue_depth[tindex])
+      p->dev_temp_queue_depth[tindex] = p->dev_max_queue_depth[tindex];
   }
+  p->dev_scbs_needed[tindex] -= p->dev_lun_queue_depth[tindex];
+  p->Scsi_Dev[tindex][lun] = NULL;
+  return;
+}
+
+/*+F*************************************************************************
+ * Function:
+ *   aic7xxx_slave_attach
+ *
+ * Description:
+ *   Configure the device we are attaching to the controller.  This is
+ *   where we get to do things like scan the INQUIRY data, set queue
+ *   depths, allocate command structs, etc.
+ *-F*************************************************************************/
+int
+aic7xxx_slave_attach(Scsi_Device *sdpnt)
+{
+  struct aic7xxx_host *p = (struct aic7xxx_host *) sdpnt->host->hostdata;
+  int scbnum, tindex, i;
+
+  tindex = sdpnt->id | (sdpnt->channel << 3);
+  p->dev_flags[tindex] |= DEVICE_PRESENT;
+
+  p->Scsi_Dev[tindex][sdpnt->lun] = sdpnt;
+  aic7xxx_device_queue_depth(p, sdpnt);
+
+  for(i = 0, scbnum = 0; i < p->host->max_id; i++)
+    scbnum += p->dev_scbs_needed[i];
   while (scbnum > p->scb_data->numscbs)
   {
     /*
@@ -7148,8 +7157,77 @@
      * the SCB in order to perform a swap operation (possible deadlock)
      */
     if ( aic7xxx_allocate_scb(p) == 0 )
-      return;
+      break;
+  }
+
+  /*
+   * We only need to check INQUIRY data on one lun of multi lun devices
+   * since speed negotiations are not lun specific.  Once we've check this
+   * particular target id once, the DEVICE_PRESENT flag will be set.
+   */
+  if (!(p->dev_flags[tindex] & DEVICE_DTR_SCANNED))
+  {
+    p->dev_flags[tindex] |= DEVICE_DTR_SCANNED;
+
+    if ( sdpnt->wdtr && (p->features & AHC_WIDE) )
+    {
+      p->needwdtr |= (1<<tindex);
+      p->needwdtr_copy |= (1<<tindex);
+      p->transinfo[tindex].goal_width = p->transinfo[tindex].user_width;
+    }
+    else
+    {
+      p->needwdtr &= ~(1<<tindex);
+      p->needwdtr_copy &= ~(1<<tindex);
+      pause_sequencer(p);
+      aic7xxx_set_width(p, sdpnt->id, sdpnt->channel, sdpnt->lun,
+                        MSG_EXT_WDTR_BUS_8_BIT, (AHC_TRANS_ACTIVE |
+                                                 AHC_TRANS_GOAL |
+                                                 AHC_TRANS_CUR) );
+      unpause_sequencer(p, FALSE);
+    }
+    if ( sdpnt->sdtr && p->transinfo[tindex].user_offset )
+    {
+      p->transinfo[tindex].goal_period = p->transinfo[tindex].user_period;
+      p->transinfo[tindex].goal_options = p->transinfo[tindex].user_options;
+      if (p->features & AHC_ULTRA2)
+        p->transinfo[tindex].goal_offset = MAX_OFFSET_ULTRA2;
+      else if (p->transinfo[tindex].goal_width == MSG_EXT_WDTR_BUS_16_BIT)
+        p->transinfo[tindex].goal_offset = MAX_OFFSET_16BIT;
+      else
+        p->transinfo[tindex].goal_offset = MAX_OFFSET_8BIT;
+      if ( sdpnt->ppr && p->transinfo[tindex].user_period <= 9 &&
+             p->transinfo[tindex].user_options )
+      {
+        p->needppr |= (1<<tindex);
+        p->needppr_copy |= (1<<tindex);
+        p->needsdtr &= ~(1<<tindex);
+        p->needsdtr_copy &= ~(1<<tindex);
+        p->needwdtr &= ~(1<<tindex);
+        p->needwdtr_copy &= ~(1<<tindex);
+        p->dev_flags[tindex] |= DEVICE_SCSI_3;
+      }
+      else
+      {
+        p->needsdtr |= (1<<tindex);
+        p->needsdtr_copy |= (1<<tindex);
+        p->transinfo[tindex].goal_period = 
+          MAX(10, p->transinfo[tindex].goal_period);
+        p->transinfo[tindex].goal_options = 0;
+      }
+    }
+    else
+    {
+      p->needsdtr &= ~(1<<tindex);
+      p->needsdtr_copy &= ~(1<<tindex);
+      p->transinfo[tindex].goal_period = 255;
+      p->transinfo[tindex].goal_offset = 0;
+      p->transinfo[tindex].goal_options = 0;
+    }
+    p->dev_flags[tindex] |= DEVICE_PRINT_DTR;
   }
+
+  return(0);
 }
 
 /*+F*************************************************************************
@@ -8246,7 +8324,6 @@
   host->can_queue = AIC7XXX_MAXSCB;
   host->cmd_per_lun = 3;
   host->sg_tablesize = AIC7XXX_MAX_SG;
-  host->select_queue_depths = aic7xxx_select_queue_depth;
   host->this_id = p->scsi_id;
   host->io_port = p->base;
   host->n_io_port = 0xFF;
diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Wed Oct  9 05:38:48 2002
+++ b/drivers/scsi/hosts.h	Wed Oct  9 05:38:48 2002
@@ -97,6 +97,10 @@
      */
     int (* detect)(struct SHT *);
 
+    /*
+     * This function is only used by one driver and will be going away
+     * once it switches over to using the slave_detach() function instead.
+     */
     int (*revoke)(Scsi_Device *);
 
     /* Used with loadable modules to unload the host structures.  Note:
@@ -200,11 +204,59 @@
     int (* reset)(Scsi_Cmnd *, unsigned int);
 
     /*
-     * This function is used to select synchronous communications,
-     * which will result in a higher data throughput.  Not implemented
-     * yet.
+     * Once the device has responded to an INQUIRY and we know the device
+     * is online, call into the low level driver with the Scsi_Device *
+     * (so that the low level driver may save it off in a safe location
+     * for later use in calling scsi_adjust_queue_depth() or possibly
+     * other scsi_* functions) and char * to the INQUIRY return data buffer.
+     * This way, low level drivers will no longer have to snoop INQUIRY data
+     * to see if a drive supports PPR message protocol for Ultra160 speed
+     * negotiations or other similar items.  Instead it can simply wait until
+     * the scsi mid layer calls them with the data in hand and then it can
+     * do it's checking of INQUIRY data.  This will happen once for each new
+     * device added on this controller (including once for each lun on
+     * multi-lun devices, so low level drivers should take care to make
+     * sure that if they do tagged queueing on a per physical unit basis
+     * instead of a per logical unit basis that they have the mid layer
+     * allocate tags accordingly).
+     *
+     * Things currently recommended to be handled at this time include:
+     *
+     * 1.  Checking for tagged queueing capability and if able then calling
+     *     scsi_adjust_queue_depth() with the device pointer and the
+     *     suggested new queue depth.
+     * 2.  Checking for things such as SCSI level or DT bit in order to
+     *     determine if PPR message protocols are appropriate on this
+     *     device (or any other scsi INQUIRY data specific things the
+     *     driver wants to know in order to properly handle this device).
+     * 3.  Allocating command structs that the device will need.
+     * 4.  Setting the default timeout on this device (if needed).
+     * 5.  Saving the Scsi_Device pointer so that the low level driver
+     *     will be able to easily call back into scsi_adjust_queue_depth
+     *     again should it be determined that the queue depth for this
+     *     device should be lower or higher than it is initially set to.
+     * 6.  Allocate device data structures as needed that can be attached
+     *     to the Scsi_Device * via SDpnt->host_device_ptr
+     * 7.  Anything else the low level driver might want to do on a device
+     *     specific setup basis...
+     * 8.  Return 0 on success, non-0 on error.  The device will be marked
+     *     as offline on error so that no access will occur.
+     */
+    int (* slave_attach)(Scsi_Device *);
+
+    /*
+     * If we are getting ready to remove a device from the scsi chain then
+     * we call into the low level driver to let them know.  Once a low
+     * level driver has been informed that a drive is going away, the low
+     * level driver *must* remove it's pointer to the Scsi_Device because
+     * it is going to be kfree()'ed shortly.  It is no longer safe to call
+     * any mid layer functions with this Scsi_Device *.  Additionally, the
+     * mid layer will not make any more calls into the low level driver's
+     * queue routine with this device, so it is safe for the device driver
+     * to deallocate all structs/commands/etc that is has allocated
+     * specifically for this device at the time of this call.
      */
-    int (* slave_attach)(int, int);
+    void (* slave_detach)(Scsi_Device *);
 
     /*
      * This function determines the bios parameters for a given
@@ -217,6 +269,8 @@
 
     /*
      * Used to set the queue depth for a specific device.
+     *
+     * Once the slave_attach() function is in full use, this will go away.
      */
     void (*select_queue_depths)(struct Scsi_Host *, Scsi_Device *);
 
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Wed Oct  9 05:38:48 2002
+++ b/drivers/scsi/scsi.c	Wed Oct  9 05:38:48 2002
@@ -551,6 +551,7 @@
 {
 	unsigned long flags;
         Scsi_Device * SDpnt;
+	int alloc_cmd = 0;
 
 	spin_lock_irqsave(&device_request_lock, flags);
 
@@ -567,6 +568,25 @@
 				   atomic_read(&SCpnt->host->host_active),
 				   SCpnt->host->host_failed));
 
+	if(SDpnt->queue_depth > SDpnt->new_queue_depth) {
+		Scsi_Cmnd *prev, *next;
+		/*
+		 * Release the command block and decrement the queue
+		 * depth.
+		 */
+		for(prev = NULL, next = SDpnt->device_queue;
+				next != SCpnt;
+				prev = next, next = next->next) ;
+		if(prev == NULL)
+			SDpnt->device_queue = next->next;
+		else
+			prev->next = next->next;
+		kfree((char *)SCpnt);
+		SDpnt->queue_depth--;
+	} else if(SDpnt->queue_depth < SDpnt->new_queue_depth) {
+		alloc_cmd = 1;
+		SDpnt->queue_depth++;
+	}
 	spin_unlock_irqrestore(&device_request_lock, flags);
 
         /*
@@ -575,6 +595,48 @@
          * they wake up.  
          */
 	wake_up(&SDpnt->scpnt_wait);
+
+	/*
+	 * We are happy to release command blocks in the scope of the
+	 * device_request_lock since that's nice and quick, but allocation
+	 * can take more time so do it outside that scope instead.
+	 */
+	if(alloc_cmd) {
+		Scsi_Cmnd *newSCpnt;
+
+		newSCpnt = kmalloc(sizeof(Scsi_Cmnd), GFP_ATOMIC |
+				(SDpnt->host->unchecked_isa_dma ?
+				 GFP_DMA : 0));
+		if(newSCpnt) {
+			memset(newSCpnt, 0, sizeof(Scsi_Cmnd));
+			newSCpnt->host = SDpnt->host;
+			newSCpnt->device = SDpnt;
+			newSCpnt->target = SDpnt->id;
+			newSCpnt->lun = SDpnt->lun;
+			newSCpnt->channel = SDpnt->channel;
+			newSCpnt->request = NULL;
+			newSCpnt->use_sg = 0;
+			newSCpnt->old_use_sg = 0;
+			newSCpnt->old_cmd_len = 0;
+			newSCpnt->underflow = 0;
+			newSCpnt->old_underflow = 0;
+			newSCpnt->transfersize = 0;
+			newSCpnt->resid = 0;
+			newSCpnt->serial_number = 0;
+			newSCpnt->serial_number_at_timeout = 0;
+			newSCpnt->host_scribble = NULL;
+			newSCpnt->state = SCSI_STATE_UNUSED;
+			newSCpnt->owner = SCSI_OWNER_NOBODY;
+			spin_lock_irqsave(&device_request_lock, flags);
+			newSCpnt->next = SDpnt->device_queue;
+			SDpnt->device_queue = newSCpnt;
+			spin_unlock_irqrestore(&device_request_lock, flags);
+		} else {
+			spin_lock_irqsave(&device_request_lock, flags);
+			SDpnt->queue_depth--;
+			spin_unlock_irqrestore(&device_request_lock, flags);
+		}
+	}
 }
 
 /*
@@ -1447,8 +1509,8 @@
 		SDpnt->device_queue = SCnext = SCpnt->next;
 		kfree((char *) SCpnt);
 	}
-	SDpnt->has_cmdblocks = 0;
 	SDpnt->queue_depth = 0;
+	SDpnt->new_queue_depth = 0;
 	spin_unlock_irqrestore(&device_request_lock, flags);
 }
 
@@ -1463,63 +1525,115 @@
  *
  * Lock status: No locking assumed or required.
  *
- * Notes:
+ * Notes:	We really only allocate one command here.  We will allocate
+ *		more commands as needed once the device goes into real use.
  */
 void scsi_build_commandblocks(Scsi_Device * SDpnt)
 {
 	unsigned long flags;
-	struct Scsi_Host *host = SDpnt->host;
-	int j;
 	Scsi_Cmnd *SCpnt;
 
+	if (SDpnt->queue_depth != 0)
+		return;
+		
+	SCpnt = (Scsi_Cmnd *) kmalloc(sizeof(Scsi_Cmnd), GFP_ATOMIC |
+			(SDpnt->host->unchecked_isa_dma ? GFP_DMA : 0));
+	if (NULL == SCpnt) {
+		/*
+		 * Since we don't currently have *any* command blocks on this
+		 * device, go ahead and try an atomic allocation...
+		 */
+		SCpnt = (Scsi_Cmnd *) kmalloc(sizeof(Scsi_Cmnd), GFP_ATOMIC |
+			(SDpnt->host->unchecked_isa_dma ? GFP_DMA : 0));
+		if (NULL == SCpnt)
+			return;	/* Oops, we aren't going anywhere for now */
+	}
+
+	memset(SCpnt, 0, sizeof(Scsi_Cmnd));
+	SCpnt->host = SDpnt->host;
+	SCpnt->device = SDpnt;
+	SCpnt->target = SDpnt->id;
+	SCpnt->lun = SDpnt->lun;
+	SCpnt->channel = SDpnt->channel;
+	SCpnt->request = NULL;
+	SCpnt->use_sg = 0;
+	SCpnt->old_use_sg = 0;
+	SCpnt->old_cmd_len = 0;
+	SCpnt->underflow = 0;
+	SCpnt->old_underflow = 0;
+	SCpnt->transfersize = 0;
+	SCpnt->resid = 0;
+	SCpnt->serial_number = 0;
+	SCpnt->serial_number_at_timeout = 0;
+	SCpnt->host_scribble = NULL;
+	SCpnt->state = SCSI_STATE_UNUSED;
+	SCpnt->owner = SCSI_OWNER_NOBODY;
 	spin_lock_irqsave(&device_request_lock, flags);
+	if(SDpnt->new_queue_depth == 0)
+		SDpnt->new_queue_depth = 1;
+	SDpnt->queue_depth++;
+	SCpnt->next = SDpnt->device_queue;
+	SDpnt->device_queue = SCpnt;
+	spin_unlock_irqrestore(&device_request_lock, flags);
+}
 
-	if (SDpnt->queue_depth == 0)
+/*
+ * Function:	scsi_adjust_queue_depth()
+ *
+ * Purpose:	Allow low level drivers to tell us to change the queue depth
+ * 		on a specific SCSI device
+ *
+ * Arguments:	SDpnt	- SCSI Device in question
+ * 		tagged	- Do we use tagged queueing (non-0) or do we treat
+ * 			  this device as an untagged device (0)
+ * 		tags	- Number of tags allowed if tagged queueing enabled,
+ * 			  or number of commands the low level driver can
+ * 			  queue up in non-tagged mode (as per cmd_per_lun).
+ *
+ * Returns:	Nothing
+ *
+ * Lock Status:	None held on entry
+ *
+ * Notes:	Low level drivers may call this at any time and we will do
+ * 		the right thing depending on whether or not the device is
+ * 		currently active and whether or not it even has the
+ * 		command blocks built yet.
+ *
+ * 		If cmdblocks != 0 then we are a live device.  We just set the
+ * 		new_queue_depth variable and when the scsi completion handler
+ * 		notices that queue_depth != new_queue_depth it will work to
+ *		rectify the situation.  If new_queue_depth is less than current
+ *		queue_depth, then it will free the completed command instead of
+ *		putting it back on the free list and dec queue_depth.  Otherwise
+ *		it will try to allocate a new command block for the device and
+ *		put it on the free list along with the command that is being
+ *		completed.  Obviously, if the device isn't doing anything then
+ *		neither is this code, so it will bring the devices queue depth
+ *		back into line when the device is actually being used.  This
+ *		keeps us from needing to fire off a kernel thread or some such
+ *		nonsense (this routine can be called from interrupt code, so
+ *		handling allocations here would be tricky and risky, making
+ *		a kernel thread a much safer way to go if we wanted to handle
+ *		the work immediately instead of letting it get done a little
+ *		at a time in the completion handler).
+ */
+void scsi_adjust_queue_depth(Scsi_Device *SDpnt, int tagged, int tags)
+{
+	unsigned long flags;
+
+	/*
+	 * refuse to set tagged depth to an unworkable size
+	 */
+	if(tags == 0)
+		return;
+	spin_lock_irqsave(&device_request_lock, flags);
+	SDpnt->new_queue_depth = tags;
+	SDpnt->tagged_queue = tagged;
+	spin_unlock_irqrestore(&device_request_lock, flags);
+	if(SDpnt->queue_depth == 0)
 	{
-		SDpnt->queue_depth = host->cmd_per_lun;
-		if (SDpnt->queue_depth == 0)
-			SDpnt->queue_depth = 1; /* live to fight another day */
-	}
-	SDpnt->device_queue = NULL;
-
-	for (j = 0; j < SDpnt->queue_depth; j++) {
-		SCpnt = (Scsi_Cmnd *)
-		    kmalloc(sizeof(Scsi_Cmnd),
-				     GFP_ATOMIC |
-				(host->unchecked_isa_dma ? GFP_DMA : 0));
-		if (NULL == SCpnt)
-			break;	/* If not, the next line will oops ... */
-		memset(SCpnt, 0, sizeof(Scsi_Cmnd));
-		SCpnt->host = host;
-		SCpnt->device = SDpnt;
-		SCpnt->target = SDpnt->id;
-		SCpnt->lun = SDpnt->lun;
-		SCpnt->channel = SDpnt->channel;
-		SCpnt->request = NULL;
-		SCpnt->use_sg = 0;
-		SCpnt->old_use_sg = 0;
-		SCpnt->old_cmd_len = 0;
-		SCpnt->underflow = 0;
-		SCpnt->old_underflow = 0;
-		SCpnt->transfersize = 0;
-		SCpnt->resid = 0;
-		SCpnt->serial_number = 0;
-		SCpnt->serial_number_at_timeout = 0;
-		SCpnt->host_scribble = NULL;
-		SCpnt->next = SDpnt->device_queue;
-		SDpnt->device_queue = SCpnt;
-		SCpnt->state = SCSI_STATE_UNUSED;
-		SCpnt->owner = SCSI_OWNER_NOBODY;
-	}
-	if (j < SDpnt->queue_depth) {	/* low on space (D.Gilbert 990424) */
-		printk(KERN_WARNING "scsi_build_commandblocks: want=%d, space for=%d blocks\n",
-		       SDpnt->queue_depth, j);
-		SDpnt->queue_depth = j;
-		SDpnt->has_cmdblocks = (0 != j);
-	} else {
-		SDpnt->has_cmdblocks = 1;
+		scsi_build_commandblocks(SDpnt);
 	}
-	spin_unlock_irqrestore(&device_request_lock, flags);
 }
 
 void __init scsi_host_no_insert(char *str, int n)
@@ -1758,13 +1872,6 @@
 			goto out;	/* We do not yet support unplugging */
 
 		scan_scsis(HBA_ptr, 1, channel, id, lun);
-
-		/* FIXME (DB) This assumes that the queue_depth routines can be used
-		   in this context as well, while they were all designed to be
-		   called only once after the detect routine. (DB) */
-		/* queue_depth routine moved to inside scan_scsis(,1,,,) so
-		   it is called before build_commandblocks() */
-
 		err = length;
 		goto out;
 	}
@@ -1826,6 +1933,8 @@
 			 */
                         if (HBA_ptr->hostt->revoke)
                                 HBA_ptr->hostt->revoke(scd);
+			if (HBA_ptr->hostt->slave_detach)
+				(*HBA_ptr->hostt->slave_detach) (scd);
 			devfs_unregister (scd->de);
 			scsi_release_commandblocks(scd);
 
@@ -1963,9 +2072,6 @@
 				/* first register parent with driverfs */
 				device_register(&shpnt->host_driverfs_dev);
 				scan_scsis(shpnt, 0, 0, 0, 0);
-				if (shpnt->select_queue_depths != NULL) {
-					(shpnt->select_queue_depths) (shpnt, shpnt->host_queue);
-				}
 			}
 		}
 
@@ -1985,7 +2091,7 @@
 							(*sdtpnt->attach) (SDpnt);
 					if (SDpnt->attached) {
 						scsi_build_commandblocks(SDpnt);
-						if (0 == SDpnt->has_cmdblocks)
+						if (SDpnt->queue_depth == 0)
 							out_of_space = 1;
 					}
 				}
@@ -2116,6 +2222,8 @@
 				printk(KERN_ERR "Attached usage count = %d\n", SDpnt->attached);
 				goto err_out;
 			}
+			if (shpnt->hostt->slave_detach)
+				(*shpnt->hostt->slave_detach) (SDpnt);
 			devfs_unregister (SDpnt->de);
 			put_device(&SDpnt->sdev_driverfs_dev);
 		}
@@ -2272,10 +2380,10 @@
 			 * If this driver attached to the device, and don't have any
 			 * command blocks for this device, allocate some.
 			 */
-			if (SDpnt->attached && SDpnt->has_cmdblocks == 0) {
+			if (SDpnt->attached && SDpnt->queue_depth == 0) {
 				SDpnt->online = TRUE;
 				scsi_build_commandblocks(SDpnt);
-				if (0 == SDpnt->has_cmdblocks)
+				if (SDpnt->queue_depth == 0)
 					out_of_space = 1;
 			}
 		}
@@ -2325,6 +2433,8 @@
 				 * Nobody is using this device any more.  Free all of the
 				 * command structures.
 				 */
+				if (shpnt->hostt->slave_detach)
+					(*shpnt->hostt->slave_detach) (SDpnt);
 				scsi_release_commandblocks(SDpnt);
 			}
 		}
@@ -2678,9 +2788,13 @@
         SDpnt->host = SHpnt;
         SDpnt->id = SHpnt->this_id;
         SDpnt->type = -1;
-        SDpnt->queue_depth = 1;
+	SDpnt->new_queue_depth = 1;
         
 	scsi_build_commandblocks(SDpnt);
+	if(SDpnt->queue_depth == 0) {
+		kfree(SDpnt);
+		return NULL;
+	}
 
 	scsi_initialize_queue(SDpnt, SHpnt);
 
diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Wed Oct  9 05:38:48 2002
+++ b/drivers/scsi/scsi.h	Wed Oct  9 05:38:48 2002
@@ -481,6 +481,7 @@
 extern void scsi_bottom_half_handler(void);
 extern void scsi_release_commandblocks(Scsi_Device * SDpnt);
 extern void scsi_build_commandblocks(Scsi_Device * SDpnt);
+extern void scsi_adjust_queue_depth(Scsi_Device *, int, int);
 extern void scsi_done(Scsi_Cmnd * SCpnt);
 extern void scsi_finish_command(Scsi_Cmnd *);
 extern int scsi_retry_command(Scsi_Cmnd *);
@@ -563,6 +564,8 @@
 	volatile unsigned short device_busy;	/* commands actually active on low-level */
 	Scsi_Cmnd *device_queue;	/* queue of SCSI Command structures */
         Scsi_Cmnd *current_cmnd;	/* currently active command */
+	unsigned short queue_depth;	/* How deep of a queue we have */
+	unsigned short new_queue_depth; /* How deep of a queue we want */
 
 	unsigned int id, lun, channel;
 
@@ -586,24 +589,25 @@
 	unsigned char current_tag;	/* current tag */
 	unsigned char sync_min_period;	/* Not less than this period */
 	unsigned char sync_max_offset;	/* Not greater than this offset */
-	unsigned char queue_depth;	/* How deep a queue to use */
 
 	unsigned online:1;
 	unsigned writeable:1;
 	unsigned removable:1;
 	unsigned random:1;
-	unsigned has_cmdblocks:1;
 	unsigned changed:1;	/* Data invalid due to media change */
 	unsigned busy:1;	/* Used to prevent races */
 	unsigned lockable:1;	/* Able to prevent media removal */
 	unsigned borken:1;	/* Tell the Seagate driver to be 
 				 * painfully slow on this device */
-	unsigned tagged_supported:1;	/* Supports SCSI-II tagged queuing */
-	unsigned tagged_queue:1;	/* SCSI-II tagged queuing enabled */
 	unsigned disconnect:1;	/* can disconnect */
 	unsigned soft_reset:1;	/* Uses soft reset option */
-	unsigned sync:1;	/* Negotiate for sync transfers */
-	unsigned wide:1;	/* Negotiate for WIDE transfers */
+	unsigned sdtr:1;	/* Device supports SDTR messages */
+	unsigned wdtr:1;	/* Device supports WDTR messages */
+	unsigned ppr:1;		/* Device supports PPR messages */
+	unsigned tagged_supported:1;	/* Supports SCSI-II tagged queuing */
+	unsigned tagged_queue:1;	/* SCSI-II tagged queuing enabled */
+	unsigned simple_tags:1;	/* Device supports simple queue tag messages */
+	unsigned ordered_tags:1;/* Device supports ordered queue tag messages */
 	unsigned single_lun:1;	/* Indicates we should only allow I/O to
 				 * one of the luns for the device at a 
 				 * time. */
diff -Nru a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Wed Oct  9 05:38:48 2002
+++ b/drivers/scsi/scsi_scan.c	Wed Oct  9 05:38:48 2002
@@ -1409,6 +1409,14 @@
 	sdev->lockable = sdev->removable;
 	sdev->soft_reset = (inq_result[7] & 1) && ((inq_result[3] & 7) == 2);
 
+	if (sdev->scsi_level >= SCSI_3 || (sdev->inquiry_len > 56 &&
+		inq_result[56] & 0x04))
+		sdev->ppr = 1;
+	if (inq_result[7] & 0x60)
+		sdev->wdtr = 1;
+	if (inq_result[7] & 0x10)
+		sdev->sdtr = 1;
+
 	/*
 	 * XXX maybe move the identifier and driverfs/devfs setup to a new
 	 * function, and call them after this function is called.
@@ -1513,9 +1521,9 @@
 	 * XXX maybe change scsi_release_commandblocks to not reset
 	 * queue_depth to 0.
 	 */
-	sdevscan->queue_depth = 1;
+	sdevscan->new_queue_depth = 1;
 	scsi_build_commandblocks(sdevscan);
-	if (sdevscan->has_cmdblocks == 0)
+	if (sdevscan->queue_depth == 0)
 		goto alloc_failed;
 
 	sreq = scsi_allocate_request(sdevscan);
@@ -1589,7 +1597,7 @@
 		kfree(scsi_result);
 	if (sreq != NULL)
 		scsi_release_request(sreq);
-	if (sdevscan->has_cmdblocks != 0)
+	if (sdevscan->queue_depth != 0)
 		scsi_release_commandblocks(sdevscan);
 	return SCSI_SCAN_NO_RESPONSE;
 }
@@ -1743,9 +1751,9 @@
 	if (sdevscan->scsi_level < SCSI_3)
 		return 1;
 
-	sdevscan->queue_depth = 1;
+	sdevscan->new_queue_depth = 1;
 	scsi_build_commandblocks(sdevscan);
-	if (sdevscan->has_cmdblocks == 0) {
+	if (sdevscan->queue_depth == 0) {
 		printk(ALLOC_FAILURE_MSG, __FUNCTION__);
 		/*
 		 * We are out of memory, don't try scanning any further.
@@ -2018,6 +2026,17 @@
 		 */
 		if (shost->select_queue_depths != NULL)
 			(shost->select_queue_depths) (shost, shost->host_queue);
+		if (shost->hostt->slave_attach != NULL)
+			if ((shost->hostt->slave_attach) (sdev) != 0) {
+				/*
+				 * Low level driver failed to attach this
+				 * device, we've got to kick it back out
+				 * now as a result :-(
+				 */
+				printk("scsi_scan_selected_lun: slave_attach "
+					"failed, marking device OFFLINE.\n");
+				sdev->online = FALSE;
+			}
 
 		for (sdt = scsi_devicelist; sdt; sdt = sdt->next)
 			if (sdt->init && sdt->dev_noticed)
@@ -2028,7 +2047,7 @@
 				(*sdt->attach) (sdev);
 				if (sdev->attached) {
 					scsi_build_commandblocks(sdev);
-					if (sdev->has_cmdblocks == 0)
+					if (sdev->queue_depth == 0)
 						printk(ALLOC_FAILURE_MSG,
 						       __FUNCTION__);
 				}

--------------050305040100060105090500
Content-Type: text/plain;
 name="james_bottomley_scsi_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="james_bottomley_scsi_fix.patch"

Received: from localhost (nighthawk [127.0.0.1])
	by nighthawk.sr71.net (8.11.6/8.11.6) with ESMTP id g9B19MU01846
	for <dave@localhost>; Thu, 10 Oct 2002 18:09:22 -0700
Received: from imap.linux.ibm.com [9.27.103.44]
	by localhost with IMAP (fetchmail-5.9.0)
	for dave@localhost (multi-drop); Thu, 10 Oct 2002 18:09:22 -0700 (PDT)
Received: from localhost ([unix socket])
	by imap.linux.ibm.com (Cyrus v2.1.9) with LMTP; Thu, 10 Oct 2002 21:09:26 -0400
X-Sieve: CMU Sieve 2.2
Received: from smtp.linux.ibm.com (linux.ibm.com [9.26.4.197])
	by imap.linux.ibm.com (Postfix) with ESMTP id A15D57C017
	for <haveblue@imap.linux.ibm.com>; Thu, 10 Oct 2002 21:09:25 -0400 (EDT)
Received: from northrelay04.pok.ibm.com (northrelay04.pok.ibm.com [9.56.224.206])
	by smtp.linux.ibm.com (Postfix) with ESMTP id 04B4F3FE06
	for <haveblue@linux.ibm.com>; Thu, 10 Oct 2002 21:09:25 -0400 (EDT)
Received: from e2.ny.us.ibm.com (e2.esmtp.ibm.com [9.14.6.102])
	by northrelay04.pok.ibm.com (8.12.3/NCO/VER6.4) with ESMTP id g9B19IKf137968
	for <haveblue@us.ibm.com>; Thu, 10 Oct 2002 21:09:22 -0400
Received: from pogo.mtv1.steeleye.com (host194.steeleye.com [66.206.164.34])
	by e2.ny.us.ibm.com (8.12.2/8.12.2) with ESMTP id g9B19KHd065956
	for <haveblue@us.ibm.com>; Thu, 10 Oct 2002 21:09:20 -0400
Received: (from root@localhost)
	by pogo.mtv1.steeleye.com (8.9.3/8.9.3) id SAA07896
	for <haveblue@us.ibm.com>; Thu, 10 Oct 2002 18:09:19 -0700
Received: from localhost.localdomain (vpn-233.mtv1.steeleye.com [172.16.1.233])
	by pogo.mtv1.steeleye.com (8.9.3/8.9.3) with ESMTP id SAA07617;
	Thu, 10 Oct 2002 18:09:16 -0700
Received: from mulgrave (jejb@localhost)
	by localhost.localdomain (8.11.6/linuxconf) with ESMTP id g9B19FJ14530;
	Thu, 10 Oct 2002 18:09:16 -0700
Message-Id: <200210110109.g9B19FJ14530@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-scsi@vger.kernel.org
Subject: Re: Degraded I/O performance, since 2.5.41 
In-Reply-To: Message from Dave Hansen <haveblue@us.ibm.com> 
   of "Thu, 10 Oct 2002 16:48:47 PDT." <3DA611DF.3000206@us.ibm.com> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-5647072960"
Date: Thu, 10 Oct 2002 18:09:14 -0700
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
X-Spam-Status: No, hits=-7.3 required=5.0
	tests=IN_REP_TO,DOUBLE_CAPSWORD,UNIFIED_PATCH
	version=2.31
X-Spam-Level: 
X-Fetchmail-Warning: no recipient addresses matched declared local names

This is a multipart MIME message.

--==_Exmh_-5647072960
Content-Type: text/plain; charset=us-ascii

OK, this patch should fix it.  Do your performance numbers for ips improve 
again with this?

James


--==_Exmh_-5647072960
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== drivers/scsi/scsi_scan.c 1.24 vs edited =====
--- 1.24/drivers/scsi/scsi_scan.c	Tue Oct  8 15:45:57 2002
+++ edited/drivers/scsi/scsi_scan.c	Thu Oct 10 17:40:53 2002
@@ -1477,11 +1477,14 @@
 		if (sdt->detect)
 			sdev->attached += (*sdt->detect) (sdev);
 
-	if (sdev->host->hostt->slave_attach != NULL)
+	if (sdev->host->hostt->slave_attach != NULL) {
 		if (sdev->host->hostt->slave_attach(sdev) != 0) {
 			printk(KERN_INFO "scsi_add_lun: failed low level driver attach, setting device offline");
 			sdev->online = FALSE;
 		}
+	} else if(sdev->host->cmd_per_lun) {
+		scsi_adjust_queue_depth(sdev, 0, sdev->host->cmd_per_lun);
+	}
 
 	if (sdevnew != NULL)
 		*sdevnew = sdev;

--==_Exmh_-5647072960--



--------------050305040100060105090500--

