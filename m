Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTE3Pns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 11:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTE3Pns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 11:43:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49333 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263760AbTE3Pnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 11:43:45 -0400
Date: Fri, 30 May 2003 10:56:58 -0500
Subject: [CHECKER] aacraid user pointer use
Content-Type: multipart/mixed; boundary=Apple-Mail-9-841091333
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Junfeng Yang <yjf@stanford.edu>
From: Hollis Blanchard <hollisb@us.ibm.com>
Message-Id: <585B8A2C-92B7-11D7-A2DA-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-9-841091333
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	delsp=yes;
	charset=US-ASCII;
	format=flowed

Stanford checker said:
---------------------------------------------------------
[BUG] at least bad programming practice. file_opetations.ioctl ->
aac_cfg_ioctl -> aac_do_ioctl -> close_getadapter_fib ->
aac_close_fib_context. All other functions called by aac_do_ioctl assume
arg is a user pointer. It is unknown what will happen.

/home/junfeng/linux-2.5.63/drivers/scsi/aacraid/ 
commctrl.c:277:aac_close_fib_context:
ERROR:TAINTED:277:277: dereferencing tainted ptr 'fibctx' [Callstack:
/home/junfeng/linux-2.5.63/drivers/scsi/sg.c:1002:aac_cfg_ioctl((tainted
3)) ->
/home/junfeng/linux-2.5.63/drivers/scsi/aacraid/ 
linit.c:671:aac_do_ioctl((tainted
2)) ->
/home/junfeng/linux-2.5.63/drivers/scsi/aacraid/ 
commctrl.c:421:close_getadapter_fib((tainted
1)) ->
/home/junfeng/linux-2.5.63/drivers/scsi/aacraid/ 
commctrl.c:348:aac_close_fib_context((tainted
1))]

	while (!list_empty(&fibctx->fibs)) {
		struct list_head * entry;
		/*
		 *	Pull the next fib from the fibs
		 */

Error --->
		entry = fibctx->fibs.next;
		list_del(entry);
		fib = list_entry(entry, struct hw_fib, header.FibLinks);
		fibctx->count--;
---------------------------------------------------------

As it turns out, the driver is fine. It is dereferencing a  
user-supplied pointer (fibctx), but it keeps a list of valid structures  
and has already made sure fibctx is one of them before using it. This  
is in contrast to the PCMCIA code, which uses a magic number to verify  
(as discussed yesterday) rather than keeping a list of all valid  
pointers.

The attached aacraid patch may help the checker, and should be  
functionally equivalent... but isn't necessary.

-- 
Hollis Blanchard
IBM Linux Technology Center

--Apple-Mail-9-841091333
Content-Disposition: attachment;
	filename=aacraid-userptr.diff
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="aacraid-userptr.diff"

===== drivers/scsi/aacraid/commctrl.c 1.2 vs edited =====
--- 1.2/drivers/scsi/aacraid/commctrl.c	Wed May  7 21:08:36 2003
+++ edited/drivers/scsi/aacraid/commctrl.c	Thu May 29 17:33:17 2003
@@ -214,8 +214,8 @@
 	if (found == 0)
 		return -EINVAL;
 
-	if((fibctx->type != FSAFS_NTC_GET_ADAPTER_FIB_CONTEXT) ||
-		 (fibctx->size != sizeof(struct aac_fib_context)))
+	if((aifcp->type != FSAFS_NTC_GET_ADAPTER_FIB_CONTEXT) ||
+		 (aifcp->size != sizeof(struct aac_fib_context)))
 		return -EINVAL;
 	status = 0;
 	spin_lock_irqsave(&dev->fib_lock, flags);
@@ -224,16 +224,16 @@
 	 *	-EAGAIN
 	 */
 return_fib:
-	if (!aac_list_empty(&fibctx->hw_fib_list)) {
+	if (!aac_list_empty(&aifcp->hw_fib_list)) {
 		struct aac_list_head * entry;
 		/*
 		 *	Pull the next fib from the fibs
 		 */
-		entry = (struct aac_list_head*)(ulong)fibctx->hw_fib_list.next;
+		entry = (struct aac_list_head*)(ulong)aifcp->hw_fib_list.next;
 		aac_list_del(entry);
 		
 		hw_fib = aac_list_entry(entry, struct hw_fib, header.FibLinks);
-		fibctx->count--;
+		aifcp->count--;
 		spin_unlock_irqrestore(&dev->fib_lock, flags);
 		if (copy_to_user(f.fib, hw_fib, sizeof(struct hw_fib))) {
 			kfree(hw_fib);
@@ -244,11 +244,11 @@
 		 */
 		kfree(hw_fib);
 		status = 0;
-		fibctx->jiffies = jiffies/HZ;
+		aifcp->jiffies = jiffies/HZ;
 	} else {
 		spin_unlock_irqrestore(&dev->fib_lock, flags);
 		if (f.wait) {
-			if(down_interruptible(&fibctx->wait_sem) < 0) {
+			if(down_interruptible(&aifcp->wait_sem) < 0) {
 				status = -EINTR;
 			} else {
 				/* Lock again and retry */
@@ -341,11 +341,11 @@
 	if(found == 0)
 		return 0; /* Already gone */
 
-	if((fibctx->type != FSAFS_NTC_GET_ADAPTER_FIB_CONTEXT) ||
-		 (fibctx->size != sizeof(struct aac_fib_context)))
+	if((aifcp->type != FSAFS_NTC_GET_ADAPTER_FIB_CONTEXT) ||
+		 (aifcp->size != sizeof(struct aac_fib_context)))
 		return -EINVAL;
 	spin_lock_irqsave(&dev->fib_lock, flags);
-	status = aac_close_fib_context(dev, fibctx);
+	status = aac_close_fib_context(dev, aifcp);
 	spin_unlock_irqrestore(&dev->fib_lock, flags);
 	return status;
 }

--Apple-Mail-9-841091333--

