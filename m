Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136087AbRD0PMX>; Fri, 27 Apr 2001 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136084AbRD0PMP>; Fri, 27 Apr 2001 11:12:15 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:31822
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S136078AbRD0PL6>; Fri, 27 Apr 2001 11:11:58 -0400
Message-Id: <200104271511.LAA01271@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: "Roets, Chris" <Chris.Roets@compaq.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_14339044400"
Date: Fri, 27 Apr 2001 11:11:32 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_14339044400
Content-Type: text/plain; charset=us-ascii

I've copied linux SCSI and quoted the entire message below so they can follow.

Your assertion that this works in 2.2.16 is incorrect, the patch to fix the 
linux reservation conflict handler has never been added to the official tree.  
I suspect you actually don't have vanilla 2.2.16 but instead have a redhat or 
other distribution patched version.  Most distributions include the Steeleye 
SCSI clustering patches which correct reservation handling.

I've attached the complete patch, which fixes both the old and the new error 
handlers in the 2.2 kernel it applies against 2.2.18.

James Bottomley


> Problem :
> install two Linux-system with a shared scsi-bus and storage on that shared
> bus.
> suppose :
> system one : SCSI ID 7
> system two : SCSI ID 6
> shared disk : SCSI ID 4
> 
> By default, you can mount the disk on both system.  This is normal
> behavior, but
> may impose data corruption.
> To prevent this, you can SCSI-reserve a disk on one system.  If the other
> system
> would try to access this device, the system should return an i/o error due
> to the reservation.
> This is a common technique used in
> - Traditional Tru64 Unix ase clustering
> - Tr64 Unix V5 Clustering to accomplish i/o barriers
> - Windows-NT Clusters
> - Steel-eye clustering
> The reservation can be done using a standard tool like scu
> 
> scu -f /dev/sdb
> scu > reserve device
> 
> On Linux, this works fine under Kernel version 2.2.16.
> Below is the code that accomplish this
> /usr/src/linux/drivers/scsi/scsi_obsolete.c in routine scsi_old_done
>             case RESERVATION_CONFLICT:
>                 printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n",
>                        SCpnt->host->host_no, SCpnt->channel,
>                        SCpnt->device->id, SCpnt->device->lun);
>                 status = CMD_FINISHED; /* returns I/O error */
>                 break;
>             default:
> As of kernel version 2.2.18, this code has changed, If a scsi reserve
> error
> occurs, the device driver does a scsi reset.  This way the scsi
> reservation is
> gone, and the device can be accessed.
> /usr/src/linux/drivers/scsi/scsi_obsolete.c in routine scsi_old_done 
>             case RESERVATION_CONFLICT:
>                 printk("scsi%d, channel %d : RESERVATION CONFLICT
> performing"
>                        " reset.\n", SCpnt->host->host_no, SCpnt->channel);
>                 scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
>                 status = REDO;
>                 break;
> 
> Fix : delete the scsi reset in the kernel code
>             case RESERVATION_CONFLICT:
> /* Deleted Chris Roets
>                 printk("scsi%d, channel %d : RESERVATION CONFLICT
> performing"
>                        " reset.\n", SCpnt->host->host_no, SCpnt->channel);
>                 scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
>                 status = REDO;
> next four lines added */
>                 printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n",
>                        SCpnt->host->host_no, SCpnt->channel,
>                        SCpnt->device->id, SCpnt->device->lun);
>                 status = CMD_FINISHED; /* returns I/O error */
>                 break;
> 
> and rebuild the kernel.
> 
> This should get the customer being able to continue
> 
        Questions  :
> - why  is this scsi reset done/added as of kernel version 2.2.18
> - as we are talking about an obsolete routine, how is this accomplished 
>  in the new code and how is it activated.  
>

--==_Exmh_14339044400
Content-Type: text/plain ; name="scsi_reset-2.2.18.diff"; charset=us-ascii
Content-Description: scsi_reset-2.2.18.diff
Content-Disposition: attachment; filename="scsi_reset-2.2.18.diff"

