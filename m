Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbTCMSbX>; Thu, 13 Mar 2003 13:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbTCMSbW>; Thu, 13 Mar 2003 13:31:22 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:30628 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262482AbTCMSbV>;
	Thu, 13 Mar 2003 13:31:21 -0500
Date: Thu, 13 Mar 2003 21:41:07 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       deanna_bonds@adaptec.com
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
Message-ID: <20030313184107.GA2334@linuxhacker.ru>
References: <20030313182819.GA2213@linuxhacker.ru> <1047584663.25948.75.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047584663.25948.75.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 13, 2003 at 07:44:23PM +0000, Alan Cox wrote:
> >    if timeout on first reset stage is reached, frees "status" and returns,
> >    otherwise it proceeds to monitor "status" (which is modified by hardware
> >    now, btw), and if timeout is reached, just exits.
> Correctly - I2O does the same thing in this case. Its just better to
> throw a few bytes away than risk corruption

Ok, so please consider applying this patch instead (appies to both
2.4 and 2.5)

Bye,
    Oleg

===== drivers/scsi/dpt_i2o.c 1.9 vs edited =====
--- 1.9/drivers/scsi/dpt_i2o.c	Wed Jan  8 18:26:13 2003
+++ edited/drivers/scsi/dpt_i2o.c	Thu Mar 13 21:39:07 2003
@@ -1318,7 +1318,9 @@
 	while(*status == 0){
 		if(time_after(jiffies,timeout)){
 			printk(KERN_WARNING"%s: IOP Reset Timeout\n",pHba->name);
-			kfree(status);
+			/* We loose 4 bytes of "status" here, but we cannot
+			   free these because controller may awake and corrupt
+			   those bytes at any time */
 			return -ETIMEDOUT;
 		}
 		rmb();
@@ -1336,6 +1338,9 @@
 			}
 			if(time_after(jiffies,timeout)){
 				printk(KERN_ERR "%s:Timeout waiting for IOP Reset.\n",pHba->name);
+			/* We loose 4 bytes of "status" here, but we cannot
+			   free these because controller may awake and corrupt
+			   those bytes at any time */
 				return -ETIMEDOUT;
 			}
 		} while (m == EMPTY_QUEUE);
