Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSHVWu3>; Thu, 22 Aug 2002 18:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318022AbSHVWu3>; Thu, 22 Aug 2002 18:50:29 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48779 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318020AbSHVWu2>; Thu, 22 Aug 2002 18:50:28 -0400
Date: Thu, 22 Aug 2002 18:54:38 -0400
From: Doug Ledford <dledford@redhat.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 qlogic error "this should not happen"
Message-ID: <20020822185438.C16827@redhat.com>
Mail-Followup-To: rwhron@earthlink.net, linux-kernel@vger.kernel.org
References: <20020822223916.GA460@rushmore>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020822223916.GA460@rushmore>; from rwhron@earthlink.net on Thu, Aug 22, 2002 at 06:39:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2002 at 06:39:16PM -0400, rwhron@earthlink.net wrote:
> While running bonnie++ with 2.5.31 and 2.5.31-mm1,
> a quad xeon with QLogic Corp. QLA2200 (rev 05)
> stopped responding.  These were the last lines
> in /var/log/messages before the box was rebooted.
> 
> kernel: qlogicfc0 : no handle slots, this should not happen.
> kernel: hostdata->queued is 6, in_ptr: 7d

Hmmm...sounds like no one bothered to correct the lock usage in this 
driver after the 2.5 kernel switched to per device queue locks instead of 
the global io_request_lock usage that this driver depended on to be safe.  
Try applying the attached patch and see if it helps you out any.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.17-iorl_before.patch"

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.19pre8/drivers/scsi/qlogicfc.c linux.19pre8-ac5/drivers/scsi/qlogicfc.c
--- linux.19pre8/drivers/scsi/qlogicfc.c	Thu May  9 22:40:23 2002
+++ linux.19pre8-ac5/drivers/scsi/qlogicfc.c	Thu May  9 22:40:52 2002
@@ -1343,18 +1343,11 @@
 
 	num_free = QLOGICFC_REQ_QUEUE_LEN - REQ_QUEUE_DEPTH(in_ptr, out_ptr);
 	num_free = (num_free > 2) ? num_free - 2 : 0;
-	host->can_queue = hostdata->queued + num_free;
+	host->can_queue = host->host_busy + num_free;
 	if (host->can_queue > QLOGICFC_REQ_QUEUE_LEN)
 		host->can_queue = QLOGICFC_REQ_QUEUE_LEN;
 	host->sg_tablesize = QLOGICFC_MAX_SG(num_free);
 
-	/* this is really gross */
-	if (host->can_queue <= host->host_busy){
-	        if (host->can_queue+2 < host->host_busy) 
-			DEBUG(printk("qlogicfc%d.c crosses its fingers.\n", hostdata->host_id));
-		host->can_queue = host->host_busy + 1;
-	}
-
 	LEAVE("isp2x00_queuecommand");
 
 	return 0;
@@ -1623,17 +1616,11 @@
 
 	num_free = QLOGICFC_REQ_QUEUE_LEN - REQ_QUEUE_DEPTH(in_ptr, out_ptr);
 	num_free = (num_free > 2) ? num_free - 2 : 0;
-	host->can_queue = hostdata->queued + num_free;
+	host->can_queue = host->host_busy + num_free;
 	if (host->can_queue > QLOGICFC_REQ_QUEUE_LEN)
 		host->can_queue = QLOGICFC_REQ_QUEUE_LEN;
 	host->sg_tablesize = QLOGICFC_MAX_SG(num_free);
 
-	if (host->can_queue <= host->host_busy){
-	        if (host->can_queue+2 < host->host_busy) 
-		        DEBUG(printk("qlogicfc%d : crosses its fingers.\n", hostdata->host_id));
-		host->can_queue = host->host_busy + 1;
-	}
-
 	outw(HCCR_CLEAR_RISC_INTR, host->io_port + HOST_HCCR);
 	LEAVE_INTR("isp2x00_intr_handler");
 }

--oyUTqETQ0mS9luUI--