Index: linux/2.2/drivers/scsi/scsi.c
diff -u linux/2.2/drivers/scsi/scsi.c:1.1.1.9 linux/2.2/drivers/scsi/scsi.c:1.1.1.9.2.4
--- linux/2.2/drivers/scsi/scsi.c:1.1.1.9	Thu Feb 15 12:53:35 2001
+++ linux/2.2/drivers/scsi/scsi.c	Fri Mar  2 18:04:40 2001
@@ -198,7 +198,13 @@
  */
 extern void scsi_old_done (Scsi_Cmnd *SCpnt);
 extern void scsi_old_times_out (Scsi_Cmnd * SCpnt);
+extern int scsi_old_reset(Scsi_Cmnd *SCpnt, unsigned int flag);
 
+/* 
+ * private interface into the new error handling code
+ */
+extern int scsi_new_reset(Scsi_Cmnd *SCpnt, unsigned int flag);
+
 #if CONFIG_PROC_FS
 extern int (* dispatch_scsi_info_ptr)(int ino, char *buffer, char **start,
 				      off_t offset, int length, int inout);
@@ -724,7 +730,7 @@
   SCSI_LOG_SCAN_BUS(3,print_hostbyte(SCpnt->result));
   SCSI_LOG_SCAN_BUS(3,printk("\n"));
 
