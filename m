Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbTCMSSc>; Thu, 13 Mar 2003 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbTCMSSc>; Thu, 13 Mar 2003 13:18:32 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:26276 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262424AbTCMSSa>;
	Thu, 13 Mar 2003 13:18:30 -0500
Date: Thu, 13 Mar 2003 21:28:19 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Cc: deanna_bonds@adaptec.com
Subject: dpt_i2o.c memleak/incorrectness
Message-ID: <20030313182819.GA2213@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is something strange going on in drivers/scsi/dpt_i2o.c in both
   2.4 and 2.5. adpt_i2o_reset_hba() function allocates 4 bytes 
   for "status" stuff, then tries to reset controller, then 
   if timeout on first reset stage is reached, frees "status" and returns,
   otherwise it proceeds to monitor "status" (which is modified by hardware
   now, btw), and if timeout is reached, just exits.
   On the first thought I just thought it is trivial memleak that can be
   fixed with patch below, but after some more thining I just thought
   "what if after some time controller awakes and modifies status,
   but it is already allocated for other purposes", scary eh?
   So may be we shold not free those four bytes on timeout at all just
   for safeness reasons?

   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== drivers/scsi/dpt_i2o.c 1.9 vs edited =====
--- 1.9/drivers/scsi/dpt_i2o.c	Wed Jan  8 18:26:13 2003
+++ edited/drivers/scsi/dpt_i2o.c	Thu Mar 13 21:17:10 2003
@@ -1336,6 +1336,7 @@
 			}
 			if(time_after(jiffies,timeout)){
 				printk(KERN_ERR "%s:Timeout waiting for IOP Reset.\n",pHba->name);
+				kfree(status);
 				return -ETIMEDOUT;
 			}
 		} while (m == EMPTY_QUEUE);
