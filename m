Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280764AbRLHOCv>; Sat, 8 Dec 2001 09:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRLHOCi>; Sat, 8 Dec 2001 09:02:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7941 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S280764AbRLHOCe>;
	Sat, 8 Dec 2001 09:02:34 -0500
Date: Sat, 8 Dec 2001 15:02:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Rich Baum <richbaum@acm.org>
Cc: linux-kernel@vger.kernel.org, campbell@torque.net
Subject: Re: [PATCH][RFC] Allow drivers/scsi/imm.c to compile in 2.5.1pre6
Message-ID: <20011208140227.GA11567@suse.de>
In-Reply-To: <29EB5FE64EF@coral.indstate.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <29EB5FE64EF@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 07 2001, Rich Baum wrote:
> The attached patch fixes compile errors in imm.c in 2.5.1pre6.  At boot it 
> will detect the drive however if a disk is in the drive I get an oops (see 
> oops1.log).  If there is no disk it will boot just fine.

Two problems:

- detect() is not run with lock held anymore
- use of ->address is deprecated

Please try attached patch -- it's a quickie, so no guarentees :-)

-- 
Jens Axboe


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=imm-1

--- /opt/kernel/linux-2.5.1-pre7/drivers/scsi/imm.c	Sun Sep 30 15:26:07 2001
+++ drivers/scsi/imm.c	Sat Dec  8 08:58:55 2001
@@ -124,11 +124,6 @@
     int i, nhosts, try_again;
     struct parport *pb;
 
-    /*
-     * unlock to allow the lowlevel parport driver to probe
-     * the irqs
-     */
-    spin_unlock_irq(&io_request_lock);
     pb = parport_enumerate();
 
     printk("imm: Version %s\n", IMM_VERSION);
@@ -137,7 +132,6 @@
 
     if (!pb) {
 	printk("imm: parport reports no devices.\n");
-	spin_lock_irq(&io_request_lock);
 	return 0;
     }
   retry_entry:
@@ -163,7 +157,6 @@
 		      "pardevice is owning the port for too longtime!\n",
 			   i);
 		    parport_unregister_device (imm_hosts[i].dev);
-		    spin_lock_irq(&io_request_lock);
 		    return 0;
 		}
 	    }
@@ -219,13 +212,11 @@
     }
     if (nhosts == 0) {
 	if (try_again == 1) {
-	    spin_lock_irq(&io_request_lock);
 	    return 0;
 	}
 	try_again = 1;
 	goto retry_entry;
     } else {
-	spin_lock_irq (&io_request_lock);
 	return 1;		/* return number of hosts detected */
     }
 }
@@ -834,7 +825,7 @@
 	    if (cmd->SCp.buffers_residual--) {
 		cmd->SCp.buffer++;
 		cmd->SCp.this_residual = cmd->SCp.buffer->length;
-		cmd->SCp.ptr = cmd->SCp.buffer->address;
+		cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 
 		/*
 		 * Make sure that we transfer even number of bytes
@@ -897,6 +888,7 @@
 {
     imm_struct *tmp = (imm_struct *) data;
     Scsi_Cmnd *cmd = tmp->cur_cmd;
+    struct Scsi_Host *host = cmd->host;
     unsigned long flags;
 
     if (!cmd) {
@@ -948,10 +940,10 @@
     if (cmd->SCp.phase > 0)
 	imm_pb_release(cmd->host->unique_id);
 
-    spin_lock_irqsave(&io_request_lock, flags);
+    spin_lock_irqsave(&host->host_lock, flags);
     tmp->cur_cmd = 0;
     cmd->scsi_done(cmd);
-    spin_unlock_irqrestore(&io_request_lock, flags);
+    spin_unlock_irqrestore(&host->host_lock, flags);
     return;
 }
 
@@ -1008,7 +1000,7 @@
 	    /* if many buffers are available, start filling the first */
 	    cmd->SCp.buffer = (struct scatterlist *) cmd->request_buffer;
 	    cmd->SCp.this_residual = cmd->SCp.buffer->length;
-	    cmd->SCp.ptr = cmd->SCp.buffer->address;
+	    cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 	} else {
 	    /* else fill the only available buffer */
 	    cmd->SCp.buffer = NULL;

--SLDf9lqlvOQaIe6s--