-  if (SCpnt->result) {
+  if (SCpnt->result && status_byte(SCpnt->result) != RESERVATION_CONFLICT) {
     if (((driver_byte (SCpnt->result) & DRIVER_SENSE) ||
          (status_byte (SCpnt->result) & CHECK_CONDITION)) &&
         ((SCpnt->sense_buffer[0] & 0x70) >> 4) == 7) {
@@ -2180,6 +2186,87 @@
 	printk("\n");
 }
 
+/* Dummy done routine.  We don't want the bogus command used for the
+ * bus/device reset to find its way into the mid-layer so we intercept
+ * it here */
+static void
+scsi_reset_provider_done_command(Scsi_Cmnd *SCpnt) {
+    /* Empty function.  Some low level drivers will call scsi_done
+     * (and end up here), others won't bother */
+}
+
+/*
+ * Function:	scsi_reset_provider
+ *
+ * Purpose:	Send requested reset to a bus or device at any phase.
+ *
+ * Arguments:	device	- device to send reset to
+ *		flag - reset type (see scsi.h)
+ *
+ * Returns:	SUCCESS/FAILURE.
+ *
+ * Notes:	This is used by the SCSI Generic driver to provide
+ *		Bus/Device reset capability.
+ */
+int
+scsi_reset_provider(Scsi_Device *dev, int flag)
+{
+    int rtn;
+    unsigned long flags;
+    Scsi_Cmnd SC;
+    Scsi_Cmnd *SCpnt = &SC;
+
+    /* initialise the command */
+    memset(&SCpnt->eh_timeout, 0, sizeof(SCpnt->eh_timeout));
+    SCpnt->host                      	= dev->host;
+    SCpnt->device                    	= dev;
+    SCpnt->target                    	= dev->id;
+    SCpnt->lun                       	= dev->lun;
+    SCpnt->channel                   	= dev->channel;
+    SCpnt->request.rq_status         	= RQ_SCSI_BUSY;
+    SCpnt->request.sem	        	= NULL;
+    SCpnt->host_wait                 	= FALSE;
+    SCpnt->device_wait               	= FALSE;
+    SCpnt->use_sg                    	= 0;
+    SCpnt->old_use_sg                	= 0;
+    SCpnt->old_cmd_len               	= 0;
+    SCpnt->underflow                 	= 0;
+    SCpnt->transfersize              	= 0;
+    SCpnt->serial_number             	= 0;
+    SCpnt->serial_number_at_timeout  	= 0;
+    SCpnt->host_scribble             	= NULL;
+    SCpnt->next                      	= NULL;
+    SCpnt->state                     	= SCSI_STATE_INITIALIZING;
+    SCpnt->owner		     	= SCSI_OWNER_MIDLEVEL;
+
+    
+    memset(&SCpnt->cmnd, '\0', sizeof(SCpnt->cmnd));
+    
+    SCpnt->scsi_done 			= scsi_reset_provider_done_command;
+    SCpnt->done				= NULL;
+    SCpnt->reset_chain			= NULL;
+    
+    SCpnt->internal_timeout		= NORMAL_TIMEOUT;
+    SCpnt->abort_reason			= DID_ABORT;
+
+    /* sometimes the command can get back into the timer chain, so use
+     * the pid as an identifier */
+    SCpnt->pid				= 0;
+
+    if(dev->host->hostt->use_new_eh_code) {
+        rtn = scsi_new_reset(SCpnt, flag);
+    } else {
+        unsigned long flags;
+
+        spin_lock_irqsave(&io_request_lock, flags);
+        rtn = scsi_old_reset(SCpnt, flag);
+        spin_unlock_irqrestore(&io_request_lock, flags);
+    }
+
+    scsi_delete_timer(SCpnt);
+
+    return rtn;
+}
 
 #ifdef CONFIG_PROC_FS
 int scsi_proc_info(char *buffer, char **start, off_t offset, int length,
Index: linux/2.2/drivers/scsi/scsi.h
diff -u linux/2.2/drivers/scsi/scsi.h:1.1.1.4 linux/2.2/drivers/scsi/scsi.h:1.1.1.4.12.1
--- linux/2.2/drivers/scsi/scsi.h:1.1.1.4	Wed Jan  5 15:24:50 2000
+++ linux/2.2/drivers/scsi/scsi.h	Fri Feb 16 11:03:42 2001
@@ -732,6 +732,14 @@
 	remove_wait_queue(QUEUE, &wait);\
 	current->state = TASK_RUNNING;	\
     }; }
+/* old style reset request from external source (private to sg.c and
+ * scsi_error.c, supplied by scsi_obsolete.c)
+ * */
+#define SCSI_TRY_RESET_DEVICE	1
+#define SCSI_TRY_RESET_BUS	2
+#define SCSI_TRY_RESET_HOST	3
+
+extern int scsi_reset_provider(Scsi_Device *, int);
 
 #endif
 
Index: linux/2.2/drivers/scsi/scsi_error.c
diff -u linux/2.2/drivers/scsi/scsi_error.c:1.1.1.4 linux/2.2/drivers/scsi/scsi_error.c:1.1.1.4.2.1
--- linux/2.2/drivers/scsi/scsi_error.c:1.1.1.4	Sat Sep 23 12:39:02 2000
+++ linux/2.2/drivers/scsi/scsi_error.c	Fri Feb 16 11:03:42 2001
@@ -981,9 +981,14 @@
     case DID_SOFT_ERROR:
       return NEEDS_RETRY;
 
+    case DID_ERROR:
+      if(msg_byte(SCpnt->result) == COMMAND_COMPLETE 
+         && status_byte(SCpnt->result) == RESERVATION_CONFLICT)
+        /* execute reservation conflict processing code lower down */
+        break;
+      /* fall through */
     case DID_BUS_BUSY:
     case DID_PARITY:
-    case DID_ERROR:
       goto maybe_retry;
     case DID_TIME_OUT:
       /*
@@ -1059,8 +1064,12 @@
        */
       return SUCCESS;
     case BUSY:
-    case RESERVATION_CONFLICT:
       goto maybe_retry;
+    case RESERVATION_CONFLICT:
+      printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n", 
+             SCpnt->host->host_no, SCpnt->channel,
+             SCpnt->device->id, SCpnt->device->lun);
+       return SUCCESS;          /* causes immediate I/O error */
     default:
       return FAILED;
     }
@@ -2045,6 +2054,44 @@
 	 */
 	if( host->eh_notify != NULL )
 	  up(host->eh_notify);
