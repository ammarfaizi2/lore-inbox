Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262537AbTCMT2k>; Thu, 13 Mar 2003 14:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262542AbTCMT2k>; Thu, 13 Mar 2003 14:28:40 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:62372 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262537AbTCMT2c>;
	Thu, 13 Mar 2003 14:28:32 -0500
Date: Thu, 13 Mar 2003 22:38:29 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Now i2o_core.c memleak/incorrectness?
Message-ID: <20030313193829.GA2940@linuxhacker.ru>
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
> >    There is something strange going on in drivers/scsi/dpt_i2o.c in both
> >    2.4 and 2.5. adpt_i2o_reset_hba() function allocates 4 bytes 
> >    for "status" stuff, then tries to reset controller, then 
> >    if timeout on first reset stage is reached, frees "status" and returns,
> >    otherwise it proceeds to monitor "status" (which is modified by hardware
> >    now, btw), and if timeout is reached, just exits.
> Correctly - I2O does the same thing in this case. Its just better to
> throw a few bytes away than risk corruption

Well, it seems that i2o does not always follow this rule.
Also i2o_init_outbound_q() seems not free this "status" thing if everything
went ok, is this intentional?
Or perhaps something like this patch is needed?

Bye,
    Oleg

===== drivers/message/i2o/i2o_core.c 1.12 vs edited =====
--- 1.12/drivers/message/i2o/i2o_core.c	Tue Aug  6 18:42:18 2002
+++ edited/drivers/message/i2o/i2o_core.c	Thu Mar 13 22:36:40 2003
@@ -2217,7 +2217,7 @@
 			else  
 				printk(KERN_ERR "%s: Outbound queue initialize timeout.\n",
 					c->name);
-			kfree(status);
+			// Better leak this for safety: kfree(status);
 			return -ETIMEDOUT;
 		}  
 		schedule();
@@ -2231,6 +2231,7 @@
 		return -ETIMEDOUT;
 	}
 
+	kfree(status);
 	return 0;
 }
 
