Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbSAPRDg>; Wed, 16 Jan 2002 12:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279798AbSAPRD1>; Wed, 16 Jan 2002 12:03:27 -0500
Received: from h24-82-238-119.wp.shawcable.net ([24.82.238.119]:14341 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP
	id <S276424AbSAPRDR>; Wed, 16 Jan 2002 12:03:17 -0500
Date: Wed, 16 Jan 2002 11:03:15 -0600 (CST)
From: derek@signalmarketing.com
X-X-Sender: manmower@uberdeity.signalmarketing.com
To: linux-kernel@vger.kernel.org, <weber@nyc.rr.com>, <dougg@torque.net>
Subject: Re: linux 2.5 and ppa.c [PATCH]
Message-ID: <Pine.LNX.4.44.0201161101330.193-100000@uberdeity.signalmarketing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's my attempt at updating the ppa.c driver for linux 2.5.x

(also, at the end of the patch are a couple of changes that are either bug
fixes, or newly introduced bugs. :)

--- ppa.c.orig	Tue Dec 11 14:38:07 2001
+++ ppa.c	Tue Dec 11 22:50:00 2001
@@ -119,7 +119,6 @@
      * unlock to allow the lowlevel parport driver to probe
      * the irqs
      */
-    spin_unlock_irq(&io_request_lock);
     pb = parport_enumerate();

     printk("ppa: Version %s\n", PPA_VERSION);
@@ -128,7 +127,6 @@

     if (!pb) {
 	printk("ppa: parport reports no devices.\n");
-	spin_lock_irq(&io_request_lock);
 	return 0;
     }
   retry_entry:
@@ -154,7 +152,6 @@
 		      "pardevice is owning the port for too longtime!\n",
 			   i);
 		    parport_unregister_device(ppa_hosts[i].dev);
-		    spin_lock_irq(&io_request_lock);
 		    return 0;
 		}
 	    }
@@ -223,13 +220,11 @@
 	    printk("  supported by the imm (ZIP Plus) driver. If the\n");
 	    printk("  cable is marked with \"AutoDetect\", this is what has\n");
 	    printk("  happened.\n");
-	    spin_lock_irq(&io_request_lock);
 	    return 0;
 	}
 	try_again = 1;
 	goto retry_entry;
     } else {
-	spin_lock_irq(&io_request_lock);
 	return 1;		/* return number of hosts detected */
     }
 }
@@ -740,7 +735,7 @@
 	    if (cmd->SCp.buffers_residual--) {
 		cmd->SCp.buffer++;
 		cmd->SCp.this_residual = cmd->SCp.buffer->length;
-		cmd->SCp.ptr = cmd->SCp.buffer->address;
+		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 	    }
 	}
 	/* Now check to see if the drive is ready to comunicate */
@@ -794,6 +789,7 @@
 {
     ppa_struct *tmp = (ppa_struct *) data;
     Scsi_Cmnd *cmd = tmp->cur_cmd;
+    struct Scsi_Host *host = cmd->host;
     unsigned long flags;

     if (!cmd) {
@@ -845,11 +841,10 @@
     if (cmd->SCp.phase > 0)
 	ppa_pb_release(cmd->host->unique_id);

+    spin_lock_irqsave(&host->host_lock, flags);
     tmp->cur_cmd = 0;
-
-    spin_lock_irqsave(&io_request_lock, flags);
     cmd->scsi_done(cmd);
-    spin_unlock_irqrestore(&io_request_lock, flags);
+    spin_unlock_irqrestore(&host->host_lock, flags);
     return;
 }

@@ -923,16 +918,16 @@
     case 4:			/* Phase 4 - Setup scatter/gather buffers */
 	if (cmd->use_sg) {
 	    /* if many buffers are available, start filling the first */
-	    cmd->SCp.buffer = (struct scatterlist *) cmd->request_buffer;
+	    cmd->SCp.buffer = (struct scatterlist *) cmd->buffer;
 	    cmd->SCp.this_residual = cmd->SCp.buffer->length;
-	    cmd->SCp.ptr = cmd->SCp.buffer->address;
+	    cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 	} else {
 	    /* else fill the only available buffer */
 	    cmd->SCp.buffer = NULL;
 	    cmd->SCp.this_residual = cmd->request_bufflen;
 	    cmd->SCp.ptr = cmd->request_buffer;
 	}
-	cmd->SCp.buffers_residual = cmd->use_sg;
+	cmd->SCp.buffers_residual = cmd->use_sg - 1;
 	cmd->SCp.phase++;

     case 5:			/* Phase 5 - Data transfer stage */