+}
+
+/*
+ * Function:	scsi_new_reset
+ *
+ * Purpose:	Send requested reset to a bus or device at any phase.
+ *
+ * Arguments:	SCpnt	- command ptr to send reset with (usually a dummy)
+ *		flag	- reset type (see scsi.h)
+ *
+ * Returns:	SUCCESS/FAILURE.
+ *
+ * Notes:	This is used by the SCSI Generic driver to provide
+ *		Bus/Device reset capability.
+ */
+int
+scsi_new_reset(Scsi_Cmnd *SCpnt, int flag)
+{
+        int rtn;
+        switch(flag) {
+        case SCSI_TRY_RESET_DEVICE:
+                rtn = scsi_try_bus_device_reset(SCpnt, 0);
+                if(rtn == SUCCESS)
+                        break;
+                /* fall through */
+        case SCSI_TRY_RESET_BUS:
+                rtn = scsi_try_bus_reset(SCpnt);
+                if(rtn == SUCCESS)
+                        break;
+                /* fall through */
+        case SCSI_TRY_RESET_HOST:
+                rtn = scsi_try_host_reset(SCpnt);
+                break;
+        default:
+                rtn = FAILED;
+                break;
+        }
+        return rtn;
 }
 
 /*
Index: linux/2.2/drivers/scsi/scsi_obsolete.c
diff -u linux/2.2/drivers/scsi/scsi_obsolete.c:1.1.1.2 linux/2.2/drivers/scsi/scsi_obsolete.c:1.1.1.2.2.2
--- linux/2.2/drivers/scsi/scsi_obsolete.c:1.1.1.2	Thu Feb 15 12:53:43 2001
+++ linux/2.2/drivers/scsi/scsi_obsolete.c	Fri Mar  2 18:04:40 2001
@@ -507,11 +507,14 @@
 		break;
 
 	    case RESERVATION_CONFLICT:
-		printk("scsi%d, channel %d : RESERVATION CONFLICT performing"
-		       " reset.\n", SCpnt->host->host_no, SCpnt->channel);
-                scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
-		status = REDO;
-		break;
+                /* Most HAs will return an error for this, so usually
+                 * reservation conflicts will be processed under DID_ERROR
+                 * code */
+                printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n", 
+                       SCpnt->host->host_no, SCpnt->channel,
+                       SCpnt->device->id, SCpnt->device->lun);
+                status = CMD_FINISHED; /* returns I/O error */
+                break;
 	    default:
 		printk ("Internal error %s %d \n"
 			"status byte = %d \n", __FILE__,
@@ -564,6 +567,14 @@
 	exit  = (DRIVER_HARD | SUGGEST_ABORT);
 	break;
     case DID_ERROR:
+        if(msg_byte(result) == COMMAND_COMPLETE
+           && status_byte(result) == RESERVATION_CONFLICT) {
+            printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n", 
+                   SCpnt->host->host_no, SCpnt->channel,
+                   SCpnt->device->id, SCpnt->device->lun);
+            status = CMD_FINISHED; /* returns I/O error */
+            break;
+        }
 	status = MAYREDO;
 	exit = (DRIVER_HARD | SUGGEST_ABORT);
 	break;
@@ -1119,6 +1130,30 @@
 
   return rtn;
 }
+
+/* This function exports SCSI Bus, Device or Host reset capability
+ * and is for use with the SCSI generic driver.
+ */
+int scsi_old_reset(Scsi_Cmnd *SCpnt, unsigned int flag)
+{
+    unsigned int old_flags = SCSI_RESET_SYNCHRONOUS;
+
+    switch(flag) {
+    case SCSI_TRY_RESET_DEVICE:
+        /* no suggestion flags to add, device reset is default */
+        break;
+    case SCSI_TRY_RESET_BUS:
+        old_flags |= SCSI_RESET_SUGGEST_BUS_RESET;
+        break;
+    case SCSI_TRY_RESET_HOST:
+        old_flags |= SCSI_RESET_SUGGEST_HOST_RESET;
+        break;
+    default:
+        return FAILED;
+    }
+    return (scsi_reset(SCpnt, old_flags) == 0) ? SUCCESS : FAILED;
+}
+
 
 
 /*
Index: linux/2.2/drivers/scsi/scsi_syms.c
diff -u linux/2.2/drivers/scsi/scsi_syms.c:1.1.1.2 linux/2.2/drivers/scsi/scsi_syms.c:1.1.1.2.18.1
--- linux/2.2/drivers/scsi/scsi_syms.c:1.1.1.2	Thu Aug 26 11:18:33 1999
+++ linux/2.2/drivers/scsi/scsi_syms.c	Fri Feb 16 11:03:42 2001
@@ -80,5 +80,10 @@
 EXPORT_SYMBOL(scsi_devicelist);
 EXPORT_SYMBOL(scsi_device_types);
 
+/*
+ * This symbol is for the sg device only
+ */
+EXPORT_SYMBOL(scsi_reset_provider);
+
 
 #endif /* CONFIG_MODULES */

--==_Exmh_14339044400--


